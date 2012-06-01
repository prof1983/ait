{**
@Anstract(Базовый типы для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.05.2012)
@LastMod(30.05.2012)
@Version(0.5)

03.05.2012 - From Prof_AI_Base.pas
}
unit AiConnectsMemory;

interface

uses
  ABase, AStreamObj, ATypes,
  AiBase, AiConnectsObj, AiTypes;

type
  TAiConnectsMemory2005 = class(TAiConnectsObject)
  private
    FConnects: array of TAId;
  public
    function AddConnect(Connect: TAId): AInt32; override;
    function Clear: TError; override;
    constructor Create;
    function GetConnect(Index: Integer): TAId; override;
    function GetConnectIndex(Connect: TAId): Int32; override;
    function GetCountConnects(): Integer; override;
    function LoadFromFile(const FileName: WideString): TError; override;
    function SaveToFile(F: TProfFile): TError; {override;}
    function SaveToFileN(FileName: String): TError; {override;}
    function SetConnectA(Index: Integer; Value: TAId): TError; override;
  end;

  TAiConnectsMemory20050911 = class(TAiConnectsObject20050911)
  private
    FConnects: array of TAI_Id;
  public
    function AddConnect(Connect: TAI_Id): Int32; override;
    function Clear: TError; override;
    constructor Create;
    function GetConnect(Index: Integer): TAI_Id; override;
    function GetConnectIndex(Connect: TAI_Id): Int32; override;
    function GetCountConnects(): Integer; override;
    function LoadFromFileN(const FileName: String): TError; override;
    function SaveToFile20050911(F: AStreamObj.TProfFile): TError; override;
    function SaveToFileN(FileName: String): TError; override;
    function SetConnectA(Index: Integer; Value: TAI_Id): TError; override;
  end;

  TAiConnectsMemory20050819 = class(TAiConnectsObject20050819)
  private
    FConnects: array of TAI_Id;
  public
    function AddConnect(Connect: TAI_Id): Int32; override;
    function Clear: TError; override;
    constructor Create;
    function GetConnect(Index: Integer): TAId; override;
    function GetConnectIndex(Connect: TAI_Id): Int32; override;
    function GetCountConnects(): Integer; override;
    function LoadFromFileN(const FileName: String): TError; override;
    function SaveToFile(F: AStreamObj.TProfFile): TError; override;
    function SaveToFileN(FileName: String): TError; override;
    function SetConnectA(Index: Integer; Value: TAId): TError; override;
  end;

  //TAI_ConnectsMemory = TAiConnectsMemory2005;

implementation

{ TAiConnectsMemory2005 }

function TAiConnectsMemory2005.AddConnect(Connect: TAI_Id): Int32;
begin
  Result := -1;
  if GetConnectIndex(Connect) >= 0 then Exit;
  Result := Length(FConnects);
  FConnects[Result] := Connect;
end;

function TAiConnectsMemory2005.Clear: TError;
begin
  SetLength(FConnects, 0);
  Result := 0;
end;

constructor TAiConnectsMemory2005.Create;
begin
  inherited Create;
  SetLength(FConnects, 0);
end;

function TAiConnectsMemory2005.GetConnect(Index: Integer): TAId;
begin
  if Index >= UInt32(Length(FConnects)) then
    Result := 0
  else
    Result := FConnects[Index];
end;

function TAiConnectsMemory2005.GetConnectIndex(Connect: TAI_Id): Int32;
var
  I: Int32;
begin
  Result := -1;
  for I := 0 to High(FConnects) do
    if FConnects[I] = Connect then begin
      Result := I;
      Exit;
    end;
end;

function TAiConnectsMemory2005.GetCountConnects(): Integer;
begin
  Result := Length(FConnects);
end;

function TAiConnectsMemory2005.LoadFromFile(const FileName: WideString): TError;
var
  Count: UInt64;
  F: file;
  I: Int32;
begin
  Result := 1;
  AssignFile(F, FileName);
  {$I-}Reset(F, 1);{$I+}
  if IOResult <> 0 then Exit;
  BlockRead(F, Count, SizeOf(Count));
  SetLength(FConnects, Count);
  for I := 0 to Count - 1 do begin
    BlockRead(F, FConnects[I], SizeOf(TAI_Id));
  end;
  CloseFile(F);
  Result := 0;
end;

function TAiConnectsMemory2005.SaveToFile(F: TProfFile): TError;
{var
  I: Int32;}
begin
  {F := TMyFileWin.Create;
  Result := F.OpenCreate(FileName);
  if Result <> 0 then Exit;
  for I := 0 to High(FConnects) do
    F.WriteUInt64(FConnects[I]);
  F.Free;}
  Result := 1;
end;

function TAiConnectsMemory2005.SaveToFileN(FileName: String): TError;
var
  Count: UInt64;
  F: file;
  I: Int32;
begin
  Result := 1;
  AssignFile(F, FileName);
  {$I-}Rewrite(F, 1);{$I+}
  if IOResult <> 0 then Exit;
  Count := Length(FConnects);
  BlockWrite(F, Count, SizeOf(Count));
  for I := 0 to High(FConnects) do begin
    BlockWrite(F, FConnects[I], SizeOf(TAI_Id));
  end;
  CloseFile(F);
  Result := 0;
end;

function TAiConnectsMemory2005.SetConnectA(Index: Integer; Value: TAId): TError;
begin
  if Index >= UInt32(Length(FConnects)) then
    Result := 1
  else begin
    FConnects[Index] := Value;
    Result := 0;
  end;
end;

{ TAiConnectsMemory20050819 }

function TAiConnectsMemory20050819.AddConnect(Connect: TAI_Id): Int32;
begin
  Result := -1;
  if GetConnectIndex(Connect) >= 0 then Exit;
  Result := Length(FConnects);
  FConnects[Result] := Connect;
end;

function TAiConnectsMemory20050819.Clear: TError;
begin
  SetLength(FConnects, 0);
  Result := 0;
end;

constructor TAiConnectsMemory20050819.Create;
begin
  inherited Create;
  SetLength(FConnects, 0);
end;

function TAiConnectsMemory20050819.GetConnect(Index: Integer): TAId;
begin
  if Index >= UInt32(Length(FConnects)) then
    Result := 0
  else
    Result := FConnects[Index];
end;

function TAiConnectsMemory20050819.GetConnectIndex(Connect: TAI_Id): Int32;
var
  I: Int32;
begin
  Result := -1;
  for I := 0 to High(FConnects) do
    if FConnects[I] = Connect then begin
      Result := I;
      Exit;
    end;
end;

function TAiConnectsMemory20050819.GetCountConnects(): Integer;
begin
  Result := Length(FConnects);
end;

function TAiConnectsMemory20050819.LoadFromFileN(const FileName: String): TError;
var
  Count: UInt64;
  F: file;
  I: Int32;
begin
  Result := 1;
  AssignFile(F, FileName);
  {$I-}Reset(F, 1);{$I+}
  if IOResult <> 0 then Exit;
  BlockRead(F, Count, SizeOf(Count));
  SetLength(FConnects, Count);
  for I := 0 to Count - 1 do begin
    BlockRead(F, FConnects[I], SizeOf(TAI_Id));
  end;
  CloseFile(F);
  Result := 0;
end;

function TAiConnectsMemory20050819.SaveToFile(F: AStreamObj.TProfFile): TError;
var
  I: Int32;
begin
  {F := TMyFileWin.Create;
  Result := F.OpenCreate(FileName);
  if Result <> 0 then Exit;
  for I := 0 to High(FConnects) do
    F.WriteUInt64(FConnects[I]);
  F.Free;}
  Result := 1;
end;

function TAiConnectsMemory20050819.SaveToFileN(FileName: String): TError;
var
  Count: UInt64;
  F: file;
  I: Int32;
begin
  Result := 1;
  AssignFile(F, FileName);
  {$I-}Rewrite(F, 1);{$I+}
  if IOResult <> 0 then Exit;
  Count := Length(FConnects);
  BlockWrite(F, Count, SizeOf(Count));
  for I := 0 to High(FConnects) do begin
    BlockWrite(F, FConnects[I], SizeOf(TAI_Id));
  end;
  CloseFile(F);
  Result := 0;
end;

function TAiConnectsMemory20050819.SetConnectA(Index: Integer; Value: TAId): TError;
begin
  if Index >= UInt32(Length(FConnects)) then
    Result := 1
  else begin
    FConnects[Index] := Value;
    Result := 0;
  end;
end;

{ TAiConnectsMemory20050911 }

function TAiConnectsMemory20050911.AddConnect(Connect: TAI_Id): Int32;
begin
  Result := -1;
  if GetConnectIndex(Connect) >= 0 then Exit;
  Result := Length(FConnects);
  FConnects[Result] := Connect;
end;

function TAiConnectsMemory20050911.Clear: TError;
begin
  SetLength(FConnects, 0);
  Result := 0;
end;

constructor TAiConnectsMemory20050911.Create;
begin
  inherited Create;
  SetLength(FConnects, 0);
end;

function TAiConnectsMemory20050911.GetConnect(Index: Integer): TAI_Id;
begin
  if Index >= UInt32(Length(FConnects)) then
    Result := 0
  else
    Result := FConnects[Index];
end;

function TAiConnectsMemory20050911.GetConnectIndex(Connect: TAI_Id): Int32;
var
  I: Int32;
begin
  Result := -1;
  for I := 0 to High(FConnects) do
    if FConnects[I] = Connect then begin
      Result := I;
      Exit;
    end;
end;

function TAiConnectsMemory20050911.GetCountConnects(): Integer;
begin
  Result := Length(FConnects);
end;

function TAiConnectsMemory20050911.LoadFromFileN(const FileName: String): TError;
var
  Count: UInt64;
  F: file;
  I: Int32;
begin
  Result := 1;
  AssignFile(F, FileName);
  {$I-}Reset(F, 1);{$I+}
  if IOResult <> 0 then Exit;
  BlockRead(F, Count, SizeOf(Count));
  SetLength(FConnects, Count);
  for I := 0 to Count - 1 do begin
    BlockRead(F, FConnects[I], SizeOf(TAI_Id));
  end;
  CloseFile(F);
  Result := 0;
end;

function TAiConnectsMemory20050911.SaveToFile20050911(F: AStreamObj.TProfFile): TError;
{var
  I: Int32;}
begin
  {F := TMyFileWin.Create;
  Result := F.OpenCreate(FileName);
  if Result <> 0 then Exit;
  for I := 0 to High(FConnects) do
    F.WriteUInt64(FConnects[I]);
  F.Free;}
  Result := 1;
end;

function TAiConnectsMemory20050911.SaveToFileN(FileName: String): TError;
var
  Count: UInt64;
  F: file;
  I: Int32;
begin
  Result := 1;
  AssignFile(F, FileName);
  {$I-}Rewrite(F, 1);{$I+}
  if IOResult <> 0 then Exit;
  Count := Length(FConnects);
  BlockWrite(F, Count, SizeOf(Count));
  for I := 0 to High(FConnects) do begin
    BlockWrite(F, FConnects[I], SizeOf(TAI_Id));
  end;
  CloseFile(F);
  Result := 0;
end;

function TAiConnectsMemory20050911.SetConnectA(Index: Integer; Value: TAI_Id): TError;
begin
  if Index >= UInt32(Length(FConnects)) then
    Result := 1
  else begin
    FConnects[Index] := Value;
    Result := 0;
  end;
end;

end.
