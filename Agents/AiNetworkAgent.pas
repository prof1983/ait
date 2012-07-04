{**
@Abstract(Агент следящий за работой сети)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.11.2005)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AiNetworkAgent;

// TODO: Создать и подключить модуль Http-сервер
// TODO: Создать и подключить модуль Ftp-сервер
// TODO: Создать и подключить модуль работы с локальной сетью
// TODO: Создать и подключить модуль связи систем AR по TCP/IP

interface

uses
  SysUtils, Windows,
  ATypes,
  AiAgentImpl, AiModuleImpl;

type //** Агент следящий за работой сети
  TAINetworkAgent = class(TAiAgent)
  private
    FHttpModule: TAiModule{TAIHttpModule};
    FFtpModule: TAiModule{TAIFtpModule};
    //FTcpIPConnectionModule
    function GetIsNetwork(): WordBool;
  public
    function Finalize(): TProfError; override;
    function Initialize(): TProfError; override;
  public
    {**
      Подключен ли компьютер к сети
      http://www.sources.ru/delphi/internet/is_computer_attached_to_network.shtml
    }
    property IsNetwork: WordBool read GetIsNetwork;
  end;

const
  stConfigureLoad = 'Загрузка конфигураций объекта AgentNet';
  stCreate = 'Объект AgentNet создан';

implementation

{ TAINetworkAgent }

function TAINetworkAgent.Finalize(): TProfError;
begin
  Result := inherited Finalize();
end;

function TAINetworkAgent.GetIsNetwork(): WordBool;
begin
  Result := (GetSystemMetrics(SM_NETWORK) and $01 = $01);
  {if GetSystemMetrics(SM_NETWORK) and $01 = $01 then
    ShowMessage('Computer is attached to a network!')
  else
    ShowMessage('Computer is not attached to a network!');}
end;

function TAINetworkAgent.Initialize(): TProfError;
begin
  Result := inherited Initialize();

  FHttpModule := TAiModule{TAIHttpModule}.Create();
  FHttpModule.Initialize();
  //FHttpModule.Start();

  FFtpModule := TAiModule{TAIFtpModule}.Create();
  FFtpModule.Initialize();

  //AddToLog(lgGeneral, ltInformation, stInitializeOk);
end;

end.

