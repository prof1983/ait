{**
@Abstract(Ai form)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.06.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AiForm2007;

interface

uses
  Forms;

type
  TAiForm = class(TForm)
  public
    function AddCommand(Cmd: WideString): Boolean; virtual;
  end;

implementation

{ TAiForm }

function TAiForm.AddCommand(Cmd: WideString): Boolean;
begin
  Result := False;
end;

end.
