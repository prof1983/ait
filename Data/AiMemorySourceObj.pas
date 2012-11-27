{**
@Abstract Источник знаний в памяти
@Author Prof1983 <prof1983@ya.ru>
@Created 25.01.2006
@LastMod 27.11.2012
}
unit AiMemorySourceObj;

interface

uses
  ABase, ABase2, ABaseUtils2, AConfigObj, ATypes,
  AiBase, AiFrameObj, AiSourceObj, AiTypes;

type
  TAiMemorySourceObject = class(TAiSourceObject)
  protected
    FItems: array of TAiFrameObject;
      //** Заглушка от неправильного Id
    FNil: TAiFrameObject;
    {FItemsRec: array of TAIFreimRec;}
  protected
      //** Произвольный порядок.
    FArbitrary: Boolean;
    FBase: array[0..1023] of TAiFrameObject;
      // 1024..2047
    FLocal: array[0..1023] of TAiFrameObject;
      // Все остальные. Не упорядоченные.
    //FItems: array of TAiFrameObject;
  public
    procedure SetArbitrary(Value: Boolean);
  public
    function Clear(): TError; override;
    function GetCountFreims(): UInt64; override;
    function GetCountItems(): AUInt32;
    function GetFreeIndexCashe(): UInt32;
    function GetFreim(Id: AId): TAiFrameObject; override;
    function GetFreimCashe(Id: AId): TAiFrameObject;
    function GetItem(Index: AUInt32): TAiFrameObject;
    function GetItemId(Index: AInt): AId; override;
    function LoadFromConfig(Config: TConfig; Prefix: String): TError;
    function NewFreim(Typ: AId; Id: AId = 0): AId; override;
    function Open(): TError; override;
    function SetFreim2(Id: AId; Freim: TAiFrameObject): TError; override;
  public
    constructor Create();
    procedure Free(); override;
  end;

implementation

{ TAiMemorySourceObject }

function TAiMemorySourceObject.Clear(): TError;
var
  I: Int32;
begin
  Result := inherited Clear;
  for I := 0 to High(FItems) do if Assigned(FItems[I]) then FItems[I].Free;
  SetLength(FItems, 0);
end;

constructor TAiMemorySourceObject.Create();
var
  I: Int32;
begin
  inherited Create();
  FArbitrary := True;
  FName := 'Memory';
  FTitle := 'SourceMemory';
  FNil := TAiFrameObject.Create();
  SetLength(FItems, 1024);
  for I := 0 to High(FItems) do
    FItems[I] := nil;
end;

procedure TAiMemorySourceObject.Free();
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
  begin
    if Assigned(FItems[I]) then
      FItems[I].Free();
  end;
  SetLength(FItems, 0);
  FNil.Free();
  inherited Free();
end;

function TAiMemorySourceObject.GetCountFreims(): UInt64;
var
  I: Int32;
begin
  Result := 0;
  if FArbitrary then
  begin
    for I := 0 to High(FItems) do
    begin
      if (Result < FItems[I].GetId()) then
      begin
        Result := FItems[I].GetId();
      end;
    end;
  end
  else
    Result := Length(FItems);
end;

function TAiMemorySourceObject.GetCountItems(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiMemorySourceObject.GetFreeIndexCashe(): UInt32;
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
  begin
    if not(Assigned(FItems[I])) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := Length(FItems);
  SetLength(FItems, Result + 1024);
end;

function TAiMemorySourceObject.GetFreim(Id: AId): TAiFrameObject;
begin
  {Поиск в локальном кеше}
  Result := GetFreimCashe(Id);
  if Assigned(Result) then
    Exit;
  // Запрос у родительской БЗ
  // ...
  // Запросы в других БЗ
  // ...
  Result := FNil; // Заглушка

  (*case Id of
    0..1023: Result := FBase[Id];
    1024..2047: Result := FLocal[Id-1024];
  else
    {Result := nil;}
    {Поиск в локальном кеше}
    Result := GetFreimCashe(Id);
    if Assigned(Result) then
    begin
      {Result := FItems[I];}
      {Result.Used := Result.Used + 1;}
      Exit;
    end;
    {Запрос у родительской БЗ}
    {...}
    {Запросы в других БЗ}
    {...}
  end;*)

  (*if Id >= Length(FItems) then
    Result := FNil {Заглушка}
  else
    Result := FItems[Id];*)
end;

function TAiMemorySourceObject.GetFreimCashe(Id: AId): TAiFrameObject;
var
  I: Int32;
begin
  Result := nil;
  for I := 0 to High(FItems) do
  begin
    if (Assigned(FItems[I])) and (FItems[I].GetId = Id) then
    begin
      Result := FItems[I];
      Exit;
    end;
  end;
end;

function TAiMemorySourceObject.GetItem(Index: UInt32): TAiFrameObject;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiMemorySourceObject.GetItemId(Index: AInt): AId;
begin
  if (Index >= UInt32(Length(FItems))) or not(Assigned(FItems[Index])) then
    Result := 0
  else
    Result := FItems[Index].GetId;
end;

function TAiMemorySourceObject.LoadFromConfig(Config: TConfig; Prefix: String): TError;
var
  Count: Int32;
  //Freim: TAiFrameObject;
  I: Int32;
  Id: AId;
  S: String;
begin
  Result := 1;
  if not(Assigned(Config)) then Exit;
  if not(Config.ReadParamValueByNameAsInt32(Prefix + 'Count', Count)) then Exit;
  for I := 0 to Count - 1 do
  begin
    S := Prefix + 'Item[' + cInt32ToStr(I) + '].';
    Config.ReadParamValueByNameAsInt64(S + 'Id', Id);
    {Freim := GetFreim(Id);}
    {Freim.LoadFromConfig(Config, S);}
  end;
  Result := 0;
end;

function TAiMemorySourceObject.NewFreim(Typ: AId; Id: AId = 0): AId;
var
  Freim: TAiFrameObject;
{var
  I: Int32;}
begin
  Result := 0;
  Freim := TAiFrameObject.Create(Self.GetId(), 0);
  {Снятие инициализации фрейма}
  {if Freim.GetInitialized then Freim.SetInitialized(False);}
  {Присоединение объекта к БЗ}
  Id := Length(FItems);
  SetLength(FItems, Id + 1);
  FItems[Id] := Freim;
  {Установка параметров фрейма, как принадлежащего к этой БЗ}
  Freim.SetId(Id);
  Freim.SetSource(Self.GetId());
  {Freim.FreimTypeId := Self.FreimId;}

  {Инициализация объекта}
  if Freim.Initialize <> 0 then
  begin
    {Result := 0;}
    Exit;
  end;

  Result := Freim.GetId;

  (*Result := Length(FItems);
  if Result < 1024 then begin
    SetLength(FItems, 1024);
    for I := Result to High(FItems) do FItems[I] := nil;
  end;

  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result] := nil;*)
end;

function TAiMemorySourceObject.Open(): TError;
begin
  {Result := inherited Open;}
  Result := 0;
  SetLength(FItems, 1);
  FItems[0] := TAiFrameObject.Create(0, 0);
end;

procedure TAiMemorySourceObject.SetArbitrary(Value: Boolean);
var
  I: Int32;
  {I2: Int32;}
  It: array of TAiFrameObject;
begin
  if FArbitrary = Value then Exit;
  if GetOpened then
  begin
    if FArbitrary then
    begin
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
        if FItems[I].GetId >= UInt32(Length(It)) then
        begin
          SetLength(It, FItems[I].GetId + 1);
        end;
        It[FItems[I].GetId] := FItems[I];
      end;
      SetLength(FItems, Length(It));
      for I := 0 to High(It) do
      begin
        FItems[I] := It[I];
      end;
    end;
  end
  else
    FArbitrary := Value;
end;

function TAiMemorySourceObject.SetFreim2(Id: AId; Freim: TAiFrameObject): TError;
var
  F2: TAiFrameObject;
  I: UInt32;
  Source: AiSourceObject;
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
      Source := Freim.GetSource;
      if (Source <> 0) and (Source <> Self.GetId()) then Exit;
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
    if (I = HighUInt32) then Exit;
    FItems[I] := Freim;
    {в родительскую БЗ}
    {...}
    Result := 0;
  end;
end;

end.
