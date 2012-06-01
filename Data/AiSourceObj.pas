{**
@Abstract(Базовый класс для источника)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(30.05.2012)
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
    Id: TAI_Id;
    Source: AiSourceObject2005;
  end;

type // Recovered
  TAiSource2004 = class
  public
    function Count(): AInt32;
    function CountFreim_Get(): AInt;
    function F(Id: AInt64): TAiFrame2004; deprecated; // Use FreimGet()
    function FreimGet(Id: AInt32; Created: Boolean = False): TAiFrame2004; virtual;
    function FreimNew(Typ: AInt32): AInt32;
    function FreimSearch54(const Name: string): AInt32;
  end;

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
    function Get_Freim(Id: TAId): TAiFrame2005; virtual;
  public // from TAiSourceAbstractObject2005
    function ConnectAdd(Id, Con: TAI_Id): Int32; virtual; // deprecated
  public
    function GetFreim(Id: TAId): TAiFrame2005; virtual;
    function GetNextFreeFreimId(): TAId; virtual;
    function GetParent(Index: UInt32): AiSourceObject2005;
    function GetParentID(Index: UInt32): TAId;
    function GetParentObj(Index: UInt32): TAiSourceObject;
    procedure SetParentObj(Index: UInt32; Value: TAiSourceObject);
    //procedure SetParentID(Index: UInt32; Value: TAId);
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
    //** Проверяет и создает базовые фреймы Prof_AI_GLobals.AIFreims
    function CheckFreims(): Boolean;
    function Clear(): TError; virtual;
    function Close(): TError; virtual;
    constructor Create({Source: TAISource = nil; Id: TAId = 0});
    function Finalize(): TProfError; virtual;
    procedure Free(); virtual;
      // Произвести инициализацию с установкой параметров
    function Init(Path: String; Log: TLog; Config: TConfig; Prefix: String): TError; virtual;
    function Initialize(): TProfError; virtual;
    function LoadFromFileN(Path, FileName: String): Boolean;
    function LoadFromFileXml(FileName: String): TError;
    function Open(): TError; virtual;
    property ParentsObj[Index: UInt32]: TAiSourceObject read GetParentObj write SetParentObj;
    //property ParentsID[Index: UInt32]: TAId read GetParentId write SetParentId;
    function SaveToFileN(FileName, Path: String): Boolean;
    function SaveToFileXml(FileName: String): Boolean;
  public
    function GetActive(): Boolean;
    function GetCountFreims(): UInt64; virtual;
    function GetFreimConnects(Id: TAId): TAiConnectsObject; virtual;
    function GetFreimData(Id: TAId): TAiDataObject; virtual;
    function GetFreimDateTimeCreate(Id: TAId): TDateTime; virtual;
    function GetFreimType(Id: TAId): TAId; virtual;
    function GetId(): AiSourceObject;
    function GetItemID(Index: Integer): TAId; virtual;
    function GetName(): string;
    function GetOpened(): Boolean;
      //** Создает новый фрейм
    function NewFreim(Typ: TAId; Id: TAId = 0): TAId; virtual;
      //** Создает новый фрейм
    function NewFreim2(Frame: TAiFrameObject2005): TAI_Id; virtual;
    //** Сделать выборку по типу
    function Select(AType: TAId): TAiSelect; virtual;
    procedure SetFreim(ID: TAId; Value: TAiFrame2005); virtual;
    function SetFreimConnects(Id: TAId; Value: TAiConnectsObject): TError; virtual;
    function SetFreimData(Id: TAId; Data: TAiDataObject): TError; virtual;
    function SetFreimType(Id, Value: TAId): Boolean; virtual;
    //** Создает и регистрирует новый тип фрейма Если AStructure задан, то AName игнорируется
    function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAI_ID; virtual;
  public // IAIFreim
    //function Get_FreimName(): WideString;
    //function Get_FreimType(): TAId;
    //function Get_Source(): TAiSourceObject;
    function LoadFromRecF64(Rec: TAiFreimRecF64): WordBool;
    //procedure Set_FreimType(Value: TAI_Id);
    //procedure Set_Source(const Value: TAiSourceObject);
  public
    function Activate(): Boolean;
    function Deactivate(): Boolean;
  public
    property CountFreims: UInt64 read GetCountFreims;
    property FreimByID[ID: TAId]: TAiFrame2005 read GetFreim write SetFreim;
    property Freims[ID: TAId]: TAiFrame2005 read Get_Freim write SetFreim;
    property Id: TAId read FId;
    property NextFreeFreimID: TAId read GetNextFreeFreimID;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
  end;
  TAiSource = TAiSourceObject;

  TAiSourceAbstractObject2005 = class(TAiSourceObject)
  public
    function ConnectCount(Id: TAI_Id): TError; virtual; // deprecated
    function ConnectDelete(Id, Con: TAI_Id): TError; virtual; // deprecated
    function ConnectDeleteI(Id: TAI_Id; Index: UInt32): TError; virtual; // deprecated
    function ConnectGet(Id: TAI_Id; Index: UInt32): TAI_Id; virtual; // deprecated
    function ConnectIndexGet(Id, Con: TAI_Id): Int32; virtual; // deprecated
    constructor Create(Source: AiSourceObject; Id: TAI_Id = 0);
    function DataClear(Id: TAI_Id): TError; virtual; // deprecated
    {function DataRead(Id: TAI_Id; var Buf: TArrayByte; Count: UInt64; Seek: UInt64): UInt64; virtual;
    function DataReadFloat32(Id: TAI_Id; var Value: Float32; Seek: UInt64): TError; virtual;
    function DataReadFloat64(Id: TAI_Id; var Value: Float64; Seek: UInt64): TError; virtual;
    function DataReadInt08(Id: TAI_Id; var Value: Int08; Seek: UInt64): TError; virtual;
    function DataReadInt16(Id: TAI_Id; var Value: Int16; Seek: UInt64): TError; virtual;
    function DataReadInt32(Id: TAI_Id; var Value: Int32; Seek: UInt64): TError; virtual;
    function DataReadInt64(Id: TAI_Id; var Value: Int64; Seek: UInt64): TError; virtual;
    function DataReadUInt08(Id: TAI_Id; var Value: UInt08; Seek: UInt64): TError; virtual;
    function DataReadUInt16(Id: TAI_Id; var Value: UInt16; Seek: UInt64): TError; virtual;
    function DataReadUInt32(Id: TAI_Id; var Value: UInt32; Seek: UInt64): TError; virtual;
    function DataReadUInt64(Id: TAI_Id; var Value: UInt64; Seek: UInt64): TError; virtual;}
    function DataSize(Id: TAI_Id): UInt64; virtual; // deprecated
    {function DataWrite(Id: TAI_Id; const Buf: TArrayByte; Count: UInt64; Seek: UInt64): UInt64; virtual;
    function DataWriteFloat32(Id: TAI_Id; Value: Float32; Seek: UInt64): TError; virtual;
    function DataWriteFloat64(Id: TAI_Id; Value: Float64; Seek: UInt64): TError; virtual;
    function DataWriteInt08(Id: TAI_Id; Value: Int08; Seek: UInt64): TError; virtual;
    function DataWriteInt16(Id: TAI_Id; Value: Int16; Seek: UInt64): TError; virtual;
    function DataWriteInt32(Id: TAI_Id; Value: Int32; Seek: UInt64): TError; virtual;
    function DataWriteInt64(Id: TAI_Id; Value: Int64; Seek: UInt64): TError; virtual;
    function DataWriteUInt08(Id: TAI_Id; Value: UInt08; Seek: UInt64): TError; virtual;
    function DataWriteUInt16(Id: TAI_Id; Value: UInt16; Seek: UInt64): TError; virtual;
    function DataWriteUInt32(Id: TAI_Id; Value: UInt32; Seek: UInt64): TError; virtual;
    function DataWriteUInt64(Id: TAI_Id; Value, Seek: UInt64): TError; virtual;}
    function FreimFree(Id: TAI_Id): Boolean; virtual; // deprecated
    function GetItemId(Index: UInt32): TAI_Id; virtual;
    function GetOpened: Boolean;
    //function Init(const APath: APascalString; ALog: TLog; AConfig: TConfig; APrefix: APascalString): TError;
    function Initialize: TError; virtual;
    function NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id; virtual;
    function Open: TError; virtual;
    function SetFreim(Id: TAI_Id; Value: TAiFrame2005): TError; virtual;
    function SetFreimConnects(Id: TAI_Id; Value: TAiConnectsObject): TError; virtual;
    function SetFreimData(Id: TAI_Id; Data: TAiDataObject2005): TError; virtual;
    function SetFreimType(Id, Value: TAI_Id): TError; virtual;
  end;

  //TAiSource2005 = TAiSourceAbstractObject2005;
  TAiSourceObject2005 = class(TAiSourceAbstractObject2005) {256}
  public
    constructor Create(Source: AiSourceObject; Id: TAI_Id = 0);
    function GetName(): String;
    function GetParentId(Index: UInt32): TAI_Id;
    function LoadFromFileN(Path, FileName: String): TError;
    function LoadFromFileXml(FileName: String): TError;
    function SaveToFileN(FileName, Path: String): TError;
    function SaveToFileXml(FileName: String): TError;
    procedure SetName(Value: String);
    procedure SetParent(Index: UInt32; Value: TAiSourceObject2005);
    procedure SetParentId(Index: UInt32; Value: TAI_Id);
  public
    {function ConnectAdd(Id, Con: TAI_Id): Int32; virtual;
    function ConnectCount(Id: TAI_Id): TError; virtual;
    function ConnectDelete(Id, Con: TAI_Id): TError; virtual;
    function ConnectDeleteI(Id: TAI_Id; Index: UInt32): TError; virtual;
    function ConnectGet(Id: TAI_Id; Index: UInt32): TAI_Id; virtual;
    function ConnectIndexGet(Id, Con: TAI_Id): Int32; virtual;}
  end;
  TAiSource2005 = TAiSourceObject2005;

  TAiSourceObject20050819 = class(TAiSourceObject2005{TAiFrameObject2005})
  private
    FOpened: Boolean;
  public
    function Close: TError; virtual;
    {function ConnectAdd(Id, Con: TAI_Id): Int32; virtual;
    function ConnectCount(Id: TAI_Id): TError; virtual;
    function ConnectDelete(Id, Con: TAI_Id): TError; virtual;
    function ConnectDeleteI(Id: TAI_Id; Index: UInt32): TError; virtual;
    function ConnectGet(Id: TAI_Id; Index: UInt32): TAI_Id; virtual;
    function ConnectIndexGet(Id, Con: TAI_Id): Int32; virtual;}
    {function DataClear(Id: TAI_Id): TError; virtual;
    function DataRead(Id: TAI_Id; var Buf: TArrayByte; Count: UInt64; Seek: UInt64): UInt64; virtual;
    function DataReadFloat32(Id: TAI_Id; var Value: Float32; Seek: UInt64): TError; virtual;
    function DataReadFloat64(Id: TAI_Id; var Value: Float64; Seek: UInt64): TError; virtual;
    function DataReadInt08(Id: TAI_Id; var Value: Int08; Seek: UInt64): TError; virtual;
    function DataReadInt16(Id: TAI_Id; var Value: Int16; Seek: UInt64): TError; virtual;
    function DataReadInt32(Id: TAI_Id; var Value: Int32; Seek: UInt64): TError; virtual;
    function DataReadInt64(Id: TAI_Id; var Value: Int64; Seek: UInt64): TError; virtual;
    function DataReadUInt08(Id: TAI_Id; var Value: UInt08; Seek: UInt64): TError; virtual;
    function DataReadUInt16(Id: TAI_Id; var Value: UInt16; Seek: UInt64): TError; virtual;
    function DataReadUInt32(Id: TAI_Id; var Value: UInt32; Seek: UInt64): TError; virtual;
    function DataReadUInt64(Id: TAI_Id; var Value: UInt64; Seek: UInt64): TError; virtual;
    function DataSize(Id: TAI_Id): UInt64; virtual;
    function DataWrite(Id: TAI_Id; const Buf: TArrayByte; Count: UInt64; Seek: UInt64): UInt64; virtual;
    function DataWriteFloat32(Id: TAI_Id; Value: Float32; Seek: UInt64): TError; virtual;
    function DataWriteFloat64(Id: TAI_Id; Value: Float64; Seek: UInt64): TError; virtual;
    function DataWriteInt08(Id: TAI_Id; Value: Int08; Seek: UInt64): TError; virtual;
    function DataWriteInt16(Id: TAI_Id; Value: Int16; Seek: UInt64): TError; virtual;
    function DataWriteInt32(Id: TAI_Id; Value: Int32; Seek: UInt64): TError; virtual;
    function DataWriteInt64(Id: TAI_Id; Value: Int64; Seek: UInt64): TError; virtual;
    function DataWriteUInt08(Id: TAI_Id; Value: UInt08; Seek: UInt64): TError; virtual;
    function DataWriteUInt16(Id: TAI_Id; Value: UInt16; Seek: UInt64): TError; virtual;
    function DataWriteUInt32(Id: TAI_Id; Value: UInt32; Seek: UInt64): TError; virtual;
    function DataWriteUInt64(Id: TAI_Id; Value, Seek: UInt64): TError; virtual;}
    procedure Free; override;
    {function FreimFree(Id: TAI_Id): Boolean; virtual;}
    function GetCountFreims: UInt64; virtual;
    function GetFreim(Id: TAI_Id): TAiFrameObject2005; virtual;
    function GetFreimConnects(Id: TAI_Id): TAiConnectsObject20050819; virtual;
    function GetFreimData(Id: TAI_Id): TAiDataObject2005; virtual;
    function GetFreimType(Id: TAI_Id): TAI_Id; virtual;
    function GetItemId(Index: UInt32): TAI_Id; virtual;
    function GetOpened: Boolean;
    function NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id; virtual;
    function SetFreim(Id: TAI_Id; Value: TAiFrameObject2005): TError; virtual;
    function SetFreimConnects(Id: TAI_Id; Value: TAiConnectsObject20050819): TError; virtual;
    function SetFreimData(Id: TAI_Id; Data: TAiDataObject2005): TError; virtual;
    function SetFreimType(Id, Value: TAI_Id): TError; virtual;
  end;

  //TAiSourceObject20050911 = TAiSourceObject2005;
  //TAiSourceObject20050915 = TAiSourceObject2005;
  //TAiSource20050915 = TAiSourceObject2005;

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

function TAiSource2004.F(Id: AInt64): TAiFrame2004;
begin
  Result := FreimGet(Id);
end;

function TAiSource2004.FreimGet(Id: AInt32; Created: Boolean): TAiFrame2004;
begin
  Result := nil;
end;

function TAiSource2004.FreimNew(Typ: AInt32): AInt32;
begin
  Result := 0;
end;

function TAiSource2004.FreimSearch54(const Name: string): AInt32;
begin
  Result := 0;
end;

{ TAiSource2005 }

constructor TAiSourceObject2005.Create(Source: AiSourceObject; Id: TAI_Id);
begin
  inherited Create(Source, Id);
  FOpened := False;
  {FParent := Parent;
  if not(Assigned(FParent)) then
    FParentId := ParentId
  else
    FParentId := FParent.FreimId;}
  {FSearch := TKBSearch.Create;
  FSelect := TKBSelect.Create(Source, 0);}
end;

function TAiSourceObject2005.GetName(): String;
begin
  Result := FName;
end;

function TAiSourceObject2005.GetParentId(Index: UInt32): TAI_Id;
begin
  if Index >= UInt32(Length(FParents)) then
    Result := 0
  else
    Result := FParents[Index].Id;
end;

function TAiSourceObject2005.LoadFromFileN(Path, FileName: String): TError;
var
  Count: UInt32;
  I: Int32;
  {F: TFileProfKB;}
  Freim: TAiFrameObject2005;
  Rec: TAIFreimRec;
{var
  Count: UInt32;
  F: file;
  HProf: TFileProfHeader;
  HKB: TFileProfKBHeader;
  Rec: TAIFreimRec;}
  S: String;
begin
  if ExtractFilePath(FileName) = '' then FileName := Path + FileName;
  Result := LoadSourceFromFileN2005(Self, FileName, Path);

  (*F := TFileProfKB.Create;
  Result := F.Open(FileName, Path);
  if Result <> 0 then Exit;

  Count := F.GetHeaderKB.CountF;
  Freim := TAI_Freim.Create(nil, 0);
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

function TAiSourceObject2005.LoadFromFileXml(FileName: String): TError;
var
  Freim: TAiFrameObject2005;
  I: Int32;
  Id: TAI_Id;
  {Xml: TMyXml;}
begin
  (*Xml := TMyXml.Create;
  Result := Xml.LoadFromFileText(FileName);
  for I := 0 to Xml.GetCountParams - 1 do begin
    Freim := TAI_Freim.Create;
    Freim.LoadFromXml(Xml.GetParam(I));
    Id := Freim.GetId;
    if Id = 0 then begin
      Id := NewFreim(Freim.GetType);
      SetFreim(Id, Freim);
    end else
      SetFreim(Id, Freim);
  end;
  Xml.Free;*)
  Result := 1;
end;

function TAiSourceObject2005.SaveToFileN(FileName, Path: String): TError;
{var
  F: TFileProfKB;
  I: Int32;
  RecF: TAIFreimRecF64;}
begin
  Result := SaveSourceToFileN2005(Self, FileName, Path);
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

function TAiSourceObject2005.SaveToFileXml(FileName: String): TError;
var
  I: Int32;
  {Param: TMyXml;
  Xml: TMyXml;}
begin
  {Xml := TMyXml.Create;
  for I := 0 to High(FFreims) do begin
    Param := Xml.NewParam('Freim', '');
    GetFreim(I).SaveToXml(Param);
  end;
  Result := Xml.SaveToFileText(FileName);
  Xml.Free;}
  Result := 1;
end;

procedure TAiSourceObject2005.SetName(Value: String);
begin
  FName := Value;
end;

procedure TAiSourceObject2005.SetParent(Index: UInt32; Value: TAiSource2005);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParents[Index].Source := AiSource2005(Value);
  if Assigned(Value) then
    FParents[Index].Id := Value.GetId
  else
    FParents[Index].Id := 0;
end;

procedure TAiSourceObject2005.SetParentId(Index: UInt32; Value: TAI_Id);
begin
  if Index >= UInt32(Length(FParents)) then Exit;
  FParents[Index].Id := Value;
  FParents[Index].Source := 0;
end;

{ TAiSourceAbstractObject2005 }

function TAiSourceAbstractObject2005.ConnectCount(Id: TAI_Id): TError;
begin
  Result := 0;
end;

function TAiSourceAbstractObject2005.ConnectDelete(Id, Con: TAI_Id): TError;
begin
  Result := 1;
end;

function TAiSourceAbstractObject2005.ConnectDeleteI(Id: TAI_Id; Index: UInt32): TError;
begin
  Result := 1;
end;

function TAiSourceAbstractObject2005.ConnectGet(Id: TAI_Id; Index: UInt32): TAI_Id;
begin
  Result := 0;
end;

function TAiSourceAbstractObject2005.ConnectIndexGet(Id, Con: TAI_Id): Int32;
begin
  Result := -1;
end;

constructor TAiSourceAbstractObject2005.Create(Source: AiSourceObject; Id: TAI_Id);
begin
  inherited Create(); //(AiSource2005(Source), Id);
  FOpened := False;
end;

function TAiSourceAbstractObject2005.DataClear(Id: TAI_Id): TError;
begin
  Result := 1;
end;

{function TAiSource2005.DataRead(Id: TAI_Id; var Buf: TArrayByte; Count: UInt64; Seek: UInt64): UInt64;
begin
  Result := 0;
end;

function TAiSource2005.DataReadFloat32(Id: TAI_Id; var Value: Float32; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadFloat64(Id: TAI_Id; var Value: Float64; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadInt08(Id: TAI_Id; var Value: Int08; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadInt16(Id: TAI_Id; var Value: Int16; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadInt32(Id: TAI_Id; var Value: Int32; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadInt64(Id: TAI_Id; var Value: Int64; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadUInt08(Id: TAI_Id; var Value: UInt08; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadUInt16(Id: TAI_Id; var Value: UInt16; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadUInt32(Id: TAI_Id; var Value: UInt32; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAiSource2005.DataReadUInt64(Id: TAI_Id; var Value: UInt64; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;}

function TAiSourceAbstractObject2005.DataSize(Id: TAI_Id): UInt64;
begin
  Result := 0;
end;

{function TAiSource2005.DataWrite(Id: TAI_Id; const Buf: TArrayByte; Count, Seek: UInt64): UInt64;
begin
  Result := 0;
end;

function TAiSource2005.DataWriteFloat32(Id: TAI_Id; Value: Float32; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteFloat64(Id: TAI_Id; Value: Float64; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteInt08(Id: TAI_Id; Value: Int08; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteInt16(Id: TAI_Id; Value: Int16; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteInt32(Id: TAI_Id; Value: Int32; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteInt64(Id: TAI_Id; Value: Int64; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteUInt08(Id: TAI_Id; Value: UInt08; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteUInt16(Id: TAI_Id; Value: UInt16; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteUInt32(Id: TAI_Id; Value: UInt32; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAiSource2005.DataWriteUInt64(Id: TAI_Id; Value, Seek: UInt64): TError;
begin
  Result := 1;
end;}

function TAiSourceAbstractObject2005.FreimFree(Id: TAI_Id): Boolean;
begin
  Result := True;
end;

function TAiSourceAbstractObject2005.GetItemId(Index: UInt32): TAI_Id;
begin
  Result := 0;
end;

function TAiSourceAbstractObject2005.GetOpened: Boolean;
begin
  Result := FOpened;
end;

{function TAiSourceAbstractObject2005.Init(const APath: APascalString;
  ALog: TLog; AConfig: TConfig; APrefix: APascalString): TError;
begin
  Result := Initialize();
end;}

function TAiSourceAbstractObject2005.Initialize: TError;
begin
  Result := 0;
  if FInitialized then Exit;
  FInitialized := True;
  //Result := Load;
  //Result := inherited Initialize;
  Open;
end;

function TAiSourceAbstractObject2005.NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id;
begin
  Result := 0;
end;

function TAiSourceAbstractObject2005.Open: TError;
begin
  FOpened := True;
  Result := 0;
end;

function TAiSourceAbstractObject2005.SetFreim(Id: TAI_Id; Value: TAiFrame2005): TError;
begin
  Result := 1;
end;

function TAiSourceAbstractObject2005.SetFreimConnects(Id: TAI_Id; Value: TAiConnectsObject): TError;
begin
  Result := 1;
end;

function TAiSourceAbstractObject2005.SetFreimData(Id: TAI_Id; Data: TAiDataObject2005): TError;
begin
  Result := 1;
end;

function TAiSourceAbstractObject2005.SetFreimType(Id, Value: TAI_Id): TError;
begin
  Result := 1;
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
  Freim: TAiFrame2005;
  I: Int32;
begin
  // TODO: Где-то здесь ошибка, приводящая к зависанию
  AddToLog(lgDataBase, ltInformation, stCheckFreimsStart);
  for I := 0 to High(AIFreims) do
  begin
    Freim := TAiFrame2005(GetFreim(AIFreims[I].Id));
    if not(Assigned(Freim)) and (AIFreims[I].Id > 0) then
    try
      AddToLog(lgDataBase, ltInformation, Format(stCheckFreimsCreate, [AIFreims[I].Id, AIFreims[I].Typ, AIFreims[I].ConnectCount, RUS_DATA_TYPE[AIFreims[I].DataType], AIFreims[I].Descript]));
      // Создание фрейма
      Freim := TAiFrame2005(GetFreim(NewFreim(AIFreims[I].Typ, AIFreims[I].Id)));
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

function TAiSourceObject.Close(): TError;
begin
  Result := Clear();
end;

function TAiSourceObject.ConnectAdd(Id, Con: TAI_Id): Int32;
begin
  Result := -1;
end;

constructor TAiSourceObject.Create({Source: TAISource = nil; Id: TAI_Id = 0});
begin
  inherited Create();
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

function TAiSourceObject.GetActive(): Boolean;
begin
  Result := FOpened;
end;

function TAiSourceObject.GetCountFreims(): UInt64;
begin
  Result := 0;
end;

function TAiSourceObject.GetFreim(Id: TAId): TAiFrame2005;
begin
  Result := nil;
  AddToLog(lgDataBase, ltError, Format(stNotOverrideA, ['GetFreim']));
end;

function TAiSourceObject.GetFreimConnects(Id: TAId): TAiConnectsObject;
begin
  Result := TAiConnectsObject.Create();
end;

function TAiSourceObject.GetFreimData(Id: TAI_Id): TAiDataObject;
var
  Freim: TAiFrameObject2005;
begin
  {Result := TAiDataObject20050911.Create(Id);}
  Freim := GetFreim(Id);
  if not(Assigned(Freim)) then
  begin
    Result := TAiDataObject2005.Create(0, dtNone);
    Exit;
  end;
  Result := Freim.GetData;
  AddToLog(lgDataBase, ltInformation, Format(stNotOverrideA, ['GetFreimData']));
end;

function TAiSourceObject.GetFreimDateTimeCreate(Id: TAI_ID): TDateTime;
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

function TAiSourceObject.GetItemID(Index: Integer): TAI_ID;
begin
  Result := 0;
end;

function TAiSourceObject.GetName(): string;
begin
  Result := FName;
end;

function TAiSourceObject.GetNextFreeFreimID(): TAI_ID;
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

function TAiSourceObject.GetParentID(Index: UInt32): TAI_ID;
begin
  if Index >= UInt32(Length(FParents)) then
    Result := 0
  else
    Result := FParents[Index].Id;
end;

function TAiSourceObject.Get_Freim(Id: TAId): TAiFrame2005;
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

function TAiSourceObject.Initialize(): TProfError;
begin
  Result := 0;
  Open();
end;

function TAiSourceObject.LoadFromFileN(Path, FileName: String): Boolean;
//var
  //Count: UInt32;
  //I: Int32;
  {F: TFileProfKB;}
  //Freim: TAiFrame2005;
  //Rec: TAIFreimRec;
{var
  Count: UInt32;
  F: file;
  HProf: TFileProfHeader;
  HKB: TFileProfKBHeader;
  Rec: TAIFreimRec;}
  //S: String;
begin
  if ExtractFilePath(FileName) = '' then FileName := Path + FileName;
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
  Result := -1;
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
end;

function TAiSourceObject.LoadFromRecF64(Rec: TAIFreimRecF64): WordBool;
begin
  Result := False;
end;

function TAiSourceObject.Open(): TError;
begin
  FOpened := True;
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
end;

{procedure TAISource.SetName(Value: WideString);
begin
  FName := Value;
end;}

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

function TAiSourceObject.NewFreim(Typ: TAI_ID; Id: TAI_ID = 0): TAI_ID;
begin
  Result := 0;
  AddToLog(lgDataBase, ltError, Format(stNotOverrideA, ['NewFreim']));
end;

function TAiSourceObject.NewFreim2(Frame: TAiFrameObject2005): TAI_Id;
begin
  Result := 0;
end;

function TAiSourceObject.NewFreimType(const AName: WideString; AStruct: PStructFreimType): TAI_ID;
begin
  Result := 0;
  //AddToLog(lgDataBase, ltError, stNotOverrideA, ['NewFreimType']);
end;

function TAiSourceObject.Select(AType: TAI_Id): TAI_Select;
begin
  Result := nil;

  //Result := TAI_Select.Create('TYPE = '+cInt64ToStr(AType), nil, Log);
end;

procedure TAiSourceObject.SetFreim(Id: TAId; Value: TAiFrame2005);
begin
end;

function TAiSourceObject.SetFreimConnects(Id: TAI_Id; Value: TAiConnectsObject): TError;
begin
  Result := -1;
end;

function TAiSourceObject.SetFreimData(Id: TAId; Data: TAiDataObject): TError;
begin
  Result := -1;
end;

function TAiSourceObject.SetFreimType(Id, Value: TAI_Id): Boolean;
begin
  //Self.FFreimType := Value;
  Result := True;
end;

{procedure TAiSourceObject.Set_FreimType(Value: TAI_Id);
begin
  Self.FFreimType := Value;
end;}

{procedure TAiSourceObject.Set_Source(const Value: IAISource);
begin
end;}

{ TAiSource20050819 }

function TAiSourceObject20050819.Close: TError;
begin
  FOpened := False;
  Result := 0;
end;

{function TAI_Source.ConnectAdd(Id, Con: TAI_Id): Int32;
begin
  Result := -1;
end;

function TAI_Source.ConnectCount(Id: TAI_Id): TError;
begin
  Result := 0;
end;

function TAI_Source.ConnectDelete(Id, Con: TAI_Id): TError;
begin
  Result := 1;
end;

function TAI_Source.ConnectDeleteI(Id: TAI_Id; Index: UInt32): TError;
begin
  Result := 1;
end;

function TAI_Source.ConnectGet(Id: TAI_Id; Index: UInt32): TAI_Id;
begin
  Result := 0;
end;

function TAI_Source.ConnectIndexGet(Id, Con: TAI_Id): Int32;
begin
  Result := -1;
end;}

{function TAI_Source.DataClear(Id: TAI_Id): TError;
begin
  Result := 1;
end;

function TAI_Source.DataRead(Id: TAI_Id; var Buf: TArrayByte; Count: UInt64; Seek: UInt64): UInt64;
begin
  Result := 0;
end;

function TAI_Source.DataReadFloat32(Id: TAI_Id; var Value: Float32; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadFloat64(Id: TAI_Id; var Value: Float64; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadInt08(Id: TAI_Id; var Value: Int08; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadInt16(Id: TAI_Id; var Value: Int16; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadInt32(Id: TAI_Id; var Value: Int32; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadInt64(Id: TAI_Id; var Value: Int64; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadUInt08(Id: TAI_Id; var Value: UInt08; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadUInt16(Id: TAI_Id; var Value: UInt16; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadUInt32(Id: TAI_Id; var Value: UInt32; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataReadUInt64(Id: TAI_Id; var Value: UInt64; Seek: UInt64): TError;
begin
  Result := 1;
  Value := 0;
end;

function TAI_Source.DataSize(Id: TAI_Id): UInt64;
begin
  Result := 0;
end;

function TAI_Source.DataWrite(Id: TAI_Id; const Buf: TArrayByte; Count, Seek: UInt64): UInt64;
begin
  Result := 0;
end;

function TAI_Source.DataWriteFloat32(Id: TAI_Id; Value: Float32; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteFloat64(Id: TAI_Id; Value: Float64; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteInt08(Id: TAI_Id; Value: Int08; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteInt16(Id: TAI_Id; Value: Int16; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteInt32(Id: TAI_Id; Value: Int32; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteInt64(Id: TAI_Id; Value: Int64; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteUInt08(Id: TAI_Id; Value: UInt08; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteUInt16(Id: TAI_Id; Value: UInt16; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteUInt32(Id: TAI_Id; Value: UInt32; Seek: UInt64): TError;
begin
  Result := 1;
end;

function TAI_Source.DataWriteUInt64(Id: TAI_Id; Value, Seek: UInt64): TError;
begin
  Result := 1;
end;}

procedure TAiSourceObject20050819.Free;
begin
  inherited Free;
end;

{function TAI_Source.FreimFree(Id: TAI_Id): Boolean;
begin
  Result := True;
end;}

function TAiSourceObject20050819.GetCountFreims: UInt64;
begin
  Result := 0;
end;

function TAiSourceObject20050819.GetFreim(Id: TAI_Id): TAiFrameObject2005;
begin
  Result := nil;
end;

function TAiSourceObject20050819.GetFreimConnects(Id: TAI_Id): TAiConnectsObject20050819;
begin
  Result := TAiConnectsObject20050819.Create;
end;

function TAiSourceObject20050819.GetFreimData(Id: TAI_Id): TAiDataObject2005;
begin
  Result := TAiDataObject2005.Create(Id);
end;

function TAiSourceObject20050819.GetFreimType(Id: TAI_Id): TAI_Id;
begin
  Result := 0;
end;

function TAiSourceObject20050819.GetItemId(Index: UInt32): TAI_Id;
begin
  Result := 0;
end;

function TAiSourceObject20050819.GetOpened: Boolean;
begin
  Result := FOpened;
end;

function TAiSourceObject20050819.NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id;
begin
  Result := 0;
end;

function TAiSourceObject20050819.SetFreim(Id: TAI_Id; Value: TAiFrameObject2005): TError;
begin
  Result := 1;
end;

function TAiSourceObject20050819.SetFreimConnects(Id: TAI_Id; Value: TAiConnectsObject20050819): TError;
begin
  Result := 1;
end;

function TAiSourceObject20050819.SetFreimData(Id: TAI_Id; Data: TAiDataObject2005): TError;
begin
  Result := 1;
end;

function TAiSourceObject20050819.SetFreimType(Id, Value: TAI_Id): TError;
begin
  Result := 1;
end;

end.
