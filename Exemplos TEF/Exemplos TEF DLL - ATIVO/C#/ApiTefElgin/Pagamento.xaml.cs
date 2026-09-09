using System;
using System.Windows.Controls;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows;
using System.Text.RegularExpressions;
using System.Runtime.InteropServices;
using System.Diagnostics;
using Newtonsoft.Json.Linq;
using System.Threading;
using System.Linq;
using System.Windows.Threading;
using System.Drawing;
using System.Windows.Media.Imaging;
using System.IO;

namespace WpfTesteVs
{
    public partial class Pagamento : Window
    {
        /*
        * Aplicativo Exemplo para E1_Tef Api, versão C#
        * Gabriel Franzeri @ Elgin, 2022
        */


        public AutoResetEvent clickEvent = new AutoResetEvent(false);

        // ===================================================================== //
        // ============ CARREGAMENTO DAS FUNÇÕES DA DLL ================== //
        // ===================================================================== //
        public const string PATH = @"C:\Elgin\TEF\E1_Tef01.dll";

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int GetProdutoTef();

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr GetClientTCP();

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr SetClientTCP(string ip, int porta);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr ConfigurarDadosPDV(string textoPinpad, string versaoAC, string nomeEstabelecimento, string loja, string identificadorPontoCaptura);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr IniciarOperacaoTEF(string dadosCaptura);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr RecuperarOperacaoTEF(string dadosCaptura);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr RealizarPagamentoTEF(int codigoOperacao, string dadosCaptura, bool novaTransacao);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr RealizarPixTEF(string dadosCaptura, bool novaTransacao);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr RealizarAdmTEF(int codigoOperacao, string dadosCaptura, bool novaTransacao);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr ConfirmarOperacaoTEF(int id, int acao);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr FinalizarOperacaoTEF(int id);

        // VARIÁVEIS
        private const string ADM_USUARIO = "";
        private const string ADM_SENHA = "";
        private const int OPERACAO_TEF = 0;
        private const int OPERACAO_ADM = 1;
        private const int OPERACAO_PIX = 2;
        public static string RetornoUI { get; set; } = "";
        public static string valorTotal { get; set; } = String.Empty;
        public static string cancelarColeta { get; set; } = String.Empty;
        public static int Operacao { get; set; } = OPERACAO_TEF;


        public Pagamento()
        {
            InitializeComponent();
        }

        // evento dos botões do teclado numérico, escrevendo seus números no label do valor da venda
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Button b = (Button)sender;
            if (LblValor.Text != "0")
            {
                string cleanString = Regex.Replace(valorTotal + b.Content.ToString(), @"[^\d]", "");
                string trimmed = cleanString.TrimStart('0');

                if (trimmed.Length > 2) {
                    string withDecimal = trimmed.Insert(trimmed.Length - 2, ".");
                    valorTotal = withDecimal;
                } else {
                    valorTotal = trimmed.Length > 1 ? "0." + trimmed : "0.0" + trimmed;
                }
                LblValor.Text = valorTotal;
            }
            else { LblValor.Text = b.Content.ToString(); }
        }

        // apaga valor da venda
        private void BtnClear_Click(object sender, RoutedEventArgs e)
        {
            valorTotal = "";
            LblValor.Text = "0.00";
        }

        // apaga último número escrito no label de venda
        private void BtnBS_Click(object sender, RoutedEventArgs e)
        {
            if (LblValor.Text != "")
            {
                valorTotal = valorTotal.Remove(LblValor.Text.Length - 1);

                string cleanString = Regex.Replace(valorTotal, @"[^\d]", "");
                string trimmed = cleanString.TrimStart('0');

                if (trimmed.Length > 2) {
                    string withDecimal = trimmed.Insert(trimmed.Length - 2, ".");
                    valorTotal = withDecimal;
                } else {
                    valorTotal = trimmed.Length > 1 ? "0." + trimmed : "0.0" + trimmed;
                }
                LblValor.Text = valorTotal;
            }
        }

        // evento botão de débito, inicializa processo e entra no loop principal
        private async void BtnIniciarOperacaoTEF_Click(object sender, RoutedEventArgs e)
        {
            Operacao = OPERACAO_TEF;
            lblOperador1.Visibility = Visibility.Visible;
            lblOperador1.Content = "AGUARDE...";

            valorTotal = LblValor.Text;
            LblValor.Text = "";

            btnInciarOperacaoPIX.IsEnabled = false;
            btnIniciarOperacaoTEF.IsEnabled = false;

            await Task.Run(() => {
                TesteApiElginTEF();
            });

            btnInciarOperacaoPIX.IsEnabled = true;
            btnIniciarOperacaoTEF.IsEnabled = true;
        }

        // evento botão de débito, inicializa processo e entra no loop principal
        private async void BtnIniciarOperacaoPIX_Click(object sender, RoutedEventArgs e)
        {
            Operacao = OPERACAO_PIX;
            lblOperador1.Visibility = Visibility.Visible;
            lblOperador1.Content = "AGUARDE...";

            valorTotal = LblValor.Text;
            LblValor.Text = "";

            btnInciarOperacaoPIX.IsEnabled = false;
            btnIniciarOperacaoTEF.IsEnabled = false;

            await Task.Run(() => {
                TesteApiElginTEF();
            });

            btnInciarOperacaoPIX.IsEnabled = true;
            btnIniciarOperacaoTEF.IsEnabled = true;
        }


        // evento do botão dinâmico prosseguir
        private void btnOk_Click(object sender, RoutedEventArgs e)
        {
            RetornoUI = "";
            string retCmb = cmbLista.SelectedIndex.ToString();
            string retTxt = txtOperador.Text;
            txtOperador.Text = "";

            lblOperador1.Visibility = Visibility.Hidden;
            txtOperador.Visibility = Visibility.Hidden;
            btnOk.Visibility = Visibility.Hidden;
            btnCancelar.Visibility = Visibility.Hidden;
            txtOperador.Visibility = Visibility.Hidden;
            imgQRCode.Visibility = Visibility.Hidden;

            if (cmbLista.Visibility == Visibility.Visible)
            {
                RetornoUI = retCmb;
            }
            else
            {
                RetornoUI = retTxt;
            }

            cmbLista.Visibility = Visibility.Hidden;

            clickEvent.Set();
        }

        // evento do botão dinâmico "Cancelar" 
        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            RetornoUI = "0";
            cancelarColeta = "9";
            clickEvent.Set();
        }

        public void printUi(string msg)
        {

            Dispatcher.Invoke(() => {

                lblOperador1.Visibility = Visibility.Hidden;
                txtOperador.Visibility = Visibility.Hidden;
                btnOk.Visibility = Visibility.Hidden;
                btnCancelar.Visibility = Visibility.Hidden;
                txtOperador.Visibility = Visibility.Hidden;
                imgQRCode.Visibility = Visibility.Hidden;

                // QRCODE PIX
                if (msg.Contains("QRCODE;"))
                {
                    string[] partes = msg.Split(';');
                    string hexQrCodeString = "";

                    for (int i = 0; i < partes.Length - 1; i++)
                    {
                        if (partes[i] == "QRCODE")
                        {
                            hexQrCodeString = partes[i + 1];
                            break;
                        }
                    }

                    ShowQRCode(hexQrCodeString);

                    imgQRCode.Visibility = Visibility.Visible;
                    btnOk.Visibility = Visibility.Visible;
                    btnCancelar.Visibility = Visibility.Visible;
                }
                else
                {
                    lblOperador1.Content = msg;
                    lblOperador1.Visibility = Visibility.Visible;
                 

                    // quando uma dessas mensagens estiver presente não mostrar os botões
                    string[] msgArray = { "aguarde", 
                                          "finalizada", 
                                          "passagem", 
                                          "cancelada", 
                                          "iniciando confirmação" 
                                        };

                    if (!msgArray.Any(msg.ToLower().Contains))
                    {
                        txtOperador.Visibility = Visibility.Visible;
                        txtOperador.Focus();
                        btnOk.Visibility = Visibility.Visible;
                        btnCancelar.Visibility = Visibility.Visible;
                    }
                }
            });
        }

        public void printUi(string[] elements)
        {

            Dispatcher.Invoke(() => {
                cmbLista.Items.Clear();

                lblOperador1.Visibility = Visibility.Hidden;
                txtOperador.Visibility = Visibility.Hidden;
                btnOk.Visibility = Visibility.Hidden;
                btnCancelar.Visibility = Visibility.Hidden;
                txtOperador.Visibility = Visibility.Hidden;
                imgQRCode.Visibility = Visibility.Hidden;

                lblOperador1.Visibility = Visibility.Visible;

                btnCancelar.Visibility = Visibility.Visible;
                btnOk.Visibility = Visibility.Visible;

                foreach (string item in elements)
                {
                    cmbLista.Items.Add(item);
                }
                cmbLista.Items.Add("Selecione uma opção");
                cmbLista.SelectedItem = "Selecione uma opção";
                cmbLista.Visibility = Visibility.Visible;

            });
        }

        public void ShowQRCode(string hexString)
        {
            // convert hex to byte array
            byte[] imageBytes = HexToByteArray(hexString);

            // create memoryStream that wraps the byte array
            using (MemoryStream stream = new MemoryStream(imageBytes)) {
                BitmapImage qrImage = new BitmapImage();
                qrImage.BeginInit();
                qrImage.StreamSource = stream;
                qrImage.CacheOption = BitmapCacheOption.OnLoad;
                qrImage.EndInit();

                imgQRCode.Source = qrImage;
            }
        }

        private byte[] HexToByteArray(string hexString)
        {
            if (hexString == null)
            {
                throw new ArgumentNullException("hexString");
            }

            if (hexString.Length % 2 != 0)
            {
                throw new ArgumentException("hexString must have an even length");
            }

            byte[] result = new byte[hexString.Length / 2];
            for (int i = 0; i < hexString.Length; i += 2)
            {
                string byteString = hexString.Substring(i, 2);
                result[i / 2] = Convert.ToByte(byteString, 16);
            }
            return result;
        }

        public void WriteLogs(Boolean header, string logs, Boolean footer)
        {

            const string div = "\n==============================================\n";
            string _output = "";

            if (header)
                _output += div;

            _output += logs;

            if (footer)
                _output += div;

            Dispatcher.Invoke(() => {
                LogsEntry.Text += _output + "\n";
                LogsEntry.ScrollToEnd();
            });

        }

        // ===================================================================== //
        // ========================= LÓGICA DO TEF ============================= //
        // ===================================================================== //


        // ===================================================================== //
        // =============================== TESTES ============================== //
        // ===================================================================== //
        public void TesteApiElginTEF()
        {
            try
            {
                SetClientTCP("127.0.0.1", 60906);
                ConfigurarDadosPDV("Meu PDV C#", "v1.0.000", "Elgin", "01", "T0004");

                // 1) INICIAR CONEXAO COM CLIENT
                string start = iniciar();

                string retorno = getRetorno(start);
                if (retorno == string.Empty || retorno != "1")
                {
                    finalizar();
                }

                // 2) REALIZAR OPERAÇÃO
                string sequencial = getSequencial(start);
                sequencial = incrementarSequencial(sequencial);

                // string resp = vender(0, sequencial);   // Pgto --> Perguntar tipo do cartao
                // string resp = vender(1, sequencial);   // Pgto --> Cartao de credito
                // string resp = vender(2, sequencial);   // Pgto --> Cartao de debito
                // string resp = vender(3, sequencial);   // Pgto --> Voucher (debito)
                // string resp = vender(4, sequencial);   // Pgto --> Frota (debito)
                // string resp = vender(5, sequencial);   // Pgto --> Private label (credito)
                // string resp = adm(0, sequencial);      // Adm  --> Perguntar operacao
                // string resp = adm(1, sequencial);      // Adm  --> Cancelamento
                // string resp = adm(2, sequencial);      // Adm  --> Pendencias
                // string resp = adm(3, sequencial);      // Adm  --> Reimpressao

                string resp = String.Empty;
                if (ControleApi.ModoOperacao.Contains("vender")) {
                    resp = Operacao == OPERACAO_TEF
                        ? vender(0, sequencial, OPERACAO_TEF)
                        : vender(0, sequencial, OPERACAO_PIX);
                } else {
                    resp = adm(0, sequencial);
                }

                retorno = getRetorno(resp);
                if (retorno == string.Empty)
                { // Continuar operacao/iniciar o processo de coleta
                    if (ControleApi.ModoOperacao.Contains("vender")) {
                        resp = coletar(0, jsonify(resp)); // coletar vendas
                    } else {
                        resp = coletar(1, jsonify(resp)); // coletar adms
                    }

                    retorno = getRetorno(resp);
                }

                // 3) VERIFICAR RESULTADO / CONFIRMAR
                if (retorno == string.Empty)
                {
                    WriteLogs(true, "ERRO AO COLETAR DADOS", true);
                    Print("ERRO AO COLETAR DADOS");
                }
                else if (retorno == "0")
                {

                    string comprovanteLoja = getComprovante(resp, "loja");
                    string comprovanteCliente = getComprovante(resp, "cliente");
                    WriteLogs(true, comprovanteLoja, true);
                    WriteLogs(true, comprovanteCliente, true);

                    WriteLogs(true, "TRANSAÇÃO OK, INICIANDO CONFIRMAÇÃO...", true);
                    Print("TRANSAÇÃO OK, INICIANDO CONFIRMAÇÃO...");
                    sequencial = getSequencial(resp);

                    // confirma a operação através do sequencial utilizado
                    string cnf = confirmar(sequencial);

                    retorno = getRetorno(cnf);
                    if (retorno == string.Empty || retorno != "1")
                    {
                        finalizar();
                    }
                }
                else if (retorno == "1")
                {
                    WriteLogs(true, "TRANSAÇÃO OK", true);
                    Print("TRANSAÇÃO OK");
                }
                else
                {
                    WriteLogs(true, "ERRO NA TRANSAÇÃO", true);
                    Print("ERRO NA TRANSAÇÃO");
                }
                // 4) FINALIZAR CONEXÃO
                string end = finalizar();

                retorno = getRetorno(end);
                if (retorno == string.Empty || retorno != "1")
                {
                    finalizar();
                }
            }
            catch (DllNotFoundException)
            {
                MessageBox.Show("Dll não encontrada");
            }
        }

        // ===================================================================== //
        // ============ MÉTODOS PARA O CONTROLE DA TRANSAÇÃO (E1_TEF) ========== //
        // ===================================================================== //

        public string iniciar()
        {
            IDictionary<string, object> payload = new Dictionary<string, object>();

            // payload.Add("aplicacao",         "Meu PDV");
            // payload.Add("aplicacao_tela",    "Meu PDV");
            // payload.Add("versao",            "v0.0.001");
            // payload.Add("estabelecimento",   "Elgin");
            // payload.Add("loja",              "01");
            // payload.Add("terminal",          "T0004");

            // payload.Add("nomeAC",                        "Meu PDV");
            // payload.Add("textoPinpad",                   "Meu PDV");
            // payload.Add("versaoAC",                      "v0.0.001");
            // payload.Add("nomeEstabelecimento",           "Elgin");
            // payload.Add("loja",                          "01");
            // payload.Add("identificadorPontoCaptura",     "T0004");

            IntPtr _intptr = IniciarOperacaoTEF(stringify(payload));
            string start = Marshal.PtrToStringAnsi(_intptr);
            WriteLogs(true, __Function() + "  " + start, true);
            return start;
        }

        public string vender(int cartao, string sequencial, int operacao)
        {
            WriteLogs(true, __Function() + " SEQUENCIAL UTILIZADO NA VENDA: " + sequencial, true);

            IDictionary<string, object> payload = new Dictionary<string, object>();
            payload.Add("sequencial", sequencial);

            // se um valor tiver sido escrito antes da transação, usar esse valor em centavos
            if (valorTotal != string.Empty)
            {
                valorTotal = Regex.Replace(valorTotal, @"[^\d]", "");
                payload.Add("valorTotal", valorTotal);
            }

            string pgto;
            if (operacao == OPERACAO_TEF)
            {
                IntPtr _intptr = RealizarPagamentoTEF(cartao, stringify(payload), true);
                pgto = Marshal.PtrToStringAnsi(_intptr);
            } else
            {
                IntPtr _intptr = RealizarPixTEF(stringify(payload), true);
                pgto = Marshal.PtrToStringAnsi(_intptr);
            }
            WriteLogs(true, __Function() + "  " + pgto, true);
            return pgto;
        }

        public string adm(int opcao, string sequencial)
        {
            WriteLogs(true, __Function() + " SEQUENCIAL UTILIZADO NA VENDA: " + sequencial, true);
            IDictionary<string, object> payload = new Dictionary<string, object>();
            payload.Add("sequencial", sequencial);

            // payload.Add("transacao_administracao_usuario", ADM_USUARIO);
            // payload.Add("transacao_administracao_senha",   ADM_SENHA);
            // payload.Add("admUsuario",                      ADM_USUARIO);
            // payload.Add("admSenha",                        ADM_SENHA);

            IntPtr _intptr = RealizarAdmTEF(opcao, stringify(payload), true);
            string adm = Marshal.PtrToStringAnsi(_intptr);
            WriteLogs(true, __Function() + "  " + adm, true);
            return adm;
        }

        public string coletar(int operacao, IDictionary<string, object> root)
        {
            // chaves utilizadas na coleta
            string coletaRetorno,      // In/Out; out: 0 = continuar coleta, 9 = cancelar coleta
                coletaSequencial,   // In/Out
                coletaMensagem,     // In/[Out]
                coletaTipo,         // In
                coletaOpcao,        // In
                coletaInformacao;   // Out

            // extrai os dados da resposta / coleta
            coletaRetorno = getStringValue(root, "tef", "automacao_coleta_retorno");
            coletaSequencial = getStringValue(root, "tef", "automacao_coleta_sequencial");
            coletaMensagem = getStringValue(root, "tef", "mensagemResultado");
            coletaTipo = getStringValue(root, "tef", "automacao_coleta_tipo");
            coletaOpcao = getStringValue(root, "tef", "automacao_coleta_opcao");

            WriteLogs(true, __Function() + " " + coletaMensagem.ToUpper(), true);
            Print(coletaMensagem.ToUpper());

            // em caso de erro, encerra coleta
            if (coletaRetorno != "0")
                return stringify(root);

            // em caso de sucesso, monta o (novo) payload e continua a coleta
            IDictionary<string, object> payload = new Dictionary<string, object>();
            payload.Add("automacao_coleta_retorno", coletaRetorno);
            payload.Add("automacao_coleta_sequencial", coletaSequencial);

            // coleta dado do usuário, caso necessário
            if (coletaTipo != string.Empty && coletaOpcao == string.Empty)
            {// valor inserido (texto)
                WriteLogs(true, "INFORME O VALOR SOLICITADO: ", true);
                coletaInformacao = Read();

                if (cancelarColeta != string.Empty)
                {
                    payload.Remove("automacao_coleta_retorno");
                    payload.Add("automacao_coleta_retorno", cancelarColeta);
                    cancelarColeta = string.Empty;
                }

                payload.Add("automacao_coleta_informacao", coletaInformacao);

            }
            else if (coletaTipo != string.Empty && coletaOpcao != string.Empty)
            { // valor selecionado (lista)
                string[] opcoes = coletaOpcao.Split(char.Parse(";"));
                string[] elements = new string[opcoes.Length];

                for (int i = 0; i < opcoes.Length; i++)
                    elements[i] += "[" + i + "] " + opcoes[i].ToUpper() + "\n";

                for (int i = 0; i < opcoes.Length; i++)
                    WriteLogs(false, "[" + i + "] " + opcoes[i].ToUpper() + "\n", false);

                Print(elements);
                WriteLogs(true, "\nDIGITE A OPÇÂO DESEJADA: ", true);
                coletaInformacao = opcoes[int.Parse(Read())];

                if (cancelarColeta != string.Empty)
                {
                    payload.Remove("automacao_coleta_retorno");
                    payload.Add("automacao_coleta_retorno", cancelarColeta);
                    cancelarColeta = string.Empty;
                }

                payload.Add("automacao_coleta_informacao", coletaInformacao);
            }

            // informa os dados coletados
            string resp;
            if (operacao == 1)
            {
                IntPtr _intptr = RealizarAdmTEF(0, stringify(payload), false);
                resp = Marshal.PtrToStringAnsi(_intptr);
            }
            else
            {
                if (Operacao == OPERACAO_PIX)
                {
                    IntPtr _intptr = RealizarPixTEF(stringify(payload), false);
                    resp = Marshal.PtrToStringAnsi(_intptr);
                }
                else
                {
                    IntPtr _intptr = RealizarPagamentoTEF(0, stringify(payload), false);
                    resp = Marshal.PtrToStringAnsi(_intptr);
                }

            }
            // verifica fim da coleta
            string retorno = getRetorno(resp);
            if (retorno != string.Empty)
            { // fim da coleta
                return resp;
            }

            return coletar(operacao, jsonify(resp));
        }

        public string confirmar(string sequencial)
        {
            WriteLogs(true, __Function() + "SEQUENCIAL DA OPERAÇÃO A SER CONFIRMADA: " + sequencial, true);
            Print("AGUARDE, CONFIRMANDO OPERAÇÃO...");

            IntPtr _intptr = ConfirmarOperacaoTEF(int.Parse(sequencial), 1);
            string cnf = Marshal.PtrToStringAnsi(_intptr);
            WriteLogs(true, __Function() + cnf, true);
            return cnf;
        }

        public string finalizar()
        {
            IntPtr _intptr = FinalizarOperacaoTEF(1); // API resolve o sequencial
            string end = Marshal.PtrToStringAnsi(_intptr);
            WriteLogs(true, __Function() + end, true);
            valorTotal = String.Empty;
            Print("OPERAÇÃO FINALIZADA!");
            return end;
        }
        // StringBuilder resultA = new StringBuilder(512);

        // ===================================================================== //
        // ============ METODOS UTILITÁRIOS PARA O EXEMPLO C# ================== //
        // ===================================================================== //
        public string incrementarSequencial(string sequencial)
        {
            bool ok;
            ok = double.TryParse(sequencial, out double value) &&
                !double.IsNaN(value) &&
                !double.IsInfinity(value);

            if (!ok)
                return string.Empty; // sequencial informado não numérico

            value++;
            return value.ToString();
        }

        public string getRetorno(string resp)
        {
            IDictionary<string, object> _jsonDic = jsonify(resp);
            return getStringValue(_jsonDic, "tef", "retorno");
            // return getStringValue(_jsonDic, "tef", "resultadoTransacao");
        }

        public string getSequencial(string resp)
        {
            IDictionary<string, object> _jsonDic = jsonify(resp);
            return getStringValue(_jsonDic, "tef", "sequencial");
        }

        public string getComprovante(string resp, string via) {
            if (via == "loja") {
                IDictionary<string, object> _jsonDic = jsonify(resp);
                return getStringValue(_jsonDic, "tef", "comprovanteDiferenciadoLoja");
            } else if (via == "cliente") {
                IDictionary<string, object> _jsonDic = jsonify(resp);
                return getStringValue(_jsonDic, "tef", "comprovanteDiferenciadoPortador");
            } else {
                return String.Empty;
            }
        }
        
        public IDictionary<string, object> jsonify(string jsonString)
        {
            if (jsonString != null) {
                IDictionary<string, object> _Dic = JsonConvert.DeserializeObject<Dictionary<string, object>>(jsonString);
                return _Dic;
            } else {
                IDictionary<string, object> _Dic = new Dictionary<string, object>();
                return _Dic;
            }
        }

        public string stringify(IDictionary<string, object> _jsonDic)
        {
            return JsonConvert.SerializeObject(_jsonDic, Formatting.Indented);
        }

        public string getStringValue(IDictionary<string, object> dicJson, string keyOut, string keyIn)
        {
            if (dicJson != null && dicJson.TryGetValue(keyOut, out dynamic value)) {
                IDictionary<string, object> _Dic = value.ToObject<Dictionary<string, object>>();
                if (_Dic != null && _Dic.TryGetValue(keyIn, out object valueIn)) {
                    Console.WriteLine(valueIn.GetType());
                    return valueIn.ToString();
                } else {
                    return string.Empty;
                }
            } else {
                return string.Empty;
            }
        }

        public string getStringValue(IDictionary<string, object> dicJson, string key)
        {
            if (dicJson != null && dicJson.TryGetValue(key, out object value)) {
                return value.ToString();
            } else {
                return string.Empty;
            }
        }

        public void Print(string msg)
        {
            printUi(msg);
        }

        public void Print(string[] elements)
        {
            printUi(elements);
        }
        public string Read()
        {
            clickEvent.WaitOne();
            clickEvent.Reset();
            return RetornoUI;
        }

        public static string __Function()
        {
            StackTrace stackTrace = new StackTrace();
            return stackTrace.GetFrame(1).GetMethod().Name;
        }
    }
}
