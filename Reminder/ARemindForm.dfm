object RemindForm: TRemindForm
  Left = 0
  Top = 0
  Caption = #1053#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077
  ClientHeight = 153
  ClientWidth = 279
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
  object reOut: TRichEdit
    Left = 0
    Top = 0
    Width = 279
    Height = 120
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object pnButtons: TPanel
    Left = 0
    Top = 120
    Width = 279
    Height = 33
    Align = alBottom
    TabOrder = 1
    object bbOk: TBitBtn
      Left = 48
      Top = 4
      Width = 75
      Height = 25
      DoubleBuffered = True
      Kind = bkOK
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
    end
    object bbAside: TBitBtn
      Left = 160
      Top = 4
      Width = 75
      Height = 25
      Caption = #1054#1090#1083#1086#1078#1080#1090#1100
      DoubleBuffered = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = bbAsideClick
    end
  end
  object pmAside: TPopupMenu
    Left = 8
    Top = 8
    object mi5: TMenuItem
      Caption = '5 '#1084#1080#1085
      OnClick = mi5Click
    end
    object mi10: TMenuItem
      Caption = '10 '#1084#1080#1085
      OnClick = mi10Click
    end
    object mi15: TMenuItem
      Caption = '15 '#1084#1080#1085
      OnClick = mi15Click
    end
    object mi30: TMenuItem
      Caption = '30 '#1084#1080#1085
      OnClick = mi30Click
    end
    object mi60: TMenuItem
      Caption = '1 '#1095#1072#1089
      OnClick = mi60Click
    end
    object mi120: TMenuItem
      Caption = '2 '#1095#1072#1089#1072
      OnClick = mi120Click
    end
    object miOther: TMenuItem
      Caption = #1044#1088#1091#1075#1086#1077
      Hint = #1054#1090#1083#1086#1078#1080#1090#1100' '#1085#1072' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103'/'#1076#1086' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
      OnClick = miOtherClick
    end
  end
end
