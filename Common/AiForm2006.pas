{**
@Abstract Форма - окошко Windows
@Author Prof1983 <prof1983@ya.ru>
@Created 07.01.2006
@LastMod 15.12.2012
}
unit AiForm2006;

interface

uses
  Forms, SysUtils,
  ABase, AConsts2, ATypes,
  AiFrameObj;

type
  {** Форма - окошко Windows }
  TAiForm = class(TAiFrameObject)
  protected
    FForm: TForm;
  public
    function GetForm(): TForm;
    procedure SetForm(Value: TForm);
  public
    function AssignedForm(): Boolean;
    function Hide(): AError; virtual;
    function Initialize(): AError; override;
    function Show(): AError; virtual;
  public
    property Form: TForm read GetForm write SetForm;
  end;

implementation

{ TAiForm }

function TAiForm.AssignedForm(): Boolean;
begin
  Result := Assigned(FForm);
  if not(Result) then
    AddToLog(lgGeneral, ltError, Format(stNotAssigned, [ClassName, 'Form']));
end;

function TAiForm.GetForm(): TForm;
begin
  if not(Assigned(FForm)) then
    Application.CreateForm(TForm, FForm);
  Result := FForm;
end;

function TAiForm.Hide(): AError;
begin
  if not(AssignedForm()) then
  begin
    Result := -1;
    Exit;
  end;
  FForm.Hide();
  Result := 0;
end;

function TAiForm.Initialize(): AError;
begin
  Result := inherited Initialize();
  GetForm;
end;

procedure TAiForm.SetForm(Value: TForm);
begin
  FForm := Value;
end;

function TAiForm.Show(): AError;
begin
  GetForm.Show;
  Result := 0;
end;

end.
