{**
@Abstract(Модуль логического вывода на основе онтологии OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(27.04.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiReasonerModule;

interface

uses
  AiModuleImpl;
  //PelletReasoner;
  //JenaReasoner, TransitiveReasoner;

type
  TAiReasonerModule = class(TAiModule)
  private
    //FReasoner: IReasoner;
    //FReasoner: TPelletReasoner;
  protected
    procedure DoCreate(); override; safecall;
  public
  end;

implementation

{ TAiReasonerModule }

procedure TAiReasonerModule.DoCreate();
begin
  inherited DoCreate();
  FName := 'ReasonerModule';
  //FReasoner := TTransitiveReasoner.Create();
  //FReasoner := TPelletReasoner.Create();
end;

end.
