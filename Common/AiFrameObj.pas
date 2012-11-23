{**
@Abstract Базовые типы для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 26.04.2006
@LastMod 23.11.2012

Prototype: org.framerd.OID
Каждый фрейм является некоторой сущностью.
}
unit AiFrameObj;

interface

uses
  SysUtils,
  ABase, ABaseUtils2, AConfigObj, ALogObj, ATypes, AXmlObj,
  AiBase, AiBaseTypes, AiConnectsObj, AiDataObj, AiTypes;

type
    // Recovered
  TAiSlot2004 = class
  public
    function GetAsInt32(): AInt32;
    function GetAsString(): string;
    function GetAsUInt32(): AUInt32;
    function GetAsUInt64(): AUInt64;
    function GetValueAsHandle(): AInt32;
    function GetValueAsString(): APascalString;
    procedure SetAsString(const Value: string);
    procedure SetAsUInt32(Value: AUInt32);
    procedure SetAsUInt64(Value: AUInt64);
    procedure SetValueAsString(const Value: APascalString);
  public
    property AsInt032: AInt32 read GetAsInt32;
    property AsString: string read GetAsString write SetAsString;
    property AsUInt032: AUInt32 read GetAsUInt32 write SetAsUInt32;
    property AsUInt064: AUInt64 read GetAsUInt64 write SetAsUInt64;
    property ValueAsHandle: AInt32 read GetValueAsHandle;
    property ValueAsString: APascalString read GetValueAsString write SetValueAsString;
  end;

type //** Фрейм
  TAiFrameObject = class
  protected
      //** Идентификатор (см. TProfEntity)
    FId: TAId;
      //** True, если инициализирован
    FInitialized: Boolean;
  protected
      //** Класс конфигураций (deprecated)
    FConfig: TConfig;
      //** Связи - объект источника. Если источника нет - локальный объект (deprecated)
    FConnects: TAiConnectsObject;
      //** Данные - объект источника. Если источника нет - локальный объект
    FData: TAiDataObject;
      //** Дата создания
    FDateCreate: TDateTime; //FDateTimeCreate: TDateTime;
      //** Дата изменения
    FDateModify: TDateTime;
      //** Тип фрейма
    FFreimType: TAId; //FType: TAI_Id;
      //** Класс логирования (deprecated)
    FLog: TLog;
      //** Функция добавления в log (deprecated)
    FOnAddToLog: TAddToLog;
      //** Путь расположения программы (deprecated)
    FPath: String;
      //** Префикс для конфигураций и логирования (deprecated)
    FPrefix: String;
      //** Пул (Источник)
    FPool: AiPool;
      //** Источник
    FSource: AiSourceObject;
      //** Версия фрейма
    FVersion: TAiVersion;
  protected
    function Get_Connects(): TAiConnectsObject;
    //** Возвращает объект работы с данными
    function Get_Data(): TAiDataObject; virtual; safecall;
    //** Возвращает дату создания
    function Get_DateTimeCreate(): TDateTime; safecall;
    //** Возвращает ID фрейма
    function Get_FrameID(): TAId; safecall;
    //** Возвращает имя фрейма
    function Get_FrameName(): WideString; safecall;
    //** Возвращает тип фрейма
    function Get_FrameType(): TAId; safecall;
    function Get_FreimName(): WideString;
    function Get_FreimType(): TAId;
    function Get_IsReadOnly(): WordBool; safecall;
    //** Возвращает источник
    //function Get_Pool(): IAIFramePool; safecall;
    {**
      Зачитывает из пула данные фрейма.
      The method getValue retrieves an OID's value from the pool in which it resides.
    }
    //function Get_Source(): TAiSource;
    //function GetValue(): IAiValue; safecall;
    //** Установыть дату создания
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    //** Установить Id. Если не инициализирован.
    procedure Set_FrameID(Value: TAId); safecall;
    //** Установить тип
    procedure Set_FrameType(Value: TAId); safecall;
    procedure Set_FreimType(Value: TAId);
    //** Установить источник. Только если не инициализирован.
    //procedure Set_Pool(const Value: IAIFramePool); safecall;
    //procedure Set_Source(const Value: IAISource);
    {**
      Заменяет значение ассоциируемого с фреймом
      The method setValue changes value associated with an OID.
    }
    //procedure SetValue(Value: IAIValue);
  protected
      //** Срабатывает при создании
    procedure DoCreate(); virtual;
  public
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt;
      //** Очистить объект
    function Clear(): AError; virtual;
      //** Загрузить конфигурации
    function ConfigureLoad(Config: TConfig; Prefix: String): AError; virtual;
      //** Загрузить конфигурации
    function ConfigureLoad1(): Boolean; virtual;
      //** Сохранить конфигурации
    function ConfigureSave(Config: TConfig; Prefix: String): AError; virtual;
      //** Сохранить конфигурации
    function ConfigureSave1(): Boolean; virtual;
      {** Adds association connect to frame
          @return(Assosiation connects count) }
    function ConnectAdd(Id: TAId): AInt;
      {** Get association identifier (from TAiFrame2004)
          @return(association identifier) }
    function ConnectGet(Index: AInt): AInt64;
      //** Финализировать. Разорвать связь объекта с источником.
    function Finalize(): AError; virtual;
      //** Free
    procedure Free(); virtual;
    //function GetConfig(): IProfNode; safecall;
      {** Return associations count (from TAiFrame2004)
          @return(associations count) }
    function GetConnectCount(): AInt32;
      //** Возвращает класс работы со связями
    function GetConnects(): TAiConnectsObject;
      //** Возвращает класс работы с данными
    function GetData(): TAiDataObject;
      //** Возвращает дату создания
    function GetDateTimeCreate(): TDateTime;
      //** Возвращает тип фрейма
    function GetFreimType(): TAId;
      {**
        Return frame identirier
        return(frame identifier)
      }
    function GetId(): TAId;
      //** Инициализирован?
    function GetInitialized(): Boolean;
      {** Get frame identifier (from TAiFrame2004)
          @return(frame identifier) }
    function GetHandle(): AInt32;
      //** Возвращает источник
    function GetSource(): AiSourceObject;
      {** Get frame type (from TAiFrame2004)
          @return(frame type) }
    function GetTyp(): AInt32;
      //** Возвращает тип фрейма
    function GetType(): TAId;
      //** Возвращает фрейм в виде XML строки
    function GetXml(): WideString; virtual;
      //** Производит инициализацию с установкой параметров
    function Init(Path: String; Log: TLog; Config: TConfig; Prefix: String): AError; virtual;
      //** Произвести инициализацию. Установить связь с источником.
    function Initialize(): AError; virtual;
    {**
      Load from source
      Загрузить из источника
    }
    function Load(): AError; virtual;
      //** Загрузить из AIData
    function LoadFromData(Data: TAiDataObject): TAiError; virtual;
      //** Загрузить из файла
    function LoadFromFile(const AFileName: WideString): AError; virtual;
      //** Load from TAiFreimRecF64 struct
    function LoadFromRecF64(Rec: TAiFreimRecF64): AError;
      //** Load from TProfXml object
    function LoadFromXml(Xml: TProfXml): AError; virtual;
      {** Get slot by name (from TAiFrame2004)
          @return(slot) }
    function P(const Name: APascalString): TAiSlot2004;
    function P2(const Name, DefValue: APascalString): TAiSlot2004;
      //** Зарегистрировать тип фрейма в источнике
    function Regist(): AError; virtual;
    {**
      Save to source
      Сохранить в источник
    }
    function Save(): AError; virtual;
      //** Сохранить в файл
    function SaveToFile(const AFileName: WideString): WordBool; virtual;
      //** Save to TAiFreimRecF64 struct
    function SaveToRecF64(var Rec: TAiFreimRecF64): AError;
      //** Сохранить список связей в XML
    function SaveToXml(Xml: TProfXml): AError; virtual;
      //** Задать дату и время создания фрейма
    procedure SetDateTimeCreate(Value: TDateTime);
      //** Set date and time frame created
    function SetDateTimeCreate2(Value: TDateTime): AError;
      //** Установить тип
    procedure SetFreimType(Value: TAId);
      //** Установить Id. Если не инициализирован.
    function SetId(Value: TAId): AError;
      //** Инициализировать/Финализировать
    function SetInitialized(Value: Boolean): AError;
      //** Установить источник. Только если не инициализирован.
    function SetSource(Value: AiSource2005): AError;
      //** Установить тип
    function SetType(Value: TAId): AError;
      //** Задаем фрейм в виде XML строки
    procedure SetXml(Value: WideString);
    function ToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: string; Params: array of const): Boolean;
  public
    constructor Create(Source: AiSourceObject = 0; Id: TAId = 0);
  public
    property ConnectCount: AInt32 read GetConnectCount;
    property Connects: TAiConnectsObject read GetConnects;
      //** Данные
    property Data: TAiDataObject read GetData;
      //** Дата и время создания фрейма
    property DateCreate: TDateTime read GetDateTimeCreate write SetDateTimeCreate;
      //** Дата и время изменения фрейма
    property DateModify: TDateTime read FDateModify write FDateModify;
    property DateTimeCreate: TDateTime read GetDateTimeCreate write SetDateTimeCreate;
      //** ID фрейма
    property FrameID: TAId read Get_FrameID write Set_FrameID;
      //** Тип фрейма
    property FrameType: TAId read Get_FrameType write Set_FrameType;
      //** ID фрейма
    property FreimId: TAId read FId write FId;
      //** Тип фрейма
    property FreimType: TAId read GetFreimType write SetFreimType;
      //** ID фрейма
    property Id: TAId read Get_FrameID write Set_FrameID;
    //property ID: TAI_ID read FID write FID;
      //** Только для чтения?
    property IsReadOnly: WordBool read Get_IsReadOnly;
    property Handle: AInt32 read GetHandle;
      //** Функция добавления в log (deprecated)
    property OnAddToLog: TAddToLog read FOnAddToLog write FOnAddToLog;
      //** Пул (Источник) фрейма
    //property Pool: IAIFramePool read Get_Pool write Set_Pool;
      //** Источник фрейма
    //property Source: IAISource2 read Get_Source;
    property Typ: AInt32 read GetTyp;
    {**
      Зачитывает или записывает данные из пула.
      An OID also has a value which is loaded on demand.
      The implementation of value loading actually occurs in FramerD
    }
    //property Value: IAIValue read GetValue write SetValue; //public FDType value;
      //** Версия фрейма
    property Version: TAiVersion read FVersion write FVersion;
      //** Фрейм в виде XML строки
    property Xml: WideString read GetXml write SetXml;
  end;
  TAiFrame = TAiFrameObject;

  //TAiFrame2004 = TAiFrameObject;
  //TAiFrame2005 = TAiFrameObject;
  //TAiFreimObject = TAiFrameObject;
  //TAiFreim = TAiFrameObject;
  //TAI_Freim = TAiFrameObject;

implementation

uses
  AiSourceObj;

{ TAiFrameObject }

function TAiFrameObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
  const StrMsg: WideString): AInt;
begin
  if not(Assigned(FOnAddToLog)) then
  begin
    Result := -2;
    Exit;
  end;
  FOnAddToLog(LogGroup, LogType, StrMsg, []);
  Result := 0;
end;

function TAiFrameObject.Clear(): AError;
begin
  if Assigned(FConnects) then
  begin
    FConnects.Free();
    FConnects := nil;
  end;
  if Assigned(FData) then
  begin
    FData.Free();
    FData := nil;
  end;
  FDateCreate := 0;
  FId := 0;
  FInitialized := False;
  //FPool := nil;
  FSource := 0;
  FFreimType := 0;
  Result := 0;
end;

function TAiFrameObject.ConfigureLoad(Config: TConfig; Prefix: String): AError;
begin
  Result := 1;
  if not(Assigned(Config)) then Exit;
  Result := 0;
end;

function TAiFrameObject.ConfigureLoad1(): Boolean;
begin
  Result := (ConfigureSave(Self.FConfig, Self.FPrefix) >= 0);
end;

function TAiFrameObject.ConfigureSave(Config: TConfig; Prefix: String): AError;
begin
  Result := 1;
  if not(Assigned(Config)) then Exit;
  Result := 0;
end;

function TAiFrameObject.ConfigureSave1(): Boolean;
begin
  Result := (ConfigureSave(Self.FConfig, Self.FPrefix) >= 0);
end;

function TAiFrameObject.ConnectAdd(Id: TAId): AInt;
begin
  Result := 0;
end;

function TAiFrameObject.ConnectGet(Index: AInt): AInt64;
begin
  Result := 0;
end;

constructor TAiFrameObject.Create(Source: AiSourceObject; Id: TAId);
begin
  inherited Create;
  FConnects := nil;
  FData := nil;
  FDateCreate := 0;
  FId := Id;
  FInitialized := False;
  FSource := Source;
  FFreimType := 0;
  if (Source <> 0) and (Id > 0) then
    Load();
end;

procedure TAiFrameObject.DoCreate();
begin
//  FConnects := nil;
  FData := nil;
  FDateCreate := 0;
  FID := 0;
  FInitialized := False;
  //FPool := nil;
  FFreimType := 0;
end;

function TAiFrameObject.Finalize(): AError;
begin
  if (FSource <> 0) then
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
  end;

  //if not(Assigned(FPool)) then
  begin
    {if Assigned(FConnects) then
    begin
      FConnects.Free;
      FConnects := nil;
    end;}
    if Assigned(FData) then
    begin
      //FData.Free;
      FData := nil;
    end;
  end;
  FInitialized := False;
  Clear;
  Result := 0;
end;

procedure TAiFrameObject.Free();
begin
  Finalize();
  inherited Free();
end;

function TAiFrameObject.GetConnectCount(): AInt32;
begin
  Result := 0;
end;

function TAiFrameObject.GetConnects(): TAiConnectsObject;
begin
  if not(Assigned(FConnects)) then
  begin
    if (FInitialized) and (FSource <> 0) then
      FConnects := (TObject(FSource) as TAiSourceObject).GetFreimConnects(FId);
    if not(Assigned(FConnects)) then
      FConnects := TAiConnectsObject.Create();
  end;
  Result := FConnects;
end;

function TAiFrameObject.GetData(): TAiDataObject;
begin
  if not(Assigned(FData)) then
  begin
    if (FInitialized) and (FSource <> 0) then
    try
      FData := (TObject(FSource) as TAiSourceObject).GetFrameData(FId, True);
    except
      FData := nil;
    end;
    if not(Assigned(FData)) then
    try
      FData := TAiDataObject.Create(FId, dtNone);
    except
      FData := nil;
    end;
  end;
  Result := FData;
end;

function TAiFrameObject.GetDateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrameObject.GetFreimType(): TAId;
begin
  Result := FFreimType;
end;

function TAiFrameObject.GetId(): TAId;
begin
  Result := FId;
end;

function TAiFrameObject.GetInitialized(): Boolean;
begin
  Result := FInitialized;
end;

function TAiFrameObject.GetHandle(): AInt32;
begin
  Result := 0;
end;

function TAiFrameObject.GetSource(): AiSourceObject;
begin
  Result := FSource;
end;

function TAiFrameObject.GetTyp(): AInt32;
begin
  Result := 0;
end;

function TAiFrameObject.GetType(): TAId;
begin
  Result := FFreimType;
end;

{function TAiFrameObject.GetValue(): IAIValue;
begin
  Result := nil;
end;}

function TAiFrameObject.GetXml(): WideString;
{var
  Xml: TProfXmlNode;}
begin
  (*Result := '<Freim>'+#13#10+
    '  <Id>'+cInt64ToStr(FId)+'</Id>'+#13#10+
    '  <Type>'+cInt32ToStr(FType)+'</Type>'+#13#10+
    '  <DateTimeCreate>'+cDateTimeToStr(FDateTimeCreate)+'</DateTimeCreate>'+#13#10+
    {FConnects.Xml+#13#10+
    FData.Xml+#13#10+}
    '</Freim>';*)

  {Result := '';
  Xml := TProfXmlNode.Create(nil);
  if not(SaveToXml(Xml)) then Exit;
  Result := Xml.Xml;
  Xml.Free;}

  {Result := False;
  if not(Assigned(Xml)) then Exit;
  GetConnects.SaveToXml(Xml.GetNodeByName('Connects'));
  Node := Xml.GetNodeByName('Data');
  GetData.SaveToXml(Node);
  Xml.WriteString('DateTimeCreate', DateTimeToStr(FDateTimeCreate));
  Xml.WriteString('Id', IntToStr(FId));
  Xml.WriteString('Type', IntToStr(FFreimType));
  Result := True;}
end;

function TAiFrameObject.Get_Connects(): TAiConnectsObject;
begin
  Result := GetConnects();
end;

function TAiFrameObject.Get_Data(): TAiDataObject;
begin
  Result := GetData();
end;

function TAiFrameObject.Get_DateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrameObject.Get_FrameID(): TAIID;
begin
  Result := FID;
end;

function TAiFrameObject.Get_FrameName(): WideString;
begin
  Result := IntToStr(FId);
end;

function TAiFrameObject.Get_FrameType(): TAIID;
begin
  Result := FFreimType;
end;

function TAiFrameObject.Get_FreimName(): WideString;
begin
  Result := IntToStr(FId);
end;

function TAiFrameObject.Get_FreimType(): TAId;
begin
  Result := FFreimType;
end;

function TAiFrameObject.Get_IsReadOnly(): WordBool;
begin
  Result := False;
end;

{function TAiFrameObject.Get_Pool(): IAIFramePool;
begin
  Result := FPool;
end;}

{function TAiFrameObject.Get_Source(): IAISource2;
begin
  Result := IAISource(FSource);
end;}

function TAiFrameObject.Init(Path: String; Log: TLog; Config: TConfig; Prefix: String): AError;
begin
  FConfig := Config;
  FLog := Log;
  FPath := Path;
  FPrefix := Prefix;
  Result := Initialize;
end;

function TAiFrameObject.Initialize(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;
  FInitialized := True;
  Result := Load();
end;

function TAiFrameObject.Load(): AError;
begin
  if (LoadFromData(GetData()) >= 0) then
  begin
    Result := 0;
    Exit;
  end;

  if not(FInitialized) then
  begin
    Result := -2;
    Exit;
  end;
  if (FSource = 0) then
  begin
    Result := -3;
    Exit;
  end;
  if (FId <= 0) then
  begin
    Result := -3;
    Exit;
  end;
  FDateCreate := (TObject(FSource) as TAiSourceObject).GetFreimDateTimeCreate(FId);
  if (FDateCreate = 0) then
    FDateCreate := dtNow();
  FFreimType := (TObject(FSource) as TAiSourceObject).GetFreimType(FId);
  Result := 0;
end;

function TAiFrameObject.LoadFromData(Data: TAiDataObject): TAiError;
begin
  Result := -1;
end;

function TAiFrameObject.LoadFromFile(const AFileName: WideString): AError;
begin
  Result := -1; //False;
end;

function TAiFrameObject.LoadFromRecF64(Rec: TAiFreimRecF64): AError;
begin
  FId := Rec.Id;
  FFreimType := Rec.Typ;
  FDateCreate := Rec.DTCreate;
  Result := 0;
end;

function TAiFrameObject.LoadFromXml(Xml: TProfXml): AError;
begin
  Result := 1;
  {
  if not(Assigned(Xml)) then Exit;
  Clear;
  Xml.GetParamValueByNameAsUInt64('Id', FId);
  Xml.GetParamValueByNameAsDateTime('DateTimeCreate', FDateTimeCreate);
  Xml.GetParamValueByNameAsUInt64('Type', FType);
  GetConnects.LoadFromXml(Xml.GetParamByName('Connects'));
  GetData.LoadFromXml(Xml.GetParamByName('Data'));
  Result := 0;
  }
end;
{function TAI_Freim.LoadFromXml(Xml: TMyXml): TError;
begin
  Clear;
  FId := cStrToUInt64(Xml.GetParamValueByName('Id'));
  FDateTimeCreate := cStrToDateTime(Xml.GetParamValueByName('DateTimeCreate'));
  GetConnects.LoadFromXml(Xml.GetParamByName('Connects'));
  GetData.LoadFromXml(Xml.GetParamByName('Data'));
  FType := cStrToUInt64(Xml.GetParamValueByName('Type'));
  Result := 0;
end;}
{function TAIFreim.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Clear();
  FID := TProfXmlNode.ReadInt64Def(Xml, 'ID');
  FDateTimeCreate := TProfXmlNode.ReadDateTimeDef(Xml, 'DateTimeCreate');
  FFreimType := TProfXmlNode.ReadInt64Def(Xml, 'Type');
  GetConnects.LoadFromXml(TProfXmlNode.GetNodeByNameA(Xml, 'Connects'));
  //GetData.LoadFromXml(Xml.GetNodeByName('Data'));
  Result := True;
end;}
{function TAiFreimObject.LoadFromXml(Xml: IXmlNode): WordBool;
var
  Connects: IXmlNode;
begin
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Clear();
  ProfXmlUtils.ProfXmlNode_ReadInt64(Xml, 'ID', FId);
  ProfXmlUtils.ProfXmlNode_ReadDateTime(Xml, 'DateTimeCreate', FDateTimeCreate);
  ProfXmlUtils.ProfXmlNode_ReadInt64(Xml, 'Type', FFreimType);
  Connects := ProfXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connects');
  GetConnects.LoadFromXml(Connects);
  //GetData.LoadFromXml(Xml.GetNodeByName('Data'));
  Result := True;
end;}
{function TAIFreimNamed.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited LoadFromXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.ReadStringA(Xml, 'Description', FDescription);
  TProfXmlNode.ReadStringA(Xml, 'Name', FName);
  TProfXmlNode.ReadStringA(Xml, 'Title', FTitle);
end;}

function TAiFrameObject.P(const Name: APascalString): TAiSlot2004;
begin
  Result := nil;
end;

function TAiFrameObject.P2(const Name, DefValue: APascalString): TAiSlot2004;
begin
  Result := nil;
end;

function TAiFrameObject.Regist(): AError;
begin
  Result := 0;
end;

function TAiFrameObject.Save(): AError;
begin
  if (FInitialized) and (FSource <> 0) and (FId > 0) then
  begin
    (TObject(FSource) as TAiSourceObject).SetFreimType(FId, FFreimType);
    Result := 0;
  end
  else
    Result := -1;
end;

function TAiFrameObject.SaveToFile(const AFileName: WideString): WordBool;
begin
  Result := False;
end;

function TAiFrameObject.SaveToRecF64(var Rec: TAiFreimRecF64): AError;
begin
  Rec.Id := FId;
  Rec.Typ := FFreimType;
  Rec.DTCreate := FDateCreate;
  Rec.DataSize := GetData.GetSize;
  {if GetData.GetType = dtStream then
    Rec.DataSize := GetData.GetStream.GetSize
  else
    Rec.DataSize := 0;}
  Rec.ConnectCount := GetConnects.GetCountConnects;
  Result := 0;
end;

function TAiFrameObject.SaveToXml(Xml: TProfXml): AError;
begin
  Result := -1;
  if not(Assigned(Xml)) then Exit;
  {
  GetConnects.SaveToXml(Xml.GetParamByName('Connects'));
  GetData.SaveToXml(Xml.GetParamByName('Data'));
  Xml.SetParamValue('DateTimeCreate', cDateTimeToStr(FDateTimeCreate));
  Xml.SetParamValue('Id', cUInt64ToStr(FId));
  Xml.SetParamValue('Type', cUInt64ToStr(FType));
  Result := 0;
  }
end;
(*function TAI_Freim.SaveToXml(Xml: TMyXml): TError;
begin
  Result := 1;
  if not(Assigned(Xml)) then Exit;
  {with Xml.NewParam('Freim', '') do begin}
    GetConnects.SaveToXml(Xml.NewParam('Connects', ''));
    GetData.SaveToXml(Xml.NewParam('Data', ''));
    Xml.NewParam('DateTimeCreate', cDateTimeToStr(FDateTimeCreate));
    Xml.NewParam('Id', cUInt64ToStr(FId));
    Xml.NewParam('Type', cUInt64ToStr(FType));
  {end;}
  Result := 0;
end;*)
(*function TAiFrameObject.SaveToXml(Xml: IXmlNode): WordBool;
{var
  con: TAiConnects;}
begin
  {Result := Assigned(Xml);
  if not(Result) then Exit;
  TProfXmlNode.WriteIntegerA(Xml, 'ID', FID);
  TProfXmlNode.WriteDateTimeA(Xml, 'DateTimeCreate', FDateTimeCreate);
  TProfXmlNode.WriteIntegerA(Xml, 'Type', FFreimType);
  con := Connects;
  if Assigned(con) then
    con.SaveToXml(TProfXmlNode.GetNodeByNameA(Xml, 'Connects'));
  //Data.SaveToXml(Xml.GetNodeByName('Data'));}
end;*)
{function TAiFreimObject.SaveToXml(Xml: IXmlNode): WordBool;
var
  Connects: IXmlNode;
begin
  Result := Assigned(Xml);
  if not(Result) then Exit;
  ProfXmlUtils.ProfXmlNode_WriteInt64(Xml, 'ID', FId);
  ProfXmlUtils.ProfXmlNode_WriteDateTime(Xml, 'DateTimeCreate', FDateTimeCreate);
  ProfXmlUtils.ProfXmlNode_WriteInt64(Xml, 'Type', FFreimType);
  Connects := ProfXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connects');
  GetConnects.SaveToXml(Connects);
  //Data.SaveToXml(Xml.GetNodeByName('Data'));
end;}
{function TAIFreimNamed.SaveToXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited SaveToXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.WriteStringA(Xml, 'Description', FDescription);
  TProfXmlNode.WriteStringA(Xml, 'Name', FName);
  TProfXmlNode.WriteStringA(Xml, 'Title', FTitle);
end;}

procedure TAiFrameObject.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
end;

function TAiFrameObject.SetDateTimeCreate2(Value: TDateTime): AError;
begin
  Result := 1;
  if FInitialized then Exit;
  FDateCreate := Value;
  Result := 0;
end;

procedure TAiFrameObject.SetFreimType(Value: TAId);
begin
  if FInitialized then Exit;
  FFreimType := Value;
end;

function TAiFrameObject.SetId(Value: TAId): AError;
begin
  Result := -1;
  if FInitialized then Exit;
  FId := Value;
  Result := 0;
end;

function TAiFrameObject.SetInitialized(Value: Boolean): AError;
begin
  FInitialized := Value;
  Result := 0;
end;

function TAiFrameObject.SetSource(Value: AiSource2005): AError;
begin
  if FInitialized then
  begin
    Result := -1;
    Exit;
  end;
  FSource := Value;
  Result := 0;
end;

function TAiFrameObject.SetType(Value: TAId): AError;
begin
  Result := -1;
  if FInitialized then Exit;
  FFreimType := Value;
  Result := 0;
end;

{procedure TAiFrameObject.SetValue(Value: IAIValue);
begin
  // ...
end;}

procedure TAiFrameObject.SetXml(Value: WideString);
//var
//  Xml: IProfXmlNode;
begin
  {Xml := TProfXmlNode.Create(nil, nil, nil);
  Xml.Xml := Value;
  LoadFromXml(Xml);
  Xml.Free();}
end;

procedure TAiFrameObject.Set_DateTimeCreate(Value: TDateTime);
begin
  FDateCreate := Value;
end;

procedure TAiFrameObject.Set_FrameID(Value: TAIID);
begin
  if FInitialized then Exit;
  FID := Value;
end;

procedure TAiFrameObject.Set_FrameType(Value: TAIID);
begin
  if FInitialized then Exit;
  FFreimType := Value;
end;

procedure TAiFrameObject.Set_FreimType(Value: TAId);
begin
  FFreimType := Value;
end;

{procedure TAiFrameObject.Set_Pool(const Value: IAIFramePool);
begin
  FPool := Value;
end;}

function TAiFrameObject.ToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: string; Params: array of const): Boolean;
begin
  if Assigned(FOnAddToLog) then
    Result := FOnAddToLog(LogGroup, LogType, StrMsg, Params)
  else
    Result := False;
end;

{ TAiSlot2004 }

function TAiSlot2004.GetAsInt32(): AInt32;
begin
  Result := 0;
end;

function TAiSlot2004.GetAsString(): string;
begin
  Result := '';
end;

function TAiSlot2004.GetAsUInt32(): AUInt32;
begin
  Result := 0;
end;

function TAiSlot2004.GetAsUInt64(): AUInt64;
begin
  Result := 0;
end;

function TAiSlot2004.GetValueAsHandle(): AInt32;
begin
  Result := 0;
end;

function TAiSlot2004.GetValueAsString(): APascalString;
begin
  Result := '';
end;

procedure TAiSlot2004.SetAsString(const Value: string);
begin
end;

procedure TAiSlot2004.SetAsUInt32(Value: AUInt32);
begin
end;

procedure TAiSlot2004.SetAsUInt64(Value: AUInt64);
begin
end;

procedure TAiSlot2004.SetValueAsString(const Value: APascalString);
begin
end;

end.
