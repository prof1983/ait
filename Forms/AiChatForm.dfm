object FormChat: TFormChat
  Left = 209
  Top = 106
  Width = 416
  Height = 233
  Caption = 'Prof.AI.Form.Chat 0.0.0.2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object MemoDialog: TMemo
    Left = 0
    Top = 0
    Width = 408
    Height = 178
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 184
    Width = 408
    Height = 22
    Align = alBottom
    TabOrder = 1
    object EditIn: TEdit
      Left = 0
      Top = 0
      Width = 321
      Height = 21
      TabOrder = 0
      OnKeyDown = EditInKeyDown
    end
    object ButtonOk: TButton
      Left = 328
      Top = 0
      Width = 33
      Height = 21
      Caption = 'Ok'
      TabOrder = 1
      OnClick = ButtonOkClick
    end
    object ButtonInfo: TButton
      Left = 368
      Top = 0
      Width = 33
      Height = 21
      Caption = 'Info'
      TabOrder = 2
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 178
    Width = 408
    Height = 6
    Align = alBottom
    Smooth = True
    TabOrder = 2
  end
end
