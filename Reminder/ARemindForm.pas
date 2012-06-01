{**
@Abstract(Главное окно программы AiReminder)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2007)
@LastMod(01.06.2012)
@Version(0.5)

История версий:
0.0.2.0 - 14.07.2007 - FTask -> FRemind
0.0.1.1 - 05.07.2007 - fmRemind -> RemindForm
0.0.1.0 - 03.07.2007 - [Bug-0002] Добавил пункт "Отложить.Другое",
  добавил XUL окно выбора времени на которое отложить
0.0.0.3 - 29.06.2007
0.0.0.2 - 28.06.2007 - Добавил Task
0.0.0.1 - 28.06.2007
}
unit ARemindForm;

interface

uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Graphics, Forms,
  Menus, Messages, StdCtrls, SysUtils, Variants, Windows,
  //XulFormCreater,
  AAsideForm, ARemind;

{
Окно в формате XUL:

<?xml version="1.0" encoding="Windows-1251"?>
<window title="Напоминание" height="180" width="300">
  <box align="bottom" height="100">
    <button label="OK" oncommand="ExampleNamespace.ExampleClass.ExampleMethod();"/>
    <button label="Отложить" />
  </box>
</window>

<?xml version="1.0" encoding="Windows-1251"?>
<ail>
  <namespace name="ExampleNamespace">
    <class name="ExampleClass">
      <method name="ExampleMethod">
        <code>
          <command >
        </code>
      </method>
    </class>
  </namespace>
</ail>
}

type
  {!
  Главное окно программы AIReminder.
  }
  TRemindForm = class(TForm)
    reOut: TRichEdit;
    pnButtons: TPanel;
    bbOk: TBitBtn;
    // Отложить
    bbAside: TBitBtn;
    pmAside: TPopupMenu;
    mi5: TMenuItem;
    mi10: TMenuItem;
    mi15: TMenuItem;
    mi30: TMenuItem;
    mi60: TMenuItem;
    mi120: TMenuItem;
    miOther: TMenuItem;
    procedure miOtherClick(Sender: TObject);
    procedure bbAsideClick(Sender: TObject);
    procedure mi120Click(Sender: TObject);
    procedure mi60Click(Sender: TObject);
    procedure mi30Click(Sender: TObject);
    procedure mi10Click(Sender: TObject);
    procedure mi5Click(Sender: TObject);
    procedure mi15Click(Sender: TObject);
  private
    FRemind: TRemind;
    procedure SetTask(Value: TRemind);
  public
    property Remind: TRemind read FRemind write SetTask;
  end;

implementation

{$R *.dfm}

const
  Minute = 1 / 24 / 60;

const
  WINDOW_ASIDE =
    '<?xml version="1.0" encoding="Windows-1251"?>'+
    '<xul>'+
      '<window title="Отложить">'+
        '<hbox>'+
        '</hbox>'+
        '<hbox>'+
          '<button/>'+
          '<button/>'+
        '</hbox>'+
      '</window>'+
    '</xul>';


{TfmRemind}

procedure TRemindForm.bbAsideClick(Sender: TObject);
var
  Mouse: TMouse;
begin
  Mouse := TMouse.Create();
  pmAside.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  Mouse.Free();
end;

procedure TRemindForm.mi10Click(Sender: TObject);
begin
  if Assigned(FRemind) then
    FRemind.DateTime := FRemind.DateTime + 10 * Minute;
  Self.ModalResult := mrRetry;
  Close();
end;

procedure TRemindForm.mi120Click(Sender: TObject);
begin
  if Assigned(FRemind) then
    FRemind.DateTime := FRemind.DateTime + 120 * Minute;
  Self.ModalResult := mrRetry;
  Close();
end;

procedure TRemindForm.mi15Click(Sender: TObject);
begin
  if Assigned(FRemind) then
    FRemind.DateTime := FRemind.DateTime + 15 * Minute;
  Self.ModalResult := mrRetry;
  Close();
end;

procedure TRemindForm.mi30Click(Sender: TObject);
begin
  if Assigned(FRemind) then
    FRemind.DateTime := FRemind.DateTime + 30 * Minute;
  Self.ModalResult := mrRetry;
  Close();
end;

procedure TRemindForm.mi5Click(Sender: TObject);
begin
  if Assigned(FRemind) then
    FRemind.DateTime := FRemind.DateTime + 5 * Minute;
  Self.ModalResult := mrRetry;
  Close();
end;

procedure TRemindForm.mi60Click(Sender: TObject);
begin
  if Assigned(FRemind) then
    FRemind.DateTime := FRemind.DateTime + 60 * Minute;
  Self.ModalResult := mrRetry;
  Close();
end;

procedure TRemindForm.miOtherClick(Sender: TObject);
var
  form: TAsideForm;
  r: Boolean;
begin
  //form := TXulFormCreater.CreateXulWindow(WINDOW_ASIDE);
  form := TAsideForm.Create(Self);
  form.Remind := FRemind;
  r := (form.ShowModal() = mrOK);
  form.Free();

  if r then
    Close();
end;

procedure TRemindForm.SetTask(Value: TRemind);
begin
  FRemind := Value;
  reOut.Clear();
  reOut.Lines.Add(Value.Title);
end;

end.
