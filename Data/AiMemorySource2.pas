{**
@Abstract(Источник знаний в памяти)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.01.2006)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AiMemorySource2;

interface

uses
  ABase, AConsts2, ATypes,
  AiBase, AiFrameImpl, AiFrameIntf, AiSourceImpl;

type //** @abstract(Источник знаний в памяти)
  TAISourceMemory = class(TAISource)
  private
    FItems: array of TAIFrame;
  protected
    function Get_FrameByID(ID: TAIID): IAIFrame; override;
  public
    function Clear(): WordBool; override;
    constructor Create();
    procedure Free(); override;
//    function GetItem(Index: UInt32): IAIFrame;
//    function GetItemID(Index: Integer): TAI_Id; override;
//    function GetCountFreims(): UInt64; override;
//    function GetCountItems(): UInt32;
    function Initialize(): TProfError; override;
    // Загрузить данные из XML
//    function LoadFromXml(Config: IXmlNode): WordBool; override;
//    function NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id; override;
//    function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAI_ID; override;
//    function ConfigureLoad(AConfig: IXmlNode = nil): WordBool; override; safecall;
  end;

{type // БЗ в памяти (тип 2) ----------------------------------------------------
  TAISourceMemory2 = class(TAISource)
  private
    FArbitrary: Boolean;        // Произвольный порядок.
    FBase: array[0..1023] of IAIFreim;
    FLocal: array[0..1023] of IAIFreim; // 1024..2047
    FItems: array of IAIFreim; // Все остальные. Не упорядоченные.
    //FOrder: TKBMemoryOrder;   // Порядок. Очередность.
  protected
    function Get_Freim(Id: TAI_Id): IAIFreim; override;
  public
    procedure SetFreim(ID: TAI_ID; Freim: IAIFreim); override;
    function Initialize: WordBool; override;
    function GetFreimCashe(Id: TAI_Id): TAIFreim;
    function NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id; override;
  public
    constructor Create(Source: TAISource = nil; Id: TAI_Id = 0);
    procedure Free; override;
    function GetCountFreims: UInt64; override;
    function GetFreeIndexCashe: UInt32;
    function GetItem(Index: UInt32): TAIFreim;
    procedure SetArbitrary(Value: Boolean);
    function Open: Boolean; override;
  end;}

implementation

{ TAISourceMemory }

function TAISourceMemory.Clear(): WordBool;
var
  I: Int32;
begin
  Result := inherited Clear;
  for I := 0 to High(FItems) do if Assigned(FItems[I]) then FItems[I].Free;
  SetLength(FItems, 0);
end;

{function TAISourceMemory.ConfigureLoad(AConfig: IXmlNode = nil): WordBool;
begin
  AddToLog(lgDataBase, ltInformation, stConfigureLoadStart, []);
  Result := inherited ConfigureLoad;
  if not(Result) then Exit;

  AddToLog(lgDataBase, ltInformation, stConfigureLoadOk, []);
end;}

constructor TAISourceMemory.Create();
var
  I: Int32;
begin
  inherited Create();
  FName := 'Memory';
  //FTitle := 'SourceMemory';
  SetLength(FItems, 1024);
  for I := 0 to High(FItems) do FItems[I] := nil;
  AddToLog(lgDataBase, ltInformation, stCreateOk);
end;

procedure TAISourceMemory.Free();
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
  try
    if Assigned(FItems[I]) then
      FItems[I].Free;
  except
  end;
  SetLength(FItems, 0);
  inherited Free;
end;

{function TAISourceMemory.GetCountFreims(): UInt64;
begin
  Result := Length(FItems);
end;}

{function TAISourceMemory.GetCountItems(): UInt32;
begin
  Result := Length(FItems);
end;}

function TAISourceMemory.Get_FrameByID(ID: TAIID): IAIFrame;
begin
  if (ID >= 0) and (ID < Length(FItems)) then
    Result := FItems[Id]
  else
    Result := nil;
end;

{function TAISourceMemory.GetItem(Index: UInt32): IAIFreim;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;}

{function TAISourceMemory.GetItemId(Index: Integer): TAI_ID;
begin
  if (Index >= Length(FItems)) or not(Assigned(FItems[Index])) then
    Result := 0
  else
    Result := FItems[Index].FreimID;
end;}

function TAISourceMemory.Initialize(): TProfError;
begin
  AddToLog(lgGeneral, ltInformation, stInitialize_Start);
  Result := inherited Initialize();
  if (Result = 0) then
    AddToLog(lgDataBase, ltInformation, stInitialize_Ok)
  else
    AddToLog(lgGeneral, ltInformation, stInitialize_Error);
end;

(*function TAISourceMemory.LoadFromXml(Config: IXmlNode): WordBool;
//var
//  Count: Int32;
//  Freim: TAIFreim;
//  I: Int32;
//  Id: TAI_Id;
//  S: String;
begin
  Result := False;
  {if not(Assigned(Config)) then Exit;
  if not(Config.ReadInt32('Count', Count)) then Exit;
  for I := 0 to Count - 1 do with Config.GetNodeByName('Item' + cInt32ToStr(I)) do begin
    ReadInt64('Id', Id);
    //Freim := GetFreim(Id);
    //Freim.LoadFromConfig(Config, S);
  end;
  Result := True;}
end;*)

(*function TAISourceMemory.NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id;
{var
  Freim: TAIFreim;}
begin
  Result := NextFreeFreimID;

  {Result := 0;
  Freim := TAIFreim.Create(Self, 0);
  // Снятие инициализации фрейма
  //if Freim.GetInitialized then Freim.SetInitialized(False);
  // Присоединение объекта к БЗ
  Id := Length(FItems);
  SetLength(FItems, Id + 1);
  FItems[Id] := Freim;
  // Установка параметров фрейма, как принадлежащего к этой БЗ
  Freim.FreimID := ID;
  Freim.Source := Self;
  //Freim.FreimTypeId := Self.FreimId;

  // Инициализация объекта
  if not(Freim.Initialize) then
  begin
    //Result := 0;
    Exit;
  end;

  Result := Freim.FreimID;}

  {Result := Length(FItems);
  if Result < 1024 then begin
    SetLength(FItems, 1024);
    for I := Result to High(FItems) do FItems[I] := nil;
  end;

  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result] := nil;}
end;*)

{function TAISourceMemory.NewFreimType(const AName: WideString; AStruct: PStructFreimType): TAI_ID;
begin
  Result := NewFreim(1);
  // ...
end;}

(*
// TAISourceMemory2 ------------------------------------------------------------
// -----------------------------------------------------------------------------
constructor TAISourceMemory2.Create(Source: TAISource = nil; Id: TAI_Id = 0);
begin
  inherited Create(Source, Id);
  {FArbitrary := Arbitrary;}
  FArbitrary := True;
end;

// -----------------------------------------------------------------------------
procedure TAISourceMemory2.Free;
var
  I: Int32;
begin
  for I := 0 to High(FItems) do TAIFreim(FItems[I]).Free();
  SetLength(FItems, 0);
  inherited Free;
end;

// -----------------------------------------------------------------------------
function TAISourceMemory2.GetCountFreims: UInt64;
var
  I: Int32;
begin
  Result := 0;
  if FArbitrary then
  begin
    for I := 0 to High(FItems) do if Result < FItems[I].FreimID then
    begin
      Result := FItems[I].FreimID;
    end;
  end
  else
  begin
    Result := Length(FItems);
  end;
end;

// -----------------------------------------------------------------------------
function TAISourceMemory2.GetFreeIndexCashe: UInt32;
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

// -----------------------------------------------------------------------------
function TAISourceMemory2.Get_Freim(ID: TAI_ID): IAIFreim;
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

// -----------------------------------------------------------------------------
function TAISourceMemory2.GetFreimCashe(Id: TAI_Id): TAIFreim;
var
  I: Int32;
begin
  Result := nil;
  for I := 0 to High(FItems) do
    if (Assigned(FItems[I])) and (FItems[I].FreimID = ID) then
    begin
      Result := TAIFreim(FItems[I]);
      Exit;
    end;
end;

// -----------------------------------------------------------------------------
function TAISourceMemory2.GetItem(Index: UInt32): TAIFreim;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := TAIFreim(FItems[Index]);
end;

// -----------------------------------------------------------------------------
function TAISourceMemory2.Initialize: WordBool;
begin
  Result := inherited Initialize;
  {Инициализация базовых фреймов}
  {...}
end;

// -----------------------------------------------------------------------------
function TAISourceMemory2.NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id;
begin
  {Result := NewFreimLocal(Freim);
  if Result > 0 then Exit;
  Result := NewFreimExternal(Freim);}
  Result := 0;
end;

// -----------------------------------------------------------------------------
function TAISourceMemory2.Open: Boolean;
begin
  {Result := inherited Open;}
  Result := True;
  SetLength(FItems, 1);
  FItems[0] := TAIFreim.Create();
end;

// -----------------------------------------------------------------------------
procedure TAISourceMemory2.SetArbitrary(Value: Boolean);
var
  I: Int32;
  {I2: Int32;}
  It: array of TAIFreim;
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
      for I := 0 to High(FItems) do
      begin
        if FItems[I].FreimID >= UInt32(Length(It)) then
        begin
          SetLength(It, FItems[I].FreimID + 1);
        end;
        It[FItems[I].FreimID] := TAIFreim(FItems[I]);
      end;
      SetLength(FItems, Length(It));
      for I := 0 to High(It) do
      begin
        FItems[I] := It[I];
      end;
    end
    else
    begin
    end;
  end
  else
    FArbitrary := Value;
end;

// -----------------------------------------------------------------------------
procedure TAISourceMemory2.SetFreim(ID: TAI_ID; Freim: IAIFreim);
var
  F2: TAIFreim;
  I: UInt32;
  Source: TAISource;
begin
  {Result := inherited SetFreim(Id, Freim);}
  {if Result <> 0 then Exit;}
  //Result := False;
  case Id of
    0..1023: begin
      FBase[Id] := Freim;
      //Result := True;
    end;
    1024..2047: begin
      Source := TAISource(Freim.Source);
      if Assigned(Source) and (Source <> Self) then Exit;
      //if not(Assigned(Source)) then Source := Self;
      Freim.FreimID := ID;
      FLocal[Id-1024] := Freim;
      //Result := True;
    end;
  else
    // Проверка - не занят ли идентификатор
    // В локальной БЗ
    F2 := TAIFreim(GetFreim(Id));
    if Assigned(F2) then
    begin
      // В родительской БЗ
      // ...
      // Если идентификатор занят, то проверка соответствия фрейма
      // с фреймом в родительской БЗ
      // ...
      //Result := True;
      Exit;
    end;
    // Если идентификатор свободен, то запись фрейма
    // в локальную БЗ
    I := GetFreeIndexCashe;
    if I = HighUInt32 then Exit;
    FItems[I] := Freim;
    // в родительскую БЗ
    // ...
    //Result := True;
  end;
end;
*)

end.
