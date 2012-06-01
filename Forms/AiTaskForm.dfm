object FormTask: TFormTask
  Left = 206
  Top = 102
  Width = 338
  Height = 302
  Caption = 'FormTask'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object LabelTitle: TLabel
    Left = 8
    Top = 32
    Width = 20
    Height = 13
    Caption = 'Title'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 36
    Height = 13
    Caption = 'Coment'
  end
  object LabelDateTimeStart: TLabel
    Left = 24
    Top = 152
    Width = 68
    Height = 13
    Caption = 'DateTimeStart'
  end
  object LabelDateTimeEnd: TLabel
    Left = 24
    Top = 176
    Width = 65
    Height = 13
    Caption = 'DateTimeEnd'
  end
  object Label5: TLabel
    Left = 8
    Top = 200
    Width = 113
    Height = 13
    Caption = 'TimeImplementation, ms'
  end
  object LabelPriority: TLabel
    Left = 8
    Top = 224
    Width = 31
    Height = 13
    Caption = 'Priority'
  end
  object Label6: TLabel
    Left = 8
    Top = 56
    Width = 21
    Height = 13
    Caption = 'Text'
  end
  object EditName: TEdit
    Left = 80
    Top = 0
    Width = 193
    Height = 21
    TabOrder = 0
  end
  object EditTitle: TEdit
    Left = 80
    Top = 24
    Width = 193
    Height = 21
    TabOrder = 1
  end
  object MemoComent: TMemo
    Left = 8
    Top = 88
    Width = 305
    Height = 57
    TabOrder = 2
  end
  object EditTimeImplementation: TEdit
    Left = 136
    Top = 192
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object DateTimePickerStart: TDateTimePicker
    Left = 104
    Top = 144
    Width = 186
    Height = 21
    Date = 38487.984656504600000000
    Time = 38487.984656504600000000
    TabOrder = 4
  end
  object DateTimePickerEnd: TDateTimePicker
    Left = 104
    Top = 168
    Width = 186
    Height = 21
    Date = 38487.984681886600000000
    Time = 38487.984681886600000000
    TabOrder = 5
  end
  object ComboBoxPriority: TComboBox
    Left = 104
    Top = 216
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = 'Normal'
    Items.Strings = (
      'Highest'
      'High'
      'Normal'
      'Low'
      'Lowest')
  end
  object ButtonMethods: TButton
    Left = 8
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Methods'
    TabOrder = 7
  end
  object ButtonCancel: TButton
    Left = 152
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object ButtonOk: TButton
    Left = 232
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 9
  end
  object CheckBoxStart: TCheckBox
    Left = 8
    Top = 152
    Width = 16
    Height = 17
    TabOrder = 10
  end
  object CheckBoxEnd: TCheckBox
    Left = 8
    Top = 176
    Width = 16
    Height = 17
    TabOrder = 11
  end
  object EditText: TEdit
    Left = 80
    Top = 48
    Width = 193
    Height = 21
    TabOrder = 12
  end
end
