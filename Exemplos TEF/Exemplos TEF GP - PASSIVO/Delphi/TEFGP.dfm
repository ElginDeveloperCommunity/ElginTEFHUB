object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 491
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 545
    Height = 105
    Caption = 'Configura'#231#245'es'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 155
      Height = 13
      Caption = 'Caminho de escrita para arquivo'
    end
    object Label2: TLabel
      Left = 24
      Top = 67
      Width = 160
      Height = 13
      Caption = 'Valor para venda e cancelamento'
    end
    object Edit1: TEdit
      Left = 232
      Top = 29
      Width = 233
      Height = 21
      TabOrder = 0
      Text = 'C:\Cliente\Req'
    end
    object edtValor: TEdit
      Left = 232
      Top = 64
      Width = 233
      Height = 21
      TabOrder = 1
      Text = '40'
    end
    object Button8: TButton
      Left = 480
      Top = 29
      Width = 39
      Height = 29
      Caption = '...'
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 119
    Width = 545
    Height = 146
    Caption = 'Fun'#231#245'es'
    TabOrder = 1
    object btnAdm: TButton
      Left = 24
      Top = 24
      Width = 161
      Height = 33
      Caption = 'ADM'
      TabOrder = 0
      OnClick = btnAdmClick
    end
    object btnReimpressao: TButton
      Left = 24
      Top = 63
      Width = 161
      Height = 33
      Caption = 'Reimpress'#227'o'
      TabOrder = 1
      OnClick = btnReimpressaoClick
    end
    object btnVenda: TButton
      Left = 191
      Top = 24
      Width = 161
      Height = 33
      Caption = 'Venda'
      TabOrder = 2
      OnClick = btnVendaClick
    end
    object btnConfirmarVenda: TButton
      Left = 191
      Top = 63
      Width = 161
      Height = 33
      Caption = 'Confirmar Venda'
      TabOrder = 3
      OnClick = btnConfirmarVendaClick
    end
    object btnNaoConfirmarVenda: TButton
      Left = 191
      Top = 102
      Width = 161
      Height = 33
      Caption = 'N'#227'o Confirmar Venda'
      TabOrder = 4
      OnClick = btnNaoConfirmarVendaClick
    end
    object btnCancelamentoVenda: TButton
      Left = 358
      Top = 24
      Width = 161
      Height = 33
      Caption = 'Cancelamento Venda'
      TabOrder = 5
      OnClick = btnCancelamentoVendaClick
    end
    object btnConectarImpressora: TButton
      Left = 358
      Top = 63
      Width = 161
      Height = 74
      Caption = 'Conectar Impressora'
      TabOrder = 6
      OnClick = btnConectarImpressoraClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 271
    Width = 545
    Height = 212
    Caption = 'Dados'
    TabOrder = 2
    object memoDados: TMemo
      Left = 24
      Top = 32
      Width = 495
      Height = 161
      Lines.Strings = (
        'memoDados')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
