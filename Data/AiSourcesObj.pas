{**
@Abstract(Источники)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(08.06.2012)
@Version(0.5)

0.0.0.2 - 07.01.2006 - Coments
0.0.0.1 - 22.09.2005
}
unit AiSourcesObj;

interface

uses
  ABase, ATypes,
  AiBase, AiSourceObj;

type
  {** Источники }
  TAiSources2006 = class(TAiSourceObject2005)
  private
    FSources: array of TAiRecSource;
  public
    function AddSource(Value: TAiSourceObject): Int32;
    function Clear(): TError; override;
    function DeleteSource(Index: Int32): AError;
    procedure Free; virtual;
    function FreeSource(Index: Int32): AError;
    function GetCountFreims: UInt64; override;
    function GetCountSources: UInt32;
    function GetSource(Index: UInt32): TAiSourceObject;
  end;

  //TAiSources = TAiSources2006;

  TAiSources20050915 = class(TAiSources2006)
  private
    FSources: array of TAiRecSource;
  public
    function AddSource(Value: AiSourceObject2005): AInt32;
    function Clear(): TError; override;
    function DeleteSource(Index: Int32): TError;
    procedure Free(); override;
    function FreeSource(Index: Int32): TError;
    function GetCountFreims(): UInt64; override;
    function GetCountSources(): UInt32;
    function GetSource(Index: UInt32): TAiSourceObject2005;
  end;

implementation

{ TAiSources20050915 }

function TAiSources20050915.AddSource(Value: AiSourceObject2005): Int32;
begin
  Result := -1;
  if (Value = 0) then Exit;
  Result := Length(FSources);
  SetLength(FSources, Result + 1);
  FSources[Result].Id := Value{.GetId};
  FSources[Result].Source := Value;
end;

function TAiSources20050915.Clear: TError;
var
  I: Int32;
begin
  for I := 0 to High(FSources) do
    if Assigned(TObject(FSources[I].Source)) then
      (TObject(FSources[I].Source) as TAiSourceObject2005).Free();
  SetLength(FSources, 0);
  Result := inherited Clear;
end;

function TAiSources20050915.DeleteSource(Index: Int32): TError;
var
  I: Int32;
begin
  Result := 1;
  if (Index < 0) or (Index >= Length(FSources)) then Exit;
  if Assigned(TObject(FSources[Index].Source)) then
    (TObject(FSources[Index].Source) as TAiSourceObject2005).Free();
  for I := Index to High(FSources) - 1 do FSources[I] := FSources[I + 1];
  SetLength(FSources, High(FSources));
  Result := 0;
end;

procedure TAiSources20050915.Free;
begin
  Clear;
  inherited Free;
end;

function TAiSources20050915.FreeSource(Index: Int32): TError;
begin
  Result := 1;
  if (Index < 0) or (Index >= Length(FSources)) then Exit;
  if Assigned(TObject(FSources[Index].Source)) then
  begin
    (TObject(FSources[Index].Source) as TAiSourceObject2005).Free();
    FSources[Index].Source := 0;
  end;
  Result := 0;
end;

function TAiSources20050915.GetCountFreims: UInt64;
var
  I: Int32;
begin
  Result := 0;
  for I := 0 to High(FSources) do
  begin
    if Assigned(TObject(FSources[I].Source)) then
      Result := Result + (TObject(FSources[I].Source) as TAiSourceObject2005).GetCountFreims();
  end;
end;

function TAiSources20050915.GetCountSources: UInt32;
begin
  Result := Length(FSources);
end;

function TAiSources20050915.GetSource(Index: UInt32): TAiSourceObject2005;
begin
  if (Index >= UInt32(Length(FSources))) then
    Result := nil
  else
    Result := TObject(FSources[Index].Source) as TAiSourceObject2005;
end;

{ TAiSources2006 }

function TAiSources2006.AddSource(Value: TAiSourceObject): Int32;
begin
  Result := -1;
  if not(Assigned(Value)) then Exit;
  Result := Length(FSources);
  SetLength(FSources, Result + 1);
  FSources[Result].Id := Value.GetId;
  FSources[Result].Source := Value.GetId;
end;

function TAiSources2006.Clear(): TError;
var
  I: Int32;
begin
  for I := 0 to High(FSources) do
  begin
    if Assigned(TObject(FSources[I].Source)) then
      (TObject(FSources[I].Source) as TAiSourceObject).Free();
  end;
  SetLength(FSources, 0);
  Result := inherited Clear;
end;

function TAiSources2006.DeleteSource(Index: Int32): AError;
var
  I: Int32;
begin
  Result := -1;
  if (Index < 0) or (Index >= Length(FSources)) then Exit;
  if Assigned(TObject(FSources[Index].Source)) then
    (TObject(FSources[Index].Source) as TAiSourceObject).Free();
  for I := Index to High(FSources) - 1 do
    FSources[I] := FSources[I + 1];
  SetLength(FSources, High(FSources));
  Result := 0;
end;

procedure TAiSources2006.Free;
begin
  Clear;
  inherited Free;
end;

function TAiSources2006.FreeSource(Index: Int32): AError;
begin
  Result := -1;
  if (Index < 0) or (Index >= Length(FSources)) then Exit;
  if Assigned(TObject(FSources[Index].Source)) then
  begin
    (TObject(FSources[Index].Source) as TAiSourceObject).Free();
    FSources[Index].Source := 0;
  end;
  Result := 0;
end;

function TAiSources2006.GetCountFreims: UInt64;
var
  I: Int32;
begin
  Result := 0;
  for I := 0 to High(FSources) do
  begin
    if Assigned(TObject(FSources[I].Source)) then
      Result := Result + (TObject(FSources[I].Source) as TAiSourceObject).GetCountFreims;
  end;
end;

function TAiSources2006.GetCountSources: UInt32;
begin
  Result := Length(FSources);
end;

function TAiSources2006.GetSource(Index: UInt32): TAISource;
begin
  if (Index >= UInt32(Length(FSources))) then
    Result := nil
  else
    Result := TObject(FSources[Index].Source) as TAiSourceObject;
end;

end.
