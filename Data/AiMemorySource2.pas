{**
@Abstract(Источник знаний в памяти)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.01.2006)
@LastMod(10.07.2012)
@Version(0.5)
}
unit AiMemorySource2;

// TODO: Rename to AiMemorySourceImpl.pas

interface

uses
  ABase, AConsts2, ATypes,
  AiBase, AiFrameImpl, AiFrameIntf, AiSourceImpl;

type //** @abstract(Источник знаний в памяти)
  TAiSourceMemory = class(TAiSource)
  protected
    FItems: array of TAiFrame;
  protected
    function Get_FrameById(Id: AId): IAiFrame; override;
  public
    function Clear(): WordBool; override;
    function Initialize(): TProfError; override;
    // Загрузить данные из XML
//    function LoadFromXml(Config: IXmlNode): WordBool; override;
//    function NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id; override;
//    function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAI_ID; override;
//    function ConfigureLoad(AConfig: IXmlNode = nil): WordBool; override; safecall;
  public
    constructor Create();
    procedure Free(); override;
  end;

implementation

{ TAiSourceMemory }

function TAiSourceMemory.Clear(): WordBool;
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

constructor TAiSourceMemory.Create();
var
  I: Int32;
begin
  inherited Create();
  FName := 'Memory';
  //FTitle := 'SourceMemory';
  SetLength(FItems, 1024);
  for I := 0 to High(FItems) do
    FItems[I] := nil;
  AddToLog(lgDataBase, ltInformation, stCreateOk);
end;

procedure TAiSourceMemory.Free();
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
  try
    if Assigned(FItems[I]) then
      FItems[I].Free();
  except
  end;
  SetLength(FItems, 0);
  inherited Free();
end;

function TAiSourceMemory.Get_FrameById(Id: AId): IAiFrame;
begin
  if (Id >= 0) and (Id < Length(FItems)) then
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

function TAiSourceMemory.Initialize(): TProfError;
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

end.
