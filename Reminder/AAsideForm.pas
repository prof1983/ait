{**
@Abstract(Окно "Отложить" напоминание)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.07.2007)
@LastMod(01.06.2012)
@Version(0.5)

History:
0.0.1.1 - 15.07.2007
0.0.1.0 - 14.07.2007 - Добавил Remind
}
unit AAsideForm;

interface

uses
  Buttons, Classes, Controls, ComCtrls, Dialogs, Graphics, Forms, Messages,
  StdCtrls, SysUtils, Variants, Windows,
  ARemind;

type
  TAsideForm = class(TForm)
    RadioButton1: TRadioButton;
    Label1: TLabel;
    DayEdit: TEdit;
    DayUpDown: TUpDown;
    Label2: TLabel;
    HourEdit: TEdit;
    HourUpDown: TUpDown;
    Label3: TLabel;
    MinuteEdit: TEdit;
    MinuteUpDown: TUpDown;
    RadioButton2: TRadioButton;
    DatePicker: TDateTimePicker;
    TimePicker: TDateTimePicker;
    OKBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    procedure MinuteUpDownChanging(Sender: TObject; var AllowChange: Boolean);
    procedure HourUpDownChanging(Sender: TObject; var AllowChange: Boolean);
    procedure DayUpDownChanging(Sender: TObject; var AllowChange: Boolean);
    procedure OKBitBtnClick(Sender: TObject);
  private
    //** Напоминание
    FRemind: TRemind;
    procedure SetRemind(Value: TRemind);
  public
    //** Напоминание
    property Remind: TRemind read FRemind write SetRemind;
  end;

implementation

{$R *.dfm}

const
  H = 1 / 24;
  M = H / 60;

{TAsideForm}

procedure TAsideForm.DayUpDownChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := True;
  DayEdit.Text := IntToStr(DayUpDown.Position);
end;

procedure TAsideForm.HourUpDownChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := True;
  HourEdit.Text := IntToStr(HourUpDown.Position);
end;

procedure TAsideForm.MinuteUpDownChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := True;
  MinuteEdit.Text := IntToStr(MinuteUpDown.Position);
end;

procedure TAsideForm.OKBitBtnClick(Sender: TObject);
var
  day: Integer;
  hour: Integer;
  minute: Integer;
begin
  if Assigned(FRemind) then
  begin
    if RadioButton1.Checked then
    begin // Отложить на
      if TryStrToInt(DayEdit.Text, day) then
        FRemind.DateTime := FRemind.DateTime + day;
      if TryStrToInt(HourEdit.Text, hour) then
        FRemind.DateTime := FRemind.DateTime + hour * H;
      if TryStrToInt(MinuteEdit.Text, minute) then
        FRemind.DateTime := FRemind.DateTime + minute * M;
    end
    else if RadioButton2.Checked then
    begin // Отложить до
      FRemind.DateTime := Trunc(DatePicker.Date) + Frac(TimePicker.Time);
    end;
  end;
end;

procedure TAsideForm.SetRemind(Value: TRemind);
begin
  FRemind := Value;
  if Assigned(FRemind) then
  begin
    DatePicker.DateTime := FRemind.DateTime;
    TimePicker.DateTime := FRemind.DateTime;
  end;
end;

end.
