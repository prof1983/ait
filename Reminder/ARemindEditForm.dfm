object RemindEditForm: TRemindEditForm
  Left = 0
  Top = 0
  Caption = #1053#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077
  ClientHeight = 110
  ClientWidth = 472
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
    Left = 8
    Top = 8
    Width = 45
    Height = 13
    Caption = #1057#1086#1073#1099#1090#1080#1077
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 137
    Height = 13
    Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1085#1072#1087#1086#1084#1080#1085#1072#1085#1080#1103
  end
  object edTask: TEdit
    Left = 8
    Top = 24
    Width = 456
    Height = 21
    TabOrder = 0
  end
  object DatePicker: TDateTimePicker
    Left = 151
    Top = 51
    Width = 98
    Height = 21
    Date = 39260.648765000000000000
    Time = 39260.648765000000000000
    TabOrder = 1
  end
  object bbOk: TBitBtn
    Left = 104
    Top = 78
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = bbOkClick
  end
  object bbCancel: TBitBtn
    Left = 216
    Top = 77
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object TimePicker: TDateTimePicker
    Left = 255
    Top = 50
    Width = 90
    Height = 21
    Date = 39260.659233935190000000
    Time = 39260.659233935190000000
    Kind = dtkTime
    TabOrder = 4
  end
  object btFiveMinut: TButton
    Left = 351
    Top = 51
    Width = 50
    Height = 20
    Caption = '+5 '#1084#1080#1085
    TabOrder = 5
    OnClick = btFiveMinutClick
  end
  object btTenMinut: TButton
    Left = 407
    Top = 51
    Width = 50
    Height = 20
    Caption = '+10 '#1084#1080#1085
    TabOrder = 6
    OnClick = btTenMinutClick
  end
  object btHour: TButton
    Left = 351
    Top = 77
    Width = 50
    Height = 20
    Caption = '+1 '#1095#1072#1089
    TabOrder = 7
    OnClick = btHourClick
  end
  object btDay: TButton
    Left = 407
    Top = 77
    Width = 50
    Height = 20
    Caption = '+1 '#1076#1077#1085#1100
    TabOrder = 8
    OnClick = btDayClick
  end
end
