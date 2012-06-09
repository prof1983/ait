{**
@Abstract(Базовый класс для источника)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(09.06.2012)
@Version(0.5)
}
unit AiSourceObj;

interface

uses
  SysUtils,
  ABase, AConfigObj, ALogObj, ATypes,
  AiBase, AiConnectsObj, AiDataObj, AiFrameObj, AiIoFileKb, AiKbMain, AiSelectObj, AiTypes;

type
  TAiRecSource = record
    Id: TAId;
    Source: AiSourceObject2005;
  end;

type
  //** @abstract(Источник фреймов) // 256
  TAiSourceObject = class
  protected
    FConfig: TConfig;
    FLog: TLog;
    FPath: string;
    FPrefix: string;
  protected
    FId: TAId;
      //** Имя источника (Название короткое)
    FName: string;
      //** Следующий свободный ID фрейма
    FNextFreeFreimID: Integer;
      //** Функция добавления в log
    FOnAddToLog: TAddToLogProc;
      {**
        True, if source is open
        Источник открыт
      }
    FOpened: Boolean;
      //** Родительские БЗ
    FParents: array of TAiRecSource{TAiSourceObject};
      //** Наименование источника для отображения
    FTitle: string;
  protected // from TAiSourceAbstractObject2005
      // True, если инициализирован
    FInitialized: Boolean;
  protected // IAiSource
    // Возвращает фрейм
    function Get_Freim(Id: TAId): TAiFrameObject; virtual;
  public
    constructor Create();
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
    //** Проверяет и создает базовые фреймы Prof_AI_GLobals.AIFreims
    function CheckFreims(): Boolean;
    function Clear(): TError; virtual;
    function Close(): AError; virtual;
    function ConnectAdd(Id, Con: TAId): AInt32; virtual; deprecated; // Delete
    function ConnectCount(Id: TAId): AError; virtual; deprecated; // Delete
    function ConnectDelete(Id, Con: TAId): AError; virtual; deprecated; // Delete
    function ConnectDeleteI(Id: TAId; Index: UInt32): AError; virtual; deprecated; // Delete
    function ConnectGet(Id: TAId; Index: UInt32): TAId; virtual; deprecated; // Delete
    function ConnectIndexGet(Id, Con: TAId): AInt32; virtual; deprecated; // Delete
    function DataClear(Id: TAId): TError; virtual; deprecated; // Use Clear()
    function DataSize(Id: TAId): AUInt64; virtual; // deprecated
    function Finalize(): TProfError; virtual;
    procedure Free(); virtual;
    function FreimFree(Id: TAId): Boolean; virtual; // deprecated
    function GetActive(): Boolean;
    function GetCountFreims(): UInt64; virtual;
    function GetFreim(Id: TAId): TAiFrameObject; virtual;
    function GetFreimConnects(Id: TAId): TAiConnectsObject; virtual;
    function GetFreimData(Id: TAId): TAiDataObject; virtual;
    function GetFreimDateTimeCreate(Id: TAId): TDateTime; virtual;
    function GetFreimType(Id: TAId): TAId; virtual;
    function GetId(): AiSourceObject;
    function GetItemId(Index: Integer): TAId; virtual;
    function GetName(): string;
    function GetNextFreeFreimId(): TAId; virtual;
    function GetOpened(): Boolean;
    function GetParent(Index: UInt32): AiSourceObject2005;
    function GetParentId(Index: UInt32): TAId;
    function GetParentObj(Index: UInt32): TAiSourceObject;
      // Произвести инициализацию с установкой параметров
    function Init(Path: String; Log: TLog; Config: TConfig; Prefix: String): TError; virtual;
    function Initialize(): AError; virtual;
    function LoadFromFile(F: TFileProfKB; Path: String): TError;
    function LoadFromFileN(Path, FileName: String): Boolean;
    function LoadFromFileXml(FileName: String): TError;
    function LoadFromRecF64(Rec: TAiFreimRecF64): WordBool;
      //** Создает новый фрейм
    function NewFreim(Typ: TAId; Id: TAId = 0): TAId; virtual;
      //** Создает новый фрейм
    function NewFreim2(Frame: TAiFrameObject): TAId; virtual;
    function Open(): TError; virtual;
    function SaveToFile(F: TFileProfKB; Path: String): TError;
    function SaveToFileN(FileName, Path: String): Boolean;
    function SaveToFileXml(FileName: String): Boolean;
      //** Сделать выборку по типу
    function Select(AType: TAId): TAiSelect; virtual;
    procedure SetFreim(Id: TAId; Value: TAiFrameObject); virtual;
    function SetFreimConnects(Id: TAId; Value: TAiConnectsObject): AError; virtual;
    function SetFreimData(Id: TAId; Data: TAiDataObject): AError; virtual;
    function SetFreimType(Id, Value: TAId): AError; virtual;
    procedure SetName(Value: String);
    procedure SetParent(Index: UInt32; Value: TAiSourceObject);
    procedure SetParentId(Index: UInt32; Value: TAId);
    procedure SetParentObj(Index: UInt32; Value: TAiSourceObject);
    //** Создает и регистрирует новый тип фрейма Если AStructure задан, то AName игнорируется
    function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAId; virtual;
  public
    function Activate(): Boolean; deprecated; // Delete
    function Deactivate(): Boolean; deprecated; // Delete
  public
    property CountFreims: UInt64 read GetCountFreims;
    property FreimByID[ID: TAId]: TAiFrameObject read GetFreim write SetFreim;
    property Freims[ID: TAId]: TAiFrameObject read Get_Freim write SetFreim;
    property Id: TAId read FId;
    property NextFreeFreimID: TAId read GetNextFreeFreimID;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    property ParentsObj[Index: UInt32]: TAiSourceObject read GetParentObj write SetParentObj;
  end;

  // Recovered
  TAiSource2004 = class
  public
    function Count(): AInt32;
    function CountFreim_Get(): AInt;
    function F(Id: AInt64): TAiFrameObject; deprecated; // Use FreimGet()
    function FreimGet(Id: AInt32; Created: Boolean = False): TAiFrameObject; virtual;
    function FreimNew(Typ: AId): AId;
    function FreimSearch54(const Name: string): AInt32;
    function FreimSearch56(): TAId{THandle064};
      {** Return identifier of param by type in frame
          @return(identifier) }
    function FreimSelectParamByType(Id, ParamTyp: AInt): AInt;
    function FreimSelectByType(Typ: TAId): TAId;
  end;

  TAiSource = TAiSourceObject;
  TAiSource2005 = TAiSourceObject;
  TAiSourceObject2005 = TAiSourceObject;

const // Сообщения -------------------------------------------------------------
  stCheckFreimsStart  = 'Проверка базовых фреймов в БЗ';
  stCheckFreimsCreate = 'Фрейм не найден -> Создание Id=%d Type=%d ConnectCount=%d DataType=%s Descript=%s';

// Functions -------------------------------------------------------------------
function LoadSourceFromFileN(Source: TAiSource; FileName, Path: String): Boolean;
function SaveSourceToFileN(Source: TAiSource; FileName, Path: String): Boolean;

implementation

const
  stNotOverrideA = 'Функция "%s" не переопределена';

// Functions -------------------------------------------------------------------

function LoadSourceFromFileN(Source: TAISource; FileName, Path: String): Boolean;
{var
  F: TFileProfKB;}
begin
  Result := False;
//  if not(Assigned(Source)) or (FileName = '') then Exit;
//  F := TFileProfKB.Create;
//  Result := F.Open(FileName, Path);
//  if not(Result) then Exit;
//  {Result := inherited LoadFromFileN(F, Path);}
//  {Count := F.GetHeaderKB.CountF;
//  for I := 0 to Count - 1 do}
//  Result := False;
end;

function LoadSourceFromFileN2005(Source: TAiSource2005; FileName, Path: String): TError;
begin
  Result := -1;
end;

function SaveSourceToFileN(Source: TAISource; FileName, Path: String): Boolean;
{var
  Count: UInt64;
  F: TFileProfKB;
  Freim: TAiFrame2005;
  Id: Int32;
  Index: Int32;
  Rec: TAIFreimRec;}
begin
  Result := False;
  (*if not(Assigned(Source)) or (FileName = '') then Exit;
  F := TFileProfKB.Create;
  F.OpenCreate(FileName, Path);

  Count := Source.GetCountFreims;
  for Index := 0 to Count - 1 do begin
    Id := Source.GetItemId(Index);
    Freim := Source.GetFreim(Id);
    Rec.Id := Id;
    if (Id > 0) and (Assigned(Freim)) then begin
      Rec.Typ := Freim.GetType;
      Rec.DTCreate := Freim.GetDateTimeCreate;
      Rec.DataSize := Freim.GetData.GetSize;
      Rec.ConnectCount := Freim.GetConnects.GetCountConnects;
      if Rec.DataSize > 0 then
        Freim.GetData.SaveToFileN(Path + 'd' + cUInt64ToStr(Id) + '.prof');
      if Rec.ConnectCount > 0 then
        Freim.GetConnects.SaveToFileN(Path + 'c' + cUInt64ToStr(Id) + '.prof');
    end else begin
      Rec.Typ := 0;
      Rec.DTCreate := 0;
      Rec.DataSize := 0;
      Rec.ConnectCount := 0;
    end;
    F.FreimWrite(Id, Rec);
  end;

  F.Free;
  Result := 0;*)
end;

function SaveSourceToFileN2005(Source: TAiSource2005; FileName, Path: String): TError;
begin
  Result := -1;
end;

{ TAiSource2004 }

function TAiSource2004.Count(): AInt32;
begin
  Result := 0;
end;

function TAiSource2004.CountFreim_Get(): AInt;
begin
  Result := 0;
end;

function TAiSource2004.F(Id: AInt64): TAiFrameObject;
begin
  Result := FreimGet(Id);
end;

function TAiSource2004.FreimGet(Id: AInt32; Created: Boolean): TAiFrameObject;
begin
  Result := nil;
end;

function TAiSource2004.FreimNew(Typ: AId): AId;
begin
  Result := 0;
end;

function TAiSource2004.FreimSearch54(const Name: string): AInt32;
begin
  Result := 0;
end;

function TAiSource2004.FreimSearch56(): TAId;
begin
  Result := 0;
end;

function TAiSource2004.FreimSelectByType(Typ: TAId): TAId;
begin
  Result := 0;
end;

function TAiSource2004.FreimSelectParamByType(Id, ParamTyp: AInt): AInt;
begin
  Result := 0;
end;

{ TAiSourceObject }

function TAiSourceObject.Activate(): Boolean;
begin
  Result := True;
end;

function TAiSourceObject.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  if Assigned(FOnAddToLog) then
    Result := FOnAddToLog(AGroup, AType, AStrMsg)
  else
    Result := 0;
end;

function TAiSourceObject.CheckFreims(): Boolean;
var
  Freim: TAiFrameObject;
  I: Int32;
begin
  // TODO: Где-то здесь ошибка, приводящая к зависанию
  AddToLog(lgDataBase, ltInformation, stCheckFreimsStart);
  for I := 0 to High(AIFreims) do
  begin
    Freim := TAiFrameObject(GetFreim(AIFreims[I].Id));
    if not(Assigned(Freim)) and (AIFreims[I].Id > 0) then
    try
      AddToLog(lgDataBase, ltInformation, Format(stCheckFreimsCreate, [AIFreims[I].Id, AIFreims[I].Typ, AIFreims[I].ConnectCount, RUS_DATA_TYPE[AIFreims[I].DataType], AIFreims[I].Descript]));
      // Создание фрейма
      Freim := TAiFrameObject(GetFreim(NewFreim(AIFreims[I].Typ, AIFreims[I].Id)));
      if not(Assigned(Freim)) then
      begin
        AddToLog(lgDataBase, ltError, 'Ошибка при создании фрейма. Фрейм не создан.');
        Continue;
      end;
    except
    end
    else
    try
      // Проверка структуры
      {if Freim.FreimType <> AIFreims[I].Typ then begin
        AddToLog(lgDataBase, ltInformation, 'Не правильный тип фрейма -> Исправление', []);
        Freim.SetFreimType(AIFreims[I].Typ);
        if Freim.Save then
          AddToLog(lgDataBase, ltInformation, 'Тип фрейма исправлен', [])
        else
          AddToLog(lgDataBase, ltError, 'Тип фрейма не исправлен', []);
      end;}
    except
      on E: Exception do begin
        AddToLog(lgDataBase, ltError, Format('Ошибка при проверке типа фрейма. "%s" <%s.%s>', [E.Message, ClassName, 'CheckFreims']))
      end;
    end;
  end;
  Result := False;
end;

function TAiSourceObject.Clear(): TError;
begin
  SetLength(FParents, 0);
  FOpened := False;
  Result := 0;
end;

function TAiSourceObject.Close(): AError;
begin
  if (Clear() < 0) then
  begin
    Result := -1;
    Exit;
  end;
  FOpened := False;
  Result := 0;
end;

function TAiSourceObject.ConnectAdd(Id, Con: TAId): AInt32;
begin
  Result := -1;
end;

function TAiSourceObject.ConnectCount(Id: TAId): AError;
begin
  Result := 0;
end;

function TAiSourceObject.ConnectDelete(Id, Con: TAId): AError;
begin
  Result := 1;
end;

function TAiSourceObject.ConnectDeleteI(Id: TAId; Index: UInt32): AError;
begin
  Result := 1;
end;

function TAiSourceObject.ConnectGet(Id: TAId; Index: AUInt32): TAId;
begin
  Result := 0;
end;

function TAiSourceObject.ConnectIndexGet(Id, Con: TAId): AInt32;
begin
  Result := -1;
end;

function TAiSourceObject.DataClear(Id: TAId): AError;
begin
  Result := 1;
end;

function TAiSourceObject.DataSize(Id: TAId): AUInt64;
begin
  Result := 0;
end;

constructor TAiSourceObject.Create();
begin
  inherited Create();
  FOpened := False;
  {FParent := Parent;
  if not(Assigned(FParent)) then
    FParentId := ParentId
  else
    FParentId := FParent.FreimId;}
  {FSearch := TKBSearch.Create;
  FSelect := TKBSelect.Create(Source, 0);}
end;

function TAiSourceObject.Deactivate(): Boolean;
begin
  Result := True;
end;

function TAiSourceObject.Finalize(): TProfError;
begin
  Close();
  //Result := inherited Finalize;
  {if (FSource <> 0) then
  begin
    if Assigned(FConnects) then
    begin
      FConnects.Free;
      FConnects := nil;
    end;
    if Assigned(FData) then
    begin
      FData.Free;
      FData := nil;
    end;
  end;}
  FInitialized := False;
  //Clear;
  Result := 0;
end;

procedure TAiSourceObject.Free();
begin
  {FSearch.Free;
  FSelect.Free;}
  inherited Free;
end;

function TAiSourceObject.FreimFree(Id: TAId): Boolean;
begin
  Result := True;
end;

function TAiSourceObject.GetActive(): Boolean;
begin
  Result := FOpened;
end;

function TAiSourceObject.GetCountFreims(): UInt64;
begin
  Result := 0;
end;

function TAiSourceObject.GetFreim(Id: TAId): TAiFrameObject;
begin
  Result := nil;
  AddToLog(lgDataBase, ltError, Format(stNotOverrideA, ['GetFreim']));
end;

function TAiSourceObject.GetFreimConnects(Id: TAId): TAiConnectsObject;
begin
  Result := TAiConnectsObject.Create();
end;

function TAiSourceObject.GetFreimData(Id: TAId): TAiDataObject;
var
  Freim: TAiFrameObject;
begin
  Freim := GetFreim(Id);
  if not(Assigned(Freim)) then
  begin
    Result := TAiDataObject.Create(Id, dtNone);
    Exit;
  end;
  Result := Freim.GetData;
  AddToLog(lgDataBase, ltInformation, Format(stNotOverrideA, ['GetFreimData']));
end;

function TAiSourceObject.GetFreimDateTimeCreate(Id: TAId): TDateTime;
begin
  Result := 0;
end;

function TAiSourceObject.GetFreimType(Id: TAId): TAId;
begin
  Result := 0;
end;

function TAiSourceObject.GetId(): AiSourceObject;
begin
  Result := AiSourceObject2005(Self);
end;

function TAiSourceObject.GetItemID(Index: Integer): TAId;
begin
  Result := 0;
end;

function TAiSourceObject.GetName(): string;
begin
  Result := FName;
end;

function TAiSourceObject.GetNextFreeFreimID(): TAId;
begin
  Result := FNextFreeFreimID;
  Inc(FNextFreeFreimID);
end;

function TAiSourceObject.GetOpened(): Boolean;
begin
  Result := FOpened;
end;

{function TAISource.GetName: WideString;
begin
  Result := FName;
end;}

function TAiSourceObject.GetParent(Index: UInt32): AiSourceObject2005;
begin
  if (Index >= UInt32(Length(FParents))) then
  begin
    Result := 0;
    Exit;
  end;

  {if not(Assigned(FParents[Index].Source)) then
  begin
    FParents[Index].Source := TAISource(GetSource.GetFreim(FParents[Index].Id));
  end;}
  Result := FParents[Index].Source;
end;

function TAiSourceObject.GetParentObj(Index: UInt32): TAiSourceObject;
begin
  if (Index >= UInt32(Length(FParents))) then
    Result := nil
  else
  begin
    {if not(Assigned(FParents[Index].Source)) then
    begin
      FParents[Index].Source := TAISource(GetSource.GetFreim(FParents[Index].Id));
    end;}
    Result := TObject(FParents[Index].Source) as TAiSourceObject;
  end;
end;

function TAiSourceObject.GetParentId(Index: AUInt32): TAId;
begin
  if Index >= UInt32(Length(FParents)) then
    Result := 0
  else
    Result := FParents[Index].Id;
end;

function TAiSourceObject.Get_Freim(Id: TAId): TAiFrameObject;
begin
  Result := GetFreim(Id);
end;

{function TAiSourceObject.Get_FreimName(): WideString;
begin
  Result := Self.FName;
end;}

{function TAiSourceObject.Get_FreimType(): TAI_Id;
begin
  Result := Self.FrameType;
end;}

{function TAiSourceObject.Get_Source(): IAISource;
begin
  Result := nil;
end;}

function TAiSourceObject.Init(Path: String; Log: TLog; Config: TConfig; Prefix: String): TError;
begin
  FConfig := Config;
  FLog := Log;
  FPath := Path;
  FPrefix := Prefix;
  Result := Initialize;
end;

function TAiSourceObject.Initialize(): AError;
begin
  Result := 0;
  if FInitialized then Exit;
  FInitialized := True;
  //Result := Load;
  Open();
end;

function TAiSourceObject.LoadFromFile(F: TFileProfKB; Path: String): TError;
begin
  Close;
  Result := 1;
  if not(Assigned(F)) or (Path = '') then Exit;
  {Далее обработка в дочерних классах}
  Result := 0;
end;

function TAiSourceObject.LoadFromFileN(Path, FileName: String): Boolean;
{var
  Count: UInt32;
  I: Int32;
  F: TFileProfKB;
  Freim: TAiFrameObject;
  Rec: TAIFreimRec;
  S: String;}
begin
  if (ExtractFilePath(FileName) = '') then
    FileName := Path + FileName;
  Result := LoadSourceFromFileN(Self, FileName, Path);

  (*F := TFileProfKB.Create;
  Result := F.Open(FileName, Path);
  if Result <> 0 then Exit;

  Count := F.GetHeaderKB.CountF;
  Freim := TAiFrame2005.Create(nil, 0);
  for I := 0 to Count - 1 do begin
    F.FreimRead(I, Rec);
    SetFreimRec(Rec.Id, Freim);
  end;
  Freim.Free;
  F.Close;
  F.Free;
  Result := 0;

  {Clear;
  AssignFile(F, FileName);
  HProf.Prof := 'Prof';
  HProf.Ident := 1;
  HProf.Version1 := 2;
  HProf.Version2 := 4;}*)
end;

function TAiSourceObject.LoadFromFileXml(FileName: String): TError;
{var
  //Freim: TAiFrame2005;
  I: Int32;
  Id: TAI_Id;
  {Xml: TMyXml;}
begin
  (*Xml := TMyXml.Create;
  Result := Xml.LoadFromFileText(FileName);
  for I := 0 to Xml.GetCountParams - 1 do begin
    Freim := TAiFrame2005.Create;
    Freim.LoadFromXml(Xml.GetParam(I));
    Id := Freim.GetId;
    if Id = 0 then begin
      Id := NewFreim(Freim.GetType);
      SetFreim(Id, Freim);
    end else
      SetFreim(Id, Freim);
  end;
  Xml.Free;*)
  Result := -1;
end;

function TAiSourceObject.LoadFromRecF64(Rec: TAIFreimRecF64): WordBool;
begin
  Result := False;
end;

function TAiSourceObject.NewFreim(Typ: TAId; Id: TAId = 0): TAId;
begin
  Result := 0;
  AddToLog(lgDataBase, ltError, Format(stNotOverrideA, ['NewFreim']));
end;

function TAiSourceObject.NewFreim2(Frame: TAiFrameObject): TAId;
begin
  Result := 0;
end;

function TAiSourceObject.NewFreimType(const AName: WideString; AStruct: PStructFreimType): TAId;
begin
  Result := 0;
  //AddToLog(lgDataBase, ltError, stNotOverrideA, ['NewFreimType']);
end;

function TAiSourceObject.Open(): TError;
begin
  FOpened := True;
  Result := 0;
end;

function TAiSourceObject.SaveToFile(F: TFileProfKB; Path: String): TError;
begin
  Result := 1;
  if (not(Assigned(F))) or (Path = '') then Exit;
  {Далее обработка в дочерних классах}
  Result := 0;
end;

function TAiSourceObject.SaveToFileN(FileName, Path: String): Boolean;
{var
  F: TFileProfKB;
  I: Int32;
  RecF: TAIFreimRecF64;}
begin
  Result := SaveSourceToFileN(Self, FileName, Path);
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

function TAiSourceObject.SaveToFileXml(FileName: String): Boolean;
{var
  Count: Int32;
  Freim: TAiFrame2005;
  I: Int32;
  //Node: TProfXmlNode;
  //Xml: TProfXmlDocument;}
  {Param: TMyXml;
  Xml: TMyXml;}
begin
  Result := False;
  {Xml := TProfXmlDocument.Create;
  try
    Xml.DocumentElement..NodeName := 'Freims';
    Count := GetCountFreims;
    for I := 0 to Count - 1 do begin
      Freim := TAiFrame2005(GetFreim(GetItemId(I)));
      if Assigned(Freim) then begin
        Node := Xml.DocumentElement.NewNode('Freim');
        Node.Xml := Freim.Xml;
        //Freim.SaveToXml(Node);
      end;
    end;
    Result := Xml.SaveToFile(FileName);
  finally
    Xml.Free;
  end;}
  // ---
  {Xml := TMyXml.Create;
  for I := 0 to High(FFreims) do begin
    Param := Xml.NewParam('Freim', '');
    GetFreim(I).SaveToXml(Param);
  end;
  Result := Xml.SaveToFileText(FileName);
  Xml.Free;}
end;

function TAiSourceObject.Select(AType: TAId): TAI_Select;
begin
  Result := nil;

  //Result := TAI_Select.Create('TYPE = '+cInt64ToStr(AType), nil, Log);
end;

procedure TAiSourceObject.SetFreim(Id: TAId; Value: TAiFrameObject);
begin
end;

function TAiSourceObject.SetFreimConnects(Id: TAId; Value: TAiConnectsObject): AError;
begin
  Result := -1;
end;

function TAiSourceObject.SetFreimData(Id: TAId; Data: TAiDataObject): AError;
begin
  Result := -1;
end;

function TAiSourceObject.SetFreimType(Id, Value: TAId): AError;
begin
  Result := -1;
end;

procedure TAiSourceObject.SetName(Value: String);
begin
  FName := Value;
end;

procedure TAiSourceObject.SetParent(Index: UInt32; Value: TAiSourceObject);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParents[Index].Source := AiSource2005(Value);
  if Assigned(Value) then
    FParents[Index].Id := Value.GetId
  else
    FParents[Index].Id := 0;
end;

procedure TAiSourceObject.SetParentId(Index: UInt32; Value: TAId);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParents[Index].Id := Value;
  FParents[Index].Source := 0;
end;

procedure TAiSourceObject.SetParentObj(Index: UInt32; Value: TAiSourceObject);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParents[Index].Id := Value.GetId();
  FParents[Index].Source := Value.GetId();
end;

{procedure TAiSourceObject.SetParentID(Index: UInt32; Value: TAI_ID);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParents[Index].Id := Value;
  FParents[Index].Source := nil;
end;}

{procedure TAiSourceObject.Set_FreimType(Value: TAI_Id);
begin
  Self.FFreimType := Value;
end;}

{procedure TAiSourceObject.Set_Source(const Value: IAISource);
begin
end;}

end.
