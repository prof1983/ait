object EntityTypeForm: TEntityTypeForm
  Left = 262
  Top = 72
  Width = 405
  Height = 307
  Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1089#1091#1097#1085#1086#1089#1090#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 113
    Top = 41
    Height = 198
  end
  object InfoMemo: TMemo
    Left = 0
    Top = 0
    Width = 397
    Height = 41
    Align = alTop
    Lines.Strings = (
      #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1080#1087' '#1089#1091#1097#1085#1086#1089#1090#1080)
    TabOrder = 0
  end
  object EntityTreeView: TTreeView
    Left = 0
    Top = 41
    Width = 113
    Height = 198
    Align = alLeft
    Indent = 19
    TabOrder = 1
  end
  object EntityStringGrid: TStringGrid
    Left = 116
    Top = 41
    Width = 281
    Height = 198
    Align = alClient
    ColCount = 3
    DefaultColWidth = 100
    DefaultRowHeight = 16
    TabOrder = 2
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 239
    Width = 397
    Height = 41
    Align = alBottom
    TabOrder = 3
    object OKBitBtn: TBitBtn
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object CancelBitBtn: TBitBtn
      Left = 208
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
