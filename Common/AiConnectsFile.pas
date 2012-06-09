{**
@Abstract(AiConnectionsFile)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.05.2012)
@LastMod(09.06.2012)
@Version(0.5)

02.05.2012 - From Prof_AI_Base.pas
}
unit AiConnectsFile;

interface

uses
  AStreamObj, ATypes,
  AiBase, AiConnectsObj;

type
  TAiConnectsFile2005 = class(TAiConnectsObject)
  private
    FFile: TProfFile;
  public
    function AddConnect(Connect: TAId): Integer; override;
    function Clear(): TError; override;
    function DeleteConnect(Con: TAId): TError; override;
    function DeleteConnectByIndex(Index: Integer): TError; override;
    function GetConnect(Index: Integer): TAId; override;
    function GetConnectIndex(Con: TAId): Int32; override;
    function GetCountConnects(): Integer; override;
    function SetConnectA(Index: Integer; Con: TAId): TError; override;
  end;

  TAiConnectsFile20050911 = class(TAiConnectsFile2005)
  private
    FFile: AStreamObj.TProfFile;
  public
    function AddConnect(Con: TAId): Int32; override;
    function Clear: TError; override;
    function DeleteConnect(Con: TAId): TError; override;
    function DeleteConnectByIndex(Index: Integer): TError; override;
    function GetConnect(Index: Integer): TAId; override;
    function GetConnectIndex(Con: TAId): Int32; override;
    function GetCountConnects(): Integer; override;
    function SetConnectA(Index: Integer; Con: TAId): TError; override;
  end;

  TAiConnectsFile20050819 = class(TAiConnectsFile20050911)
  public
    function AddConnect(Con: TAId): Int32; override;
    function Clear: TError; override;
    function DeleteConnect(Con: TAId): TError; override;
    function DeleteConnectByIndex(Index: Integer): TError; override;
    function GetConnect(Index: Integer): TAId; override;
    function GetConnectIndex(Con: TAId): Int32; override;
    function GetCountConnects(): Integer; override;
    function SetConnectA(Index: Integer; Con: TAId): TError; override;
  end;

  //TAI_ConnectsFile = TAiConnectsFile2005;

implementation

{ TAiConnectsFile2005 }

function TAiConnectsFile2005.AddConnect(Connect: TAIId): Integer;
{var
  F: TFileConnect;
  Rec: TAIFreimRecF64;}
begin
  Result := -1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectAdd(Id, Con);}
  if FreimCount <= Id then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek(Rec.ConnectCount * SizeOf(TAIFreimId64));
  C := Con;
  Result := F.Write(C, SizeOf(C));}
  Result := Rec.ConnectCount;
  F.CWrite(Result, Con);
  F.Free;
  Inc(Rec.ConnectCount);
  FF.FreimWrite(Id, Rec);*)
end;

function TAiConnectsFile2005.Clear: TError;
begin
  Result := 1;
end;

function TAiConnectsFile2005.DeleteConnect(Con: TAId): TError;
{var
  F: TFileConnect;
  I: Int32;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := 1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectDelete(Id, Con);}
  if (Id >= FreimCount) or (Con >= FreimCount) or (Con = 0) then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Rec.ConnectCount = 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  for I := 0 to Rec.ConnectCount - 1 do begin
    F.GetStream.Read(H, SizeOf(H));
    if H = Con then begin
      {Перемещение последней связи на это место}
      {F.Seek((Rec.ConnectCount - 1) * SizeOf(TAIFreimId64));
      F.Read(H, SizeOf(H));
      F.Seek(I * SizeOf(TAIFreimId64));
      F.Write(H, SizeOf(H));}
      H := F.CRead(Rec.ConnectCount - 1);
      F.CWrite(I, H);
      Dec(Rec.ConnectCount);
      FF.FreimWrite(Id, Rec);
      Result := 0;
      F.Free;
      Exit;
    end;
  end;
  F.Free;*)
end;

function TAiConnectsFile2005.DeleteConnectByIndex(Index: Integer): TError;
{var
  F: TFileConnect;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := 1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectDeleteI(Id, Index);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Index >= Rec.ConnectCount then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek((Rec.ConnectCount - 1) * SizeOf(TAIFreimId64));
  F.Read(H, SizeOf(H));
  F.Seek(Index * SizeOf(TAIFreimId64));
  F.Write(H, SizeOf(H));}
  H := F.CRead(Rec.ConnectCount - 1);
  F.CWrite(Index, H);
  Dec(Rec.ConnectCount);
  FF.FreimWrite(Id, Rec);
  F.Free;*)
end;

function TAiConnectsFile2005.GetConnect(Index: Integer): TAId;
{var
  F: TFileConnect;
  Rec: TAIFreimRecF64;}
begin
  Result := 0;
  (*if not(Assigned(FF)) then Exit;
  {Result := ConnectGet(Id, Index);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Index >= Rec.ConnectCount then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek(Index * SizeOf(TAIFreimId64));
  F.Read(H, SizeOf(H));
  Result := H;}
  Result := F.CRead(Index);
  F.Free;*)
end;

function TAiConnectsFile2005.GetConnectIndex(Con: TAId): Int32;
{var
  F: TFileConnect;
  I: Int32;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := -1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectIndexGet(Id, Con);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Rec.ConnectCount = 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  for I := 0 to Rec.ConnectCount - 1 do begin
    F.GetStream.Read(H, SizeOf(H));
    if H = Con then begin
      Result := I;
      F.Free;
      Exit;
    end;
  end;
  F.Free;*)
end;

function TAiConnectsFile2005.GetCountConnects(): Integer;
begin
  Result := 0;
  {...}
end;

function TAiConnectsFile2005.SetConnectA(Index: Integer; Con: TAId): TError;
begin
  Result := 1;
  {...}
end;

{ TAiConnectsFile20050911 }

function TAiConnectsFile20050911.AddConnect(Con: TAId): Int32;
{var
  F: TFileConnect;
  Rec: TAIFreimRecF64;}
begin
  Result := -1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectAdd(Id, Con);}
  if FreimCount <= Id then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek(Rec.ConnectCount * SizeOf(TAIFreimId64));
  C := Con;
  Result := F.Write(C, SizeOf(C));}
  Result := Rec.ConnectCount;
  F.CWrite(Result, Con);
  F.Free;
  Inc(Rec.ConnectCount);
  FF.FreimWrite(Id, Rec);*)
end;

function TAiConnectsFile20050911.Clear: TError;
begin
  Result := 1;
end;

function TAiConnectsFile20050911.DeleteConnect(Con: TAId): TError;
{var
  F: TFileConnect;
  I: Int32;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := 1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectDelete(Id, Con);}
  if (Id >= FreimCount) or (Con >= FreimCount) or (Con = 0) then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Rec.ConnectCount = 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  for I := 0 to Rec.ConnectCount - 1 do begin
    F.GetStream.Read(H, SizeOf(H));
    if H = Con then begin
      {Перемещение последней связи на это место}
      {F.Seek((Rec.ConnectCount - 1) * SizeOf(TAIFreimId64));
      F.Read(H, SizeOf(H));
      F.Seek(I * SizeOf(TAIFreimId64));
      F.Write(H, SizeOf(H));}
      H := F.CRead(Rec.ConnectCount - 1);
      F.CWrite(I, H);
      Dec(Rec.ConnectCount);
      FF.FreimWrite(Id, Rec);
      Result := 0;
      F.Free;
      Exit;
    end;
  end;
  F.Free;*)
end;

function TAiConnectsFile20050911.DeleteConnectByIndex(Index: Integer): TError;
{var
  F: TFileConnect;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := 1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectDeleteI(Id, Index);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Index >= Rec.ConnectCount then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek((Rec.ConnectCount - 1) * SizeOf(TAIFreimId64));
  F.Read(H, SizeOf(H));
  F.Seek(Index * SizeOf(TAIFreimId64));
  F.Write(H, SizeOf(H));}
  H := F.CRead(Rec.ConnectCount - 1);
  F.CWrite(Index, H);
  Dec(Rec.ConnectCount);
  FF.FreimWrite(Id, Rec);
  F.Free;*)
end;

function TAiConnectsFile20050911.GetConnect(Index: Integer): TAId;
{var
  F: TFileConnect;
  Rec: TAIFreimRecF64;}
begin
  Result := 0;
  (*if not(Assigned(FF)) then Exit;
  {Result := ConnectGet(Id, Index);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Index >= Rec.ConnectCount then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek(Index * SizeOf(TAIFreimId64));
  F.Read(H, SizeOf(H));
  Result := H;}
  Result := F.CRead(Index);
  F.Free;*)
end;

function TAiConnectsFile20050911.GetConnectIndex(Con: TAId): Int32;
{var
  F: TFileConnect;
  I: Int32;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := -1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectIndexGet(Id, Con);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Rec.ConnectCount = 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  for I := 0 to Rec.ConnectCount - 1 do begin
    F.GetStream.Read(H, SizeOf(H));
    if H = Con then begin
      Result := I;
      F.Free;
      Exit;
    end;
  end;
  F.Free;*)
end;

function TAiConnectsFile20050911.GetCountConnects(): Integer;
begin
  Result := 0;
  {...}
end;

function TAiConnectsFile20050911.SetConnectA(Index: Integer; Con: TAId): TError;
begin
  Result := 1;
  {...}
end;

{ TAiConnectsFile20050819 }

function TAiConnectsFile20050819.AddConnect(Con: TAId): Int32;
{var
  F: TFileConnect;
  Rec: TAIFreimRecF64;}
begin
  Result := -1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectAdd(Id, Con);}
  if FreimCount <= Id then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek(Rec.ConnectCount * SizeOf(TAIFreimId64));
  C := Con;
  Result := F.Write(C, SizeOf(C));}
  Result := Rec.ConnectCount;
  F.CWrite(Result, Con);
  F.Free;
  Inc(Rec.ConnectCount);
  FF.FreimWrite(Id, Rec);*)
end;

function TAiConnectsFile20050819.Clear: TError;
begin
  Result := 1;
end;

function TAiConnectsFile20050819.DeleteConnect(Con: TAId): TError;
{var
  F: TFileConnect;
  I: Int32;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := 1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectDelete(Id, Con);}
  if (Id >= FreimCount) or (Con >= FreimCount) or (Con = 0) then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Rec.ConnectCount = 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  for I := 0 to Rec.ConnectCount - 1 do begin
    F.GetStream.Read(H, SizeOf(H));
    if H = Con then begin
      {Перемещение последней связи на это место}
      {F.Seek((Rec.ConnectCount - 1) * SizeOf(TAIFreimId64));
      F.Read(H, SizeOf(H));
      F.Seek(I * SizeOf(TAIFreimId64));
      F.Write(H, SizeOf(H));}
      H := F.CRead(Rec.ConnectCount - 1);
      F.CWrite(I, H);
      Dec(Rec.ConnectCount);
      FF.FreimWrite(Id, Rec);
      Result := 0;
      F.Free;
      Exit;
    end;
  end;
  F.Free;*)
end;

function TAiConnectsFile20050819.DeleteConnectByIndex(Index: Integer): TError;
{var
  F: TFileConnect;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := 1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectDeleteI(Id, Index);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Index >= Rec.ConnectCount then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek((Rec.ConnectCount - 1) * SizeOf(TAIFreimId64));
  F.Read(H, SizeOf(H));
  F.Seek(Index * SizeOf(TAIFreimId64));
  F.Write(H, SizeOf(H));}
  H := F.CRead(Rec.ConnectCount - 1);
  F.CWrite(Index, H);
  Dec(Rec.ConnectCount);
  FF.FreimWrite(Id, Rec);
  F.Free;*)
end;

function TAiConnectsFile20050819.GetConnect(Index: Integer): TAId;
{var
  F: TFileConnect;
  Rec: TAIFreimRecF64;}
begin
  Result := 0;
  (*if not(Assigned(FF)) then Exit;
  {Result := ConnectGet(Id, Index);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Index >= Rec.ConnectCount then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  {F.Seek(Index * SizeOf(TAIFreimId64));
  F.Read(H, SizeOf(H));
  Result := H;}
  Result := F.CRead(Index);
  F.Free;*)
end;

function TAiConnectsFile20050819.GetConnectIndex(Con: TAId): Int32;
{var
  F: TFileConnect;
  I: Int32;
  H: TAI_Id64;
  Rec: TAIFreimRecF64;}
begin
  Result := -1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.ConnectIndexGet(Id, Con);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  if Rec.ConnectCount = 0 then Exit;
  F := TFileConnect.Create;
  if F.Open(FPath, Id) <> 0 then begin F.Free; Exit; end;
  for I := 0 to Rec.ConnectCount - 1 do begin
    F.GetStream.Read(H, SizeOf(H));
    if H = Con then begin
      Result := I;
      F.Free;
      Exit;
    end;
  end;
  F.Free;*)
end;

function TAiConnectsFile20050819.GetCountConnects(): Integer;
begin
  Result := 0;
  {...}
end;

function TAiConnectsFile20050819.SetConnectA(Index: Integer; Con: TAId): TError;
begin
  Result := 1;
  {...}
end;

end.