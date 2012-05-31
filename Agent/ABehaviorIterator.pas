{**
@Abstract(Behavior iterator)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.09.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit ABehaviorIterator;

interface

implementation

uses
  ABehavior;

type
  IBehaviorIterator = interface
    function GetCurrent(): IBehavior;

    // Begin
    function First(): IBehavior;
    function Next(): IBehavior;

    property Current: IBehavior read GetCurrent;
    //property CurrentIsLast: Boolean read GetCurrentIsLast;
  end;

end.
