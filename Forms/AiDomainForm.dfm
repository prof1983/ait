object fmDomain: TfmDomain
  Left = 0
  Top = 0
  Width = 532
  Height = 386
  Caption = 'fmDomain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 161
    Height = 340
    Align = alLeft
    ItemHeight = 13
    TabOrder = 0
  end
  object mmMain: TMainMenu
    Left = 16
    Top = 80
    object miFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object miLoad: TMenuItem
        Caption = 'Load'
        OnClick = miLoadClick
      end
      object miSave: TMenuItem
        Caption = 'Save'
        OnClick = miSaveClick
      end
      object miDemo: TMenuItem
        Caption = 'Demo'
        OnClick = miDemoClick
      end
      object miDelimer1: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = 'Exit'
        OnClick = miExitClick
      end
    end
  end
end
