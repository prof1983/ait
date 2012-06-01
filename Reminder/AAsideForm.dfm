object AsideForm: TAsideForm
  Left = 0
  Top = 0
  Caption = #1054#1090#1083#1086#1078#1080#1090#1100
  ClientHeight = 187
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 143
    Top = 8
    Width = 25
    Height = 13
    Caption = #1076#1085#1077#1081
  end
  object Label2: TLabel
    Left = 143
    Top = 32
    Width = 29
    Height = 13
    Caption = #1095#1072#1089#1086#1074
  end
  object Label3: TLabel
    Left = 143
    Top = 64
    Width = 30
    Height = 13
    Caption = #1084#1080#1085#1091#1090
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 8
    Width = 123
    Height = 17
    Caption = #1054#1090#1083#1086#1078#1080#1090#1100' '#1085#1072
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object DayEdit: TEdit
    Left = 174
    Top = 5
    Width = 34
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object DayUpDown: TUpDown
    Left = 214
    Top = 1
    Width = 17
    Height = 25
    TabOrder = 2
    OnChanging = DayUpDownChanging
  end
  object HourEdit: TEdit
    Left = 174
    Top = 32
    Width = 35
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object HourUpDown: TUpDown
    Left = 214
    Top = 32
    Width = 16
    Height = 24
    TabOrder = 4
    OnChanging = HourUpDownChanging
  end
  object MinuteEdit: TEdit
    Left = 174
    Top = 59
    Width = 34
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object MinuteUpDown: TUpDown
    Left = 214
    Top = 59
    Width = 16
    Height = 24
    TabOrder = 6
    OnChanging = MinuteUpDownChanging
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 96
    Width = 123
    Height = 17
    Caption = #1054#1090#1083#1086#1078#1080#1090#1100' '#1076#1086
    TabOrder = 7
  end
  object DatePicker: TDateTimePicker
    Left = 143
    Top = 96
    Width = 105
    Height = 21
    Date = 39266.993798101850000000
    Time = 39266.993798101850000000
    TabOrder = 8
  end
  object TimePicker: TDateTimePicker
    Left = 143
    Top = 123
    Width = 105
    Height = 21
    Date = 39266.993971712960000000
    Time = 39266.993971712960000000
    Kind = dtkTime
    TabOrder = 9
  end
  object OKBitBtn: TBitBtn
    Left = 40
    Top = 154
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 10
    OnClick = OKBitBtnClick
  end
  object CancelBitBtn: TBitBtn
    Left = 156
    Top = 154
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 11
  end
end
