object TaskForm: TTaskForm
  Left = 0
  Top = 0
  Caption = #1047#1072#1076#1072#1085#1080#1077
  ClientHeight = 213
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TitleLabel: TLabel
    Left = 8
    Top = 8
    Width = 53
    Height = 13
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
  end
  object CommentLabel: TLabel
    Left = 8
    Top = 40
    Width = 49
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
  end
  object TitleEdit: TEdit
    Left = 67
    Top = 5
    Width = 342
    Height = 21
    TabOrder = 0
  end
  object CommentMemo: TMemo
    Left = 63
    Top = 37
    Width = 346
    Height = 140
    TabOrder = 1
  end
  object OKBitBtn: TBitBtn
    Left = 104
    Top = 183
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = OKBitBtnClick
  end
  object CancelBitBtn: TBitBtn
    Left = 216
    Top = 184
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
  end
end
