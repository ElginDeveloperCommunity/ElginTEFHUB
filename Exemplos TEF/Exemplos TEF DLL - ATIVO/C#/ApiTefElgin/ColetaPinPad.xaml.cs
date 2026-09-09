using System;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Runtime.InteropServices;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace WpfTesteVs
{
    /// <summary>
    /// Lógica interna para ColetaPinPad.xaml
    /// </summary>
    public partial class ColetaPinPad : Window
    {

        // ===================================================================== //
        // ============ CARREGAMENTO DAS FUNÇÕES DA DLL ================== //
        // ===================================================================== //
        public const string PATH = @"C:\Elgin\TEF\E1_Tef01.dll";
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr IniciarOperacaoTEF(string dadosCaptura);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr FinalizarOperacaoTEF(int id);
        
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr RealizarColetaPinPad(int tipoColeta, bool confirmar);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr ConfirmarCapturaPinPad(int tipoColeta, string dadosCaptura);

        private const string hrLogs = "\n=================================\n";

        public ColetaPinPad()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            // as funções de coleta dos valores com o pinpad não dependem do fluxo de transação
            // da api (como descrito na documentação), mas precisam que a conexão com o pinpad 
            // esteja aberta. A conexão com o pinpad fica aberta entre os passos 1 e 4 descritos
            // na documentação, ou seja, entre o uso das funções IniciarOperacaoTEF e FinalizarOperacaoTEF.

            // inicia a conexão do tef
            lblValorColetado.Content = "_";
            txtLogs.Text = "INICIANDO OPERAÇÃO";

            // selecione o index da combobox
            int cmbIndex = cmbTipoColeta.SelectedIndex;
            if (cmbIndex == -1)
            {
                _ = MessageBox.Show("Selecione o tipo da operação");
                _ = cmbTipoColeta.Focus();
                return;
            }

            // inicia operação tef
            IntPtr _intptr = IniciarOperacaoTEF("{}");
            string start = Marshal.PtrToStringAnsi(_intptr);
            txtLogs.Text += start;

            // adiciona 1 para corresponder aos valores na documentação
            // 1 - RG
            // 2 - CPF
            // 3 - CNPJ
            // 4 - Telefone
            int tipoColeta = cmbIndex + 1;
            bool confirmar = (bool)rdbConfirm.IsChecked;

            // logs das opções escolhidas
            txtLogs.Text += hrLogs;
            txtLogs.Text += "\nOPÇÕES ESCOLHIDAS\ntipoColeta: " + tipoColeta +
                            "\nconfirmar: " + confirmar;

            // realiza a coleta
            IntPtr _intptrColeta = RealizarColetaPinPad(tipoColeta, confirmar);
            string coleta = Marshal.PtrToStringAnsi(_intptrColeta);

            // checkar se a operação foi bem sucedida ou não
            string resultadoPinPad;
            if (int.Parse(getRetorno(coleta)) == 1)
            {
                // pega o valor digitado pelo usuário no pinpad
                resultadoPinPad = getStringValue(jsonify(coleta), "tef", "resultadoCapturaPinPad");
                txtLogs.Text += "\nRESULTADO CAPTURA: " + resultadoPinPad;
                lblValorColetado.Content = resultadoPinPad;
            } else
            {
                finalizar(getStringValue(jsonify(coleta), "tef", "mensagemResultado"));
                return;
            }

            // logs do retorno da DLL
            txtLogs.Text += hrLogs;
            txtLogs.Text += "\nRETORNO DLL: RealizarcoletaPinPad";
            txtLogs.Text += coleta;


            // se a variável <confirmar> for true, a confirmação será feita automaticamente
            // caso o desenvolvedor queira fazer algo com o valor antes da confirmação,
            // ele pode usar a função ConfirmarCapturaPinPad como exemplificado a seguir:
            if (confirmar)
            {
                finalizar("\nFIM DA OPERAÇÃO");
                return;
            }

            txtLogs.Text += hrLogs;
            txtLogs.Text += "\nINICIANDO CONFIRMAÇÃO";

            // faz algo com o valor coletado
            // nesse exemplo são adicionadas as máscaras dos valores
            switch (tipoColeta)
            {
                case 1: resultadoPinPad = FormatRG(resultadoPinPad); break;
                case 2: resultadoPinPad = FormatCPF(resultadoPinPad); break;
                case 3: resultadoPinPad = FormatCNPJ(resultadoPinPad); break;
                case 4: resultadoPinPad = FormatPhone(resultadoPinPad); break;
                default:
                    break;
            }

            IntPtr ptrRealizaConfirmacao = ConfirmarCapturaPinPad(tipoColeta, resultadoPinPad);
            string retornoConfirmacao = Marshal.PtrToStringAnsi(ptrRealizaConfirmacao);

            // checkar se a operação foi bem sucedida ou não
            if (int.Parse(getRetorno(retornoConfirmacao)) == 1) {
                // pega o valor digitado pelo usuário no pinpad
                resultadoPinPad = getStringValue(jsonify(retornoConfirmacao), "tef", "resultadoCapturaPinPad");
                txtLogs.Text += "\nRESULTADO CONFIRMAÇÃO: " + resultadoPinPad;
                lblValorColetado.Content = resultadoPinPad;
                // logs do retorno da DLL
                txtLogs.Text = "\nRETORNO DLL: ConfirmarCapturaPinPad" + retornoConfirmacao;
            } else
            {
                finalizar(getStringValue(jsonify(retornoConfirmacao), "tef", "mensagemResultado"));
                return;
            }

            // finalizar operação
            finalizar("FIM DA OPERAÇÃO");
        }

        private void finalizar(string reason)
        {
            txtLogs.Text += hrLogs;
            txtLogs.Text += "FINALIZANDO OPERAÇÃO - REASON: " + reason;

            // Finalizando operação
            IntPtr _ptrRetorno = FinalizarOperacaoTEF(1); // api resolve o sequencial
            string retorno = Marshal.PtrToStringAnsi(_ptrRetorno);
            if (int.Parse(getRetorno(retorno)) == 1)
            {
                txtLogs.Text += hrLogs;
                txtLogs.Text += "FINALIZADA OPERAÇÃO COM SUCESSO!";
            } else
            {
                txtLogs.Text += hrLogs;
                txtLogs.Text += "FINALIZADA OPERAÇÃO COM ERRO!";
                txtLogs.Text += retorno;
            }
        }

        private string getRetorno(string resp)
        {
            IDictionary<string, object> _jsonDic = jsonify(resp);
            return getStringValue(_jsonDic, "tef", "retorno");
            // return getStringValue(_jsonDic, "tef", "resultadoTransacao");
        }

        private IDictionary<string, object> jsonify(string jsonString)
        {
            if (jsonString != null) {
                IDictionary<string, object> _Dic = JsonConvert.DeserializeObject<Dictionary<string, object>>(jsonString);
                return _Dic;
            } else {
                IDictionary<string, object> _Dic = new Dictionary<string, object>();
                return _Dic;
            }
        }

        private string getStringValue(IDictionary<string, object> dicJson, string keyOut, string keyIn)
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

        private string getStringValue(IDictionary<string, object> dicJson, string key)
        {
            if (dicJson != null && dicJson.TryGetValue(key, out object value)) {
                return value.ToString();
            } else {
                return string.Empty;
            }
        }

        private string MultiInsert(string str, string insertChar, params int[] positions)
        {
            StringBuilder sb = new StringBuilder(str.Length + (positions.Length * insertChar.Length));
            HashSet<int> posLookup = new HashSet<int>(positions);
            for (int i = 0; i < str.Length; i++)
            {
                sb.Append(str[i]);
                if (posLookup.Contains(i))
                    sb.Append(insertChar);

            }
            return sb.ToString();
        }

        private string FormatCPF(string cpf)
        {
            return MultiInsert(cpf, ".", 2, 5).Insert(11, "-");
        }
        private string FormatRG(string rg)
        {
            return MultiInsert(rg, ".", 1, 4).Insert(10, "-");
        }
        private string FormatCNPJ(string cnpj)
        {
            return MultiInsert(cnpj, ".", 1, 4).Insert(9, "/").Insert(14, "-");
        }
        private string FormatPhone(string phone)
        {
            return "(" + phone.Insert(2, ")").Insert(8, "-");
        }

        private void txtLogs_TextChanged(object sender, TextChangedEventArgs e)
        {
            txtLogs.ScrollToEnd();
        }
    }
}
