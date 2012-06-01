{**
@Abstract(Главная форма Assistant)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.06.2007)
@LastMod(14.05.2012)
@Version(0.5)

Главная форма программы Assistant.
Является MDI формой.
По умолчанию должна разворачиваться на полный экран.
В верхней части окна место для меню и основные кнопки быстрого вызова команд.
В верхней части окна есть поле для ввода команд вручную.
Рядом кнопка "..." для ввода многострочных и сложных команд.
Рядом кнопка "Run" для запуска выполнения команды.
В нижней части окна место для вывода кнопок открытых окон.
В нижней части окна также есть статусная строка для вывода информации.

Форме AssistantForm должен быть передан указатель на микроядро системы (AICore)
для вызова выполнения команд.

Проторип внешнего вида окна:
- 1С 7.7 (http://www.1c.ru/)
- SAS Base (http://www.sas.com/)

История изменений:
0.2.1.8 - 17.07.2007 - Добавил проверку AIL
0.2.1.7 - 16.07.2007 - Remote bbNewTaskClick
0.2.1.6 - 14.07.2007 - Добавил дерево заданий
0.2.1.5 - 07.07.2007 - AssistantSettings, FIsDebug, Переименовал Actions
0.2.1.4 - 06.07.2007 - Добавил TaskLoader, TaskSaver
  Переименовал Loader -> RemindLoader, Saver -> RemindSaver
0.2.1.3 - 06.07.2007 - Добавил fTask, Сделал работу с заданиями
0.2.1.2 - 05.07.2007
0.2.1.1 - 04.07.2007
0.2.1.0 - 04.07.2007 - Изменил PopumMenu в TrayIcon на PopupActionBar
0.2.0.0 - 04.07.2007 - Сделал вкладки. Сделал вкладку "Задания".
0.1.1.0 - 03.07.2007 - В эту форму перенесено сожержимое формы ReminderForm
0.1.0.7 - 03.07.2007 - Переименовал TfmAssistant -> TAssistantForm
0.1.0.6 - 24.06.2007 - Добавил CloseWindow()
0.1.0.5 - 23.06.2007 - Переименовал AddMsg в AddToLog
0.1.0.4 - 21.06.2007 - Создал ActionMainMenu
0.1.0.3 - 21.06.2007 - Добавил обработку команд, создал DoCommand()
0.1.0.2 - 20.06.2007 - Добавил FCore
0.1.0.1 - 20.06.2007 - Заменил edCommand -> cbCommand
0.1.0.0 - 20.06.2007 - Закоментировал все формы и объекты.
0.0.2.1 - 05.06.2007 - Добавил fmRules
0.0.2.0 - 04.06.2007 - Создан из fmReasoner
0.0.1.0 - 04.06.2007 - Сделал MDI окно логирования
}

unit AiMainForm;

interface

uses
  ActnCtrls, ActnList, ActnMan, ActnMenus, ActnPopup,
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Graphics, Forms,
  ImgList, Menus, Messages, StdActns, StdCtrls, SysUtils, ToolWin, Variants,
  Windows, XPStyleActnCtrls,
  AiBaseTypes, AiCoreImpl, AiCoreIntf, {AiForm,}
  AssistantProgram, AssistantSettings, AssistantSettingsLoader, AssistantDataSaver,
  CommandComboBoxControl, Remind, RemindLoader, RemindSaver, RichEditLog,
  Task, TaskLoader, TaskSaver,
  fAbout, fRemind, fRemindEdit, fTask, PlatformDefaultStyleActnCtrls;

type
  //** @abstract(Главная форма AIAssistant)
  TAssistantForm = class(TForm)
    tcWindows: TTabControl;
    CommandPanel: TPanel;
    sbMain: TStatusBar;
    CommandComboBox: TComboBox;
    CommandButton: TButton;
    RunCommandSpeedButton: TSpeedButton;
    ActionManager: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    TrayIcon: TTrayIcon;
    TrayPopup: TPopupActionBar;
    ImageList: TImageList;
    OpenProjectAction: TAction;
    NewProjectAction: TAction;
    CloseProjectAction: TAction;
    FileOpenAction: TFileOpen;
    HelpContentsAction: THelpContents;
    FileSaveAsAction: TFileSaveAs;
    AboutAction: TAction;
    RemindTimer: TTimer;
    MainPageControl: TPageControl;
    RemindTabSheet: TTabSheet;
    RemindListBox: TListBox;
    ButtonRemindPanel: TPanel;
    NewRemindBitBtn: TBitBtn;
    DeleteRemindBitBtn: TBitBtn;
    CloseBitBtn: TBitBtn;
    TaskTabSheet: TTabSheet;
    TaskListBox: TListBox;
    TaskButtonPanel: TPanel;
    AddTaskBitBtn: TBitBtn;
    RemoteTaskBitBtn: TBitBtn;
    AddRemindAction: TAction;
    AddTaskAction: TAction;
    ExitAction: TAction;
    ManagerAction: TAction;
    ManagerMenuItem: TMenuItem;
    DelimerMenuItem1: TMenuItem;
    AddRemindMenuItem: TMenuItem;
    AddTaskMenuItem: TMenuItem;
    DelimerMenuItem2: TMenuItem;
    ExitMenuItem: TMenuItem;
    AboutMenuItem: TMenuItem;
    CloseAction: TAction;
    RemoteRemindAction: TAction;
    RemoteTaskAction: TAction;
    LogRichEdit: TRichEdit;
    TaskTreeView: TTreeView;
    TaskSplitter: TSplitter;
    TabSheet1: TTabSheet;
    ConsolePanel: TPanel;
    ComboBox1: TComboBox;
    ConsoleCommandButton: TButton;
    ConsoleRunCommandSpeedButton: TSpeedButton;
    ConsoleRichEdit: TRichEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure RunCommandSpeedButtonClick(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
    procedure AddRemindActionExecute(Sender: TObject);
    procedure AddTaskActionExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure CloseProjectActionExecute(Sender: TObject);
    procedure CommandButtonClick(Sender: TObject);
    procedure CommandComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CommandComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ExitActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure ManagerActionExecute(Sender: TObject);
    procedure NewProjectActionExecute(Sender: TObject);
    procedure OpenProjectActionExecute(Sender: TObject);
    procedure RemindListBoxDblClick(Sender: TObject);
    procedure RemindTimerTimer(Sender: TObject);
    procedure RemoteTaskActionExecute(Sender: TObject);
    procedure RemoteRemindActionExecute(Sender: TObject);
    procedure TaskListBoxDblClick(Sender: TObject);
    procedure tcWindowsChange(Sender: TObject);
    procedure tcWindowsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    //procedure SpeedButton3Click(Sender: TObject);
  private
    //** Контрол для ComboBox ввода команд
    FCommandComboBoxControl: TCommandComboBoxControl;
    //** Флаг, который указывает закрывать программу или сворачивать в трей.
    FIsClose: Boolean;
    {**
      Функция добавления лог-сообщения.
      Все лог-сообщения поступают в микроядро.
      Далеее рассылаются по объектам вывода, записи и обработки лог-сообщений.
    }
    FOnAddToLog: TAIProcMessage;
    //** Список напоминаний
    FReminds: TReminds;
    //** Настройки программы
    FSettings: TAssistantSettings;
    //** Список заданий
    FTasks: TTasks;
  private // Reminder
    //** Флаг, который показывает, что это окно является главным окном сборки
    FIsMainWindow: Boolean;
    //FPool: TAIFilePool;
    function AddRemind(Remind: TRemind): Integer;
    function AddTask(Task: TTask): Integer;
    function NewRemind(Title: WideString; DateTime: TDateTime): TRemind;
    function NewTask(Title, Comment: WideString): TTask;
    procedure RefreshRemindListBox();
    procedure RefreshTaskListBox();
    function RemoteRemindByIndex(Index: Integer): Boolean;
    function RemoteTaskByIndex(Index: Integer): Boolean;
  protected
    //** Микроядро системы
    FCore: TAICore;
    procedure SetCore(Value: TAICore);
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
    //** Инициализировать
    procedure Initialize();
    //** Обновить кнопки открытых окон
    procedure RefreshChildTabs();
  public
    //** Микроядро системы
    property Core: TAICore read FCore write SetCore;
  public // Reminder
    {**
    Флаг, который указывает закрывать программу или сворачивать в трей.
    Флаг устанавливается при выборе "Выход" в контекстном меню.
    }
    property IsClose: Boolean read FIsClose;
    //** Флаг, который показывает, что это окно является главным окном сборки
    property IsMainWindow: Boolean read FIsMainWindow write FIsMainWindow;
  end;

const
  // Несколько пользователей программы
  IsMultiUser = False;

implementation

const
  FILE_EXT_INI  = 'ini';
  FILE_EXT_POOL = 'pool';
  FILE_EXT_XML  = 'xml';

{$R *.dfm}

{TAssistantForm}

procedure TAssistantForm.AboutActionExecute(Sender: TObject);
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

procedure TAssistantForm.CloseProjectActionExecute(Sender: TObject);
begin
  // Закрыть все открытые окна
  // ...

  // Подадим команду микроядру
  // ...
end;

procedure TAssistantForm.NewProjectActionExecute(Sender: TObject);
begin
  // ...
end;

procedure TAssistantForm.OpenProjectActionExecute(Sender: TObject);
begin
  // Закроем проект
  CloseProjectActionExecute(Sender);

  // Выберем файл
  // ...

  // Подадим команду микроядру
  // ...
end;

function TAssistantForm.AddRemind(Remind: TRemind): Integer;
begin
  Result := Length(FReminds);
  SetLength(FReminds, Result + 1);
  FReminds[Result] := Remind;
end;

procedure TAssistantForm.AddRemindActionExecute(Sender: TObject);
var
  fmRemind: TRemindEditForm;
  task: WideString;
begin
  fmRemind := TRemindEditForm.Create(Self);
  try
    fmRemind.DateTime := Now;
    if fmRemind.ShowModal() = mrOK then
    begin
      task := fmRemind.edTask.Text;
      if (task <> '') then
      begin
        NewRemind(task, fmRemind.DateTime);
        RefreshRemindListBox();
      end;
    end;
  except
  end;
  fmRemind.Free();
end;

function TAssistantForm.AddTask(Task: TTask): Integer;
begin
  Result := Length(FTasks);
  SetLength(FTasks, Result + 1);
  FTasks[Result] := Task;
end;

procedure TAssistantForm.AddTaskActionExecute(Sender: TObject);
var
  TaskForm: TTaskForm;
begin
  TaskForm := TTaskForm.Create(Self);
  if TaskForm.ShowModal() = mrOK then
  begin
    NewTask(TaskForm.TitleEdit.Text, TaskForm.CommentMemo.Text);
    RefreshTaskListBox();
  end;
  TaskForm.Free();
end;

function TAssistantForm.AddToLog(Msg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(Msg);
  except
  end;

  {if Assigned(FLog) then
  try
    Result := FLog.AddMsg(Msg);
  except
  end;}
end;

procedure TAssistantForm.Button1Click(Sender: TObject);
begin
  TAssistantProgram.GetInstance().RunFile('Example1.javax');
end;

procedure TAssistantForm.CommandButtonClick(Sender: TObject);
begin
  // ...
end;

procedure TAssistantForm.CommandComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    Self.RunCommandSpeedButtonClick(nil);
end;

procedure TAssistantForm.CommandComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    CommandComboBox.Text := '';
end;

procedure TAssistantForm.CloseActionExecute(Sender: TObject);
begin
  Hide();
end;

function TAssistantForm.CloseWindow(form: TForm): Boolean;
begin
  Result := False;
  if Assigned(form) then
  begin
    // Проверяем флаг главного окна
    if (form.Tag and $01 <> $01) then
    begin
      form.Free();
      RefreshChildTabs();
      Result := True;
    end;
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

function TAssistantForm.DoCommand(Cmd: WideString): Boolean;
var
  form: TForm;
begin
  Result := False;
  if cmd = 'HELP' then
  begin
    AddToLog('--------------------------------');
    AddToLog('Программа: AIReasoner');
    AddToLog('Версия: 0.0.0.1');
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
    form := ActiveMDIChild;
    if (form is TAIForm) then
    begin
      Result := TAIForm(form).AddCommand(cmd);
    end;

    if not(Result) and Assigned(FCore) then
    begin
      // Передаем команду микроядру на выполнение
      FCore.AddCommand(cmd);
      // ...
      Result := True;
    end;
  end;
end;

procedure TAssistantForm.DoCreate();
var
  RichEditLog: TRichEditLog;
  p: TAssistantProgram;
begin
  inherited;

  ////TAssistantDataSaver.Save('c:\example.xml', DomImplementation);

  // Инициализируем настройки программы
  FSettings := TAssistantSettings.Create();
  FSettings.Title := Caption;
  TAssistantSettingsLoader.Load(FSettings, ExtractFilePath(ParamStr(0)) + 'Assistant.' + FILE_EXT_INI);
  if FSettings.Title <> '' then
    Caption := FSettings.Title;

  //FConfigDocument := TConfigDocument.

  // Загружаем данные из XML файлов
  TRemindLoader.Load(FReminds, ExtractFilePath(ParamStr(0)) + 'Reminder.' + FILE_EXT_XML);
  TTaskLoader.Load(FTasks, ExtractFilePath(ParamStr(0)) + 'Tasks.' + FILE_EXT_XML);
  RefreshRemindListBox();
  RefreshTaskListBox();

  // Инициализируем контрол для элемента ввода команд
  FCommandComboBoxControl := TCommandComboBoxControl.Create();
  FCommandComboBoxControl.Control := CommandComboBox;
  FCommandComboBoxControl.OnCommand := CommandButtonClick;

  p := TAssistantProgram.GetInstance();

  RichEditLog := TRichEditLog.Create();
  RichEditLog.RichEdit := LogRichEdit;
  p.LogJournal := RichEditLog;

  // Выполнить скрипт
  p.RunScript('LogJournal.AddToLog("Проверка AIL");');

  ConsoleRichEdit.Lines.Add(p.ProgramName + ' (' + IntToStr(p.ProgramID) + ') ' + p.ProgramVersion);
  if (p.ProgramNameDisplay <> '') and (p.ProgramName <> p.ProgramNameDisplay) then
    ConsoleRichEdit.Lines.Add(p.ProgramNameDisplay);
  if p.ProgramDescription <> '' then
    ConsoleRichEdit.Lines.Add(p.ProgramDescription);
  ConsoleRichEdit.Lines.Add('Введите имя:');
end;

procedure TAssistantForm.DoDestroy();
var
  i: Integer;
  form: TForm;
begin
  inherited;

  // Сохраним данные в XML файл
  TRemindSaver.Save(FReminds, ExtractFilePath(ParamStr(0)) + 'Reminder.' + FILE_EXT_XML);
  TTaskSaver.Save(FTasks, ExtractFilePath(ParamStr(0)) + 'Tasks.' + FILE_EXT_XML);

  // Закрываем все дочерние окна
  for i := MDIChildCount - 1 downto 0 do
  begin
    form := MDIChildren[i];
    if Assigned(form) then
      form.Free();
  end;
end;

procedure TAssistantForm.ExitActionExecute(Sender: TObject);
begin
  FIsClose := True;
  Application.MainForm.Close();
end;

procedure TAssistantForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Завершать работу программы если IsClose=True или если главное окно не видимо
  CanClose := FIsClose or not(Visible);
  if not(FIsClose) then
    Hide();
end;

procedure TAssistantForm.FormPaint(Sender: TObject);
begin
  // ...
end;

procedure TAssistantForm.Initialize();
begin
  if not(TAssistantProgram.GetInstance().IsDebug) then
  begin
    CommandComboBox.Visible := False;
    CommandButton.Visible := False;
    RunCommandSpeedButton.Visible := False;
    LogRichEdit.Visible := False;
    tcWindows.Hide();
  end;

  //tcWindows.Tabs.Clear();

  {FReasonerForm := TfmReasoner.Create(Self);
  FReasonerForm.OnClose := ChildFormClose;

  FTabReasoner := tcWindows.Tabs.Add('Reasoner');

  InitRules();
  InitLog();
  AddMsg('Создаем Reasoner');
  FReasoner := TAIWSReasoner.Create();
  AddMsg('Reasoner создан успешно');}

  RefreshChildTabs();
end;

procedure TAssistantForm.ManagerActionExecute(Sender: TObject);
begin
  Show();
end;

function TAssistantForm.NewRemind(Title: WideString; DateTime: TDateTime): TRemind;
begin
  Result := TRemind.Create();
  Result.Title := Title;
  Result.DateTime := DateTime;
  AddRemind(Result);
end;

function TAssistantForm.NewTask(Title, Comment: WideString): TTask;
begin
  Result := TTask.Create();
  Result.Title := Title;
  Result.Comment := Comment;
  AddTask(Result);
end;

procedure TAssistantForm.RefreshChildTabs();
var
  i: Integer;
  ii: Integer;
  c: Integer;
  form: TForm;
begin
  tcWindows.Tabs.Clear();
  ii := -1;
  c := MDIChildCount;
  for i := 0 to c - 1 do
  begin
    form := MDIChildren[i];
    tcWindows.Tabs.Add(form.Caption);
    if ActiveMDIChild = form then
      ii := i;
  end;
  tcWindows.TabIndex := ii;
end;

procedure TAssistantForm.RefreshRemindListBox();
var
  i: Integer;
begin
  RemindListBox.Clear();
  for i := 0 to High(FReminds) do
    RemindListBox.Items.Add(FReminds[i].Title + '=' + DateTimeToStr(FReminds[i].DateTime));
end;

procedure TAssistantForm.RefreshTaskListBox();
var
  i: Integer;
begin
  TaskListBox.Clear();
  for i := 0 to High(FTasks) do
    TaskListBox.Items.Add(FTasks[i].Title + ' - ' + FTasks[i].Comment);
end;

procedure TAssistantForm.RemindListBoxDblClick(Sender: TObject);
var
  fmTask: TRemindEditForm;
  task: TRemind;
  index: Integer;
begin
  index := RemindListBox.ItemIndex;
  if (index >= 0) and (index < Length(FReminds)) then
  try
    task := FReminds[index];
    if not(Assigned(task)) then Exit;

    fmTask := TRemindEditForm.Create(Self);
    try
      fmTask.Task := task;
      if fmTask.ShowModal() = mrOK then
      begin
        RefreshRemindListBox();
      end;
    except
    end;
    fmTask.Free();
  except
  end;
end;

procedure TAssistantForm.RemoteTaskActionExecute(Sender: TObject);
begin
  RemoteTaskByIndex(TaskListBox.ItemIndex);
  RefreshTaskListBox();
end;

procedure TAssistantForm.RemoteRemindActionExecute(Sender: TObject);
begin
  RemoteRemindByIndex(RemindListBox.ItemIndex);
  RefreshRemindListBox();
end;

function TAssistantForm.RemoteRemindByIndex(Index: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  if (Index >= 0) and (Index < Length(FReminds)) then
  begin
    FReminds[Index] := nil;
    for i := Index to High(FReminds) - 1 do
      FReminds[i] := FReminds[i + 1];
    SetLength(FReminds, High(FReminds));
    Result := True;
  end;
end;

function TAssistantForm.RemoteTaskByIndex(Index: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  if (Index >= 0) and (Index < Length(FTasks)) then
  begin
    FTasks[Index] := nil;
    for i := Index to High(FTasks) - 1 do
      FTasks[i] := FTasks[i + 1];
    SetLength(FTasks, High(FTasks));
    Result := True;
  end;
end;

procedure TAssistantForm.RunCommandSpeedButtonClick(Sender: TObject);
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

procedure TAssistantForm.SetCore(Value: TAICore);
begin
  FCore := Value;
  FOnAddToLog := TAICore(Value).AddLogMessage;
end;

{
procedure TAssistantForm.SpeedButton3Click(Sender: TObject);
var
  form: TForm;
begin
  form := ActiveMDIChild;
  if Assigned(form) then
  begin
    // Проверяем флаг главного окна
    if (form.Tag and $01 <> $01) then
      CloseWindow(form);
  end;
end;
}

procedure TAssistantForm.TaskListBoxDblClick(Sender: TObject);
var
  TaskForm: TTaskForm;
  index: Integer;
begin
  index := TaskListBox.ItemIndex;
  if (index >= 0) and (index < Length(FTasks)) then
  try
    TaskForm := TTaskForm.Create(Self);
    TaskForm.Task := FTasks[index];
    if TaskForm.ShowModal() = mrOK then
    begin
      RefreshTaskListBox();
    end;
    TaskForm.Free();
  except
  end;
end;

procedure TAssistantForm.tcWindowsChange(Sender: TObject);
var
  i: Integer;
  name: WideString;
begin
  if (tcWindows.TabIndex >= 0) and (tcWindows.TabIndex < Self.MDIChildCount) then
  begin
    name := tcWindows.Tabs.Strings[tcWindows.TabIndex];
    for i := 0 to Self.MDIChildCount - 1 do
      if Self.MDIChildren[i].Caption = name then
        Self.MDIChildren[i].Show();
  end;
end;

procedure TAssistantForm.tcWindowsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {if tcWindows.TabIndex = FTabReasoner then
  begin
    if Assigned(FReasoner) then
      FReasonerForm.Show();
  end
  else if tcWindows.TabIndex = FTabRules then
  begin
    if Assigned(FRules) then
      FRules.Show();
  end
  else if tcWindows.TabIndex = FTabLog then
  begin
    if Assigned(FLog) then
      FLog.Show();
  end;
  // ...}
end;

procedure TAssistantForm.RemindTimerTimer(Sender: TObject);
var
  i: Integer;
  dt: TDateTime;
  dtNow: TDateTime;
  fmRemind: TRemindForm;
begin
  for i := 0 to RemindListBox.Count - 1 do
  begin
    dt := FReminds[i].DateTime;
    dtNow := Now();
    if (dt <= dtNow) then
    begin
      RemindTimer.Enabled := False;

      fmRemind := TRemindForm.Create(Self);
      fmRemind.Remind := FReminds[i];
      if fmRemind.ShowModal() = mrOk then
      begin
        Self.RemoteRemindByIndex(i);
      end;
      RefreshRemindListBox();
      RemindTimer.Enabled := True;
      Exit;
    end;
  end;
end;

end.
