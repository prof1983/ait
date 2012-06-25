{**
@Abstract(Форма редактирования задания)
@Author(Prof1983 prof1983@ya.ru)
@Created(27.06.2007)
@LastMod(25.06.2012)
@Version(0.5)

История версий:
0.0.0.3 - 29.06.2007 - Создал bbOkClick()
0.0.0.2 - 28.06.2007
0.0.0.1 - 27.06.2007
}
unit ARemindTaskForm;

interface

uses
  Buttons, Classes, ComCtrls, Controls, Dialogs, Graphics, Forms, Messages,
  StdCtrls, SysUtils, Variants, Windows,
  ARemind;

type
  TfmRemindTask = class(TForm)
    Label1: TLabel;
    edTask: TEdit;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    DateTimePicker2: TDateTimePicker;
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

{ TfmTask }

procedure TfmRemindTask.bbOkClick(Sender: TObject);
begin
  if Assigned(FTask) then
    FTask.DateTime := DateTime;
end;

function TfmRemindTask.GetDateTime(): TDateTime;
begin
  Result := Trunc(DateTimePicker1.DateTime) + Frac(DateTimePicker2.DateTime);
end;

procedure TfmRemindTask.SetDateTime(Value: TDateTime);
begin
  DateTimePicker1.DateTime := Value;
  DateTimePicker2.DateTime := Value;
end;

procedure TfmRemindTask.SetTask(Value: TRemind);
begin
  FTask := Value;
  edTask.Text := Value.Title;
  DateTime := Value.DateTime;
end;

end.
