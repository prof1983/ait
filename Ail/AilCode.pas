{**
@Abstract(Ai lang code)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Выполняемый код метода.
Может иметь сдедующие виды:
1. Выполнить действие (call)
2. Выполнить последовательность действий (begin ... end;)
3. Выполнить одно из перечисленных действий для достижения результата
   (while ... do begin call(item[i]); end;))
   Перед выполненим действия запускается машина логического вывода с целью
   выбора действия, которое с наибольшей вероятностью приведет к достижению цели.
4. Оператор условного перехода к выполнению действия. (if (...) then ... else ...)
   Для выбора действия используется машина логического вывода.
   Логическое условие может быть нечетким, может содержать одно или несколько правил.
   В том числе может учитывать правила из онтологий.
   При логическом выводе рассматриваются указанные онтологии, онтологии
   загруженные для рассматриваемой ситуации и базовые онтологии.
   Базовые онтологии - это онтологии, которые подгружаются при запуске системы и
   в них записываются базовые условия.

История изменений:
0.0.0.2 - 14.08.2007 - Добавил коментарии
}
unit AilCode;

interface

type
  TAilCodeType = (
    CallActionCodeType,             // Выполнить действие
    CallSortedActionListCodeType,   // Выполнить действия по порядку
    CallUnsortedActionListCodeType, // Выполнить действия в любом прядке
    CallOneActionOfListCodeType,    // Выполнить одно действие из списка для достижения результата
    ConditionCodeType               // Оператор условного перехода к выполнению действия
    );

type
  TAilCode = class
  private
    FCodeType: TAilCodeType;
  public
    function GetIsCallAction(): Boolean;
    function GetIsCallSortedActionList(): Boolean;
    function GetIsCallUnsortedActionList(): Boolean;
    function GetIsCallOneActionOfList(): Boolean;
    function GetIsCondition(): Boolean;
  public
    property CodeType: TAilCodeType read FCodeType;
    property IsCallAction: Boolean read GetIsCallAction;
    property IsCallSortedActionList: Boolean read GetIsCallSortedActionList;
    property IsCallUnsortedActionList: Boolean read GetIsCallUnsortedActionList;
    property IsCallOneActionOfList: Boolean read GetIsCallOneActionOfList;
    property IsCondition: Boolean read GetIsCondition;
  end;

implementation

{ TAilCode }

function TAilCode.GetIsCallAction(): Boolean;
begin
  Result := (FCodeType = CallActionCodeType);
end;

function TAilCode.GetIsCallOneActionOfList(): Boolean;
begin
  Result := (FCodeType = CallOneActionOfListCodeType);
end;

function TAilCode.GetIsCallSortedActionList(): Boolean;
begin
  Result := (FCodeType = CallSortedActionListCodeType);
end;

function TAilCode.GetIsCallUnsortedActionList(): Boolean;
begin
  Result := (FCodeType = CallUnsortedActionListCodeType);
end;

function TAilCode.GetIsCondition(): Boolean;
begin
  Result := (FCodeType = ConditionCodeType);
end;

end.
