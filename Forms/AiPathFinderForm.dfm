object FormPath: TFormPath
  Left = 194
  Top = 109
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Поиск пути по алгоритму A*'
  ClientHeight = 573
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 8
    Width = 561
    Height = 561
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object StartButton: TSpeedButton
    Left = 568
    Top = 8
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = 'Start'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = StartButtonClick
  end
  object FinishButton: TSpeedButton
    Left = 608
    Top = 8
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = 'End'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = FinishButtonClick
  end
  object WallButton: TSpeedButton
    Left = 648
    Top = 8
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = 'Wall'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = WallButtonClick
  end
  object OpenButton: TSpeedButton
    Left = 592
    Top = 96
    Width = 33
    Height = 33
    Caption = 'Open'
    Flat = True
    OnClick = OpenButtonClick
  end
  object SaveButton: TSpeedButton
    Left = 640
    Top = 96
    Width = 33
    Height = 33
    Caption = 'Save'
    Flat = True
    OnClick = SaveButtonClick
  end
  object NewButton: TSpeedButton
    Left = 680
    Top = 96
    Width = 33
    Height = 33
    Caption = 'New'
    Flat = True
    OnClick = NewButtonClick
  end
  object FindButton: TSpeedButton
    Left = 720
    Top = 96
    Width = 33
    Height = 33
    Caption = 'Find'
    Flat = True
    OnClick = FindButtonClick
  end
  object EraseButton: TSpeedButton
    Left = 688
    Top = 8
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = 'Erase'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = EraseButtonClick
  end
  object ClearButton: TSpeedButton
    Left = 728
    Top = 8
    Width = 33
    Height = 33
    Caption = 'Clear'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = ClearButtonClick
  end
  object Label2: TLabel
    Left = 568
    Top = 224
    Width = 58
    Height = 13
    Caption = 'Статистика'
  end
  object ClStatButton: TSpeedButton
    Left = 592
    Top = 152
    Width = 81
    Height = 33
    Caption = 'Clear stats'
    Flat = True
    OnClick = ClStatButtonClick
  end
  object SvStatButton: TSpeedButton
    Left = 680
    Top = 152
    Width = 73
    Height = 33
    Caption = 'Save stats'
    Flat = True
    OnClick = SvStatButtonClick
  end
  object SpeedButton1: TSpeedButton
    Left = 568
    Top = 48
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = '1'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 608
    Top = 48
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = '2'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 648
    Top = 48
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = '3'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 688
    Top = 48
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = '4'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton4Click
  end
  object SpeedButton5: TSpeedButton
    Left = 728
    Top = 48
    Width = 33
    Height = 33
    GroupIndex = 1
    Caption = '5'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton5Click
  end
  object Memo1: TMemo
    Left = 568
    Top = 240
    Width = 217
    Height = 329
    TabOrder = 0
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.map'
    FileName = '*.map'
    Filter = 'Файл карты|*.map'
    InitialDir = 'C:\Works\pathfinding\Done\Best'
    Left = 448
    Top = 120
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'map'
    FileName = '*.map'
    Filter = 'Файл карты|*.map'
    InitialDir = 'C:\Works\pathfinding\Done\Best'
    Left = 416
    Top = 120
  end
  object SaveDialog2: TSaveDialog
    FileName = '*.sts'
    Filter = 'Файлы статистики|*.sts'
    InitialDir = 'C:\Works\pathfinding\Done\Best'
    Left = 384
    Top = 120
  end
end