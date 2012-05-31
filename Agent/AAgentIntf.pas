{**
@Abstract(Agent interface)
@Author(Prof1983 prof1983@ya.ru)
@Created(24.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Каждый агент является компонентом системы.
}
unit AAgentIntf;

interface

uses
  ABehaviorList, AModuleIntf;

type
  IAgent = interface(IProfModule)
    function GetBehaviours(): IBehaviorList;

    //procedure Run(); //Activate
    //Delete
    //Suspend
    //procedure Wait();
    //Wait(ms)

    //procedure Start();
    //procedure Stop();

    // Public property

    property Behaviours: IBehaviorList read GetBehaviours;
  end;

implementation

end.