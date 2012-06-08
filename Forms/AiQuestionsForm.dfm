object FormQuestions: TFormQuestions
  Left = 206
  Top = 103
  Caption = 'FormQuestions'
  ClientHeight = 218
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 89
    Height = 218
    Align = alLeft
    TabOrder = 0
    object ButtonRefresh: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 17
      Caption = 'Refresh'
      TabOrder = 0
    end
    object ButtonAdd: TButton
      Left = 8
      Top = 32
      Width = 75
      Height = 17
      Caption = 'Add'
      TabOrder = 1
    end
    object ButtonInsert: TButton
      Left = 8
      Top = 48
      Width = 75
      Height = 17
      Caption = 'Insert'
      TabOrder = 2
    end
    object ButtonDelete: TButton
      Left = 8
      Top = 64
      Width = 75
      Height = 17
      Caption = 'Delete'
      TabOrder = 3
    end
    object ButtonInfo: TButton
      Left = 8
      Top = 88
      Width = 75
      Height = 17
      Caption = 'Info'
      TabOrder = 4
    end
    object ButtonShow: TButton
      Left = 8
      Top = 104
      Width = 75
      Height = 17
      Caption = 'Show'
      TabOrder = 5
    end
    object ButtonUp: TButton
      Left = 8
      Top = 128
      Width = 75
      Height = 17
      Caption = 'Up'
      TabOrder = 6
    end
    object ButtonDown: TButton
      Left = 8
      Top = 144
      Width = 75
      Height = 17
      Caption = 'Down'
      TabOrder = 7
    end
  end
  object ListBox1: TListBox
    Left = 89
    Top = 0
    Width = 265
    Height = 218
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
end
