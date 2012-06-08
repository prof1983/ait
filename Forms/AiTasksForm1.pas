{**
@Abstract(Окно управления списком заданий)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.05.2005)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiTasksForm1;

interface

uses
  Windows, Messages, SysUtils, {Variants,} Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  ABase, AiFrameObj, AiListObj;
  {Prof_,
  Prof_AI,
  Prof_AI_Base,
  Prof_AI_Class,
  Prof_Base;}

type
  TFormTasks = class;

  TAiWinPanel = class
  end;

  TAiWinButton = class
  end;

  TAiWinListBox = class
  end;

  TAiFormTasks = class(TAiFrameObject)
  private
    FPanel1: TAIWinPanel;
    FButtonAdd: TAIWinButton;
    FButtonDelete: TAIWinButton;
    FButtonDown: TAIWinButton;
    FButtonInfo: TAIWinButton;
    FButtonInsert: TAIWinButton;
    FButtonRefresh: TAIWinButton;
    FButtonSaveXml: TAIWinButton;
    FButtonShow: TAIWinButton;
    FButtonUp: TAIWinButton;
    FForm: TFormTasks;
    FListBox1: TAIWinListBox;
  public
    function Initialize(): AError; override;
  end;

  TFormTasks = class(TForm)
    Panel1: TPanel;
    ButtonRefresh: TButton;
    ButtonAdd: TButton;
    ButtonInsert: TButton;
    ButtonDelete: TButton;
    ButtonInfo: TButton;
    ButtonShow: TButton;
    ButtonUp: TButton;
    ButtonDown: TButton;
    ListBox1: TListBox;
    ButtonSaveXml: TButton;
    procedure ButtonSaveXmlClick(Sender: TObject);
  private
    FList: TAiListObject;
  public
    function GetList(): TAiListObject;
    function Refresh(): AError;
    function SetList(Value: TAiListObject): AError;
  end;

var
  FormTasks: TFormTasks;

implementation

{$R *.dfm}

{ TAiFormTasks }

function TAiFormTasks.Initialize(): AError;
begin
  Result := inherited Initialize();
  if not(Assigned(FButtonAdd)) then FButtonAdd := TAIWinButton.Create;
  if not(Assigned(FButtonDelete)) then FButtonDelete := TAIWinButton.Create;
  if not(Assigned(FButtonDown)) then FButtonDown := TAIWinButton.Create;
  if not(Assigned(FButtonInfo)) then FButtonInfo := TAIWinButton.Create;
  if not(Assigned(FButtonRefresh)) then FButtonRefresh := TAIWinButton.Create;
  if not(Assigned(FButtonSaveXml)) then FButtonSaveXml := TAIWinButton.Create;
  if not(Assigned(FButtonShow)) then FButtonShow := TAIWinButton.Create;
  if not(Assigned(FButtonUp)) then FButtonUp := TAIWinButton.Create;

  if not(Assigned(FListBox1)) then FListBox1 := TAIWinListBox.Create;
  if not(Assigned(FPanel1)) then FPanel1 := TAIWinPanel.Create;
end;

{ TFormTasks }

procedure TFormTasks.ButtonSaveXmlClick(Sender: TObject);
begin
  {if Assigned(FList) then
    FList.SaveToFileXml('tasks.txt');}
end;

function TFormTasks.GetList(): TAiListObject;
begin
  Result := FList;
end;

function TFormTasks.Refresh(): AError;
begin
  Result := 1;
  {...}
end;

function TFormTasks.SetList(Value: TAiListObject): AError;
begin
  FList := Value;
  Result := Refresh;
end;

end.
