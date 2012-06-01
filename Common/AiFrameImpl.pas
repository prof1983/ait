{**
@Abstract(Базовые типы для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2006)
@LastMod(22.05.2012)
@Version(0.5)

Prototype: org.framerd.OID
Каждый фрейм является некоторой сущностью.
}
unit AiFrameImpl;

interface

uses
  SysUtils, XmlIntf,
  AConsts2, ANodeIntf, AObjectImpl, ATypes, AXmlUtils,
  AiBase, AiBaseTypes, AiDataIntf, AiFrame, AiFramePoolIntf, AiIntf, AiTypes;

type //** Фрейм
  TAIFrame = class(TProfObject, IAIFrame)
  protected
      //** Данные - объект источника. Если источника нет - локальный объект
    FData: IAIData;
      //** Дата создания
    FDateCreate: TDateTime; //FDateTimeCreate: TDateTime;
      //** Дата изменения
    FDateModify: TDateTime;
      //** Идентификатор (см. TProfEntity)
    //FID: TAIID;
      //** Инициализирован? (See TProfObject)
    //FInitialized: Boolean;
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
    FSource: IAiSource2;
  protected // From TAiFreim
      // Функция добавления в log (See TProfEntity)
    //FOnAddToLog: TAddToLog;
      // Путь расположения программы
    FPath: String;
  protected // IAiFrame
    function Get_Connects(): IAiConnects; safecall;
    //** Возвращает объект работы с данными
    function Get_Data(): IAIData; virtual; safecall;
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
    function Get_Source2(): IAiSource2; safecall;
    //** Установыть дату создания
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    //** Установить Id. Если не инициализирован.
    procedure Set_FrameID(Value: TAIID); safecall;
    //** Установить тип
    procedure Set_FrameType(Value: TAIID); safecall;
    //** Установить источник. Только если не инициализирован.
    procedure Set_Pool(const Value: IAIFramePool); safecall;
  public
      //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
      //** Срабатывает при уничтожении
    procedure DoDestroy(); override; safecall;
      // Return config interface
    function GetConfig(): IProfNode; safecall; deprecated; // Use TProfObject.GetConfigNode
      //** Возвращает дату создания
    function GetDateTimeCreate(): TDateTime;
      //** Инициализирован?
    function GetInitialized(): Boolean;
      //** Возвращает источник
    function GetSource(): IAISource2; safecall;
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
    procedure SetSource(Value: IAiSource2);
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
      //** Сохранить список связей в XML
    function SaveToXml(Xml: IXmlNode): WordBool; virtual;
  public
    //** Данные
    property Data: IAIData read Get_Data;
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
    property Source: IAISource2 read GetSource write SetSource;
    //** Источник фрейма
    property Source2: IAiSource2 read Get_Source2;
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
  //TAIFrame4 = TAIFrame;

type //** Фрейм
  TAiFrame2007 = class(TAIFrame)
  protected
    function Get_Connects(): IAIConnects; safecall;
      //** Возвращает объект работы с данными
    function Get_Data(): IAIData; virtual; safecall;
    function Get_DateTimeCreate(): TDateTime; safecall;
    function Get_FrameId(): TAiId; safecall;
    function Get_FrameName(): WideString; safecall;
    function Get_FrameType(): TAiId; safecall;
    function Get_FreimName(): WideString; safecall;
    function Get_FreimType(): TAIID; safecall;
    function Get_Source2(): IAiSource2; safecall;
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    procedure Set_FrameId(Value: TAiId); safecall;
    procedure Set_FrameType(Value: TAiId); safecall;
    procedure Set_FreimType(Value: TAiId); safecall;
    procedure Set_Source2(const Value: IAiSource2); safecall;
  protected
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
      //** Инициализирован?
    function GetInitialized(): Boolean;
      //** Возвращает фрейм в виде XML строки
    function GetXml(): WideString; virtual;
      //** Задать дату и время создания фрейма
    procedure SetDateTimeCreate(Value: TDateTime);
      //** Установить тип
    procedure SetFrameType(Value: TAIID); safecall;
      //** Установить Id. Если не инициализирован.
    procedure SetFrameID(Value: TAIID); safecall;
      // Установить тип
    procedure SetFreimType(Value: TAId);
      //** Инициализировать/Финализировать
    procedure SetInitialized(Value: Boolean);
    procedure SetXml(Value: WideString);
  public
      //** Очистить объект
    function Clear(): WordBool; virtual; safecall;
      //** Загрузить конфигурации
    //function ConfigureLoad: WordBool; override;
      //** Сохранить конфигурации
    //function ConfigureSave: WordBool; override;
    constructor Create(); override;
      //** Финализировать. Разорвать связь объекта с источником.
    function Finalize(): TProfError; override;
      //** Освободить
    procedure Free(); override;
      //** Произвести инициализацию. Установить связь с источником.
    function Initialize(): TProfError; override;
      //** Зарегистрировать тип фрейма в источнике
    function Regist(): Boolean; virtual; safecall;
  public
      //** Загрузить из источника
    function Load(): Boolean; virtual;
      //** Загрузить из файла
    function LoadFromFile(const AFileName: WideString): WordBool; virtual; safecall;
      //** Сохранить в источник
    function Save(): WordBool; virtual;
      //** Сохранить в файл
    function SaveToFile(const AFileName: WideString): WordBool; virtual; safecall;
      //** Сохранить в XML
    function SaveToXml(Xml: IXmlNode): WordBool; virtual;
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
      //** Фрейм в виде XML строки
    property Xml: WideString read GetXml write SetXml;
  end;

type // Фрейм
  TAIFreim = class(TAiFrame2007, IAIFreim)
  protected // IAiFrame
    function Get_Data(): IAiData; virtual; safecall;
    function Get_DateTimeCreate(): TDateTime; safecall;
    function Get_FrameId(): TAiId; safecall;
    function Get_FrameName(): WideString; safecall;
    function Get_FrameType(): TAiId; safecall;
    function Get_Source2(): IAiSource2; safecall;
    procedure Set_FrameId(Value: TAiId); safecall;
    procedure Set_FrameType(Value: TAiId); safecall;
  protected // IAiFreim
    function Get_Connects(): IAiConnects; safecall;
    function Get_FreimName(): WideString; safecall;
    function Get_FreimType(): TAId; safecall;
    function Get_Source1(): IAiSource1; safecall;
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    procedure Set_FreimType(Value: TAId); safecall;
    procedure Set_Source1(const Value: IAiSource1); safecall;
    //function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
    //function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
  protected
    procedure DoCreate(); override; safecall;
    procedure DoDestroy(); override; safecall;
    procedure SetDateTimeCreate(Value: TDateTime);
    procedure SetId(Value: TAId);             // Установить Id. Если не инициализирован.
    procedure SetInitialized(Value: Boolean); // Инициализировать/Финализировать
    procedure SetXml(Value: WideString);
  public // IAIFreim
    function LoadFromRecF64(Rec: TAIFreimRecF64): WordBool; safecall;
  public
    function GetId(): TAId;                   // Возвращает Id
    function GetInitialized(): Boolean;       // Инициализирован?
      // Возвращает источник
    function GetSource(): IAiSource2;
    function GetXml(): WideString; virtual;
  public
    function Clear(): WordBool; virtual;          // Очистить объект
    //function ConfigureLoad: WordBool; override; // Загрузить конфигурации
    //function ConfigureSave: WordBool; override; // Сохранить конфигурации
    constructor Create(ASource: IAiSource2 = nil; AId: TAId = 0);
      // Финализировать. Разорвать связь объекта с источником.
    function Finalize(): TProfError; override;
    procedure Free(); override;
      // Произвести инициализацию. Установить связь с источником.
    function Initialize(): TProfError; override;
    function Regist(): Boolean; virtual;         // Зарегистрировать тип фрейма в источнике
  public
    function Load(): Boolean; virtual;           // FromSource
    function LoadFromXml(Xml: IXmlNode): WordBool; virtual;
    function Save(): WordBool; virtual;          // ToSource
    function SaveToFile(const AFileName: WideString): WordBool; virtual;
    function SaveToRecF64(var Rec: TAIFreimRecF64): Boolean;
      //** Сохранить список связей в XML
    function SaveToXml(Xml: IXmlNode): WordBool; virtual;
  end;

implementation

{ TAIFrame }

function TAIFrame.Clear(): WordBool;
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

procedure TAIFrame.DoCreate();
begin
  inherited DoCreate();
//  FConnects := nil;
  FData := nil;
  FDateCreate := 0;
  FID := 0;
  FInitialized := False;
  FPool := nil;
  FFrameType := 0;
end;

procedure TAIFrame.DoDestroy();
begin
  inherited DoDestroy();
end;

function TAIFrame.Finalize(): TProfError;
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

procedure TAIFrame.Free();
begin
  {Finalize;}
  DoDestroy();
  inherited Free();
end;

function TAIFrame.GetConfig(): IProfNode;
begin
  Result := nil;
end;

(*function TAIFrame3.GetConnects(): TAIConnects;
begin
  {if not(Assigned(FConnects)) then begin
    if (FInitialized) and Assigned(FSource) then
      FConnects := FSource.GetFreimConnects(FId);
    if not(Assigned(FConnects)) then
      FConnects := TAI_Connects.Create;
  end;}
  Result := FConnects;
end;*)

function TAIFrame.GetDateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAIFrame.GetInitialized(): Boolean;
begin
  Result := FInitialized;
end;

function TAiFrame.GetSource(): IAiSource2;
begin
  Result := FSource;
end;

function TAIFrame.GetValue(): IAIValue;
begin
  Result := nil;
end;

function TAIFrame.GetXml(): WideString;
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

function TAIFrame.Get_Connects(): IAIConnects;
begin
  Result := nil{FConnects};
end;

function TAIFrame.Get_Data(): IAIData;
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

function TAIFrame.Get_DateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAIFrame.Get_FrameID(): TAIID;
begin
  Result := FID;
end;

function TAIFrame.Get_FrameName(): WideString;
begin
  Result := IntToStr(FId);
end;

function TAIFrame.Get_FrameType(): TAIID;
begin
  Result := FFrameType;
end;

function TAIFrame.Get_IsReadOnly(): WordBool;
begin
  Result := False;
end;

function TAIFrame.Get_Pool(): IAIFramePool;
begin
  Result := FPool;
end;

function TAIFrame.Get_Source2(): IAiSource2;
begin
  Result := nil;
end;

function TAIFrame.Initialize(): TProfError;
begin
  Result := 0;
  if FInitialized then Exit;
  Result := inherited Initialize();
  {Result :=} Load();
end;

function TAIFrame.Load(): TAIError;
begin
  Result := LoadFromData(Get_Data());

//  Result := Assigned(FSource) and (FID > 0);
//  if not(Result) then Exit;
  //FDateTimeCreate := FSource.GetFreimDateTimeCreate(FId);
  //if FDateTimeCreate = 0 then FDateTimeCreate := dtNow;
  //FFreimType := FSource.GetFreimType(FId);
end;

function TAIFrame.LoadFromData(Data: IAIData): TAIError;
begin
  Result := -1;
end;

function TAIFrame.LoadFromFile(const AFileName: WideString): TProfError;
begin
  Result := -1; //False;
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

function TAIFrame.Regist(): Boolean;
begin
  Result := False;
  AddToLog(lgGeneral, ltError, stNotOverrideA);
end;

function TAIFrame.Save(): TAIError;
begin
  {if (FInitialized) and Assigned(FSource) and (FId > 0) then begin
    FSource.SetFreimType(FId, FFreimType);
    Result := True;
  end else}
  Result := -1;
end;

function TAIFrame.SaveToFile(const AFileName: WideString): WordBool;
begin
  Result := False;
end;

function TAIFrame.SaveToXml(Xml: IXmlNode): WordBool;
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

procedure TAIFrame.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
end;

procedure TAiFrame.SetSource(Value: IAiSource2);
begin
  if FInitialized then Exit;
  FSource := Value;
end;

procedure TAIFrame.SetValue(Value: IAIValue);
begin
  // ...
end;

procedure TAIFrame.SetXml(Value: WideString);
//var
//  Xml: IProfXmlNode;
begin
  {Xml := TProfXmlNode.Create(nil, nil, nil);
  Xml.Xml := Value;
  LoadFromXml(Xml);
  Xml.Free();}
end;

procedure TAIFrame.Set_DateTimeCreate(Value: TDateTime);
begin
  FDateCreate := Value;
end;

procedure TAIFrame.Set_FrameID(Value: TAIID);
begin
  if FInitialized then Exit;
  FID := Value;
end;

procedure TAIFrame.Set_FrameType(Value: TAIID);
begin
  if FInitialized then Exit;
  FFrameType := Value;
end;

procedure TAIFrame.Set_Pool(const Value: IAIFramePool);
begin
  FPool := Value;
end;

{ TAiFrame2007 }

function TAiFrame2007.Clear: WordBool;
begin
  if Assigned(FConnects) then FreeAndNil(FConnects);
  if Assigned(FData) then FreeAndNil(FData);
  FDateCreate := 0;
  FId := 0;
  FInitialized := False;
  FSource := nil;
  FFrameType := 0;
  Result := True;
end;

{function TAIFreim.ConfigureLoad: WordBool;
begin
  Result := inherited ConfigureLoad;
end;}

{function TAIFreim.ConfigureSave: WordBool;
begin
  Result := inherited ConfigureSave;
end;}

constructor TAiFrame2007.Create();
begin
  inherited Create();
  FConnects := nil;
  FData := nil;
  FDateCreate := 0;
  FID := 0; //AID;
  FInitialized := False;
  FSource := nil; //ASource;
  FFrameType := 0;
  //if Assigned(Source) and (ID > 0) then Load();
  //DoCreate();
end;

function TAiFrame2007.Finalize(): TProfError;
begin
  if not(Assigned(FSource)) then
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
      FConnects := TAI_Connects.Create;
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

function TAiFrame2007.Get_Connects(): IAIConnects;
begin
  Result := FConnects;
end;

function TAiFrame2007.Get_Data(): IAIData;
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

function TAiFrame2007.Get_DateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrame2007.Get_FrameId: TAiId;
begin
  Result := Self.FID;
end;

function TAiFrame2007.Get_FrameName: WideString;
begin
  Result := Self.FName;
end;

function TAiFrame2007.Get_FrameType(): TAiId;
begin
  Result := Self.FFrameType;
end;

function TAiFrame2007.Get_FreimName(): WideString;
begin
  Result := IntToStr(FID);
end;

function TAiFrame2007.Get_FreimType(): TAiId;
begin
  Result := FFrameType;
end;

function TAiFrame2007.Get_Source2(): IAiSource2;
begin
  Result := IAISource2(FSource);
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
  Result := Assigned(FSource) and (FID > 0);
  if not(Result) then Exit;
  //FDateTimeCreate := FSource.GetFreimDateTimeCreate(FId);
  //if FDateTimeCreate = 0 then FDateTimeCreate := dtNow;
  //FFreimType := FSource.GetFreimType(FId);
end;

function TAiFrame2007.LoadFromFile(const AFileName: WideString): WordBool;
begin
  Result := False;
end;

{function TAIFreim.LoadFromRecF64(Rec: TAIFreimRecF64): WordBool;
begin
  FId := Rec.Id;
  FFreimType := Rec.Typ;
  FDateTimeCreate := Rec.DTCreate;
  Result := True;
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

(*function TAIFreim.SaveToRecF64(var Rec: TAIFreimRecF64): Boolean;
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
end;*)

function TAiFrame2007.SaveToXml(Xml: IXmlNode): WordBool;
{var
  con: TAI_Connects;}
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

procedure TAiFrame2007.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
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

procedure TAiFrame2007.SetXml(Value: WideString);
//var
//  Xml: IProfXmlNode;
begin
  {Xml := TProfXmlNode.Create(nil, nil, nil);
  Xml.Xml := Value;
  LoadFromXml(Xml);
  Xml.Free();}
end;

procedure TAiFrame2007.Set_DateTimeCreate(Value: TDateTime);
begin
  FDateCreate := Value;
end;

procedure TAiFrame2007.Set_FrameId(Value: TAiId);
begin
  Self.FId := Value;
end;

procedure TAiFrame2007.Set_FrameType(Value: TAiId);
begin
  Self.FFrameType := Value;
end;

procedure TAiFrame2007.Set_FreimType(Value: TAiId);
begin
  FFrameType := Value;
end;

procedure TAiFrame2007.Set_Source2(const Value: IAiSource2);
begin
  FSource := IAISource2(Value);
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

function TAIFreim.Clear: WordBool;
begin
  if Assigned(FConnects) then FreeAndNil(FConnects);
  if Assigned(FData) then FreeAndNil(FData);
  FDateCreate := 0;
  FId := 0;
  FInitialized := False;
  FSource := nil;
  FFrameType := 0;
  Result := True;
end;

constructor TAIFreim.Create(ASource: IAiSource2 = nil; AId: TAId = 0);
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

procedure TAIFreim.DoCreate();
begin
  inherited DoCreate();
end;

procedure TAIFreim.DoDestroy();
begin
  inherited DoDestroy();
end;

function TAIFreim.Finalize(): TProfError;
begin
  if not(Assigned(FSource)) then
  begin
    if Assigned(FConnects) then
    begin
      //FConnects.Free;
      FConnects := nil;
    end;
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

procedure TAIFreim.Free();
begin
  {Finalize;}
  DoDestroy();
  inherited Free();
end;

function TAIFreim.GetID(): TAI_ID;
begin
  Result := FId;
end;

function TAIFreim.GetInitialized(): Boolean;
begin
  Result := FInitialized;
end;

function TAIFreim.GetSource(): IAiSource2;
begin
  Result := FSource;
end;

function TAIFreim.GetXml(): WideString;
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

function TAIFreim.Get_Connects(): IAiConnects;
begin
  Result := FConnects;
end;

function TAIFreim.Get_Data(): IAiData;
begin
  Result := FData;
end;

function TAIFreim.Get_DateTimeCreate: TDateTime;
begin
  Result := FDateCreate;
end;

function TAIFreim.Get_FrameId(): TAiId;
begin
  Result := Self.FId;
end;

function TAIFreim.Get_FrameName(): WideString;
begin
  Result := Self.FName;
end;

function TAIFreim.Get_FrameType(): TAiId;
begin
  Result := Self.FFrameType;
end;

function TAIFreim.Get_FreimName: WideString;
begin
  Result := Self.FName;
end;

function TAIFreim.Get_FreimType: TAI_Id;
begin
  Result := FFrameType;
end;

function TAIFreim.Get_Source1(): IAiSource1;
begin
  Result := FSource;
end;

function TAIFreim.Get_Source2(): IAiSource2;
begin
  Result := nil;
end;

function TAIFreim.Initialize(): TProfError;
begin
  Result := 0;
  if FInitialized then Exit;
  FInitialized := True;
  Load;
  {Result := SetInitialized(True);}
end;

function TAIFreim.Load(): Boolean;
begin
  Result := True;
  {if not(FInitialized) then Exit;
  if not(Assigned(FSource)) then Exit;
  FDateTimeCreate := FSource.GetFreimDateTimeCreate(FId);
  if FDateTimeCreate = 0 then FDateTimeCreate := dtNow;
  FFreimType := FSource.GetFreimType(FId);}
end;

function TAIFreim.LoadFromRecF64(Rec: TAIFreimRecF64): WordBool;
begin
  FId := Rec.Id;
  FFrameType := Rec.Typ;
  FDateCreate := Rec.DTCreate;
  Result := True;
end;

function TAIFreim.LoadFromXml(Xml: IXmlNode): WordBool;
var
  Connects: IXmlNode;
begin
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Clear();
  AXmlUtils.ProfXmlNode_ReadInt64(Xml, 'ID', FId);
  AXmlUtils.ProfXmlNode_ReadDateTime(Xml, 'DateTimeCreate', FDateCreate);
  AXmlUtils.ProfXmlNode_ReadInt64(Xml, 'Type', FFrameType);
  Connects := AXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connects');
  GetConnects.LoadFromXml(Connects);
  //GetData.LoadFromXml(Xml.GetNodeByName('Data'));
  Result := True;
end;

function TAIFreim.Regist(): Boolean;
begin
  Result := False;
  AddToLog(lgGeneral, ltError, stNotOverrideA);
end;

function TAIFreim.Save(): WordBool;
begin
  {if (FInitialized) and Assigned(FSource) and (FId > 0) then begin
    FSource.SetFreimType(FId, FFreimType);
    Result := True;
  end else} Result := False;
end;

function TAIFreim.SaveToFile(const AFileName: WideString): WordBool;
begin
  Result := True;
end;

function TAIFreim.SaveToRecF64(var Rec: TAIFreimRecF64): Boolean;
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

function TAIFreim.SaveToXml(Xml: IXmlNode): WordBool;
var
  Connects: IXmlNode;
begin
  Result := Assigned(Xml);
  if not(Result) then Exit;
  AXmlUtils.ProfXmlNode_WriteInt64(Xml, 'ID', FId);
  AXmlUtils.ProfXmlNode_WriteDateTime(Xml, 'DateTimeCreate', FDateCreate);
  AXmlUtils.ProfXmlNode_WriteInt64(Xml, 'Type', FFrameType);
  Connects := AXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connects');
  GetConnects.SaveToXml(Connects);
  //Data.SaveToXml(Xml.GetNodeByName('Data'));
end;

procedure TAIFreim.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
end;

procedure TAIFreim.SetId(Value: TAI_Id);
begin
  if FInitialized then Exit;
  FId := Value;
end;

procedure TAIFreim.SetInitialized(Value: Boolean);
begin
  FInitialized := Value;
end;

procedure TAIFreim.SetXml(Value: WideString);
{var
  Xml: IProfXmlNode;}
begin
  {Xml := TProfXmlNode.Create(nil, nil, nil);
  Xml.Xml := Value;
  LoadFromXml(Xml);
  Xml.Free();}
end;

procedure TAIFreim.Set_DateTimeCreate(Value: TDateTime);
begin
  FDateCreate := Value;
end;

procedure TAIFreim.Set_FrameId(Value: TAiId);
begin
  Self.FId := Value;
end;

procedure TAIFreim.Set_FrameType(Value: TAiId);
begin
  Self.FFrameType := Value;
end;

procedure TAIFreim.Set_FreimType(Value: TAI_Id);
begin
  FFrameType := Value;
end;

procedure TAIFreim.Set_Source1(const Value: IAiSource1);
begin
  //FSource := IAiSource1(Value);
end;

{function TAIFreim.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := False;
  if Assigned(FOnAddToLog) then try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;}

{function TAIFreim.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  AddToLog(AGroup, AType, AStrMsg, AParams);
  Result := 0;
end;}

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
