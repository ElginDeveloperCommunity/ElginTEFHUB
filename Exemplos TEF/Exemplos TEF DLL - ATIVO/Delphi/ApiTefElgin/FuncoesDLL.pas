unit FuncoesDLL;

// Interface com funcoes exportadas da DLL E1_Tef01.dll
// Carregamento dinamico com procura em C:\Elgin\TEF por padrao.

interface

uses
  Winapi.Windows, System.SysUtils;

const
  DLL_NOME = 'E1_Tef01.dll';
  DLL_CAMINHO_PADRAO = 'C:\Elgin\TEF\E1_Tef01.dll';

  // Carrega a DLL. Se ACaminho for vazio, usa somente:
  //   C:\Elgin\TEF\E1_Tef01.dll
  // Retorna True se carregou e resolveu todas as funcoes.
  function CarregarDLLTEF(const ACaminho: string = ''): Boolean;
  procedure DescarregarDLLTEF;
  function DLLTEFCarregada: Boolean;
  function CaminhoDLLTEF: string;

  function SetClientTCP(ip: PAnsiChar; porta: Integer): PAnsiChar; stdcall;

  function ConfigurarDadosPDV(textoPinpad: PAnsiChar; versaoAC: PAnsiChar; nomeEstabelecimento: PAnsiChar; loja: PAnsiChar; identificadorPontoCaptura: PAnsiChar): PAnsiChar; stdcall;

  function IniciarOperacaoTEF(dadosCaptura: PAnsiChar): PAnsiChar; stdcall;

  function RecuperarOperacaoTEF(dadosCaptura: PAnsiChar): PAnsiChar; stdcall;

  function RealizarPagamentoTEF(codigoOperacao: Integer; dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall;

  function RealizarPixTEF(dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall;

  function RealizarAdmTEF(codigoOperacao: Integer; dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall;

  function ConfirmarOperacaoTEF(id: Integer; acao: Integer): PAnsiChar; stdcall;

  function FinalizarOperacaoTEF(id: Integer): PAnsiChar; stdcall;

  function RealizarColetaPinPad(tipoColeta: integer; confirmar: boolean): PAnsiChar; stdcall;

  function ConfirmarCapturaPinPad(tipoCaptura: integer; dadosCaptura: PAnsiChar): PAnsiChar; stdcall;

implementation

var
  DLLHandle: THandle = 0;
  FCaminhoDLL: string = '';

  _SetClientTCP: function(ip: PAnsiChar; porta: Integer): PAnsiChar; stdcall = nil;
  _ConfigurarDadosPDV: function(textoPinpad: PAnsiChar; versaoAC: PAnsiChar; nomeEstabelecimento: PAnsiChar; loja: PAnsiChar; identificadorPontoCaptura: PAnsiChar): PAnsiChar; stdcall = nil;
  _IniciarOperacaoTEF: function(dadosCaptura: PAnsiChar): PAnsiChar; stdcall = nil;
  _RecuperarOperacaoTEF: function(dadosCaptura: PAnsiChar): PAnsiChar; stdcall = nil;
  _RealizarPagamentoTEF: function(codigoOperacao: Integer; dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall = nil;
  _RealizarPixTEF: function(dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall = nil;
  _RealizarAdmTEF: function(codigoOperacao: Integer; dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall = nil;
  _ConfirmarOperacaoTEF: function(id: Integer; acao: Integer): PAnsiChar; stdcall = nil;
  _FinalizarOperacaoTEF: function(id: Integer): PAnsiChar; stdcall = nil;
  _RealizarColetaPinPad: function(tipoColeta: integer; confirmar: boolean): PAnsiChar; stdcall = nil;
  _ConfirmarCapturaPinPad: function(tipoCaptura: integer; dadosCaptura: PAnsiChar): PAnsiChar; stdcall = nil;

function DLLTEFCarregada: Boolean;
begin
  Result := (DLLHandle <> 0) and Assigned(_SetClientTCP);
end;

function CaminhoDLLTEF: string;
begin
  Result := FCaminhoDLL;
end;

procedure LimparPonteiros;
begin
  _SetClientTCP := nil;
  _ConfigurarDadosPDV := nil;
  _IniciarOperacaoTEF := nil;
  _RecuperarOperacaoTEF := nil;
  _RealizarPagamentoTEF := nil;
  _RealizarPixTEF := nil;
  _RealizarAdmTEF := nil;
  _ConfirmarOperacaoTEF := nil;
  _FinalizarOperacaoTEF := nil;
  _RealizarColetaPinPad := nil;
  _ConfirmarCapturaPinPad := nil;
end;

function ResolverFuncoes: Boolean;
begin
  @_SetClientTCP := GetProcAddress(DLLHandle, 'SetClientTCP');
  @_ConfigurarDadosPDV := GetProcAddress(DLLHandle, 'ConfigurarDadosPDV');
  @_IniciarOperacaoTEF := GetProcAddress(DLLHandle, 'IniciarOperacaoTEF');
  @_RecuperarOperacaoTEF := GetProcAddress(DLLHandle, 'RecuperarOperacaoTEF');
  @_RealizarPagamentoTEF := GetProcAddress(DLLHandle, 'RealizarPagamentoTEF');
  @_RealizarPixTEF := GetProcAddress(DLLHandle, 'RealizarPixTEF');
  @_RealizarAdmTEF := GetProcAddress(DLLHandle, 'RealizarAdmTEF');
  @_ConfirmarOperacaoTEF := GetProcAddress(DLLHandle, 'ConfirmarOperacaoTEF');
  @_FinalizarOperacaoTEF := GetProcAddress(DLLHandle, 'FinalizarOperacaoTEF');
  @_RealizarColetaPinPad := GetProcAddress(DLLHandle, 'RealizarColetaPinPad');
  @_ConfirmarCapturaPinPad := GetProcAddress(DLLHandle, 'ConfirmarCapturaPinPad');

  Result := Assigned(_SetClientTCP) and Assigned(_ConfigurarDadosPDV) and
    Assigned(_IniciarOperacaoTEF) and Assigned(_RecuperarOperacaoTEF) and
    Assigned(_RealizarPagamentoTEF) and Assigned(_RealizarPixTEF) and
    Assigned(_RealizarAdmTEF) and Assigned(_ConfirmarOperacaoTEF) and
    Assigned(_FinalizarOperacaoTEF) and Assigned(_RealizarColetaPinPad) and
    Assigned(_ConfirmarCapturaPinPad);
end;

function TentarCarregar(const ACaminho: string): Boolean;
begin
  Result := False;
  if ACaminho = '' then
    Exit;
  // LoadLibrary com caminho completo procura exatamente ali
  DLLHandle := LoadLibrary(PChar(ACaminho));
  if DLLHandle = 0 then
    Exit;
  if ResolverFuncoes then
  begin
    FCaminhoDLL := ACaminho;
    Result := True;
  end
  else
  begin
    FreeLibrary(DLLHandle);
    DLLHandle := 0;
    LimparPonteiros;
  end;
end;

function CarregarDLLTEF(const ACaminho: string = ''): Boolean;
begin
  // Ja carregada: nada a fazer
  if DLLTEFCarregada then
    Exit(True);

  // Caminho explicito informado pelo chamador tem prioridade,
  // caso contrario usa somente a pasta padrao da Elgin.
  if ACaminho <> '' then
    Exit(TentarCarregar(ACaminho));

  Result := TentarCarregar(DLL_CAMINHO_PADRAO);
end;

procedure DescarregarDLLTEF;
begin
  if DLLHandle <> 0 then
  begin
    FreeLibrary(DLLHandle);
    DLLHandle := 0;
  end;
  FCaminhoDLL := '';
  LimparPonteiros;
end;

procedure GarantirCarregada;
begin
  if not DLLTEFCarregada then
  begin
    if not CarregarDLLTEF then
      raise Exception.Create(
        'Nao foi possivel carregar ' + DLL_NOME + '.' + sLineBreak +
        'Verifique se a DLL existe em ' + DLL_CAMINHO_PADRAO);
  end;
end;

// ---- Wrappers (mantem a mesma assinatura usada pelo restante do projeto) ----

function SetClientTCP(ip: PAnsiChar; porta: Integer): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _SetClientTCP(ip, porta);
end;

function ConfigurarDadosPDV(textoPinpad: PAnsiChar; versaoAC: PAnsiChar; nomeEstabelecimento: PAnsiChar; loja: PAnsiChar; identificadorPontoCaptura: PAnsiChar): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _ConfigurarDadosPDV(textoPinpad, versaoAC, nomeEstabelecimento, loja, identificadorPontoCaptura);
end;

function IniciarOperacaoTEF(dadosCaptura: PAnsiChar): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _IniciarOperacaoTEF(dadosCaptura);
end;

function RecuperarOperacaoTEF(dadosCaptura: PAnsiChar): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _RecuperarOperacaoTEF(dadosCaptura);
end;

function RealizarPagamentoTEF(codigoOperacao: Integer; dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _RealizarPagamentoTEF(codigoOperacao, dadosCaptura, novaTransacao);
end;

function RealizarPixTEF(dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _RealizarPixTEF(dadosCaptura, novaTransacao);
end;

function RealizarAdmTEF(codigoOperacao: Integer; dadosCaptura: PAnsiChar; novaTransacao: Boolean): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _RealizarAdmTEF(codigoOperacao, dadosCaptura, novaTransacao);
end;

function ConfirmarOperacaoTEF(id: Integer; acao: Integer): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _ConfirmarOperacaoTEF(id, acao);
end;

function FinalizarOperacaoTEF(id: Integer): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _FinalizarOperacaoTEF(id);
end;

function RealizarColetaPinPad(tipoColeta: integer; confirmar: boolean): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _RealizarColetaPinPad(tipoColeta, confirmar);
end;

function ConfirmarCapturaPinPad(tipoCaptura: integer; dadosCaptura: PAnsiChar): PAnsiChar; stdcall;
begin
  GarantirCarregada;
  Result := _ConfirmarCapturaPinPad(tipoCaptura, dadosCaptura);
end;

initialization
  // Tenta carregar na inicializacao para manter o comportamento antigo
  // (falha silenciosa aqui; o erro so aparece ao chamar a primeira funcao).
  CarregarDLLTEF;

finalization
  DescarregarDLLTEF;

end.
