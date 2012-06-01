{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(31.01.2008)
@LastMod(20.07.2011)
@Version(0.5)

0.0.5.7 - 20.07.2011
[*] Rename Task.pas -> ATaskObj.pas
}
unit AiTaskObj1;

interface

type
  TATask = class
  private
    FName: string;
    FText: string;
  public
    function GetName: string;
    function GetText: string;
    procedure SetName(const Value: string);
    procedure SetText(const Value: string);
  end;

implementation

{ TATask }

function TATask.GetName: string;
begin
  Result := FName;
end;

function TATask.GetText: string;
begin
  Result := FText;
end;

procedure TATask.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TATask.SetText(const Value: string);
begin
  FText := Value;
end;

end.
 