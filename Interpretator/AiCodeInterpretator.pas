{**
@Abstract(Интерпретатор кода на языке AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.09.2006)
@LastMod(28.04.2012)
@Version(0.5)
}
unit AiCodeInterpretator;

interface

uses
  AiInterpretatorImpl;

type
  TAICodeInterpretator = class(TAIInterpretator)
  private
    //FCode: TAIXmlParam;         // Выполняемый код
    //FParams: TAIParams;         // Параметры
    //FParamsIn: TAIParams;       // Входные данные
    //FParamsOut: TAIParams;      // Выходные данные
    //FSystem: TAISystem;         // Глобальный системный объект для кода
  public
    function Run(): WordBool;
  end;

implementation

{ TAICodeInterpretator }

function TAICodeInterpretator.Run(): WordBool;
var
  i: Integer;
begin
  Result := False;

  // Получаем список нодов - действий, которые нужно выполнить по порядку
  // ...
  if not(Assigned(Code)) then Exit;

  // Выполняем действия
  for i := 0 to Code.Count - 1 do
  begin
    if Code.Strings[i] = '' then

  end;
end;

end.
