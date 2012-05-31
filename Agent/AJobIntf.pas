{**
@Abstract(Job interface)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AJobIntf;

interface

uses
  AJobTypes;

type
  IJob = interface
    function GetJobType(): TJobType;

    property JobType: TJobType read GetJobType;
  end;

implementation

end.
