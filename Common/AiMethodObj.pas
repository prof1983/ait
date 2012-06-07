{**
@Abstract(AiMethod)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.06.2007)
@LastMod(25.04.2012)
@Version(0.5)
}
unit AiMethod;

interface

uses
  AiInterpretatorBaseTypes;

type // Метод
  TAiMethod = class(TInterfacedObject)
  private
    //** Выполняемый код метода
    FCode: WideString;
    //** Имя метода
    FName: WideString;
    //** Тип возращаемого результата
    FResultType: TAIValueType;
  public
    //** Выполняемый код метода
    property Code: WideString read FCode write FCode;
    //** Имя метода
    property Name: WideString read FName write FName;
    //** Тип возращаемого результата
    property ResultType: TAIValueType read FResultType write FResultType;
  end;

implementation

end.
