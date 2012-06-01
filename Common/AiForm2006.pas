{**
@Abstract(Форма - окошко Windows)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.01.2006)
@LastMod(03.05.2012)
@Version(0.5)
}
unit AiForm2006;

interface

uses
  Forms, SysUtils,
  AConsts2, ATypes,
  AiFrameImpl;

type //** Форма - окошко Windows
  TAIForm = class(TAiFreim)
  private
    FForm: TForm;
  private
    function GetForm(): TForm;
    procedure SetForm(Value: TForm);
  public
    function AssignedForm(): Boolean;
    property Form: TForm read GetForm write SetForm;
    function Hide(): Boolean; virtual;
    function Initialize(): TProfError; override;
    function Show(): Boolean; virtual;
  end;

implementation

{ TAIForm }

function TAIForm.AssignedForm(): Boolean;
begin
  Result := Assigned(FForm);
  if not(Result) then
    AddToLog(lgGeneral, ltError, Format(stNotAssigned, [ClassName, 'Form']));
end;

function TAIForm.GetForm(): TForm;
begin
  if not(Assigned(FForm)) then
    Application.CreateForm(TForm, FForm);
  Result := FForm;
end;

function TAIForm.Hide(): Boolean;
begin
  Result := AssignedForm();
  if not(Result) then Exit;
  FForm.Hide();
end;

function TAIForm.Initialize(): TProfError;
begin
  Result := inherited Initialize();
  GetForm;
end;

procedure TAIForm.SetForm(Value: TForm);
begin
  FForm := Value;
end;

function TAIForm.Show(): Boolean;
begin
  GetForm.Show;
  Result := True;
end;

end.
