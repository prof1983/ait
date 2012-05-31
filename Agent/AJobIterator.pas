{**
@Abstract(Job iterator)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AJobIterator;

interface

uses
  AJobIntf;

type
  IJobIterator = interface
    function Next(): IJob;
  end;

implementation

end.
