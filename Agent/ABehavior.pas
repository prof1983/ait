{**
@Abstract(Поведение агента)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Prototype: jade.core.behaviours.Behaviour

Поведение агента определяет реакции на события, выполняемые действия.
У поведения (Behavior) может быть родительское поведение (Root). В этом случае
текущее поведение расширяет или замещает действия родительского поведения.

У каждого поведения выполняемяй код подпроцесса имеет следующий вид:

БесконечныйЦикл(
    ПолучитьСледующееСообщениеИзКонвеераСообщений(msg);
    Если(
      (msg != null),
      (
        // Тогда
        ОбработатьСообщение(msg);
      ),
      (
        // Иначе
        ПолучитьТекущееЗадание(job);
        Если(
          (job != null),
          (
            ПолучитьСледующуюКоманду(job, cmd);
            ВыполнитьКоманду(cmd);
          ),
          (
            ПолучитьСледующееЗадание(job);
            Если(
              (job != null),
              (ТекущееЗадание = job),
              (
                Сообщить('Список заданий пуст');
                Подождать(1000);
              )
            )
          )
        )
      )
    )
)

}
unit ABehavior;

// TODO: Separate ABehavior -> ABehaviorIntf and ABehaviorImpl

interface

uses
  ANode1;

type
  // Поведение агента
  IBehavior = interface
    // Название поведения
    function GetName(): WideString;
    // Главное поведение
    function GetRoot(): IBehavior;

    // Название поведения
    property Name: WideString read GetName;
    // Главное поведение
    property Root: IBehavior read GetRoot;
  end;

type
  TBehavior = class(TNodeItem, IBehavior)
  private
    FRoot: TBehavior;
    //FRunnable
  protected
    function GetName(): WideString;
    function GetRoot(): IBehavior;
  public
    //Action()
    //Block()
    //Block(ms)
    //Done()
    //Reset()
    //Restart()
  public
    property BehaviourName: WideString read GetName write SetNodeName;
    //property IsRunnable: Boolean read FRunnable;
    // Родительское поведение
    property Root: TBehavior read FRoot;
    //property DataStore: IDataStore read FDataStore;
  public
    //property OnEnd: TEvent read FOnEnd;
    //property OnStart: TEvent read FOnStart;
  end;

implementation

{ TBehavior }

function TBehavior.GetName(): WideString;
begin
  Result := GetNodeName();
  if (Result = '') then
  begin
    Result := Self.ClassName;
    if Result[1] = 'T' then
      Result := Copy(Result, 2, Length(Result) - 1);
  end;
end;

function TBehavior.GetRoot(): IBehavior;
begin
  Result := FRoot;
end;

end.
