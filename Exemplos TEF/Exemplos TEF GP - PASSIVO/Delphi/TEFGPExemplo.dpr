program TEFGPExemplo;

uses
  Vcl.Forms,
  TEFGP in 'TEFGP.pas' {Form1},
  FuncDLL in 'FuncDLL.pas',
  TEFGPConectaImpressora in 'TEFGPConectaImpressora.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
