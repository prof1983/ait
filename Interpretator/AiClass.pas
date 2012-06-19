{**
@Abstract(AiClass)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.06.2007)
@LastMod(19.06.2012)
@Version(0.5)
}
unit AiClass;

interface

uses
  AiMethodObj;

type // Класс
  TAiClass = class(TInterfacedObject)
  private
    // Массив методов
    FMethods: array of TAiMethod;
    //** Имя класса
    FName: WideString;
    function GetMethodByIndex(Index: Integer): TAiMethod;
  public
    function AddMethod(Method: TAiMethod): Integer;
  public
    property MethodByIndex[Index: Integer]: TAiMethod read GetMethodByIndex;
    //** Имя класса
    property Name: WideString read FName write FName;
  end;

implementation

{ TAiClass }

function TAiClass.AddMethod(Method: TAiMethod): Integer;
begin
  Result := Length(FMethods);
  SetLength(FMethods, Result + 1);
  FMethods[Result] := Method;
end;

function TAiClass.GetMethodByIndex(Index: Integer): TAiMethod;
begin
  if (Index >= 0) and (Index < Length(FMethods)) then
    Result := FMethods[Index]
  else
    Result := nil;
end;

end.
