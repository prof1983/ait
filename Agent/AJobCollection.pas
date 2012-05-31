{**
@Abstract(Job collection)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AJobCollection;

interface

uses
  AJobIterator;

type
  IJobCollection = interface
    function GetIterator(): IJobIterator;

    property Iterator: IJobIterator read GetIterator;
  end;

implementation

end.
