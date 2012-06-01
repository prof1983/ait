{**
@Abstract(Логический вывод на основе онтологии OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.06.2007)
@LastMod(26.03.2012)
@Version(0.5)

Главная форма программы.
Является MDI формой.
По умолчанию должна разворачиваться на полный экран.
В верхней части окна место для меню и основные кнопки быстрого вызова команд.
В верхней части окна есть поле для ввода команд вручную.
Рядом кнопка "..." для ввода многострочных и сложных команд.
Рядом кнопка "Run" для запуска выполнения команды.
В нижней части окна место для вывода кнопок открытых окон.
В нижней части окна также есть статусная строка для вывода информации.

Форме должен быть передан указатель на микроядро системы (Core)
для вызова выполнения команд.

Проторип внешнего вида окна:
- 1С 7.7 (http://www.1c.ru/)
- SAS Base (http://www.sas.com/)

История версий
0.1.0.2 - 20.06.2007 - Добавил FCore
0.1.0.1 - 20.06.2007 - Заменил edCommand -> cbCommand
0.1.0.0 - 20.06.2007 - Закоментировал все формы и объекты.
0.0.2.1 - 05.06.2007 - Добавил fmRules
0.0.2.0 - 04.06.2007 - Создан из fmReasoner
0.0.1.0 - 04.06.2007 - Сделал MDI окно логирования
}
unit AiOrganizerAssistantForm;

interface

uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Graphics, Forms, Messages,
  StdCtrls, SysUtils, Variants, Windows;

type //** @abstract(Логический вывод на основе онтологии OWL)
  TfmAssistant = class(TForm)
    tcWindows: TTabControl;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    sbMain: TStatusBar;
    cbCommand: TComboBox;
    btCommand: TButton;
    sbRunCommand: TSpeedButton;
    procedure cbCommandKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbCommandKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btCommandClick(Sender: TObject);
    procedure tcWindowsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btRunClick(Sender: TObject);
  private
    //** Микроядро системы
    //FCore: IAIWSCore;
    //FLog: TfmLog;
    //FReasoner: TAIWSReasoner;
    //FReasonerForm: TfmReasoner;
    //FRules: TfmRules;
  protected
    function AddMsg(Msg: WideString): Integer;
    procedure DoCreate(); override;
    procedure InitLog();
    procedure InitRules();
  public
    procedure Initialize();
    procedure RefreshChildTabs();
  public
    //** Микроядро системы
    //property Core: IAIWSCore read FCore write FCore;
  end;

implementation

{$R *.dfm}

{ TfmAssistant }

function TfmAssistant.AddMsg(Msg: WideString): Integer;
begin
  Result := 0;
  {if Assigned(FLog) then
  try
    Result := FLog.AddMsg(Msg);
  except
  end;}
end;

procedure TfmAssistant.btCommandClick(Sender: TObject);
begin
  // ...
end;

procedure TfmAssistant.btRunClick(Sender: TObject);
var
  cmd: WideString;
begin
  cmd := cbCommand.Text;
  cbCommand.Text := '';
  if cmd = '' then Exit;
  AddMsg('--> ' + cmd);

  if cmd = 'HELP' then
  begin
    AddMsg('--------------------------------');
    AddMsg('Программа: AIReasoner');
    AddMsg('Версия: 0.0.0.1');
    AddMsg('--------------------------------');
    AddMsg('Краткая справка по командам программы');
    AddMsg('HELP - вывести справку');
    AddMsg('RULES - вывести список правил');
    AddMsg('FACTS - вывести список фактов');
    AddMsg('LOG - показат окно логирования');
    AddMsg('--------------------------------');
  end
  else if cmd = 'RULES' then
  begin
    InitRules();

    {AddMsg('--------------------------------');
    AddMsg('Список правил');
    AddMsg('Список правил пуст');
    // ...
    AddMsg('--------------------------------');}
  end
  else if cmd = 'FACTS' then
  begin
    AddMsg('--------------------------------');
    AddMsg('Список фактов');
    AddMsg('Список фактов пуст');
    // ...
    AddMsg('--------------------------------');
  end
  else if cmd = 'LOG' then
  begin
    InitLog();
  end;
end;

procedure TfmAssistant.cbCommandKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    btRunClick(nil);
end;

procedure TfmAssistant.cbCommandKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    cbCommand.Text := '';
end;

procedure TfmAssistant.DoCreate();
begin
  inherited;
end;

procedure TfmAssistant.FormPaint(Sender: TObject);
begin
  // ...
end;

procedure TfmAssistant.Initialize();
begin
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

procedure TfmAssistant.InitLog();
begin
  {if not(Assigned(FLog)) then
  begin
    FLog := TfmLog.Create(Self);
    FTabLog := tcWindows.Tabs.Add('Log');
    tcWindows.TabIndex := FTabLog;
    AddMsg('наберите HELP для получения справки по работе с программой');
  end;}
end;

procedure TfmAssistant.InitRules();
begin
  {if not(Assigned(FRules)) then
  begin
    FRules := TfmRules.Create(Self);
    FTabRules := tcWindows.Tabs.Add('Rules');
  end;}
end;

procedure TfmAssistant.RefreshChildTabs();
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

procedure TfmAssistant.SpeedButton3Click(Sender: TObject);
var
  form: TForm;
begin
  form := ActiveMDIChild;
  if Assigned(form) then
  begin
    // Вроверяем флаг главного окна
    if (form.Tag and $01 <> $01) then
      form.Free();
  end;

  RefreshChildTabs();

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

procedure TfmAssistant.tcWindowsMouseUp(Sender: TObject; Button: TMouseButton;
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

end.
