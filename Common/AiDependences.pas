{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(24.05.2012)
@LastMod(30.05.2012)
@Version(0.5)
}
unit AiDependences;

interface

uses
  AiFrameObj;

type
  // Зависимости, связанные между собой. Рассматривается как единая зависимость.
  TAiDependences2006 = class(TAiFreim)
  private
    FItems: array of TAiFreim{TAiDependence};
  public
    procedure Free(); override;
    function GetItem(Index: Integer): TAiFreim;
    //function New(Decision: TAiDecision; Format: TAiDependenceFormat): TAiDependence;
  end;

implementation

{ TAiDependences2006 }

procedure TAiDependences2006.Free();
var
  I: Integer;
begin
  for I := 0 to High(FItems) do
    FItems[I].Free();
  inherited Free();
end;

function TAiDependences2006.GetItem(Index: Integer): TAiFreim;
begin
  if (Index >= Length(FItems)) then
  begin
    Result := nil;
    Exit;
  end;
  Result := FItems[Index];
end;

(*function TAiDependences2006.New(Decision: TAiDecision; Format: TAiDependenceFormat): TAiDependence;
var
  I: Int32;
begin
  I := Length(FItems);
  SetLength(FItems, I + 1);
  //FItems[I] := TAIDependence.Create(nil, nil);
 { FItems[I].Decision := Decision;
  FItems[I].Format := Format;}
  Result := FItems[I];
end;*)

end.
