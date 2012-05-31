{**
@Abstract(Behavior list)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Prototype: jade.core.behaviours.BehaviourList
}
unit ABehaviorList;

interface

uses
  ABehavior, ABehaviorCollection, ABehaviorIterator;

type
  IBehaviorIterator = interface
    function GetCurrent(): IBehavior;

    // Begin
    function First(): IBehavior;
    function Next(): IBehavior;

    property Current: IBehavior read GetCurrent;
    //property CurrentIsLast: Boolean read GetCurrentIsLast;
  end;

type
  IBehaviorCollection = interface
    function GetIterator(): IBehaviorIterator;

    // Добавить умение
    procedure Add(Behaviour: IBehavior);
    // Удалить умение
    procedure Remove(Behaviour: IBehavior);

    property Iterator: IBehaviorIterator read GetIterator;
  end;

type
  IBehaviorList = interface(IBehaviorCollection)
    // Protected methods

    function GetBehaviourByIndex(Index: Integer): IBehavior;
    function GetBehaviourCount(): Integer;

    // Public properties

    property BehaviourByIndex[Index: Integer]: IBehavior read GetBehaviourByIndex;
    property BehaviourCount: Integer read GetBehaviourCount;
  end;

type
  TBehaviorList = class(TInterfacedObject, IBehaviorList)
  private
    FBehaviours: array of IBehavior;
  protected
    function GetBehaviourByIndex(Index: Integer): IBehavior;
    function GetBehaviourCount(): Integer;
    function GetIterator(): IBehaviorIterator;
  public
    // Добавить умение
    procedure Add(Behaviour: IBehavior);
    // Удалить умение
    procedure Remove(Behaviour: IBehavior);
  public
    property BehaviourByIndex[Index: Integer]: IBehavior read GetBehaviourByIndex;
    property BehaviourCount: Integer read GetBehaviourCount;
    property Iterator: IBehaviorIterator read GetIterator;
  end;

implementation

{ TBehaviorList }

procedure TBehaviorList.Add(Behaviour: IBehavior);
var
  i: Integer;
begin
  i := Length(FBehaviours);
  SetLength(FBehaviours, i + 1);
  FBehaviours[i] := Behaviour;
end;

function TBehaviorList.GetBehaviourByIndex(Index: Integer): IBehavior;
begin
  if (Index >= 0) and (Index < Length(FBehaviours)) then
    Result := FBehaviours[Index]
  else
    Result := nil;
end;

function TBehaviorList.GetBehaviourCount(): Integer;
begin
  Result := Length(FBehaviours);
end;

function TBehaviorList.GetIterator(): IBehaviorIterator;
begin
  Result := nil;
  // ...
end;

procedure TBehaviorList.Remove(Behaviour: IBehavior);
var
  i: Integer;
  i2: Integer;
begin
  for i := 0 to High(FBehaviours) do
    if (FBehaviours[i] = Behaviour) then
    begin
      FBehaviours[i] := nil;
      for i2 := i to High(FBehaviours) - 1 do
        FBehaviours[i2] := FBehaviours[i2 + 1];
      SetLength(FBehaviours, High(FBehaviours));
    end;
end;

end.
