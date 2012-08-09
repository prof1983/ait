{**
@Abstract Базовые типы для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 26.04.2006
@LastMod 09.08.2012

Prototype: org.framerd.OID
Каждый фрейм является некоторой сущностью.
}
unit AiFrameImpl;

interface

uses
  SysUtils, XmlIntf,
  ABase, AConsts2, AEntityImpl, AIteratorIntf, ANodeIntf, ATypes, AXmlUtils,
  AiBase, AiBaseTypes, AiCollectionImpl, AiConnectsIntf, AiDataIntf, AiEntityImpl,
  AiFrameIntf, AiFramePoolIntf, AiFrameUtils, AiSlotIntf, AiSlotImpl, AiTypes;

type //** Фрейм
  TAiFrame = class(TAiEntity, IAiFrame)
  protected
      //** Данные - объект источника. Если источника нет - локальный объект
    FData: IAiData2;
      //** Дата создания
    FDateCreate: TDateTime; //FDateTimeCreate: TDateTime;
      //** Дата изменения
    FDateModify: TDateTime;
      //** Идентификатор (See TProfEntity)
    //FId: TAId;
      //** Инициализирован?
    FInitialized: Boolean;
      //** Префикс для конфигураций и логирования (Удалить?)
    //FPrefix: String;
      //** Пул (Источник)
    FPool: IAIFramePool;
      //** Тип фрейма
    FFrameType: TAId; //FFreimType: TAIID;
      //** Версия фрейма
    FVersion: TAIVersion;
  protected // From TAiFrame2007
      //** Связи - объект источника. Если источника нет - локальный объект
    FConnects: IAiConnects;
      //** Префикс для конфигураций и логирования
    FPrefix: String;
      //** Источник
    FSource: AiSource2{IAiSource2};
  protected // From TAiFreim
      // Функция добавления в log (See TProfEntity)
    //FOnAddToLog: TAddToLog;
      // Путь расположения программы
    FPath: String;
  protected // IAiFrame
    function Get_Connects(): IAiConnects; safecall;
    //** Возвращает объект работы с данными
    function Get_Data(): IAiData2; virtual; safecall;
    //** Возвращает дату создания
    function Get_DateTimeCreate(): TDateTime; safecall;
    //** Возвращает ID фрейма
    function Get_FrameID(): TAIID; safecall;
    //** Возвращает имя фрейма
    function Get_FrameName(): WideString; safecall;
    //** Возвращает тип фрейма
    function Get_FrameType(): TAIID; safecall;
    function Get_IsReadOnly(): WordBool; safecall;
    //** Возвращает источник
    function Get_Pool(): IAIFramePool; safecall;
    function Get_Source2(): AiSource2; safecall;
    //** Установыть дату создания
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    //** Установить Id. Если не инициализирован.
    procedure Set_FrameID(Value: TAIID); safecall;
    //** Установить тип
    procedure Set_FrameType(Value: TAIID); safecall;
    procedure Set_Source2(const Value: AiSource2); safecall;
    //** Установить источник. Только если не инициализирован.
    procedure Set_Pool(const Value: IAIFramePool); safecall;
  protected // IAiFreim
    function Get_FreimName(): WideString; safecall; deprecated 'Use Get_FrameName()';
    function Get_FreimType(): TAIID; safecall; deprecated 'Use Get_FrameType()';
    procedure Set_FreimType(Value: TAiId); safecall; deprecated 'Use Set_FrameType()';
  public // IAiFrame
      {** Добавляет слот }
    function AddSlot(Slot: IAiSlot): Integer;
      {** Создает новый слот }
    function NewSlot(Name: WideString): IAiSlot;
  public
      //** Срабатывает при создании
    procedure DoCreate(); virtual; safecall;
      //** Срабатывает при уничтожении
    procedure DoDestroy(); virtual; safecall;
      // Return config interface
    function GetConfig(): IProfNode; safecall; deprecated; // Use TProfObject.GetConfigNode
      //** Возвращает дату создания
    function GetDateTimeCreate(): TDateTime;
      //** Инициализирован?
    function GetInitialized(): Boolean;
      //** Возвращает источник
    function GetSource(): AiSource2; safecall;
      //** Возвращает фрейм в виде XML строки
    function GetXml(): WideString; virtual;
      {**
        Зачитывает из пула данные фрейма.
        The method getValue retrieves an OID's value from the pool in which it resides.
      }
    function GetValue(): IAiValue; safecall;
      //** Задать дату и время создания фрейма
    procedure SetDateTimeCreate(Value: TDateTime);
      //** Установить источник. Только если не инициализирован.
    procedure SetSource(Value: AiSource2);
      {**
        Заменяет значение ассоциируемого с фреймом
        The method setValue changes value associated with an OID.
      }
    procedure SetValue(Value: IAIValue); safecall;
      //** Задаем фрейм в виде XML строки
    procedure SetXml(Value: WideString);
  public
      //** Очистить объект
    function Clear(): WordBool; virtual; safecall;
      //** Финализировать. Разорвать связь объекта с источником.
    function Finalize(): TProfError; virtual;
      //** Освободить
    procedure Free(); virtual;
      //** Произвести инициализацию. Установить связь с источником.
    function Initialize(): TProfError; virtual;
      //** Загрузить из источника
    function Load(): TAIError; virtual; safecall;
      //** Загрузить из AIData
    function LoadFromData(Data: IAIData): TAIError; virtual; safecall;
      //** Загрузить из файла
    function LoadFromFile(const AFileName: WideString): TProfError; virtual; safecall;
      //** Зарегистрировать тип фрейма в источнике
    function Regist(): Boolean; virtual; safecall;
      //** Сохранить в источник
    function Save(): TAIError; virtual; safecall;
      //** Сохранить в файл
    function SaveToFile(const AFileName: WideString): WordBool; virtual; safecall;
      //** Сохранить список связей в XML
    function SaveToXml(Xml: IXmlNode): WordBool; virtual;
  public
    constructor Create();
  public
    //** Данные
    property Data: IAiData2 read Get_Data;
    //** Дата и время создания фрейма
    property DateCreate: TDateTime read GetDateTimeCreate write SetDateTimeCreate;
    //** Дата и время изменения фрейма
    property DateModify: TDateTime read FDateModify write FDateModify;
    //** ID фрейма
    property FrameID: TAIID read Get_FrameID write Set_FrameID;
    //** Тип фрейма
    property FrameType: TAIID read Get_FrameType write Set_FrameType;
    //** ID фрейма
    property ID: TAIID read Get_FrameID write Set_FrameID;
    //** Только для чтения?
    property IsReadOnly: WordBool read Get_IsReadOnly;
    //** Пул (Источник) фрейма
    property Pool: IAIFramePool read Get_Pool write Set_Pool;
      //** Источник врейма
    property Source: AiSource2 read GetSource write SetSource;
    //** Источник фрейма
    property Source2: AiSource2 read Get_Source2;
    {**
      Зачитывает или записывает данные из пула.
      An OID also has a value which is loaded on demand.
      The implementation of value loading actually occurs in FramerD
    }
    property Value: IAIValue read GetValue write SetValue; //public FDType value;
    //** Версия фрейма
    property Version: TAIVersion read FVersion write FVersion;
    //** Фрейм в виде XML строки
    property Xml: WideString read GetXml write SetXml;
  end;

  //** @abstract(Фрейм)
  TAiFrame1 = class(TAiFrame)
  protected
    //** Данные - объект источника. Если источника нет - локальный объект
    FData: IAiData2;
    //** Дата создания
    FDateCreate: TDateTime;
    //** Дата изменения
    FDateModify: TDateTime;
    //** Идентификатор (см. TProfEntity)
    //FID: TAIID;
    // Инициализирован?
    //FInitialized: Boolean;
    //** Префикс для конфигураций и логирования (Удалить?)
    //FPrefix: String;
    //** Пул (Источник)
    FPool: IAIFramePool;
    //** Тип фрейма
    FFreimType: TAIID;
    //** Версия фрейма
    FVersion: TAIVersion;
  protected // IAiFrame
    //** Возвращает объект работы с данными
    function Get_Data(): IAiData2; virtual; safecall;
    //** Возвращает дату создания
    function Get_DateTimeCreate(): TDateTime; safecall;
    //** Возвращает ID фрейма
    function Get_FrameID(): TAIID; safecall;
    //** Возвращает имя фрейма
    function Get_FrameName(): WideString; safecall;
    //** Возвращает тип фрейма
    function Get_FrameType(): TAIID; safecall;
    function Get_IsReadOnly(): WordBool; safecall;
    //** Возвращает источник
    function Get_Pool(): IAIFramePool; safecall;
      //** Возвращает источник
    function Get_Source2(): AiSource2; safecall;
    {**
      Зачитывает из пула данные фрейма.
      The method getValue retrieves an OID's value from the pool in which it resides.
    }
    function GetValue(): IAIValue; safecall;
    //** Установыть дату создания
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    //** Установить Id. Если не инициализирован.
    procedure Set_FrameID(Value: TAIID); safecall;
    //** Установить тип
    procedure Set_FrameType(Value: TAIID); safecall;
    //** Установить источник. Только если не инициализирован.
    procedure Set_Pool(const Value: IAIFramePool); safecall;
    {**
      Заменяет значение ассоциируемого с фреймом
      The method setValue changes value associated with an OID.
    }
    procedure SetValue(Value: IAIValue); safecall;
  public // IAIFrame
    function Get_Connects(): IAIConnects; safecall;
    //function Get_Source(): IAISource2; safecall;
  public // IProfObject
    function GetConfig(): IProfNode; safecall;
  public // IAiFrame
      {** Добавляет слот }
    function AddSlot(Slot: IAiSlot): Integer;
      {** Создает новый слот }
    function NewSlot(Name: WideString): IAiSlot;
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
    //** Срабатывает при уничтожении
    procedure DoDestroy(); override; safecall;
    //** Возвращает дату создания
    function GetDateTimeCreate(): TDateTime;
    //** Инициализирован?
    function GetInitialized(): Boolean;
    //** Возвращает фрейм в виде XML строки
    function GetXml(): WideString; virtual;
    //** Задать дату и время создания фрейма
    procedure SetDateTimeCreate(Value: TDateTime);
    //** Задаем фрейм в виде XML строки
    procedure SetXml(Value: WideString);
  public
    //** Очистить объект
    function Clear(): WordBool; virtual; safecall;
    // Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): TProfError; {override;} safecall;
    // Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): TProfError; {override;} safecall;
    //** Финализировать. Разорвать связь объекта с источником.
    function Finalize(): TProfError; override; //safecall;
    //** Освободить
    procedure Free(); override;
    //** Произвести инициализацию. Установить связь с источником.
    function Initialize(): TProfError; override; //safecall;
    //** Загрузить из источника
    function Load(): TAIError; virtual; safecall;
    //** Загрузить из AIData
    function LoadFromData(Data: IAIData): TAIError; virtual; safecall;
    //** Загрузить из файла
    function LoadFromFile(const AFileName: WideString): TProfError; virtual; safecall;
    //** Зарегистрировать тип фрейма в источнике
    function Regist(): Boolean; virtual; safecall;
    //** Сохранить в источник
    function Save(): TAIError; virtual; safecall;
    //** Сохранить в файл
    function SaveToFile(const AFileName: WideString): WordBool; virtual; safecall;
  public
    //** Данные
    property Data: IAiData2 read Get_Data;
    //** Дата и время создания фрейма
    property DateCreate: TDateTime read GetDateTimeCreate write SetDateTimeCreate;
    //** Дата и время изменения фрейма
    property DateModify: TDateTime read FDateModify write FDateModify;
    //** ID фрейма
    property FrameID: TAIID read Get_FrameID write Set_FrameID;
    //** Тип фрейма
    property FrameType: TAIID read Get_FrameType write Set_FrameType;
    //** ID фрейма
    property ID: TAIID read Get_FrameID write Set_FrameID;
    //** Только для чтения?
    property IsReadOnly: WordBool read Get_IsReadOnly;
    //** Пул (Источник) фрейма
    property Pool: IAIFramePool read Get_Pool write Set_Pool;
    //** Источник фрейма
    //property Source: IAISource2 read Get_Source;
    {**
      Зачитывает или записывает данные из пула.
      An OID also has a value which is loaded on demand.
      The implementation of value loading actually occurs in FramerD
    }
    property Value: IAIValue read GetValue write SetValue; //public FDType value;
    //** Версия фрейма
    property Version: TAIVersion read FVersion write FVersion;
    //** Фрейм в виде XML строки
    property Xml: WideString read GetXml write SetXml;
  end;

  TAiFrame2007 = class(TAIFrame)
  protected
      //** Слоты
    FSlots: array of IAiSlot;
  protected
    procedure SetSlotValue(SlotName: WideString; SlotValue: Variant);
  protected
      //** Возвращает слот по индексу
    function GetSlotByIndex(Index: Integer): IAiSlot;
      //** Возвращает слот по имени
    function GetSlotByName(Name: WideString): IAiSlot;
      //** Возвращает количество слотов
    function GetSlotCount(): Integer;
    function GetSlotValueAsString(SlotName: WideString): WideString;
  public
      //** Возвращает объект работы со связями
    function GetConnects(): IAiConnects;
      //** Возвращает класс работы с данными
    function GetData(): IAiData;
      //** Возвращает дату создания
    function GetDateTimeCreate(): TDateTime;
      //** Возвращает тип фрейма
    function GetFrameType(): TAIID; safecall;
      //** Возвращает ID фрейма
    function GetFrameID(): TAIID; safecall;
      //** Возвращает тип фрейма
    function GetFreimType(): TAId;
      //** Return frame identifier
    function GetId(): AId;
      //** Инициализирован?
    function GetInitialized(): Boolean;
      //** Возвращает источник
    function GetSource(): AiSource2;
      //** Возвращает фрейм в виде XML строки
    function GetXml(): WideString; virtual;
      //** Задать дату и время создания фрейма
    procedure SetDateTimeCreate(Value: TDateTime);
      //** Установить тип
    procedure SetFrameType(Value: TAIID); safecall;
      //** Установить Id. Если не инициализирован.
    procedure SetFrameID(Value: TAIID); safecall;
      //** Установить тип
    procedure SetFreimType(Value: TAId);
      //** Установить Id. Если не инициализирован.
    procedure SetId(Value: TAId);
      //** Инициализировать/Финализировать
    procedure SetInitialized(Value: Boolean);
    procedure SetXml(Value: WideString);
  public
      //** Добавить слот
    function AddSlot(Slot: IAiSlot): Integer;
      //** Очистить объект
    function Clear(): WordBool; virtual; safecall;
      //** Загрузить конфигурации
    //function ConfigureLoad: WordBool; override;
      //** Сохранить конфигурации
    //function ConfigureSave: WordBool; override;
      //** Финализировать. Разорвать связь объекта с источником.
    function Finalize(): TProfError; override;
      //** Произвести инициализацию. Установить связь с источником.
    function Initialize(): TProfError; override;
      //** Новый слот
    function NewSlot(Name: WideString): IAiSlot;
      //** Зарегистрировать тип фрейма в источнике
    function Regist(): Boolean; virtual; safecall;
  public
      //** Загрузить из источника
    function Load(): Boolean; virtual;
      //** Загрузить из файла
    function LoadFromFile(const AFileName: WideString): WordBool; virtual; safecall;
    function LoadFromRecF64(Rec: TAIFreimRecF64): WordBool; safecall;
      //** Load frame data from xml
    function LoadFromXml(Xml: IXmlNode): WordBool; virtual;
      //** Сохранить в источник
    function Save(): WordBool; virtual;
      //** Сохранить в файл
    function SaveToFile(const AFileName: WideString): WordBool; virtual; safecall;
      //** Save frame data to FrameRec64
    function SaveToRecF64(var Rec: TAIFreimRecF64): Boolean;
      //** Сохранить в XML
    function SaveToXml(Xml: IXmlNode): WordBool; virtual;
  public
    constructor Create(ASource: AiSource2 = 0; AId: TAId = 0);
      //** Освободить
    procedure Free(); override;
  public
      //** Связи
    property Connects: IAiConnects read GetConnects;
      //** Данные
    property Data: IAIData read {GetData}Get_Data;
      //** Дата и время создания фрейма
    property DateTimeCreate: TDateTime read GetDateTimeCreate write SetDateTimeCreate;
      //** ID фрейма
    property ID: TAIID read FID write FID;
      //** ID фрейма
    property FrameID: TAIID read GetFrameID write SetFrameID;
      //** Тип фрейма
    property FrameType: TAIID read GetFrameType write SetFrameType;
      //** Frame identifier
    property FreimId: TAId read FId write FId;
      //** Frame type
    property FreimType: TAId read GetFreimType write SetFreimType;
      //** Слот по индексу
    property SlotByIndex[Index: Integer]: IAiSlot read GetSlotByIndex;
      //** Слот по имени
    property SlotByName[Name: WideString]: IAiSlot read GetSlotByName;
      //** Количество слотов
    property SlotCount: Integer read GetSlotCount;
      //** Фрейм в виде XML строки
    property Xml: WideString read GetXml write SetXml;
  end;

  TAiFrame20070620 = TAiFrame2007;

type // Фрейм
  TAIFreim = class(TAiFrame2007, IAIFreim)
  protected // IAiFreim
    function Get_Connects(): IAiConnects; safecall;
    function Get_FreimName(): WideString; safecall;
    function Get_FreimType(): TAId; safecall;
    function Get_Source1(): AiSource1; safecall;
    procedure Set_FreimType(Value: TAId); safecall;
    procedure Set_Source1(const Value: AiSource1); safecall;
  end;

implementation

{ TAiFrame }

function TAiFrame.AddSlot(Slot: IAiSlot): Integer;
begin
  Result := 0;
end;

function TAiFrame.Clear(): WordBool;
begin
//  if Assigned(FConnects) then FreeAndNil(FConnects);
  if Assigned(FData) then
  begin
    //FreeAndNil(FData);
    FData := nil;
  end;
  FDateCreate := 0;
  FID := 0;
  FInitialized := False;
  FPool := nil;
  FFrameType := 0;
  Result := True;
end;

constructor TAiFrame.Create();
begin
  inherited Create();
  DoCreate();
end;

procedure TAiFrame.DoCreate();
begin
//  FConnects := nil;
  FData := nil;
  FDateCreate := 0;
  FID := 0;
  FInitialized := False;
  FPool := nil;
  FFrameType := 0;
end;

procedure TAiFrame.DoDestroy();
begin
end;

function TAiFrame.Finalize(): TProfError;
begin
  if not(Assigned(FPool)) then
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

procedure TAiFrame.Free();
begin
  {Finalize;}
  DoDestroy();
  inherited Free();
end;

function TAiFrame.GetConfig(): IProfNode;
begin
  Result := nil;
end;

(*function TAIFrame3.GetConnects(): TAIConnects;
begin
  {if not(Assigned(FConnects)) then begin
    if (FInitialized) and Assigned(FSource) then
      FConnects := FSource.GetFreimConnects(FId);
    if not(Assigned(FConnects)) then
      FConnects := TAiConnects.Create();
  end;}
  Result := FConnects;
end;*)

function TAiFrame.GetDateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrame.GetInitialized(): Boolean;
begin
  Result := FInitialized;
end;

function TAiFrame.GetSource(): AiSource2;
begin
  Result := FSource;
end;

function TAiFrame.GetValue(): IAIValue;
begin
  Result := nil;
end;

function TAiFrame.GetXml(): WideString;
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

function TAiFrame.Get_Connects(): IAiConnects;
begin
  Result := FConnects;
end;

function TAiFrame.Get_Data(): IAiData2;
begin
  {if not(Assigned(FData)) then
  begin
    if (FInitialized) and Assigned(FSource) then
    try
      FData := FSource.GetFreimData(FId);
    except
      FData := nil;
    end;
    if not(Assigned(FData)) then
    try
      FData := TAI_Data.Create(Self, dtNone, AddToLog);
    except
      FData := nil;
    end;
  end;}
  Result := FData;
end;

function TAiFrame.Get_DateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrame.Get_FrameId(): AId;
begin
  Result := Self.FId;
end;

function TAiFrame.Get_FrameName(): WideString;
begin
  if (Self.FName = '') then
    Result := IntToStr(Self.FId)
  else
    Result := Self.FName;
end;

function TAiFrame.Get_FrameType(): AId;
begin
  Result := Self.FFrameType;
end;

function TAiFrame.Get_FreimName(): WideString;
begin
  Result := Get_FrameName();
end;

function TAiFrame.Get_FreimType(): AId;
begin
  Result := Get_FrameType();
end;

function TAiFrame.Get_IsReadOnly(): WordBool;
begin
  Result := False;
end;

function TAiFrame.Get_Pool(): IAIFramePool;
begin
  Result := FPool;
end;

function TAiFrame.Get_Source2(): AiSource2;
begin
  Result := FSource;
end;

function TAiFrame.Initialize(): TProfError;
begin
  Result := 0;
  if FInitialized then Exit;
  Result := Load();
end;

function TAiFrame.Load(): TAIError;
begin
  Result := LoadFromData(Get_Data());

//  Result := Assigned(FSource) and (FID > 0);
//  if not(Result) then Exit;
  //FDateTimeCreate := FSource.GetFreimDateTimeCreate(FId);
  //if FDateTimeCreate = 0 then FDateTimeCreate := dtNow;
  //FFreimType := FSource.GetFreimType(FId);
end;

function TAiFrame.LoadFromData(Data: IAIData): TAIError;
begin
  Result := -1;
end;

function TAiFrame.LoadFromFile(const AFileName: WideString): TProfError;
begin
  Result := -1; //False;
end;

function TAiFrame.NewSlot(Name: WideString): IAiSlot;
begin
  Result := nil;
end;

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

function TAiFrame.Regist(): Boolean;
begin
  Result := False;
  AddToLog(lgGeneral, ltError, stNotOverrideA);
end;

function TAiFrame.Save(): TAIError;
begin
  {if (FInitialized) and Assigned(FSource) and (FId > 0) then begin
    FSource.SetFreimType(FId, FFreimType);
    Result := True;
  end else}
  Result := -1;
end;

function TAiFrame.SaveToFile(const AFileName: WideString): WordBool;
begin
  Result := False;
end;

function TAiFrame.SaveToXml(Xml: IXmlNode): WordBool;
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
  Result := False;
end;

procedure TAiFrame.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
end;

procedure TAiFrame.SetSource(Value: AiSource2);
begin
  if FInitialized then Exit;
  FSource := Value;
end;

procedure TAiFrame.SetValue(Value: IAIValue);
begin
  // ...
end;

procedure TAiFrame.SetXml(Value: WideString);
//var
//  Xml: IProfXmlNode;
begin
  {Xml := TProfXmlNode.Create(nil, nil, nil);
  Xml.Xml := Value;
  LoadFromXml(Xml);
  Xml.Free();}
end;

procedure TAiFrame.Set_DateTimeCreate(Value: TDateTime);
begin
  FDateCreate := Value;
end;

procedure TAiFrame.Set_FrameId(Value: AId);
begin
  if FInitialized then Exit;
  Self.FId := Value;
end;

procedure TAiFrame.Set_FrameType(Value: AId);
begin
  if FInitialized then Exit;
  Self.FFrameType := Value;
end;

procedure TAiFrame.Set_FreimType(Value: TAiId);
begin
  FFrameType := Set_FrameType(Value);
end;

procedure TAiFrame.Set_Source2(const Value: AiSource2);
begin
  FSource := Value;
end;

procedure TAiFrame.Set_Pool(const Value: IAIFramePool);
begin
  FPool := Value;
end;

{ TAiFrame1 }

function TAiFrame1.AddSlot(Slot: IAiSlot): Integer;
begin
  Result := -1;
end;

function TAiFrame1.Clear(): WordBool;
begin
//  if Assigned(FConnects) then FreeAndNil(FConnects);
  if Assigned(FData) then FreeAndNil(FData);
  FDateCreate := 0;
  FID := 0;
  FInitialized := False;
  FPool := nil;
  FFreimType := 0;
  Result := True;
end;

function TAiFrame1.ConfigureLoad(AConfig: IProfNode): TProfError;
begin
  Result := 0;
end;

function TAiFrame1.ConfigureSave(AConfig: IProfNode): TProfError;
begin
  Result := 0;
end;

procedure TAiFrame1.DoCreate();
begin
  inherited DoCreate();
//  FConnects := nil;
  FData := nil;
  FDateCreate := 0;
  FID := 0;
  FInitialized := False;
  FPool := nil;
  FFreimType := 0;
end;

procedure TAiFrame1.DoDestroy();
begin
  inherited DoDestroy();
end;

function TAiFrame1.Finalize(): TProfError;
begin
  if not(Assigned(FPool)) then
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

procedure TAiFrame1.Free();
begin
  {Finalize;}
  DoDestroy();
  inherited Free();
end;

function TAiFrame1.GetConfig(): IProfNode;
begin
  Result := nil;
end;

(*function TAIFrame3.GetConnects(): TAIConnects;
begin
  {if not(Assigned(FConnects)) then begin
    if (FInitialized) and Assigned(FSource) then
      FConnects := FSource.GetFreimConnects(FId);
    if not(Assigned(FConnects)) then
      FConnects := TAiConnects.Create();
  end;}
  Result := FConnects;
end;*)

function TAiFrame1.GetDateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrame1.GetInitialized(): Boolean;
begin
  Result := FInitialized;
end;

function TAiFrame1.GetValue(): IAIValue;
begin
  Result := nil;
end;

function TAiFrame1.GetXml(): WideString;
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

function TAiFrame1.Get_Connects(): IAIConnects;
begin
  Result := nil{FConnects};
end;

function TAiFrame1.Get_Data(): IAiData2;
begin
  {if not(Assigned(FData)) then
  begin
    if (FInitialized) and Assigned(FSource) then
    try
      FData := FSource.GetFreimData(FId);
    except
      FData := nil;
    end;
    if not(Assigned(FData)) then
    try
      FData := TAI_Data.Create(Self, dtNone, AddToLog);
    except
      FData := nil;
    end;
  end;}
  Result := FData;
end;

function TAiFrame1.Get_DateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrame1.Get_FrameID(): TAIID;
begin
  Result := FID;
end;

function TAiFrame1.Get_FrameName(): WideString;
begin
  Result := IntToStr(FID);
end;

function TAiFrame1.Get_FrameType(): TAIID;
begin
  Result := FFreimType;
end;

function TAiFrame1.Get_IsReadOnly(): WordBool;
begin
  Result := False;
end;

function TAiFrame1.Get_Pool(): IAIFramePool;
begin
  Result := FPool;
end;

{function TAiFrame1.Get_Source(): IAISource2;
begin
  Result := nil;
end;}

function TAiFrame1.Get_Source2(): AiSource2;
begin
  Result := 0;
end;

function TAiFrame1.Initialize(): TProfError;
begin
  Result := 0;
  if FInitialized then Exit;
  Result := inherited Initialize();
  {Result :=} Load();
end;

function TAiFrame1.Load(): TAIError;
begin
  Result := LoadFromData(Get_Data());

//  Result := Assigned(FSource) and (FID > 0);
//  if not(Result) then Exit;
  //FDateTimeCreate := FSource.GetFreimDateTimeCreate(FId);
  //if FDateTimeCreate = 0 then FDateTimeCreate := dtNow;
  //FFreimType := FSource.GetFreimType(FId);
end;

function TAiFrame1.LoadFromData(Data: IAIData): TAIError;
begin
  Result := -1;
end;

function TAiFrame1.LoadFromFile(const AFileName: WideString): TProfError;
begin
  Result := -1; //False;
end;

function TAiFrame1.NewSlot(Name: WideString): IAiSlot;
begin
  Result := nil;
end;

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

function TAiFrame1.Regist(): Boolean;
begin
  Result := False;
  AddToLog(lgGeneral, ltError, stNotOverrideA);
end;

function TAiFrame1.Save(): TAIError;
begin
  {if (FInitialized) and Assigned(FSource) and (FId > 0) then begin
    FSource.SetFreimType(FId, FFreimType);
    Result := True;
  end else}
  Result := -1;
end;

function TAiFrame1.SaveToFile(const AFileName: WideString): WordBool;
begin
  Result := False;
end;

{function TAIFreim.SaveToXml(Xml: IXmlNode): WordBool;
var
  con: TAiConnects;
begin
  Result := Assigned(Xml);
  if not(Result) then Exit;
  TProfXmlNode.WriteIntegerA(Xml, 'ID', FID);
  TProfXmlNode.WriteDateTimeA(Xml, 'DateTimeCreate', FDateTimeCreate);
  TProfXmlNode.WriteIntegerA(Xml, 'Type', FFreimType);
  con := Connects;
  if Assigned(con) then
    con.SaveToXml(TProfXmlNode.GetNodeByNameA(Xml, 'Connects'));
  //Data.SaveToXml(Xml.GetNodeByName('Data'));
end;}

procedure TAiFrame1.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
end;

procedure TAiFrame1.SetValue(Value: IAIValue);
begin
  // ...
end;

procedure TAiFrame1.SetXml(Value: WideString);
//var
//  Xml: IProfXmlNode;
begin
  {Xml := TProfXmlNode.Create(nil, nil, nil);
  Xml.Xml := Value;
  LoadFromXml(Xml);
  Xml.Free();}
end;

procedure TAiFrame1.Set_DateTimeCreate(Value: TDateTime);
begin
  FDateCreate := Value;
end;

procedure TAiFrame1.Set_FrameID(Value: TAIID);
begin
  if FInitialized then Exit;
  FID := Value;
end;

procedure TAiFrame1.Set_FrameType(Value: TAIID);
begin
  if FInitialized then Exit;
  FFreimType := Value;
end;

procedure TAiFrame1.Set_Pool(const Value: IAIFramePool);
begin
  FPool := Value;
end;

{ TAiFrame2007 }

function TAiFrame2007.AddSlot(Slot: IAiSlot): Integer;
begin
  Result := Length(FSlots);
  SetLength(FSlots, Result + 1);
  FSlots[Result] := Slot;
end;

function TAiFrame2007.Clear: WordBool;
begin
  if Assigned(FConnects) then FreeAndNil(FConnects);
  if Assigned(FData) then FreeAndNil(FData);
  FDateCreate := 0;
  FId := 0;
  FInitialized := False;
  FSource := 0;
  FFrameType := 0;
  Result := True;
end;

constructor TAiFrame2007.Create(ASource: AiSource2 = 0; AId: TAId = 0);
begin
  inherited Create();
  FConnects := nil;
  FData := nil;
  FDateCreate := 0;
  FId := AId;
  FInitialized := False;
  FSource := ASource;
  FFrameType := 0;
  {if Assigned(Source) and (Id > 0) then Load;}
  Self.FName := IntToStr(FId);
  DoCreate();
end;

function TAiFrame2007.Finalize(): TProfError;
begin
  if (FSource = 0) then
  begin
    FConnects := nil;
    FData := nil;
  end;
  FInitialized := False;
  Clear;
  Result := 0;
end;

procedure TAiFrame2007.Free();
begin
  {Finalize;}
  DoDestroy();
  inherited Free();
end;

function TAiFrame2007.GetConnects(): IAiConnects;
begin
  {if not(Assigned(FConnects)) then begin
    if (FInitialized) and Assigned(FSource) then
      FConnects := FSource.GetFreimConnects(FId);
    if not(Assigned(FConnects)) then
      FConnects := TAiConnects.Create();
  end;}
  Result := FConnects;
end;

function TAIFrame2007.GetData(): IAiData;
begin
  {if not(Assigned(FData)) then begin
    if (FInitialized) and Assigned(FSource) then
      FData := FSource.GetFreimData(FId);
    if not(Assigned(FData)) then
      FData := TAI_Data.Create(Self, dtNone, AddToLog);
  end;}
  Result := FData;
end;

function TAiFrame2007.GetDateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrame2007.GetId(): AId;
begin
  Result := FId;
end;

function TAiFrame2007.GetInitialized(): Boolean;
begin
  Result := FInitialized;
end;

function TAiFrame2007.GetFrameId(): TAiId;
begin
  Result := FID;
end;

function TAiFrame2007.GetFrameType(): TAiId;
begin
  Result := FFrameType;
end;

function TAiFrame2007.GetFreimType(): TAId;
begin
  Result := FFrameType;
end;

function TAiFrame2007.GetSlotByIndex(Index: Integer): IAiSlot;
begin
  if (Index >= 0) and (Index < Length(FSlots)) then
    Result := FSlots[Index]
  else
    Result := nil;
end;

function TAiFrame2007.GetSlotByName(Name: WideString): IAiSlot;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FSlots) do
    if TAISlot(FSlots[i]).Name = Name then
    begin
      Result := FSlots[i];
      Exit;
    end;
end;

function TAiFrame2007.GetSlotCount(): Integer;
begin
  Result := Length(FSlots);
end;

function TAiFrame2007.GetSlotValueAsString(SlotName: WideString): WideString;
var
  Slot: IAiSlot;
begin
  Result := '';
  slot := GetSlotByName(SlotName);
  if Assigned(slot) then
  try
    Result := slot.Value;
  except
  end;
end;

function TAiFrame2007.GetSource(): AiSource2;
begin
  Result := FSource;
end;

function TAiFrame2007.GetXml(): WideString;
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

function TAiFrame2007.Initialize(): TProfError;
begin
  Result := 0;
  if FInitialized then Exit;
  Result := inherited Initialize();
  if not(Load()) then
    Result := -2;
end;

function TAiFrame2007.Load(): Boolean;
begin
  Result := (FSource <> 0) and (FId > 0);
  if not(Result) then Exit;
  //FDateTimeCreate := FSource.GetFreimDateTimeCreate(FId);
  //if FDateTimeCreate = 0 then FDateTimeCreate := dtNow;
  //FFreimType := FSource.GetFreimType(FId);
end;

function TAiFrame2007.LoadFromFile(const AFileName: WideString): WordBool;
begin
  Result := False;
end;

function TAiFrame2007.LoadFromRecF64(Rec: TAIFreimRecF64): WordBool;
begin
  FId := Rec.Id;
  FFrameType := Rec.Typ;
  FDateCreate := Rec.DTCreate;
  Result := True;
end;

function TAiFrame2007.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := (AiFrameUtils.AiFrame_LoadFromXml(Self, Xml) >= 0);
end;

function TAiFrame2007.NewSlot(Name: WideString): IAiSlot;
var
  slot: TAISlot;
begin
  slot := TAISlot.Create();
  slot.Name := Name;
  AddSlot(slot);
  Result := slot;
end;

function TAiFrame2007.Regist(): Boolean;
begin
  Result := False;
  AddToLog(lgGeneral, ltError, stNotOverrideA);
end;

function TAiFrame2007.Save(): WordBool;
begin
  {if (FInitialized) and Assigned(FSource) and (FId > 0) then begin
    FSource.SetFreimType(FId, FFreimType);
    Result := True;
  end else} Result := False;
end;

function TAiFrame2007.SaveToFile(const AFileName: WideString): WordBool;
begin
  Result := False;
end;

function TAiFrame2007.SaveToRecF64(var Rec: TAIFreimRecF64): Boolean;
begin
  {Rec.Id := FId;
  Rec.Typ := FFreimType;
  Rec.DTCreate := FDateTimeCreate;
  if GetData.GetType = dtStream then
    Rec.DataSize := GetData.GetStream.GetSize
  else
    Rec.DataSize := 0;
  Rec.ConnectCount := GetConnects.GetCountConnects;
  Result := True;}
  Result := False;
end;

function TAiFrame2007.SaveToXml(Xml: IXmlNode): WordBool;
begin
  Result := (AiFrame_SaveToXml(Self, Xml) >= 0);
end;

procedure TAiFrame2007.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
end;

procedure TAiFrame2007.SetId(Value: TAId);
begin
  SetFrameId(Value);
end;

procedure TAiFrame2007.SetInitialized(Value: Boolean);
begin
  FInitialized := Value;
end;

procedure TAiFrame2007.SetFrameID(Value: TAIID);
begin
  if FInitialized then Exit;
  FID := Value;
end;

procedure TAiFrame2007.SetFrameType(Value: TAIID);
begin
  if FInitialized then Exit;
  FFrameType := Value;
end;

procedure TAiFrame2007.SetFreimType(Value: TAId);
begin
  if FInitialized then Exit;
  FFrameType := Value;
end;

procedure TAiFrame2007.SetSlotValue(SlotName: WideString; SlotValue: Variant);
var
  Slot: IAiSlot;
begin
  try
    slot := GetSlotByName(SlotName);
    if not(Assigned(slot)) then
      slot := NewSlot(SlotName);
    slot.Value := SlotValue;
  except
  end;
end;

procedure TAiFrame2007.SetXml(Value: WideString);
//var
//  Xml: IProfXmlNode;
begin
  {Xml := TProfXmlNode.Create(nil, nil, nil);
  Xml.Xml := Value;
  LoadFromXml(Xml);
  Xml.Free();}
end;

{function TAIFreim.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := False;
  if Assigned(FOnAddToLog) then
  try
    Result := (FOnAddToLog(AGroup, AType, AStrMsg, AParams) > 0);
  except
  end;
end;}

{function TAIFreim.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;}

{ TAiFreim }

function TAIFreim.Get_Connects(): IAiConnects;
begin
  Result := FConnects;
end;

function TAIFreim.Get_FreimName: WideString;
begin
  Result := Self.FName;
end;

function TAIFreim.Get_FreimType(): TAId;
begin
  Result := FFrameType;
end;

function TAIFreim.Get_Source1(): AiSource1;
begin
  Result := FSource;
end;

procedure TAIFreim.Set_FreimType(Value: TAId);
begin
  FFrameType := Value;
end;

procedure TAIFreim.Set_Source1(const Value: AiSource1);
begin
  //FSource := IAiSource1(Value);
end;

{ TAIFreimNamed }

{function TAIFreimNamed.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited LoadFromXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.ReadStringA(Xml, 'Description', FDescription);
  TProfXmlNode.ReadStringA(Xml, 'Name', FName);
  TProfXmlNode.ReadStringA(Xml, 'Title', FTitle);
end;}

{function TAIFreimNamed.SaveToXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited SaveToXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.WriteStringA(Xml, 'Description', FDescription);
  TProfXmlNode.WriteStringA(Xml, 'Name', FName);
  TProfXmlNode.WriteStringA(Xml, 'Title', FTitle);
end;}

end.
