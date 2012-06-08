object FormTasks: TFormTasks
  Left = 210
  Top = 106
  Caption = 'FormTasks'
  ClientHeight = 212
  ClientWidth = 323
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
    Width = 73
    Height = 212
    Align = alLeft
    TabOrder = 0
    object ButtonRefresh: TButton
      Left = 0
      Top = 0
      Width = 73
      Height = 17
      Caption = 'Refresh'
      TabOrder = 0
    end
    object ButtonAdd: TButton
      Left = 0
      Top = 24
      Width = 73
      Height = 17
      Caption = 'Add'
      TabOrder = 1
    end
    object ButtonInsert: TButton
      Left = 0
      Top = 40
      Width = 73
      Height = 17
      Caption = 'Insert'
      TabOrder = 2
    end
    object ButtonDelete: TButton
      Left = 0
      Top = 56
      Width = 73
      Height = 17
      Caption = 'Delete'
      TabOrder = 3
    end
    object ButtonInfo: TButton
      Left = 0
      Top = 80
      Width = 73
      Height = 17
      Caption = 'Info'
      TabOrder = 4
    end
    object ButtonShow: TButton
      Left = 0
      Top = 96
      Width = 73
      Height = 17
      Caption = 'Show'
      TabOrder = 5
    end
    object ButtonUp: TButton
      Left = 0
      Top = 120
      Width = 73
      Height = 17
      Caption = 'Up'
      TabOrder = 6
    end
    object ButtonDown: TButton
      Left = 0
      Top = 136
      Width = 73
      Height = 17
      Caption = 'Down'
      TabOrder = 7
    end
    object ButtonSaveXml: TButton
      Left = 0
      Top = 160
      Width = 73
      Height = 17
      Caption = 'SaveXml'
      TabOrder = 8
      OnClick = ButtonSaveXmlClick
    end
  end
  object ListBox1: TListBox
    Left = 73
    Top = 0
    Width = 250
    Height = 212
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
end
