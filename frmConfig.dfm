object ufrmConfig: TufrmConfig
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'ufrmConfig'
  ClientHeight = 290
  ClientWidth = 341
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 27
    Width = 65
    Height = 13
    Caption = 'Cor de Fundo'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 55
    Width = 46
    Height = 13
    Caption = 'Cor Led 1'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 83
    Width = 46
    Height = 13
    Caption = 'Cor Led 2'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object colorBackground: TColorBox
    Left = 87
    Top = 24
    Width = 105
    Height = 22
    TabOrder = 0
  end
  object colorLedBike1: TColorBox
    Left = 87
    Top = 52
    Width = 105
    Height = 22
    DefaultColorColor = clGreen
    NoneColorColor = clGreen
    Selected = clGreen
    TabOrder = 1
  end
  object colorLedBike2: TColorBox
    Left = 87
    Top = 80
    Width = 105
    Height = 22
    DefaultColorColor = clBlue
    NoneColorColor = clBlue
    Selected = clBlue
    TabOrder = 2
  end
  object Button1: TButton
    Left = 87
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = Button1Click
  end
end
