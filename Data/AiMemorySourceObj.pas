{**
@Abstract(Источник знаний в памяти)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.01.2006)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AiMemorySourceObj;

interface

uses
  ABaseUtils2, AConfigObj, ATypes,
  AiBase, AiFrameObj, AiSourceObj, AiTypes;

type
  TAiSourceMemory2005 = class(TAiSource2005)
  private
    FItems: array of TAiFrame2005;
    FNil: TAiFrame2005;             {Заглушка от неправильного Id}
    {FItemsRec: array of TAIFreimRec;}
  public
    function Clear: TError; override;
    constructor Create(Source: AiSource2005 = 0; Id: TAId = 0);
    procedure Free; {override;}
    function GetFreim(Id: TAI_Id): TAiFrame2005; override;
    function GetItem(Index: UInt32): TAiFrame2005;
    function GetItemId(Index: UInt32): TAI_Id; override;
    function GetCountFreims: UInt64; override;
    function GetCountItems: UInt32;
    function LoadFromConfig(Config: TConfig; Prefix: String): TError;
    function NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id; override;
  end;

implementation

{ TAiSourceMemory2005 }

function TAiSourceMemory2005.Clear(): TError;
var
  I: Int32;
begin
  Result := inherited Clear;
  for I := 0 to High(FItems) do if Assigned(FItems[I]) then FItems[I].Free;
  SetLength(FItems, 0);
end;

constructor TAiSourceMemory2005.Create(Source: AiSource2005; Id: TAId);
var
  I: Int32;
begin
  inherited Create(Source, Id);
  FName := 'Memory';
  FTitle := 'SourceMemory';
  FNil := TAiFrame2005.Create();
  SetLength(FItems, 1024);
  for I := 0 to High(FItems) do FItems[I] := nil;
end;

procedure TAiSourceMemory2005.Free();
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
    if Assigned(FItems[I]) then
      FItems[I].Free;
  SetLength(FItems, 0);
  FNil.Free;
  inherited Free;
end;

function TAiSourceMemory2005.GetCountFreims(): UInt64;
begin
  Result := Length(FItems);
end;

function TAiSourceMemory2005.GetCountItems(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiSourceMemory2005.GetFreim(Id: TAI_Id): TAiFrame2005;
begin
  if Id >= Length(FItems) then
    Result := FNil {Заглушка}
  else
    Result := FItems[Id];
end;

function TAiSourceMemory2005.GetItem(Index: UInt32): TAiFrame2005;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiSourceMemory2005.GetItemId(Index: UInt32): TAI_Id;
begin
  if (Index >= UInt32(Length(FItems))) or not(Assigned(FItems[Index])) then
    Result := 0
  else
    Result := FItems[Index].GetId;
end;

function TAiSourceMemory2005.LoadFromConfig(Config: TConfig; Prefix: String): TError;
var
  Count: Int32;
  //Freim: TAiFrame2005;
  I: Int32;
  Id: TAI_Id;
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

function TAiSourceMemory2005.NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id;
var
  Freim: TAiFrame2005;
{var
  I: Int32;}
begin
  Result := 0;
  Freim := TAiFrame2005.Create(Self.GetId(), 0);
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

end.
