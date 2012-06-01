{**
@Abstract(AiNamespace)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.06.2007)
@LastMod(25.04.2012)
@Version(0.5)
}
unit AiNamespace;

interface

uses
  AiClass;

type // Пространство имен
  TAiNamespace = class(TInterfacedObject)
  private
    // Массив классов
    FClasses: array of TAiClass;
    //** Имя пространства имен
    FName: WideString;
    function GetClassByIndex(Index: Integer): TAiClass;
  public
    function AddClass(Cls: TAiClass): Integer;
  public
    property ClassByIndex[Index: Integer]: TAiClass read GetClassByIndex;
    //** Имя пространства имен
    property Name: WideString read FName write FName;
  end;

implementation

{ TAiNamespace }

function TAiNamespace.AddClass(Cls: TAIClass): Integer;
begin
  Result := Length(FClasses);
  SetLength(FClasses, Result + 1);
  FClasses[Result] := Cls;
end;

function TAiNamespace.GetClassByIndex(Index: Integer): TAiClass;
begin
  if (Index >= 0) and (Index < Length(FClasses)) then
    Result := FClasses[Index]
  else
    Result := nil;
end;

end.
