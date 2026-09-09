unit FormADM;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,System.JSON,
  Utils, FuncoesDLL, StrUtils, Vcl.Mask;
//
// Aplicativo Exemplo para E1_Tef Api, versão Delphi VCL
// Gabriel Franzeri @ Elgin, 2022
//
type
  TfrmAdm = class(TForm)
    lblOperador: TLabel;
    btnOk: TButton;
    txtOperador: TEdit;
    listOperador: TListBox;
    GroupBox1: TGroupBox;
    btnIniciarOperacao: TButton;
    Logs: TGroupBox;
    memoLogs: TMemo;
    GroupBox2: TGroupBox;
    btnCanc: TButton;

    // Prototypes
    // M�todos para o controle da transa��o (E1_Tef)
    procedure TesteApiElginTEF;
    function iniciar():String;
    function vender(cartao:Integer; sequencial:String):String;
    function adm(opcao:Integer; sequencial:String):String;
    function coletar(operacao:Integer; root:TJsonObject):String;
    function confirmar(sequencial:String):String;
    function finalizar():String;

    // M�todos utilit�rios
    function readInput():String;
    procedure writeLogs(logs:String);
    procedure print(msg:String);
    procedure printArray(elements : TStringList);
    procedure printArrayThread(elements : TStringList);

    // M�todos UI
    procedure btnOKClick(Sender: TObject);
    procedure btnCancClick(Sender: TObject);
    procedure btnIniciarOperacaoClick(Sender: TObject);
    procedure txtOperadorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    myThread : TThread;
    caso:Integer;
    retornoUI:String;
    cancelarColeta:String;
    txtOperadorTextoAtual : String;
    ApplyingMask: String;
  end;
var
  frmAdm: TfrmAdm;
implementation
const
  OPERACAO_VENDER = 0;
  OPERACAO_ADM = 1;


{$R *.dfm}

// ===================================================================== //
// ============================ MÉTODOS DE UI ========================== //
// ===================================================================== //

// handle da tecla "Enter" durante fase de coleta em que informações são 
// pedidas para o usuário
procedure TfrmAdm.txtOperadorKeyPress(Sender: TObject; var Key: Char);
var
  retList : String;
  retTxt : String;
  input,
  res: string;
  len,
  dotPos,
  dotIndex: Integer;
begin

// tecla "Enter"
if Key = #13 then
begin
  // mesmo código do btnOKClick

  // variável global usada no fluxo de transação para pegar retorno do usuário
  retornoUI := '';

  // Se usuário não escolher nenhuma opção, pedir para que seja escolhida 
  // uma opção
  if (listOperador.ItemIndex = -1) and (listOperador.Visible) then begin
      ShowMessage('Escolha uma op��o');
    exit;
  end;

  // NOTA: coleta tipo texto permite valor vazio - nao bloquear txt vazio aqui.
  // Se a operação exigir valor, a própria DLL retorna nova coleta.

  // pega valor escolhido pelo usuário
  retList := IntToStr(listOperador.ItemIndex);
  retTxt := txtOperador.Text;

  // reseta UI
  txtOperador.Text := '';
  lblOperador.Visible := false;
  txtOperador.Visible := false;
  btnOK.Visible := false;
  btnCanc.Visible := false;

  // define variável global como retorno do usuário
  if listOperador.Visible then begin
    retornoUI := retList;
  end else begin
    retornoUI := retTxt;
  end;
  listOperador.Visible := false;

  // retoma a execução da thread da transação
  myThread.Resume;
end;

// APLICA MASCARAS NO TEDIT
if ApplyingMask = '.##' then begin

  if (key = removeNonNumericChars(key)) or (key = #8) then begin
    if key = removeNonNumericChars(key) then
      dotIndex := 1;
    if key = #8 then
      dotIndex := 3;

    res := maskValor(txtOperador.Text, dotIndex);

    txtOperador.Text := res;
    txtOperador.SelStart := length(res);
  end;
end else if ApplyingMask = 'dd\/MM\/yyyy' then begin
    res := maskDate(txtOperador.Text);

    txtOperador.Text := res;
    txtOperador.SelStart := length(res);
end;

end;

// handle da tecla "Enter" durante fase de coleta em que informações são 
// pedidas para o usuário
procedure TfrmAdm.btnOKClick(Sender: TObject);
var
  retList : String;
  retTxt : String;
begin
  // variável global usada no fluxo de transação para pegar retorno do usuário
  retornoUI := '';

  // Se usuário não escolher nenhuma opção, pedir para que seja escolhida 
  // uma opção
  if (listOperador.ItemIndex = -1) and (listOperador.Visible) then begin
      ShowMessage('Escolha uma op��o');
    exit;
  end;

  // NOTA: coleta tipo texto permite valor vazio - nao bloquear txt vazio aqui.

  // pega valor escolhido pelo usuário
  retList := IntToStr(listOperador.ItemIndex);
  retTxt := txtOperador.Text;

  // reseta UI
  txtOperador.Text := '';
  lblOperador.Visible := false;
  txtOperador.Visible := false;
  btnOK.Visible := false;
  btnCanc.Visible := false;

  // define variável global como retorno do usuário
  if listOperador.Visible then begin
    retornoUI := retList;
  end else begin
    retornoUI := retTxt;
  end;
  listOperador.Visible := false;

  // retoma execução da thread da transação
  myThread.Resume;
end;

// botão 'Cancelar'
procedure TfrmAdm.btnCancClick(Sender: TObject);
begin
  // define a variável global retornoUI = 0 
  retornoUI := '';

  // define variavel global cancelarColeta = 9 para que quando o fluxo da 
  // transação for retomado, a transação seja cancelada (na função coleta)
  cancelarColeta := '9';

  // retorma execução da thread da transação
  myThread.Resume;
end;

// botão que inicia o fluxo de uma transação ADM
procedure TfrmAdm.btnIniciarOperacaoClick(Sender: TObject);
begin

  // antes de começar a transação, feedback visual para o usuário saber que 
  // a transação irá iniciar
  lblOperador.Visible := true;
  lblOperador.Caption := 'AGUARDE...';


  //INSTANCIA THREAD RESPONSAVEL POR INICIAR A TRANSA��O
  //NESSE EXEMPLO A TRANSA��O � FEITA EM UMA THREAD PARA N�O OCORRER CONGELAMENTO
  //DA TELA PRINCIPAL
  myThread := TThread.CreateAnonymousThread(
    procedure
      begin
        try
          // chama a função que contém o fluxo principal da transação
          // https://elgindevelopercommunity.github.io/group__t20.html
          TesteApiElginTEF;
        except
        on E : Exception do
        begin
          writeLogs('Exception [nome da classe]: '+ E.ClassName +
                #13#10 + 'Exception [mensagem]: '+E.Message +
                #13#10 + 'PILHA: ' + E.StackTrace);
          end;
        end;
      end
  );
  // começa a execução da thread
  myThread.start();
end;

// Função usada na fase de coleta para mostrar elementos e escritas enviadas 
// pela API em formato de String à Automação Comercial
procedure TfrmAdm.print(msg:String);
begin
  // sincroniza com a thread da UI para mostrar elementos
  TThread.Synchronize(nil, procedure
  begin
    // reseta UI
    listOperador.Visible := false;
    txtOperador.Visible := false;
    btnOK.Visible := false;
    btnCanc.Visible := false;
    lblOperador.Caption := msg;
    lblOperador.Visible := true;

    // não mostra na tela nem os botões nem o TEdit durante processamentos
    if naoContem(msg) then begin
      txtOperador.Visible := true;
      txtOperador.SetFocus;
      btnOK.Visible := true;
      btnCanc.Visible := true;
    end;
  end
  );
end;

// Função usada na fase de coleta para mostrar elementos e escritas enviadas 
// pela API em formato de TStringList à Automação Comercial
procedure TfrmAdm.printArray(elements : TStringList);
begin
  TThread.Synchronize(nil, procedure
    begin
      // sincroniza com a thread da UI para mostrar elementos
      printArrayThread(elements);
    end
  );
end;

// função chamada pela printArray
procedure TfrmAdm.printArrayThread(elements : TStringList);
var
  element : String;
begin
      // reseta UI
      listOperador.Clear;

      listOperador.Visible := false;
      txtOperador.Visible := false;
      btnOK.Visible := false;
      btnCanc.Visible := false;
      lblOperador.Visible := true;
      btnOK.Visible := true;

      // adiciona ao listOperador os elementos presentes no parâmetro da função
      for element in elements do
        listOperador.Items.Add(element);
      // torna o listOperador visível ao usuário
      listOperador.Visible := true;
end;

// escreve logs em tela
procedure TfrmAdm.writeLogs(logs:String);
var
  divLogs : String;
begin
  TThread.Synchronize(nil, procedure
    begin
      // cria uma string de divisão formatada com quebra linha
      divLogs := #13#10 + '==============================================' + #13#10;

      // adiciona a string de divisão seguida pelo conteúdo dos logs ao 
      // componente memoLogs
      memoLogs.Lines.Add(divLogs + logs);
    end
  );
end;
// ===================================================================== //
// ============================ LÓGICA DO TEF ========================== //
// ===================================================================== //
// =============================== TESTES ============================== //
// ===================================================================== //
procedure TfrmAdm.TesteApiElginTEF;
var
  start : String;
  retorno : String;
  sequencial : String;
  resp : String;
  comprovanteLoja : String;
  comprovanteCliente : String;
  cnf : String;
  endFinalizar : String;
begin
  // configuração inicial 
  // https://elgindevelopercommunity.github.io/group__t23.html
  FuncoesDLL.SetClientTCP('127.0.0.1', 60906);
  FuncoesDLL.ConfigurarDadosPDV('TEFElgin Delphi', 'v1.0.000', 'Elgin', '01', 'T0004');

  // 1) INICIAR CONEX�O COM CLIENT
  start := iniciar();

  // faz o parse do retorno da função iniciar
  retorno := getRetorno(start);
  // dependendo do resultado da função iniciar definido na variável "retorno" o 
  // fluxo poderá terminar ou continuar
  if (retorno = '') or (retorno <> '1') then begin
      finalizar();
      exit;
    end;

  // 2) REALIZAR OPERACAO

  // define a variável "sequencial" a partir do retorno da função "iniciar"
  // e incrementa seu valor para ser enviado na próxima chamada à API
  sequencial := getSequencial(start);
  sequencial := incrementarSequencial(sequencial);

  // possíveis chamadas a serem feitas
  // resp := vender(0, sequencial);   // Pgto --> Perguntar tipo do cartao
  // resp := vender(1, sequencial);   // Pgto --> Cartao de credito
  // resp := vender(2, sequencial);   // Pgto --> Cartao de debito
  // resp := vender(3, sequencial);   // Pgto --> Voucher (debito)
  // resp := vender(4, sequencial);   // Pgto --> Frota (debito)
  // resp := vender(5, sequencial);   // Pgto --> Private label (credito)
  // resp := adm(0, sequencial);      // Adm  --> Perguntar operacao
  // resp := adm(1, sequencial);      // Adm  --> Cancelamento
  // resp := adm(2, sequencial);      // Adm  --> Pendencias
  // resp := adm(3, sequencial);      // Adm  --> Reimpressao

  // POR SER A JANELA DE ADM, USAR A FUNÇÃO ADm
  resp := adm(0, sequencial);

  // extrair a chave "retorno" do retorno da função vender
  retorno := getRetorno(resp);
  // se a chave retorno não estiver presente, ou seja, for igual a '', 
  // continuar para o fluxo de coleta
  if retorno = '' then
  // Continuar operacao/iniciar o processo de coleta
    begin
      // 0 para coletar vendas, 1 para coletar adm
      resp := coletar(OPERACAO_ADM, jsonify(resp));
      // extrair a chave "retorno" do retorno da função coletar
      retorno := getRetorno(resp);
    end;

  // 3) VERIFICAR RESULTADO / CONFIRMAR
  // se a chave retorno não estiver presente no retorno da função "coletar", 
  // finalizar operação com erro
  if retorno = '' then
    begin
      writeLogs('ERRO AO COLETAR DADOS');
      print('ERRO AO COLETAR DADOS');
    end
  else if retorno = '0' then
   begin
    // extrair comprovantes das respectivas chaves no retorno da 
    // função "coletar"
    comprovanteLoja := getComprovante(resp, 'loja');
    comprovanteCliente := getComprovante(resp, 'cliente');
    writeLogs(comprovanteLoja);
    writeLogs(comprovanteCliente);
    writeLogs('TRANSA��O OK, INICIANDO CONFIRMAÇÃO...');
    print('TRANSA��O OK, INICIANDO CONFIRMAÇÃO...');

    // extrair valor da chave "sequencial" retornado pela função "coletar"
    sequencial := getSequencial(resp);

    // confirma a opera��o por meio do sequencial utilizado
    cnf := confirmar(sequencial);

    // extrair chave "retorno" do retorno da função confirmar
    retorno := getRetorno(cnf);
    // se chave retorno for varia ou diferente de '1' finalizar
    if (retorno = '') or (retorno <> '1') then
      finalizar();
   end
  else if retorno = '1' then
    begin
      writeLogs('TRANSAÇÃO OK');
      print('TRANSAÇÃO OK');
    end
  else
    begin
      writeLogs('ERRO NA TRANSAÇÃO');
      print('ERRO NA TRANSAÇÃO');
    end;

  // 4) FINALIZAR CONEXAO
  endFinalizar := finalizar();
  retorno := getRetorno(endFinalizar);
  if (retorno = '') or (retorno <> '1') then
    finalizar();
    exit;
end;

// ===================================================================== //
// ============ M�TODOS PARA O CONTROLE DA TRANSAÇÃO (E1_TEF) ========== //
// ===================================================================== //
function TfrmAdm.iniciar():String;
var
  payload : TJsonObject;
  resultado : UTF8String;
begin
  payload := TJsonObject.Create;

  // possíveis valores a serem adicionados ao payload, porém não necessários
  // se for escolhido usar os valores default definidos nas funções 

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

  // conforme a documentação: 
  // https://elgindevelopercommunity.github.io/group__tf.html#ga1bf9edea41af3c30936caf5ce7f8c988
  resultado := IniciarOperacaoTEF(stringify(payload));
  // mostrar na UI o retorno da função
  writeLogs('INICIAR: ' + jsonify(UTF8toString(resultado)).Format(2));
  // libera a memória ocupada pela instância de TJsonObject
  FreeAndNil(payload);

  // retorna a string retornada pela função IniciarOperacaoTEF
  result := UTF8ToString(resultado);
end;

// VENDER
function TfrmAdm.vender(cartao:Integer; sequencial:String):String;
var
  payload : TJsonObject;
  resultado : UTF8String;
begin
  payload := TJsonObject.Create;
  writeLogs('VENDER: ' + ' SEQUENCIAL UTILIZADO NA VENDA: ' + sequencial);
  payload.AddPair('sequencial', sequencial);

  resultado := FuncoesDLL.RealizarPagamentoTEF(cartao, stringify(payload), True);
  writeLogs('VENDER: ' + jsonify(UTF8ToString(resultado)).Format(2));
  FreeAndNil(payload);
  result := UTF8ToString(resultado);
end;

// ADM
function TfrmAdm.adm(opcao:Integer; sequencial:String):String;
var
  payload : TJsonObject; // Objeto JSON para armazenar os dados da transação
  resultado : UTF8String; // String UTF-8 para armazenar o resultado da transação
begin
  // Cria uma instância de TJsonObject para armazenar os dados da transação
  payload := TJsonObject.Create;
  // registra um log com o sequencial utilizado na venda
  writeLogs('ADM: ' + ' SEQUENCIAL UTILIZADO NA VENDA: ' + sequencial);
  // adiciona o sequencial ao objecto payload
  payload.AddPair('sequencial', sequencial);

  // payload.Add("admUsuario",                      ADM_USUARIO);
  // payload.Add("admSenha",                        ADM_SENHA);

  resultado := FuncoesDLL.RealizarAdmTEF(opcao, stringify(payload), True);

  // Registra um log com o resultado da transação formatado em JSON
  writeLogs('ADM: ' + jsonify(UTF8ToString(resultado)).Format(2));
  // Libera a memória ocupada pelo objeto payload
  FreeAndNil(payload);

  // Converte o resultado para uma string e retorna
  result := UTF8ToString(resultado);
end;

// COLETAR
// segue lógica de coleta explicada na documentação
// https://elgindevelopercommunity.github.io/group__t21.html
function TfrmAdm.coletar(operacao:Integer; root:TJsonObject):String;
var
  // chaves utilizadas na coleta
  coletaRetorno,      // In/Out; out: 0 = continuar coleta, 9 = cancelar coleta
  coletaSequencial,   // In/Out
  coletaMensagem,     // In/[Out]
  coletaTipo,         // In
  coletaOpcao,        // In
  coletaMascara,
  coletaInformacao : String;   // Out
  payload : TJsonObject;
  resp : UTF8String;
  retorno : String;
  opcoes : TStringList;
  elements : TStringList;
  i : Integer;
begin
  // extrai os dados da resposta / coleta
  coletaRetorno       := getStringValue(root, 'tef.automacao_coleta_retorno');
  coletaSequencial    := getStringValue(root, 'tef.automacao_coleta_sequencial');
  coletaMensagem      := getStringValue(root, 'tef.mensagemResultado');
  coletaTipo          := getStringValue(root, 'tef.automacao_coleta_tipo');
  coletaOpcao         := getStringValue(root, 'tef.automacao_coleta_opcao');
  coletaMascara       := getStringValue(root, 'tef.automacao_coleta_mascara');
  writeLogs('COLETAR: ' +  UpperCase(coletaMensagem));
  print(UpperCase(coletaMensagem));

  // em caso de erro, encerra coleta
  if coletaRetorno <> '0' then begin
    result := stringify(root);
    exit;
  end;

  ApplyingMask := coletaMascara;

  // em caso de sucesso, monta o (novo) payload e continua a coleta
  payload := TJsonObject.Create;
  payload.AddPair('automacao_coleta_retorno', coletaRetorno);
  payload.AddPair('automacao_coleta_sequencial', coletaSequencial);

  // COLETA DADOS DO USUÀRIO
  // se a chave coletaTipo não for vazia e a chave coletaOpcao for vazia
  // quer dizer que a API está pedindo por um valor que o usuário 
  // precisa digitar
  if (coletaTipo <> '') and (coletaOpcao = '') then begin // valor inserido (texto)
    writeLogs('INFORME O VALOR SOLICITADO: ');
    coletaInformacao := readInput();

    // verifica variável global "cancelarColeta"
    // se houve cancelamento, adiciona a chave com cancelamento para avisar a dll
    if (cancelarColeta <> '') then begin
      payload.RemovePair('automacao_coleta_retorno');
      payload.AddPair('automacao_coleta_retorno', cancelarColeta);
      cancelarColeta := '';
    end;

    // adiciona no payload valor digitado pelo usuário
    payload.AddPair('automacao_coleta_informacao', coletaInformacao);
  end

  // se a chave coletaTipo não for vazia e a chave coletaOpcao também não for 
  // vazia quer dizer que a API está pedindo por um valor que o usuário 
  // precisa escolher dentre algumas opções
  else if (coletaTipo <> '') and (coletaOpcao <> '') then begin // valor selecionado (lista)

    // lógica que lê e separa as opções retornadas na chave 'automacao_coleta_opcao'
    // presentes na variável 'coletaOpcao'
    opcoes := TStringList.Create;
    elements := TStringList.Create;
    Split(';', coletaOpcao, opcoes);
    for i := 0 to opcoes.Count - 1 do
    begin
      elements.Add('[' + IntToStr(i) + ']' + UpperCase(opcoes[i]) + #13#10);
    end;
    for i := 0 to opcoes.Count - 1 do
    begin
      writeLogs('[' + IntToStr(i) + '] ' + UpperCase(opcoes[i]) + #13#10)
    end;

    // mostra na UI a lista de opções para que o usuário selecione
    printArray(elements);
    writeLogs(#13#10 + 'DIGITE A OPÇÃO DESEJADA: ');

    // espera o input do usuário para continuar o fluxo. Função readInput irá 
    // retornar o index do array da opção escolhida
    coletaInformacao := opcoes[strtoint(readInput())];

    // verifica variável global "cancelarColeta"
    // se houve cancelamento, adiciona a chave com cancelamento para avisar a dll
    if (cancelarColeta <> '') then begin
      payload.RemovePair('automacao_coleta_retorno');
      payload.AddPair('automacao_coleta_retorno', cancelarColeta);
      cancelarColeta := '';
    end;

    // adiciona no payload valor escolhido pelo usuário
    payload.AddPair('automacao_coleta_informacao', coletaInformacao);
    // libera a memória ocupada pela instância de TJsonObject
    FreeAndNil(elements);
  end;

  // informa od dados coletados
  if operacao = OPERACAO_ADM then begin
    resp := FuncoesDLL.RealizarAdmTEF(0, stringify(payload), false);
  end
  else begin
    resp := FuncoesDLL.RealizarPagamentoTEF(0, stringify(payload), false);
  end;

  // libera a memória ocupada pela instância de TJsonObject
  FreeAndNil(payload);

  writeLogs(jsonify(UTF8ToString(resp)).Format(2));

  // verifica fim da coleta
  retorno := getRetorno(UTF8ToString(resp));
  if retorno <> '' then begin
    result := UTF8ToString(resp);
    exit;
  end;
  // passa para próxima fase da coleta chamando novamente a função até que 
  // a coleta seja finalizada
  result := coletar(operacao, jsonify(UTF8ToString(resp)));
end;

// função que confirma transações realizadas
function TfrmAdm.confirmar(sequencial:String):String;
var
  resultado : UTF8String;
begin
  writeLogs('CONFIRMAR: ' + 'SEQUENCIAL DA OPERA��O A SER CONFIRMADA: ');
  print('AGUARDE, CONFIRMANDO OPERAÇÃO...');

  resultado := FuncoesDLL.ConfirmarOperacaoTEF(strtoint(sequencial), 1);
  writeLogs('CONFIRMAR: ' + jsonify(UTF8ToString(resultado)).Format(2));
  result := UTF8ToString(resultado);
end;

function TfrmAdm.finalizar():String;
var
  resultado : UTF8String;
begin
  resultado := FuncoesDLL.FinalizarOperacaoTEF(1); // api resolve o sequencial
  writeLogs('Finalizar: ' + jsonify(UTF8ToString(resultado)).Format(2));
  print('OPERAÇÃO FINALIZADA');
  result := UTF8ToString(resultado);
end;

// ===================================================================== //
// ========== METODOS UTILITÁRIOS PARA O EXEMPLO DELPHI ================ //
// ===================================================================== //

// função chamada quando necessário pegar algum retorno do usuário
// após pausar a thread da transação, quando o usuário informar o dado pedido 
// na UI, a thread recomeça a a função retorna o valor na variável global retornoUI
function TfrmAdm.readInput():String;
begin
  myThread.Suspended := true; //PAUSA A THREAD AGUARDANDO A ENTRADA DO USUARIO...
  result := retornoUI;
end;

end.
