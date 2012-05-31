{**
@Abstract(Agent container)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Prototype: jade.core.Container
}
unit AAgentContainer;

interface

type
  TAgentContainer = class
  private
    //FContainerID: TAgentContainerID;
    //FPlatformID: TPlatformID;
  public
//    property ContainerID: TAgentContainerID read FContainerID;
    //property MainContainer: TAssistantAgentContainer read FMainContainer; // ?
//    property PlatformID: TPlatformID read FPlatformID;
    //ServiceManager
    //ServiceFinder
    //AID getAMS(); // ?
    //AID getDefaultDF(); // ?
  public
    // Инициализировать агента
    //void initAgent(AID agentID, Agent instance, JADEPrincipal ownerPrincipal, Credentials initialCredentials)
    // Старт выполнения локального агента
    //void powerUpLocalAgent(AID agentID) throws NotFoundException;
    // Добавить локального агента в контейнер
    //Agent addLocalAgent(AID id, Agent a);
    // Удалить локального агента в контейнер
    //void removeLocalAgent(AID id);
    // Поместить локального агента в контейнер
    //Agent acquireLocalAgent(AID id);
    // Освободить локального агента
    //void release LocalAgent(AID id);
    // Добавить адрес к локальному агенту
    //void addAddressToLocalAgents(String address);
    // Удалить адрес из локального агента
    //void removeAddressFromLocalAgents(String address);
    // Послать сообщение локальному агенту
    //boolean postMessageToLocalAgent(ACLMessage msg, AID receiverID);
    // Поместить агента в этот контейнер
    //boolean livesHere(AID id);
    // Завершить работу
    //void shutDown();
    // Сделать этот контейнер лидером
    //void becomeLeader();
  end;

implementation

end.