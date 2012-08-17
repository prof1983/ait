{**
@Abstract Главная форма EntityStorage
@Author Prof1983 <prof1983@ya.ru>
@Created 06.07.2007
@LastMod 17.08.2012

Главная форма программы EntityStorage.
В верхней части окна место для меню и основные кнопки быстрого вызова команд.
В верхней части окна есть поле для ввода команд вручную.
Рядом кнопка "..." для ввода многострочных и сложных команд.
Рядом кнопка "Run" для запуска выполнения команды.
В нижней части окна также есть статусная строка для вывода информации.

Проторип внешнего вида окна:
- 1С 7.7 (http://www.1c.ru/)
- SAS Base (http://www.sas.com/)
}
unit AiStorageForm;

(*
object EntityStorageForm: TEntityStorageForm
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 550
    Height = 24
    UseSystemFont = False
    ActionManager = ActionManager
    Caption = 'ActionMainMenuBar1'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 0
  end
  object MainPageControl: TPageControl
    Left = 0
    Top = 57
    Width = 550
    Height = 223
    ActivePage = StorageTabSheet
    Align = alClient
    TabOrder = 3
    object StorageTabSheet: TTabSheet
      Caption = #1061#1088#1072#1085#1080#1083#1080#1097#1077
      object EntityGroupSplitter: TSplitter
        Left = 137
        Top = 0
        Height = 195
      end
      object pnButtons: TPanel
        Left = 453
        Top = 0
        Width = 89
        Height = 195
        Align = alRight
        TabOrder = 0
        object bbNewTask: TBitBtn
          Left = 6
          Top = 8
          Width = 75
          Height = 25
          Action = NewEntityAction
          Caption = #1057#1086#1079#1076#1072#1090#1100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object bbDeleteTask: TBitBtn
          Left = 6
          Top = 40
          Width = 75
          Height = 25
          Action = RemoteEntityAction
          Caption = #1059#1076#1072#1083#1080#1090#1100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object EntityGroupTreeView: TTreeView
        Left = 0
        Top = 0
        Width = 137
        Height = 195
        Align = alLeft
        Indent = 19
        TabOrder = 1
      end
      object EntityStringGrid: TStringGrid
        Left = 140
        Top = 0
        Width = 313
        Height = 195
        Align = alClient
        ColCount = 3
        DefaultColWidth = 100
        DefaultRowHeight = 16
        RowCount = 2
        TabOrder = 2
      end
    end
  end
  object LogRichEdit: TRichEdit
    Left = 0
    Top = 283
    Width = 550
    Height = 65
    Align = alBottom
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Items = <
              item
                Action = OpenProjectAction
                ImageIndex = 18
              end
              item
                Action = NewProjectAction
                ImageIndex = 10
              end
              item
                Action = CloseProjectAction
              end
              item
                Caption = '-'
              end
              item
                Caption = '&Exit'
              end>
            Visible = False
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = AboutAction
              end
              item
                Action = HelpContents1
                ImageIndex = 27
              end>
            Caption = '?'
          end>
      end
      item
      end
      item
        Items = <
          item
            Items = <
              item
                Visible = False
                Action = OpenProjectAction
                ImageIndex = 18
              end
              item
                Visible = False
                Action = NewProjectAction
                ImageIndex = 10
              end
              item
                Visible = False
                Action = CloseProjectAction
              end
              item
                Visible = False
                Action = FileOpen
                Caption = 'O&pen...'
                ImageIndex = 26
                ShortCut = 16463
              end
              item
                Visible = False
                Action = FileSaveAs
                ImageIndex = 28
              end
              item
                Visible = False
                Caption = '-'
              end
              item
                Action = ExitAction
                ImageIndex = 1
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = HelpContents1
                ImageIndex = 27
              end
              item
                Action = AboutAction
              end>
            Caption = '?'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Images = ImageList
    Left = 288
    Top = 128
    StyleName = 'XP Style'
    object OpenProjectAction: TAction
      Category = 'File'
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1086#1077#1082#1090
      ImageIndex = 18
      OnExecute = OpenProjectActionExecute
    end
    object NewProjectAction: TAction
      Category = 'File'
      Caption = #1053#1086#1074#1099#1081' '#1087#1088#1086#1077#1082#1090
      ImageIndex = 10
      OnExecute = NewProjectActionExecute
    end
    object actInfo: TAction
      Caption = '?'
    end
    object CloseProjectAction: TAction
      Category = 'File'
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1088#1086#1077#1082#1090
      OnExecute = CloseProjectActionExecute
    end
    object SaveProjectAsAction: TAction
      Category = 'File'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1088#1086#1077#1082#1090' '#1082#1072#1082'...'
      ImageIndex = 28
    end
    object FileOpen: TFileOpen
      Category = 'File'
      Caption = #1054#1090#1082#1088#1099#1090#1100'...'
      ImageIndex = 26
      ShortCut = 16463
      BeforeExecute = FileOpenBeforeExecute
    end
    object HelpContents1: THelpContents
      Category = 'Help'
      Caption = '&Contents'
      Enabled = False
      Hint = 'Help Contents'
      ImageIndex = 27
    end
    object FileSaveAs: TFileSaveAs
      Category = 'File'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089' '#1076#1088#1091#1075#1080#1084' '#1080#1084#1077#1085#1077#1084' '#1080' '#1074' '#1076#1088#1091#1075#1086#1084' '#1092#1086#1088#1084#1072#1090#1077
      ImageIndex = 28
      BeforeExecute = FileSaveAsBeforeExecute
    end
    object AboutAction: TAction
      Category = 'Help'
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnExecute = AboutActionExecute
    end
    object NewEntityAction: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1089#1091#1097#1085#1086#1089#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1089#1091#1097#1085#1086#1089#1090#1100
      ImageIndex = 22
      OnExecute = NewEntityActionExecute
    end
    object ExitAction: TAction
      Category = 'File'
      Caption = #1042#1099#1093#1086#1076
      ImageIndex = 1
      OnExecute = ExitActionExecute
    end
    object RemoteEntityAction: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1091#1097#1085#1086#1089#1090#1100
      ImageIndex = 25
      OnExecute = RemoteEntityActionExecute
    end
    object ManagerAction: TAction
      Caption = #1052#1077#1085#1077#1076#1078#1077#1088
      OnExecute = ManagerActionExecute
    end
    object CloseAction: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      ImageIndex = 23
      OnExecute = CloseActionExecute
    end
    object NewGroupAction: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 0
      OnExecute = NewGroupActionExecute
    end
    object RemoteGroupAction: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 1
      OnExecute = RemoteGroupActionExecute
    end
  end
end

*)

interface

uses
  ActnCtrls, ActnList, ActnMan, ActnMenus, ActnPopup,
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Graphics, Grids, Forms,
  ImgList, Menus, Messages, StdActns, StdCtrls, SysUtils, ToolWin, Variants,
  Windows, XPStyleActnCtrls,
  ACommandComboBoxControl, AIteratorIntf, ALogRichEdit, ASystemData, ASystemUtils,
  AiBase, AiBaseTypes, AiConsts, AiFilePoolImpl, AiEntityForm, AiEntityGroup,
  AiEntityStoragePool, AiEntityStorageSettings, AiEntityStorageSettingsLoader, AiEntityTypeForm,
  fAbout1;

type //** @abstract(Главная форма EntityStorageForm)
  TEntityStorageForm = class(TForm)
    CommandPanel: TPanel;
    sbMain: TStatusBar;
    CommandComboBox: TComboBox;
    CommandButton: TButton;
    RunCommandSpeedButton: TSpeedButton;
    ActionManager: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    ImageList: TImageList;
    actInfo: TAction;
    OpenProjectAction: TAction;
    NewProjectAction: TAction;
    CloseProjectAction: TAction;
    FileOpen: TFileOpen;
    HelpContents1: THelpContents;
    FileSaveAs: TFileSaveAs;
    AboutAction: TAction;
    bbClose: TBitBtn;
    NewEntityAction: TAction;
    ExitAction: TAction;
    ManagerAction: TAction;
    CloseAction: TAction;
    RemoteEntityAction: TAction;
    MainPageControl: TPageControl;
    StorageTabSheet: TTabSheet;
    pnButtons: TPanel;
    bbNewTask: TBitBtn;
    bbDeleteTask: TBitBtn;
    SaveProjectAsAction: TAction;
    EntityGroupTreeView: TTreeView;
    EntityGroupSplitter: TSplitter;
    EntityStringGrid: TStringGrid;
    NewGroupAction: TAction;
    RemoteGroupAction: TAction;
    NewGroupBitBtn: TBitBtn;
    RemoteGroupBitBtn: TBitBtn;
    LogRichEdit: TRichEdit;
    LogSplitter: TSplitter;
    procedure AboutActionExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure CloseProjectActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure FileSaveAsBeforeExecute(Sender: TObject);
    procedure FileOpenBeforeExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ManagerActionExecute(Sender: TObject);
    procedure NewEntityActionExecute(Sender: TObject);
    procedure NewGroupActionExecute(Sender: TObject);
    procedure RemoteEntityActionExecute(Sender: TObject);
    procedure RemoteGroupActionExecute(Sender: TObject);
    procedure NewProjectActionExecute(Sender: TObject);
    procedure OpenProjectActionExecute(Sender: TObject);
    procedure CommandButtonClick(Sender: TObject);
    procedure btRunClick(Sender: TObject);
    procedure CommandComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CommandComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
      //** Контрол для ComboBox ввода команд
    FCommandComboBoxControl: TCommandComboBoxControl;
      //** Флаг, который указывает закрывать программу или сворачивать в трей.
    FIsClose: Boolean;
    FLog: TRichEditLog;
      {**
      Функция добавления лог-сообщения.
      Все лог-сообщения поступают в микроядро.
      Далеее рассылаются по объектам вывода, записи и обработки лог-сообщений. }
    FOnAddToLog: TAIProcMessage;
      //** Объект хранения сущностей
    FPool: TAIFilePool;
      //** Настройки программы
    FSettings: TEntityStorageSettings;
  private
    procedure OpenPool(FileName: WideString; Creating: Boolean = False);
    procedure RefreshGroupTreeView();
  protected
      //** Добавить лог-сообщение
    function AddToLog(Msg: WideString): Integer; virtual;
    function CloseWindow(form: TForm): Boolean; virtual;
    function DoCommand(Cmd: WideString): Boolean; virtual;
      //** Срабатывает при создании
    procedure DoCreate(); override;
      //** Срабатывает при уничтожении
    procedure DoDestroy(); override;
  public
    //TrayIcon: TTrayIcon;
  public
      //** Инициализировать
    procedure Initialize();
  public
    {**
      Флаг, который указывает закрывать программу или сворачивать в трей.
      Флаг устанавливается при выборе "Выход" в контекстном меню.
    }
    property IsClose: Boolean read FIsClose;
  end;

implementation

const
  FILE_EXT_INI  = 'ini';
  FILE_EXT_POOL = 'pool';
  FILE_EXT_XML  = 'xml';

{$R *.dfm}

{ TEntityStorageForm }

procedure TEntityStorageForm.AboutActionExecute(Sender: TObject);
var
  fmAbout: TAboutForm;
begin
  try
    fmAbout := TAboutForm.Create(Self);
    fmAbout.Picture.Assign(Application.Icon);
    fmAbout.ShowModal();
    fmAbout.Free();
  except
  end;
end;

procedure TEntityStorageForm.CloseProjectActionExecute(Sender: TObject);
begin
  // Закрыть все открытые окна
  // ...

  // Подадим команду микроядру
  // ...
end;

procedure TEntityStorageForm.NewProjectActionExecute(Sender: TObject);
begin
  // ...
end;

procedure TEntityStorageForm.OpenProjectActionExecute(Sender: TObject);
begin
  // Закроем проект
  CloseProjectActionExecute(Sender);

  // Выберем файл
  // ...

  // Подадим команду микроядру
  // ...
end;

function TEntityStorageForm.AddToLog(Msg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(Msg);
  except
  end;

  if Assigned(FLog) then
  try
    Result := FLog.AddToLog(Msg);
  except
  end;
end;

procedure TEntityStorageForm.CommandButtonClick(Sender: TObject);
begin
  // ...
end;

procedure TEntityStorageForm.btRunClick(Sender: TObject);
var
  cmd: WideString;
begin
  cmd := CommandComboBox.Text;
  if CommandComboBox.ItemIndex < 0 then
    CommandComboBox.Items.Add(cmd);
  CommandComboBox.Text := '';
  if cmd = '' then Exit;
  AddToLog('--> ' + cmd);

  DoCommand(cmd);
end;

procedure TEntityStorageForm.CommandComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    btRunClick(nil);
end;

procedure TEntityStorageForm.CommandComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    CommandComboBox.Text := '';
end;

procedure TEntityStorageForm.CloseActionExecute(Sender: TObject);
begin
  Hide();
end;

function TEntityStorageForm.CloseWindow(form: TForm): Boolean;
begin
  Result := False;
  if Assigned(form) then
  begin
    // Проверяем флаг главного окна
    {if (form.Tag and $01 <> $01) then
    begin
      form.Free();
      RefreshChildTabs();
      Result := True;
    end;}
  end;

  {if tcWindows.TabIndex = FTabReasoner then
  begin
    if Assigned(FReasonerForm) then
    begin
      FReasonerForm.Free();
      FReasonerForm := nil;
      tcWindows.Tabs.Delete(FTabReasoner);
    end;
  end
  else if tcWindows.TabIndex = FTabRules then
  begin
    if Assigned(FRules) then
    begin
      FRules.Free();
      FRules := nil;
      tcWindows.Tabs.Delete(FTabRules);
    end;
  end
  else if tcWindows.TabIndex = FTabLog then
  begin
    if Assigned(FLog) then
    begin
      FLog.Free();
      FLog := nil;
      tcWindows.Tabs.Delete(FTabLog);
    end;
  end;}
end;

function TEntityStorageForm.DoCommand(Cmd: WideString): Boolean;
//var
//  form: TForm;
begin
  Result := False;
  if cmd = 'HELP' then
  begin
    AddToLog('--------------------------------');
    AddToLog('Программа: StorageEntity');
    AddToLog('Версия: 0.0.5');
    AddToLog('--------------------------------');
    AddToLog('Краткая справка по командам программы');
    AddToLog('HELP - вывести справку');
    AddToLog('RULES - вывести список правил');
    AddToLog('FACTS - вывести список фактов');
    AddToLog('LOG - показат окно логирования');
    AddToLog('--------------------------------');
    Result := True;
  end
  else if cmd = 'FACTS' then
  begin
    AddToLog('--------------------------------');
    AddToLog('Список фактов');
    AddToLog('Список фактов пуст');
    // ...
    AddToLog('--------------------------------');
    Result := True;
  end
  else
  begin
    // Передаем команду активному дочернему окну
    {form := ActiveMDIChild;
    if (form is TAIForm) then
    begin
      Result := TAIForm(form).AddCommand(cmd);

      if not(Result) and Assigned(FCore) then
      begin
        // Передаем команду микроядру на выполнение
        FCore.AddCommand(cmd);
        // ...
        Result := True;
      end;
    end;}
  end;
end;

procedure TEntityStorageForm.DoCreate();
begin
  inherited;

  // Инициализируем RichEditLog
  FLog := TRichEditLog.Create();
  FLog.RichEdit := LogRichEdit;

  // Инициализируем настройки программы
  FSettings := TEntityStorageSettings.Create();
  FSettings.Title := Caption;

  FExePath := ExtractFilePath(ParamStr(0));
  FConfigPath := NormalizePath2(ExpandFileName(FExePath + AiConfigDir));
  FDataPath := NormalizePath2(ExpandFileName(FExePath + AiDataDir));

  TEntityStorageSettingsLoader.Load(FSettings, FConfigPath  + 'EntityStorage.' + FILE_EXT_INI);
  if FSettings.Title <> '' then
    Caption := FSettings.Title;

  // Инициализируем контрол для элемента ввода команд
  FCommandComboBoxControl := TCommandComboBoxControl.Create();
  FCommandComboBoxControl.Control := CommandComboBox;
  FCommandComboBoxControl.OnCommand := CommandButtonClick;

  // Инициализируем объект работы с сущностями
  FPool := TAIFilePool.Create();
  FPool.OnAddToLog := AddToLog;
  OpenPool(FDataPath + 'EntityStorage.' + FILE_EXT_POOL, True);

  RefreshGroupTreeView();

  Self.FIsClose := True;
  NewGroupBitBtn.Caption := '';
  RemoteGroupBitBtn.Caption := '';
end;

procedure TEntityStorageForm.DoDestroy();
begin
  inherited;
end;

procedure TEntityStorageForm.ExitActionExecute(Sender: TObject);
begin
  FIsClose := True;
  Application.MainForm.Close();
end;

procedure TEntityStorageForm.FileOpenBeforeExecute(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(Self);
  if od.Execute() then
  begin
    FPool.Close();
    FPool.FileName := od.FileName;
    FPool.Open();
  end;
  od.Free();
end;

procedure TEntityStorageForm.FileSaveAsBeforeExecute(Sender: TObject);
begin
  // ...
end;

procedure TEntityStorageForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FIsClose;
  if not(FIsClose) then
    Hide();
end;

procedure TEntityStorageForm.Initialize();
begin
end;

procedure TEntityStorageForm.ManagerActionExecute(Sender: TObject);
begin
  Show();
end;

procedure TEntityStorageForm.NewEntityActionExecute(Sender: TObject);
var
  EntityForm: TEntityForm;
  EntityTypeForm: TEntityTypeForm;
begin
  // Выбор типа сущности
  EntityTypeForm := TEntityTypeForm.Create(Self);
  if EntityTypeForm.ShowModal() = mrOK then
  begin
    // ...
  end;
  EntityTypeForm.Free();

  // Ввод данных сущности
  EntityForm := TEntityForm.Create(Self);
  if EntityForm.ShowModal() = mrOK then
  begin
    // ...
  end;
  EntityForm.Free();
end;

procedure TEntityStorageForm.NewGroupActionExecute(Sender: TObject);
begin
  // ...
end;

procedure TEntityStorageForm.OpenPool(FileName: WideString; Creating: Boolean);
begin
  FPool.FileName := FileName;
  if (FPool.Open() < 0) then
    if Creating then
      FPool.OpenCreate()
    else
      Exit;

  // Выводим информацию
  if FPool.IsOpened then
  begin
    AddToLog('#information Pool.Base=' + IntToStr(FPool.Base) +
      ' Pool.Capacity='+IntToStr(FPool.Capacity)+
      ' Pool.Count='+IntToStr(FPool.Count));
  end
  else
    AddToLog('#warning Файл EntityStorage.pool не открыт');
end;

procedure TEntityStorageForm.RefreshGroupTreeView();
var
  //collection: TAICollection;
  iterator: IAIterator;
  id: TAIID;
//  group: TEntityGroup;
begin
  EntityGroupTreeView.Items.Clear();
  if not(Assigned(FPool)) or not(FPool.IsOpened) then Exit;
  iterator := FPool.Iterator;
  if not(Assigned(iterator)) or (iterator.IsEmpty) then Exit;
  id := iterator.Next;
  while (id > 0) do
  begin
    if TEntityStoragePool.IsEntityGroup(FPool, id) then
    begin
//      group := TEntityStoragePool.GetEntityGroup(FPool, id);
      //FPool.GetEntityValueAsCollection(id);
      // ...
    end;
    id := iterator.Next;
  end;
end;

procedure TEntityStorageForm.RemoteEntityActionExecute(Sender: TObject);
begin
  // ...
end;

procedure TEntityStorageForm.RemoteGroupActionExecute(Sender: TObject);
begin
  // ...
end;

end.
