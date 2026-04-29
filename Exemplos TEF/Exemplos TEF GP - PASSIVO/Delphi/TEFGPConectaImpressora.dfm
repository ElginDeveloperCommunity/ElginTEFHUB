object Form2: TForm2
  Left = 0
  Top = 0
  ActiveControl = btnConectarImpressora
  Caption = 'Conex'#227'o Impressora'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 27
    Width = 20
    Height = 13
    Caption = 'Tipo'
  end
  object Label2: TLabel
    Left = 48
    Top = 88
    Width = 43
    Height = 13
    Caption = 'Conex'#227'o'
  end
  object Label3: TLabel
    Left = 248
    Top = 27
    Width = 34
    Height = 13
    Caption = 'Modelo'
  end
  object Label4: TLabel
    Left = 248
    Top = 88
    Width = 50
    Height = 13
    Caption = 'Par'#226'metro'
  end
  object edtTipo: TEdit
    Left = 104
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '1'
  end
  object edtConexao: TEdit
    Left = 97
    Top = 85
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'USB'
  end
  object edtModelo: TEdit
    Left = 320
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'i9'
  end
  object edtParametro: TEdit
    Left = 320
    Top = 85
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object btnConectarImpressora: TButton
    Left = 177
    Top = 152
    Width = 121
    Height = 41
    Caption = 'Conectar Impressora'
    TabOrder = 4
    OnClick = btnConectarImpressoraClick
  end
end
