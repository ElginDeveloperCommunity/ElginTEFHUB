unit TEFGP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StrUtils, FuncDLL, TEFGPConectaImpressora;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    edtValor: TEdit;
    btnAdm: TButton;
    btnReimpressao: TButton;
    btnVenda: TButton;
    btnConfirmarVenda: TButton;
    btnNaoConfirmarVenda: TButton;
    btnCancelamentoVenda: TButton;
    btnConectarImpressora: TButton;
    Button8: TButton;
    memoDados: TMemo;
    procedure btnVendaClick(Sender: TObject);
    procedure btnConfirmarVendaClick(Sender: TObject);
    procedure btnNaoConfirmarVendaClick(Sender: TObject);
    procedure btnCancelamentoVendaClick(Sender: TObject);
    procedure btnAdmClick(Sender: TObject);
    procedure btnConectarImpressoraClick(Sender: TObject);
    procedure btnReimpressaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    procedure EscreverDadosLog(linhas : array of string);
    procedure EscreverDadosArquivo(linhas : array of string);
    procedure RenomearArquivo;
    procedure LimpaDadosLog;
    procedure EnviarDados(linhas : array of string);
    procedure CriaDiretoriosBase;
    function BuscaComprovante: string;
  public
    { Public declarations }
    tipo       : integer;             
    modelo    : string;   
    conexao   : string;
    parametro : integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
// CRIA OS DIRETÓRIOS ONDE ACONTECE A TROCA DE ARQUIVO SE ELES NÃO EXISTIREM
procedure TForm1.CriaDiretoriosBase;
begin
  if not DirectoryExists('C:\Cliente\Req') then
    ForceDirectories('C:\Cliente\Req');
  if not DirectoryExists('C:Cliente\Resp') then
    ForceDirectories('C:\Cliente\Resp');            
end;

// ESCREVE OS DADOS ENVIADOS NA INTERFACE DO USUÁRIO
procedure TForm1.EscreverDadosLog(linhas : array of string);
var
  sl : TStringList;
  i: integer;
begin
  sl := TStringList.Create; // cria o objeto de TStringList  
  // adiciona à variável "sl" os dados do array "linhas"
  for i := Low(linhas) to High(linhas) do
    sl.Add(linhas[i]);          
  memoDados.Text := sl.Text;     
  sl.Free; // libera espaço do objeto "sl"                        
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CriaDiretoriosBase;
end;

// LIMPA OS DADOS ESCRITOS NA UI
procedure TForm1.LimpaDadosLog;
begin
  memoDados.Lines.Clear();
end;

// ESCREVE DADOS NOS ARQUIVOS
procedure TForm1.EscreverDadosArquivo(linhas : array of string);
var
  fn       : TextFile;
  sl       : TStringList;
  fnString : string;
  i        : integer;
begin                      
  // tenta abrir arquivo, se não existir, o cria  
  AssignFile(fn, 'C:\Cliente\Req\Intpos.tmp'); 
  ReWrite(fn); // desconsidera texto existente no arquivo  
  CloseFile(fn); // fecha o arquivo     
                                            
  fnString := 'C:\Cliente\Req\Intpos.tmp'; // path do arquivo    
  sl := TStringList.Create; // cria objeto de TStringList    
  // adiciona à variável "sl" os dados do array "linhas"
  for i := Low(linhas) to High(linhas) do
    sl.Add(linhas[i]);          
  memoDados.Text := sl.Text;     
  sl.SaveToFile(fnString); // escreve no arquivo
  sl.Free;
end;

// RENOMEIA ARQUIVO
procedure TForm1.RenomearArquivo;
var 
  oldName, newName : string;
begin
  oldName := 'C:\Cliente\Req\Intpos.tmp';
  newName := ChangeFileExt(oldName, '.001');
  DeleteFile(newName);
  if not RenameFile(oldName, newName) then
    ShowMessage('Ocorreu um erro na hora de renoemar o arquivo ' +
                'C:\Cliente\Req\intpos.tmp:\n\n' +
                IntToStr(GetLastError));   
  end;

// PROCEDURE PRINCIPAL EM TODOS OS BOTÕES MENOS O DA IMPRESSORA
procedure TForm1.EnviarDados(linhas : array of string);
begin
  LimpaDadosLog;
  EscreverDadosArquivo(linhas);
  EscreverDadosLog(linhas);
  RenomearArquivo
end;

// BUSCA NO ARQUIVO O COMPROVANTE
function TForm1.BuscaComprovante : string;
var
  i                 : integer;
  ii                : integer;
  i_b               : integer; // contador linhas em branco
  tamanho_array     : integer;
  strFinal          : string;
  fn                : TextFile;
  linhas_lista      : array of string;
  linhas_escolhidas : TStringList;
  linhas_formatadas : array of string;
begin
  // Lê linhas comprovante e colocar em um array
  SetLength(linhas_lista, 512);
  AssignFile(fn, 'C:\Cliente\Resp\Intpos.001');
  Reset(fn); // abre arquivo
  i := 0;
  while not Eof(fn) do
    begin
    ReadLn(fn, linhas_lista[i]);
    i := i + 1;
    end;
  CloseFile(fn);

  // Seleciona as linhas que representam o comprovante
  linhas_escolhidas := TStringList.Create;
  ii := 0;
  for i := Low(linhas_lista) to High(linhas_lista) do
    begin
      if ContainsText(linhas_lista[i], '029') then
        begin
          linhas_escolhidas.Add(linhas_lista[i]);
        end
      else
        ii := ii;
    end;

  // formata as linhas que representam o comprovante
  tamanho_array := linhas_escolhidas.Count;
  SetLength(linhas_formatadas, tamanho_array);
  for i := 0 to linhas_escolhidas.Count-1 do
    linhas_formatadas[i] := Copy(linhas_escolhidas[i], 10);

  // escreve comprovante na UI
  EscreverDadosLog(linhas_formatadas);

  strFinal := System.String.Join(sLineBreak, linhas_formatadas);
  Result := strFinal;  
end;

// ========================================================================== //
// ========================== EVENTOS DOS BOTÕES ============================ //                                                
// ========================================================================== //

procedure TForm1.btnAdmClick(Sender: TObject);
var
  linhas : array of string;
begin
  linhas := ['000-000 = ADM',
             '001-000 = 1',
             '999-999 = 0']; 
  EnviarDados(linhas);
end;

procedure TForm1.btnCancelamentoVendaClick(Sender: TObject);
var
  linhas : array of string;
begin
  linhas := ['000-000 = CNC',
             '001-000 = 1',
             '999-999 = 0']; 
  EnviarDados(linhas);
end;

procedure TForm1.btnConectarImpressoraClick(Sender: TObject);
begin
  Form2.Show;   
end;

procedure TForm1.btnConfirmarVendaClick(Sender: TObject);
var
  linhas : array of string;
begin
  linhas := ['000-000 = CNF',
             '001-000 = 1',
             '027-000 = 123456',
             '999-999 = 0']; 
  EnviarDados(linhas);
end;

procedure TForm1.btnNaoConfirmarVendaClick(Sender: TObject);
var
  linhas : array of string;
begin
  linhas := ['000-000 = NCN',
             '001-000 = 1',
             '027-000 = 123456',
             '999-999 = 0']; 
  EnviarDados(linhas);
  EnviarDados(linhas);
end;

procedure TForm1.btnReimpressaoClick(Sender: TObject);
var
  res : integer;
  txt : string;
begin
 // se conexão com impressora for feita, começar processo de impressão do comprovante
 if Form2.con then
 begin
    // BuscaComprovante
    txt := BuscaComprovante;
    ShowMessage(txt);
    res := FuncDLL.AbreConexaoImpressora(tipo, PAnsiChar(AnsiString(modelo)), 
                                         PAnsiChar(AnsiString(conexao)), 
                                         parametro);
    if res = 0 then
    begin 
      FuncDLL.ImpressaoTexto(PAnsiChar(AnsiString(txt)), 0, 1, 0);
      FuncDLL.AvancaPapel(4);
      FuncDLL.Corte(1);
      FuncDLL.FechaConexaoImpressora();
    end
    else
      ShowMessage('Houve um problema ao abrir a conexão com a impressora' + 
                  sLineBreak + IntToStr(res) + sLineBreak + 
                  IntToStr(tipo) + String(AnsiString(modelo)) + String(AnsiString(conexao)) + 
                  IntToStr(parametro));
 end
 else
  ShowMessage('Antes de Imprimir, por favor conectar a impressora');
end;

procedure TForm1.btnVendaClick(Sender: TObject);
var
  linhas : array of string;
begin
  linhas := ['000-000 = CRT',
             '001-000 = 1',
             '002-000 = 123456',
             '003-000 = ' + edtValor.Text ,
             '004-000 = 0',
             '999-999 = 0']; 
  EnviarDados(linhas);
end;

end.
