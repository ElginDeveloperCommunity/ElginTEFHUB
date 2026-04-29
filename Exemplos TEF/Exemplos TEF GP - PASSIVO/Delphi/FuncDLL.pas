unit FuncDLL;

interface

  function AbreConexaoImpressora(tipo:Integer; modelo:PAnsiChar; conexao:PAnsiChar; parametro:Integer):Integer; stdcall; external 'E1_Impressora01.dll';
  function ImpressaoTexto(dados:PAnsiChar; posicao:integer; stilo:integer; tamanho:integer):integer; stdcall; external 'E1_Impressora01.dll';
  function Corte(avanco:integer):integer; stdcall; external 'E1_Impressora01.dll';
  function AvancaPapel(linhas : integer) : integer; stdcall; external 'E1_Impressora01.dll';
  function FechaConexaoImpressora() : integer; stdcall; external 'E1_Impressora01.dll';

implementation

end.
