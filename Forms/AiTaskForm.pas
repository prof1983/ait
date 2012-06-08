{**
@Abstract(Окно редактирования задания)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.05.2005)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiTaskForm;

interface

uses
  Classes, Controls, ComCtrls, Dialogs, Graphics, Forms, Messages, StdCtrls,
  SysUtils, Variants, Windows,
  ABaseUtils2, ATypes,
  AiBase; {AiGlobals;}

type
  TFormTask = class(TForm)
    EditName: TEdit;
    LabelTitle: TLabel;
    EditTitle: TEdit;
    MemoComent: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    LabelDateTimeStart: TLabel;
    LabelDateTimeEnd: TLabel;
    Label5: TLabel;
    EditTimeImplementation: TEdit;
    DateTimePickerStart: TDateTimePicker;
    DateTimePickerEnd: TDateTimePicker;
    LabelPriority: TLabel;
    ComboBoxPriority: TComboBox;
    ButtonMethods: TButton;
    ButtonCancel: TButton;
    ButtonOk: TButton;
    CheckBoxStart: TCheckBox;
    CheckBoxEnd: TCheckBox;
    Label6: TLabel;
    EditText: TEdit;
  private
    FMethods: array of TAiId;
  public
    function Clear: TError;
    procedure DisableEnd;
    procedure DisableStart;
    procedure EnableEnd;
    procedure EnableStart;
    function GetCountMethods: UInt32;
    function GetMethod(Index: UInt32): TAiId;
    function GetTaskComent: String;
    function GetTaskDateTimeEnd: TDateTime;
    function GetTaskDateTimeStart: TDateTime;
    function GetTaskName: String;
    function GetTaskPriority: UInt32;
    function GetTaskText: String;
    function GetTaskTimeInplementation: UInt64;
    function GetTaskTitle: String;
    function SetTaskComent(Value: String): TError;
    function SetTaskDateTimeEnd(Value: TDateTime): TError;
    function SetTaskDateTimeStart(Value: TDateTime): TError;
    function SetTaskName(Value: String): TError;
    function SetTaskPriority(Value: UInt32): TError;
    function SetTaskText(Value: String): TError;
    function SetTaskTimeImplementation(Value: UInt64): TError;
    function SetTaskTitle(Value: String): TError;
  end;

var
  FormTask: TFormTask;

implementation

{$R *.dfm}

{ TFormTask }

function TFormTask.Clear: TError;
begin
  EditName.Text := '';
  EditTitle.Text := '';
  EditText.Text := '';
  MemoComent.Clear;
  DisableStart;
  DisableEnd;
  EditTimeImplementation.Text := '1000';
  ComboBoxPriority.ItemIndex := 2;
  SetLength(FMethods, 0);
  Result := 0;
end;

procedure TFormTask.DisableEnd;
begin
  CheckBoxEnd.Checked := False;
  LabelDateTimeEnd.Enabled := False;
  DateTimePickerEnd.Enabled := False;
end;

procedure TFormTask.DisableStart;
begin
  CheckBoxStart.Checked := False;
  LabelDateTimeStart.Enabled := False;
  DateTimePickerStart.Enabled := False;
end;

procedure TFormTask.EnableEnd;
begin
  CheckBoxEnd.Checked := True;
  LabelDateTimeEnd.Enabled := True;
  DateTimePickerEnd.Enabled := True;
end;

procedure TFormTask.EnableStart;
begin
  CheckBoxStart.Checked := True;
  LabelDateTimeStart.Enabled := True;
  DateTimePickerStart.Enabled := True;
end;

function TFormTask.GetCountMethods: UInt32;
begin
  Result := Length(FMethods);
end;

function TFormTask.GetMethod(Index: UInt32): TAiId;
begin
  if Index >= Length(FMethods) then
    Result := 0
  else
    Result := FMethods[Index];
end;

function TFormTask.GetTaskComent: String;
begin
  Result := MemoComent.Text;
end;

function TFormTask.GetTaskDateTimeEnd: TDateTime;
begin
  Result := DateTimePickerEnd.DateTime;
end;

function TFormTask.GetTaskDateTimeStart: TDateTime;
begin
  Result := DateTimePickerStart.DateTime;
end;

function TFormTask.GetTaskName: String;
begin
  Result := EditName.Text;
end;

function TFormTask.GetTaskPriority: UInt32;
begin
  Result := ComboBoxPriority.ItemIndex;
end;

function TFormTask.GetTaskText: String;
begin
  Result := EditText.Text;
end;

function TFormTask.GetTaskTimeInplementation: UInt64;
begin
  Result := cStrToUInt64(EditTimeImplementation.Text);
end;

function TFormTask.GetTaskTitle: String;
begin
  Result := EditTitle.Text;
end;

function TFormTask.SetTaskComent(Value: String): TError;
begin
  MemoComent.Text := Value;
  Result := 0;
end;

function TFormTask.SetTaskDateTimeEnd(Value: TDateTime): TError;
begin
  DateTimePickerEnd.DateTime := Value;
  Result := 0;
end;

function TFormTask.SetTaskDateTimeStart(Value: TDateTime): TError;
begin
  DateTimePickerStart.DateTime := Value;
  Result := 0;
end;

function TFormTask.SetTaskName(Value: String): TError;
begin
  EditName.Text := Value;
  Result := 0;
end;

function TFormTask.SetTaskPriority(Value: UInt32): TError;
begin
  Result := 1;
  if Value > 4 then Exit;
  ComboBoxPriority.ItemIndex := Value;
  Result := 0;
end;

function TFormTask.SetTaskText(Value: String): TError;
begin
  EditText.Text := Value;
  Result := 0;
end;

function TFormTask.SetTaskTimeImplementation(Value: UInt64): TError;
begin
  EditTimeImplementation.Text := cUInt64ToStr(Value);
  Result := 0;
end;

function TFormTask.SetTaskTitle(Value: String): TError;
begin
  EditTitle.Text := Value;
  Result := 0;
end;

end.
