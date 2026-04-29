unit TEFGPConectaImpressora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FuncDLL;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtTipo: TEdit;
    edtConexao: TEdit;
    edtModelo: TEdit;
    edtParametro: TEdit;
    btnConectarImpressora: TButton;
    procedure btnConectarImpressoraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    con : bool;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses TEFGP;

procedure TForm2.btnConectarImpressoraClick(Sender: TObject);
var
  ret : integer;
begin
  Form1.tipo := StrToInt(edtTipo.Text);
  Form1.modelo := edtModelo.Text;
  Form1.conexao := edtConexao.Text;
  Form1.parametro := StrToInt(edtParametro.Text);

  ret := FuncDLL.AbreConexaoImpressora(Form1.tipo,
                                       PAnsiChar(AnsiString(Form1.modelo)),
                                       PAnsiChar(AnsiString(Form1.conexao)),
                                       Form1.parametro);
  if ret = 0 then
    begin
      con := true;
      FuncDLL.FechaConexaoImpressora;
      ShowMessage('Impressora Conectada com Sucesso!');
    end
  else
    begin
      con := false;
      FuncDLL.FechaConexaoImpressora;
      ShowMessage('Erro na hora de Conectar com a Impressora' + sLineBreak +
                IntToStr(ret));
    end;
end;

end.
