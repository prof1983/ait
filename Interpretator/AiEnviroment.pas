{**
@Abstract(Среда для выполения программы)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.06.2007)
@LastMod(25.04.2012)
@Version(0.5)

Среда выполнения включает в себя следующие элементы:
1. Онтология
  1.1. Пространства имен
  1.2. Классы
  1.3. Свойства классов
  1.4. Методы классов
  1.5. Зависимости классов, свойств (факты зависимостей)

  1.6. Общие правила
  1.7. Общие факты
2. Рабочие факты (значения определенных свойств определенных объектов)
3. Рабочие правила

Онтология может быть конечная или бесконечная.

История версий:
0.0.0.2 - 17.06.2007 - Добавил FRules
0.0.0.1 - 17.06.2007 - Создал FNamespaces
}
unit AiEnviroment;

interface

uses
  AiNamespace;

type
  {** Правило IF .. THEN ..
  Состоит из двух основных частей:
  1. Часть Если (IF, Condition Entities)
  2. Часть Тогда (THEN, =>)
  }
  TAiRule = class(TInterfacedObject)
  private
    //FConditionEntities: array of ...
  public
  end;

type // Среда для выполения программы
  TAiEnviroment = class(TInterfacedObject)
  private
    // Массив пространств имен
    FNamespaces: array of TAiNamespace;
    FRules: array of TAiRule;
    function GetNamespaceByIndex(Index: Integer): TAiNamespace;
    function GetRuleByIndex(Index: Integer): TAiRule;
  public
    function AddNamespace(Namespace: TAiNamespace): Integer;
  public
    property NamespaceByIndex[Index: Integer]: TAiNamespace read GetNamespaceByIndex;
    property RuleByIndex[Index: Integer]: TAiRule read GetRuleByIndex;
  end;

implementation

{ TAiEnviroment }

function TAiEnviroment.AddNamespace(Namespace: TAiNamespace): Integer;
begin
  Result := Length(FNamespaces);
  SetLength(FNamespaces, Result + 1);
  FNamespaces[Result] := Namespace;
end;

function TAiEnviroment.GetNamespaceByIndex(Index: Integer): TAiNamespace;
begin
  if (Index >= 0) and (Index < Length(FNamespaces)) then
    Result := FNamespaces[Index]
  else
    Result := nil;
end;

function TAiEnviroment.GetRuleByIndex(Index: Integer): TAiRule;
begin
  if (Index >= 0) and (Index < Length(FRules)) then
    Result := FRules[Index]
  else
    Result := nil;
end;

end.
