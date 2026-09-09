Imports System.Runtime.InteropServices
Imports Newtonsoft.Json

Public Class ControleApi
    Public Shared Property ModoOperacao As String = String.Empty


    ' ===================================================================== //
    ' ============ CARREGAMENTO DAS FUNÇÕES DA DLL ================== //
    ' ===================================================================== //

    ' A API TEF deve ser carregada exclusivamente da instalação local da Elgin.
    Public Const PATH As String = "C:\Elgin\TEF\E1_Tef01.dll"

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function GetProdutoTef() As Integer
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function GetClientTCP() As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function SetClientTCP(ip As String, porta As Integer) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function ConfigurarDadosPDV(textoPinpad As String, versaoAC As String, nomeEstabelecimento As String, loja As String, identificadorPontoCaptura As String) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function IniciarOperacaoTEF(dadosCaptura As String) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function RecuperarOperacaoTEF(dadosCaptura As String) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function RealizarPagamentoTEF(codigoOperacao As Integer, dadosCaptura As String, novaTransacao As Boolean) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function RealizarPixTEF(dadosCaptura As String, novaTransacao As Boolean) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function RealizarAdmTEF(codigoOperacao As Integer, dadosCaptura As String, novaTransacao As Boolean) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function ConfirmarOperacaoTEF(id As Integer, acao As Integer) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function RealizarColetaPinPad(tipoColeta As Integer, confirmar As Boolean) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function ConfirmarCapturaPinPad(tipoColeta As Integer, dadosCaptura As String) As IntPtr
    End Function

    <DllImport(PATH, CallingConvention:=CallingConvention.StdCall)>
    Friend Shared Function FinalizarOperacaoTEF(id As Integer) As IntPtr
    End Function



    ' //===================================================================== //
    ' //============ METODOS UTILITÁRIOS PARA O EXEMPLO C# ================== //
    ' //===================================================================== //

    Public Shared Function incrementarSequencial(sequencial As String) As String
        Dim ok As Boolean
        Dim value As Double = Nothing
        ok = Double.TryParse(sequencial, value) AndAlso Not Double.IsNaN(value) AndAlso Not Double.IsInfinity(value)
        If Not ok Then Return String.Empty
        value += 1
        Return value.ToString()
    End Function

    Public Shared Function getRetorno(resp As String) As String
        Dim _jsonDic As IDictionary(Of String, Object) = jsonify(resp)
        Return getStringValue(_jsonDic, "tef", "retorno")
    End Function

    Public Shared Function getSequencial(resp As String) As String
        Dim _jsonDic As IDictionary(Of String, Object) = jsonify(resp)
        Return getStringValue(_jsonDic, "tef", "sequencial")
    End Function

    Public Shared Function getComprovante(resp As String, via As String) As String
        If via = "loja" Then
            Dim _jsonDic As IDictionary(Of String, Object) = jsonify(resp)
            Return getStringValue(_jsonDic, "tef", "comprovanteDiferenciadoLoja")
        ElseIf via = "cliente" Then
            Dim _jsonDic As IDictionary(Of String, Object) = jsonify(resp)
            Return getStringValue(_jsonDic, "tef", "comprovanteDiferenciadoPortador")
        Else
            Return String.Empty
        End If
    End Function

    Public Shared Function jsonify(jsonString As String) As IDictionary(Of String, Object)
        If jsonString IsNot Nothing Then
            Dim _Dic As IDictionary(Of String, Object) = JsonConvert.DeserializeObject(Of Dictionary(Of String, Object))(jsonString)
            Return _Dic
        Else
            Dim _Dic As IDictionary(Of String, Object) = New Dictionary(Of String, Object)()
            Return _Dic
        End If
    End Function

    Public Shared Function stringify(_jsonDic As IDictionary(Of String, Object)) As String
        Return JsonConvert.SerializeObject(_jsonDic, Formatting.Indented)
    End Function

    Public Shared Function getStringValue(dicJson As IDictionary(Of String, Object), keyOut As String, keyIn As String) As String
        Dim value As Object = Nothing, valueIn As Object = Nothing

        If dicJson IsNot Nothing AndAlso dicJson.TryGetValue(keyOut, value) Then
            Dim _Dic As IDictionary(Of String, Object) = value.ToObject(Of Dictionary(Of String, Object))()

            If _Dic IsNot Nothing AndAlso _Dic.TryGetValue(keyIn, valueIn) Then
                Console.WriteLine(valueIn.[GetType]())
                Return valueIn.ToString()
            Else
                Return String.Empty
            End If
        Else
            Return String.Empty
        End If
    End Function

    Public Shared Function getStringValue(dicJson As IDictionary(Of String, Object), key As String) As String
        Dim value As Object = Nothing

        If dicJson IsNot Nothing AndAlso dicJson.TryGetValue(key, value) Then
            Return value.ToString()
        Else
            Return String.Empty
        End If
    End Function

    Public Shared Function __Function() As String
        Dim stackTrace As StackTrace = New StackTrace()
        Return stackTrace.GetFrame(1).GetMethod().Name
    End Function

End Class
