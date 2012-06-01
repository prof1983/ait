{**
@Abstract(Форма редактирования задания)
@Author(Prof1983 prof1983@ya.ru)
@Created(27.06.2007)
@LastMod(01.06.2012)
@Version(0.5)

История версий:
0.0.1.0 - 06.07.2007 - При редактировании не сохранялзя заголовок. Исправил.
0.0.0.4 - 03.07.2007 - [Bug-0001] Добавил 4 кнопки увеличения времени
0.0.0.3 - 29.06.2007 - Создал bbOkClick()
0.0.0.2 - 28.06.2007
0.0.0.1 - 27.06.2007
}
unit ARemindEditForm;

interface

uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, Graphics, Forms, Messages,
  StdCtrls, SysUtils, Variants, Windows,
  ARemind;

type //** @abstract(Форма редактирования задания)
  TRemindEditForm = class(TForm)
    Label1: TLabel;
    edTask: TEdit;
    Label2: TLabel;
    DatePicker: TDateTimePicker;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    TimePicker: TDateTimePicker;
    btFiveMinut: TButton;
    btTenMinut: TButton;
    btHour: TButton;
    btDay: TButton;
    procedure btDayClick(Sender: TObject);
    procedure btHourClick(Sender: TObject);
    procedure btTenMinutClick(Sender: TObject);
    procedure btFiveMinutClick(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
  private
    FTask: TRemind;
    function GetDateTime(): TDateTime;
    procedure SetDateTime(Value: TDateTime);
    procedure SetTask(Value: TRemind);
  public
    property DateTime: TDateTime read GetDateTime write SetDateTime;
    property Task: TRemind read FTask write SetTask;
  end;

implementation

{$R *.dfm}

const
  Day = 1;
  Hour = Day / 24;
  Minute = Hour / 60;

{ TRemindEditForm }

procedure TRemindEditForm.bbOkClick(Sender: TObject);
begin
  if Assigned(FTask) then
  begin
    FTask.Title := edTask.Text;
    FTask.DateTime := DateTime;
  end;
end;

procedure TRemindEditForm.btDayClick(Sender: TObject);
begin
  DatePicker.Date := DatePicker.Date + Day;
end;

procedure TRemindEditForm.btFiveMinutClick(Sender: TObject);
begin
  TimePicker.Time := TimePicker.Time + Minute * 5;
end;

procedure TRemindEditForm.btHourClick(Sender: TObject);
begin
  TimePicker.Time := TimePicker.Time + Hour;
end;

procedure TRemindEditForm.btTenMinutClick(Sender: TObject);
begin
  TimePicker.Time := TimePicker.Time + Minute * 10;
end;

function TRemindEditForm.GetDateTime(): TDateTime;
begin
  Result := Trunc(DatePicker.DateTime) + Frac(TimePicker.DateTime);
end;

procedure TRemindEditForm.SetDateTime(Value: TDateTime);
begin
  DatePicker.DateTime := Value;
  TimePicker.DateTime := Value;
end;

procedure TRemindEditForm.SetTask(Value: TRemind);
begin
  FTask := Value;
  edTask.Text := Value.Title;
  DateTime := Value.DateTime;
end;

end.
