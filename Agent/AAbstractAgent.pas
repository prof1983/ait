{**
@Abstract(Агент)
@Author(Prof1983 prof1983@ya.ru)
@Created(24.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Каждый агент является компонентом системы.
}
unit AAbstractAgent;

// TODO: Перенести все лишнее в другой класс

interface

uses
  AAgentIntf, AAgentContainer, ABehaviorList, AJobCollection, AModuleImpl, APropertyList;

type
  TAbstractAgent = class(TAbstractModule, IAgent)
  protected
      //** Работы
    FJobs: IJobCollection;
      //** Состояния
    FBehaviours: TBehaviorList;
    FContainer: TAgentContainer;
    FProperties: TPropertyList;
  protected
    function GetBehaviours(): IBehaviorList;
  public
      //** Работы
    property Jobs: IJobCollection read FJobs write FJobs;
      //** Поведения, манеры, режимы
    property Behaviours: TBehaviorList read FBehaviours;
    property Container: TAgentContainer read FContainer;
    property Properties: TPropertyList read FProperties;
  end;

implementation

{ TAbstractAgent }

function TAbstractAgent.GetBehaviours: IBehaviorList;
begin
  Result := nil;
  // TODO: !!!
  // ...
end;

end.
