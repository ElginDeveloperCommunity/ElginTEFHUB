Attribute VB_Name = "FuncoesDLL"

Public Declare Function GetProdutoTef Lib "C:\Elgin\TEF\E1_Tef01.dll" () As Integer
Public Declare Function GetClientTCP Lib "C:\Elgin\TEF\E1_Tef01.dll" () As String
Public Declare Function SetClientTCP Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal ip As String, ByVal porta As Long) As Long
Public Declare Function ConfigurarDadosPDV Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal textoPinpad As String, ByVal versaoAC As String, ByVal nomeEstabelecimento As String, ByVal loja As String, ByVal identificadorPontoCaptura As String) As Long
Public Declare Function IniciarOperacaoTEF Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal dadosCaptura As String) As Long
Public Declare Function RecuperarOperacaoTEF Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal dadosCaptura As String) As Long
Public Declare Function RealizarPagamentoTEF Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal codigoOperacao As Long, ByVal dadosCaptura As String, ByVal novaTransacao As Boolean) As Long
Public Declare Function RealizarPixTEF Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal dadosCaptura As String, ByVal novaTransacao As Boolean) As Long
Public Declare Function RealizarAdmTEF Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal codigoOperacao As Long, ByVal dadosCaptura As String, ByVal novaTransacao As Boolean) As Long
Public Declare Function ConfirmarOperacaoTEF Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal id As Long, ByVal acao As Long) As Long
Public Declare Function FinalizarOperacaoTEF Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal id As Long) As Long
Public Declare Function RealizarColetaPinPad Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal tipoColeta As Long, ByVal confirmar As Boolean) As Long
Public Declare Function ConfirmarCapturaPinPad Lib "C:\Elgin\TEF\E1_Tef01.dll" (ByVal tipoCaptura As Long, ByVal dadosCaptura As String) As Long


'FUN��ES PARA C�PIA DE MEMORIA
Public Declare Function lstrlenA Lib "kernel32" (ByVal lpString As Long) As Long
Public Declare Function lstrlenW Lib "kernel32" (ByVal lpString As Long) As Long
Public Declare Function SysAllocStringByteLen Lib "oleaut32.dll" (ByVal m_pBase As Long, ByVal l As Long) As String

'Public Declare Function LoadPicture Lib "GDI32" Alias "LoadImageA" (ByVal hInst As Long, ByVal lpsz As String, ByVal un1 As Long, ByVal n1 As Long, ByVal n2 As Long, ByVal un2 As Long) As Long
'Public Declare Function DeleteObject Lib "GDI32" (ByVal hObject As Long) As Long


