{**
@Abstract(Ai knowledge base object)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.06.2012)
@LastMod(04.06.2012)
@Version(0.0.5)

From Prof_AI_Base_Class_20050526
}
unit AiKbObj;

interface

uses
  Classes,
  ABase, ABase2, ABaseUtils3,
  AiBase, AiFrameObj, AiIoFileKb, AiSourceObj, AiTypes;

type
  TAiKb = class(TAiSourceObject2005)
  private
    {FBases: array of TKB;}
    FParents: array of TAIKB;
    FParentsId: array of TAId;
    {FSearch: TKBSearch;}
    {FSelect: TKBSelect;}
  public
    function Close(): AError; override;
    function GetParent(Index: AUInt32): TAIKB;
    function GetParentId(Index: AUInt32): TAId;
    function LoadFromFileN(FileName, Path: String): AError;
    function SaveToFileN(FileName, Path: String): AError; virtual;
    procedure SetParent(Index: UInt32; Value: TAIKB);
    procedure SetParentId(Index: AUInt32; Value: TAId);
  public
    constructor Create(Source: AiSourceObject; Id: TAId = 0);
    procedure Free(); {override;}
  end;

  TAiKbFile = class(TAIKB)
  private
    FF: TFileProfKB;
    FPath: String;              {Путь для расположения дополнительных файлов}
  public
    function Close(): AError; override;
    function ConnectAdd(Id, Con: TAId): AInt32; override;
    function ConnectDelete(Id, Con: TAId): AError; override;
    function ConnectDeleteI(Id: TAId; Index: AUInt32): AError; override;
    function ConnectGet(Id: TAId; Index: AUInt32): TAId; override;
    function ConnectIndexGet(Id, Con: TAId): Int32; override;
    function DataClear(Id: TAId): AError; override;
    function DataSize(Id: TAId): AUInt64; override;
    function FreimDTCreateGet(Id: TAId): TDateTime;
    function FreimCount: UInt64;
    function FreimDataGet(Id: TAId): TStream;
    function FreimFree(Id: TAId): Boolean; override;
    function FreimNew(Typ: TAId): TAId;
    function FreimRecGet(Id: TAId; var R: TAiFreimRec): AError;
    function FreimTypeGet(Id: TAId): TAId;
    function FreimTypeSet(Id, Typ: TAId): AError;
  public
    function GetFile(): TFileProfKB;
    function GetPath(): String;
    function Open(FileName, Path: String): AError;
    function OpenCreate(FileName, Path: String): AError;
  end;

  TAiKbFileCashe = TAiKbFile;

  TAiKbMemory = class(TAiKb)
  private
    FItems: array of TAiFrameObject;
    FItemsRec: array of TAIFreimRec;
  public
    constructor Create(Source: AiSourceObject; Id: TAId = 0);
    procedure Free(); {override;}
    function GetFreim(Id: TAId): TAiFrameObject; override;
    function GetItem(Index: AUInt32): TAiFrameObject;
    function GetCountFreims(): UInt64; override;
    function GetCountItems(): AUInt32;
    function Initialize(): AError; override;
    function NewFreim(Freim: TAiFrameObject): TAId; {override;}
    function LoadFromFileN(FileName, Path: String): AError;
  end;

  TAiKbMemory2 = class(TAiKb)
  private
    FArbitrary: Boolean;        {Произвольный порядок.}
    FBase: array[0..1023] of TAiFrameObject;
    FLocal: array[0..1023] of TAiFrameObject; {1024..2047}
    FItems: array of TAiFrameObject; {Все остальные. Не упорядоченные.}
    {FOrder: TKBMemoryOrder;}   {Порядок. Очередность.}
  public
    function GetFreim(Id: TAId): TAiFrameObject; override;
    function SetFreim(Id: TAId; Freim: TAiFrameObject): AError; override;
    function Initialize(): AError; override;
    function GetFreimCashe(Id: TAId): TAiFrameObject;
    function NewFreim(Freim: TAiFrameObject): TAId; {override;}
  public
    constructor Create(Source: AiSourceObject; Id: TAId = 0);
    procedure Free(); {override;}
    function GetCountFreims(): UInt64; override;
    function GetFreeIndexCashe(): AUInt32;
    function GetItem(Index: AUInt32): TAiFrameObject;
    function SaveToFile(FileName, Path: String): AError;
    procedure SetArbitrary(Value: Boolean);
    function Open(): AError;
  end;

  {Источник БЗ через сеть}
  //TAiKbNet = TAiKb;
  //TAiKbNetCasheFile = TAiKbNet;
  //TAiKbNetCasheFileMemory = TAiKbNet;
  //TAiKbNetCasheMemory = TAiKbNet;

implementation

{ TAiKb }

function TAiKb.Close(): AError;
begin
  Result := inherited Close();
  SetLength(FParents, 0);
  SetLength(FParentsId, 0);
end;

constructor TAiKb.Create(Source: AiSourceObject; Id: TAId = 0);
begin
  inherited Create(Source, Id);
  {FParent := Parent;
  if not(Assigned(FParent)) then
    FParentId := ParentId
  else
    FParentId := FParent.FreimId;}
  {FSearch := TKBSearch.Create;
  FSelect := TKBSelect.Create(Source, 0);}
end;

procedure TAiKb.Free;
begin
  {FSearch.Free;
  FSelect.Free;}
  inherited Free;
end;

function TAiKb.GetParent(Index: UInt32): TAIKB;
begin
  if Index >= UInt32(Length(FParents)) then
    Result := nil
  else
  begin
    {if not(Assigned(FParents[Index])) then
    begin
      FParents[Index] := TAIKB((TObject(GetSource) as TAiSource2005).GetFreim(FParentsId[Index]));
    end;}
    Result := FParents[Index];
  end;
end;

function TAiKb.GetParentId(Index: AUInt32): TAId;
begin
  if Index >= UInt32(Length(FParentsId)) then
    Result := 0
  else
    Result := FParentsId[Index];
end;

function TAiKb.LoadFromFileN(FileName, Path: String): AError;
var
  F: TFileProfKB;
begin
  F := TFileProfKB.Create;
  if not(F.Open(FileName, Path)) then
  begin
    Result := -1;
    Exit;
  end;
  Result := 0;
  {Result := inherited LoadFromFileN(F, Path);}
  {Count := F.GetHeaderKB.CountF;
  for I := 0 to Count - 1 do}
  Result := 1;
end;

function TAiKb.SaveToFileN(FileName, Path: String): AError;
var
  Count: UInt64;
  F: TFileProfKB;
  Freim: TAiFrameObject;
  Id: Int32;
  Rec: TAIFreimRec;
begin
  F := TFileProfKB.Create;
  F.OpenCreate(FileName, Path);

  Count := GetCountFreims;
  for Id := 0 to Count - 1 do
  begin
    Freim := GetFreim(Id);
    Rec.Id := Id;
    if Assigned(Freim) then
    begin
      Rec.Typ := Freim.GetType;
      Rec.DTCreate := Freim.GetDateTimeCreate;
      Rec.DataSize := Freim.GetData.GetSize;
      Rec.ConnectCount := Freim.GetConnects.GetCountConnects;
      if Rec.DataSize > 0 then
        Freim.GetData.SaveToFileN(Path + 'd' + cUInt64ToStr(Id) + '.prof');
      if Rec.ConnectCount > 0 then
        Freim.GetConnects.SaveToFile(Path + 'c' + cUInt64ToStr(Id) + '.prof');
    end else begin
      Rec.Typ := 0;
      Rec.DTCreate := 0;
      Rec.DataSize := 0;
      Rec.ConnectCount := 0;
    end;
    F.FreimWrite(Id, Rec);
  end;

  F.Free;
  Result := 0;
end;

procedure TAiKb.SetParent(Index: UInt32; Value: TAIKB);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParents[Index] := Value;
  if Assigned(Value) then
    FParentsId[Index] := Value.GetId
  else
    FParentsId[Index] := 0;
end;

procedure TAiKb.SetParentId(Index: AUInt32; Value: TAId);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParentsId[Index] := Value;
  FParents[Index] := nil;
end;

{ TAiKbFile }

function TAiKbFile.Close(): AError;
begin
  if Assigned(FF) then FF.Free;
  FF := nil;
  Result := inherited Close;
end;

function TAiKbFile.ConnectAdd(Id, Con: TAId): AInt32;
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

function TAiKbFile.ConnectDelete(Id, Con: TAId): AError;
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

function TAiKbFile.ConnectDeleteI(Id: TAId; Index: AUInt32): AError;
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

function TAiKbFile.ConnectGet(Id: TAId; Index: AUInt32): TAId;
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

function TAiKbFile.ConnectIndexGet(Id, Con: TAId): AInt32;
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

function TAiKbFile.DataClear(Id: TAId): AError;
{var
  F: TFileData;
  Rec: TAIFreimRecF64;}
begin
  Result := 1;
  (*if not(Assigned(FF)) then Exit;
  {Result := FF.DataClear(Id);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  Rec.DataSize := 0;
  Result := FF.FreimWrite(Id, Rec);
  F := TFileData.Create;
  F.Delete(FPath, Id);
  F.Free;*)
end;

(*function TKBFile.DataRead(Id: TAIFreimId; var Buf; Size: UInt64; Seek: UInt64 {= High(UIntPtr)}): UInt64;
var
  F: TFileData;
  Rec: TAIFreimRecF64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.DataRead(Id, Buf, Size, Seek);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  F := TFileData.Create;
  F.Open(FPath, Id);
  F.Seek(Seek);
  Result := F.Read(Buf, Size);
  F.Free;
end;*)

function TAiKbFile.DataSize(Id: TAId): AUInt64;
var
  Rec: TAIFreimRec;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.DataSize(Id);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  Result := Rec.DataSize;
end;

(*function TKBFile.DataWrite(Id: TAIFreimId; const Buf; Size: UInt64; Seek: UInt64 {= High(UIntPtr)}): UInt64;
var
  F: TFileData;
  Rec: TAIFreimRecF64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.DataWrite(Id, Buf, Size, Seek);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  F := TFileData.Create;
  F.Open(FPath, Id);
  F.Seek(Seek);
  Result := F.Write(Buf, Size);
  F.Free;
end;*)

function TAiKbFile.FreimCount: UInt64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.GetHeaderKB.CountF;
end;

function TAiKbFile.FreimDataGet(Id: TAId): TStream;
begin
  {Result := inherited FreimDataGet(Id);
  Result := nil;
  {if Id >= FreimCount then Exit;}
  Result := nil;
end;

function TAiKbFile.FreimDTCreateGet(Id: TAId): TDateTime;
var
  Rec: TAIFreimRec;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.DTCreate(Id);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  Result := Rec.DTCreate;
end;

function TAiKbFile.FreimFree(Id: TAId): Boolean;
begin
  Result := False;
end;

function TAiKbFile.FreimNew(Typ: TAId): TAId;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.FreimNew(Typ);
end;

function TAiKbFile.FreimRecGet(Id: TAId; var R: TAiFreimRec): AError;
begin
  {if inherited FreimRecGet(Id, R) = 0 then Exit;
  if not(Assigned(FF)) then Exit;
  if FF.Read(RecF, SizeOf(RecF)) = SizeOf(RecF) then Result := 0;
  FreimRecFToFreimRec(RecF, R);}

  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.FreimRead(Id, R);
  {FreimRecF64ToFreimRec(RecF, R);}
end;

function TAiKbFile.FreimTypeGet(Id: TAId): TAId;
var
  Rec: TAIFreimRec;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.TypeGet(Id);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  Result := Rec.Typ;
end;

function TAiKbFile.FreimTypeSet(Id, Typ: TAId): AError;
var
  Rec: TAIFreimRec;
begin
  Result := 1;
  if not(Assigned(FF)) then Exit;
  {Result := FF.TypeSet(Id, Typ);}
  if Id >= FreimCount then Exit;
  if FF.FreimRead(Id, Rec) <> 0 then Exit;
  Rec.Typ := Typ;
  if FF.FreimWrite(Id, Rec) then
    Result := 0
  else
    Result := -1;
end;

function TAiKbFile.GetFile: TFileProfKB;
begin
  Result := FF;
end;

function TAiKbFile.GetPath: String;
begin
  Result := FPath;
end;

function TAiKbFile.Open(FileName, Path: String): AError;
begin
  Close;
  FF := TFileProfKB.Create;
  if FF.Open(FileName) then
    Result := 0
  else
    Result := -1;
  FPath := Path;
  {inherited Open;}
end;

function TAiKbFile.OpenCreate(FileName, Path: String): AError;
begin
  Close;
  Result := SaveToFileN(FileName, Path);
  if Result <> 0 then Exit;
  Result := Open(FileName, Path);
end;

{ TAiKbMemory }

constructor TAiKbMemory.Create(Source: AiSourceObject; Id: TAId = 0);
var
  I: Int32;
begin
  inherited Create(Source, Id);
  SetLength(FItems, 1024);
  for I := 0 to High(FItems) do FItems[I] := nil;
end;

procedure TAiKbMemory.Free;
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
    if Assigned(FItems[I]) then
      FItems[I].Free;
  SetLength(FItems, 0);
  inherited Free;
end;

function TAiKbMemory.GetCountFreims: UInt64;
begin
  Result := Length(FItems);
end;

function TAiKbMemory.GetCountItems: UInt32;
begin
  Result := Length(FItems);
end;

function TAiKbMemory.GetFreim(Id: TAId): TAiFrameObject;
begin
  if Id >= Length(FItems) then
    Result := nil
  else
    Result := FItems[Id];
end;

function TAiKbMemory.GetItem(Index: UInt32): TAiFrameObject;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiKbMemory.Initialize(): AError;
begin
  Result := 0;
end;

function TAiKbMemory.LoadFromFileN(FileName, Path: String): AError;
var
  I: Int32;
  F: TFileProfKB;
begin
  F := TFileProfKB.Create;
  if F.Open(FileName, Path) then
  begin
    Result := -1;
    Exit;
  end;
  Result := 0;
  {}
  SetLength(FItems, F.GetHeaderKB.CountF);
  for I := 0 to High(FItems) do FItems[I] := nil;
  {}
  SetLength(FItemsRec, F.GetHeaderKB.CountF);
  for I := 0 to High(FItemsRec) do begin
    F.FreimRead(I, FItemsRec[I]);
  end;
  F.Close;
  F.Free;
  Result := 0;
end;

function TAiKbMemory.NewFreim(Freim: TAiFrameObject): TAId;
var
  Id: TAId;
begin
  Result := 0;
  {Снятие инициализации фрейма}
  if Freim.GetInitialized then
    Freim.SetInitialized(False);
  {Присоединение объекта к БЗ}
  Id := Length(FItems);
  SetLength(FItems, Id + 1);
  FItems[Id] := Freim;
  {Установка параметров фрейма, как принадлежащего к этой БЗ}
  Freim.SetId(Id);
  Freim.SetSource(AiSource2005(Self));
  {Freim.FreimTypeId := Self.FreimId;}

  {Инициализация объекта}
  if Freim.Initialize <> 0 then begin
    {Result := 0;}
    Exit;
  end;

  Result := Freim.GetId;
end;

{ TAiKbMemory2 }

constructor TAiKbMemory2.Create(Source: AiSourceObject; Id: TAId = 0);
begin
  inherited Create(Source, Id);
  {FArbitrary := Arbitrary;}
  FArbitrary := True;
end;

procedure TAiKbMemory2.Free;
var
  I: Int32;
begin
  for I := 0 to High(FItems) do FItems[I].Free;
  SetLength(FItems, 0);
  inherited Free;
end;

function TAiKbMemory2.GetCountFreims: UInt64;
var
  I: Int32;
begin
  Result := 0;
  if FArbitrary then begin
    for I := 0 to High(FItems) do if Result < FItems[I].GetId then begin
      Result := FItems[I].GetId;
    end;
  end else begin
    Result := Length(FItems);
  end;
end;

function TAiKbMemory2.GetFreeIndexCashe: UInt32;
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
    if not(Assigned(FItems[I])) then begin
      Result := I;
      Exit;
    end;
  Result := Length(FItems);
  SetLength(FItems, Result + 1024);
end;

function TAiKbMemory2.GetFreim(Id: TAId): TAiFrameObject;
begin
  case Id of
    0..1023: Result := FBase[Id];
    1024..2047: Result := FLocal[Id-1024];
  else
    {Result := nil;}
    {Поиск в локальном кеше}
    Result := GetFreimCashe(Id);
    if Assigned(Result) then begin
      {Result := FItems[I];}
      {Result.Used := Result.Used + 1;}
      Exit;
    end;
    {Запрос у родительской БЗ}
    {...}
    {Запросы в других БЗ}
    {...}
  end;
end;

function TAiKbMemory2.GetFreimCashe(Id: TAId): TAiFrameObject;
var
  I: Int32;
begin
  Result := nil;
  for I := 0 to High(FItems) do
    if (Assigned(FItems[I])) and (FItems[I].GetId = Id) then
    begin
      Result := FItems[I];
      Exit;
    end;
end;

function TAiKbMemory2.GetItem(Index: AUInt32): TAiFrameObject;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiKbMemory2.Initialize(): AError;
begin
  Result := inherited Initialize;
  {Инициализация базовых фреймов}
  {...}
end;

function TAiKbMemory2.NewFreim(Freim: TAiFrameObject): TAId;
begin
  {Result := NewFreimLocal(Freim);
  if Result > 0 then Exit;
  Result := NewFreimExternal(Freim);}
  Result := 0;
end;

function TAiKbMemory2.Open(): AError;
begin
  {Result := inherited Open;}
  Result := 0;
  SetLength(FItems, 1);
  FItems[0] := TAiFrameObject.Create(0, 0);
end;

function TAiKbMemory2.SaveToFile(FileName, Path: String): AError;
{var
  F: TFileProfKB;
  I: Int32;
  RecF: TAIFreimRecF64;}
begin
  Result := inherited SaveToFileN(FileName, Path);
  (*F := TFileProfKB.Create;
  F.OpenCreate(FileName);
  if not(FArbitrary) then begin
    for I := 0 to High(FItems) do begin
      if not(Assigned(FItems[I])) then GetFreim(I);
      RecF := FItems[I].ToRecF64;
      if F.FreimWriteNext(RecF) <> 0 then begin
        Result := 2;
        F.Free;
        Exit;
      end;
    end;
  end else begin
    for I := 0 to FreimCount-1 do begin
      RecF := GetFreim(I).ToRecF64;
      if F.FreimWriteNext(RecF) <> 0 then begin
        Result := 2;
        F.Free;
        Exit;
      end;
    end;
  end;
  F.Free;
  Result := 0;*)
end;

procedure TAiKbMemory2.SetArbitrary(Value: Boolean);
var
  I: Int32;
  {I2: Int32;}
  It: array of TAiFrameObject;
begin
  if FArbitrary = Value then Exit;
  if GetOpened then begin
    if FArbitrary then begin
      {Сортируем по порядку}
      {Метод пузырька}
      {for I2 := 0 to High(FItems) do for I := 0 to High(FItems)-1 do begin
        if FItems[I].FreimId > FItems[I + 1].FreimId then begin
          F := FItems[I];
          FItems[I] := FItems[I + 1];
          Freim[I + 1] := F;
        end;
      end;}
      {Другой метод}
      for I := 0 to High(FItems) do begin
        if FItems[I].GetId >= UInt32(Length(It)) then begin
          SetLength(It, FItems[I].GetId + 1);
        end;
        It[FItems[I].GetId] := FItems[I];
      end;
      SetLength(FItems, Length(It));
      for I := 0 to High(It) do begin
        FItems[I] := It[I];
      end;
    end else begin
    end;
  end else
    FArbitrary := Value;
end;

function TAiKbMemory2.SetFreim(Id: TAId; Freim: TAiFrameObject): AError;
var
  F2: TAiFrameObject;
  I: UInt32;
  Source: TAiSource2005;
begin
  {Result := inherited SetFreim(Id, Freim);}
  {if Result <> 0 then Exit;}
  Result := 1;
  case Id of
    0..1023: begin
      FBase[Id] := Freim;
      Result := 0;
    end;
    1024..2047: begin
      Source := TObject(Freim.GetSource) as TAiSource2005;
      if Assigned(Source) and (Source <> Self) then Exit;
      {if not(Assigned(Source)) then Source := Self;}
      Freim.SetId(Id);
      FLocal[Id-1024] := Freim;
      Result := 0;
    end;
  else
    {Проверка - не занят ли идентификатор}
    {В локальной БЗ}
    F2 := GetFreim(Id);
    if Assigned(F2) then begin
      {В родительской БЗ}
      {...}
      {Если идентификатор занят, то проверка соответствия фрейма
      с фреймом в родительской БЗ}
      {...}
      Result := 0;
      Exit;
    end;
    {Если идентификатор свободен, то запись фрейма}
    {в локальную БЗ}
    I := GetFreeIndexCashe;
    if I = HighUInt32 then Exit;
    FItems[I] := Freim;
    {в родительскую БЗ}
    {...}
    Result := 0;
  end;
end;

end.
