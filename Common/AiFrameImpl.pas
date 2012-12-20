{**
@Abstract Базовые типы для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 26.04.2006
@LastMod 20.12.2012

Prototype: org.framerd.OID
Каждый фрейм является некоторой сущностью.
}
unit AiFrameImpl;

interface

uses
  SysUtils, XmlIntf,
  ABase, AConsts2, AEntityImpl, AIteratorIntf, ANodeIntf, ATypes, AXmlUtils,
  AiBase, AiBaseTypes, AiCollectionImpl, AiConnectsIntf, AiDataIntf, AiEntityImpl,
  AiFrameIntf, AiFrameObj, AiFramePoolIntf, AiFrameUtils, AiSlotIntf, AiSlotImpl, AiTypes;

type //** Фрейм
  TAiFrame = class(TAiEntity, IAiFrame)
  protected
      //** Данные - объект источника. Если источника нет - локальный объект
    FData: IAiData2;
      //** Дата создания
    FDateCreate: TDateTime;
      //** Дата изменения
    FDateModify: TDateTime;
      //** Инициализирован?
    FInitialized: Boolean;
      //** Пул (Источник)
    FPool: IAIFramePool;
      //** Тип фрейма
    FFrameType: TAId;
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
      // Путь расположения программы
    FPath: String;
  protected
      //** Слоты
    FSlots: array of IAiSlot;
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
    function Get_Source2(): AiSource2; safecall;
    //** Установыть дату создания
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    //** Установить Id. Если не инициализирован.
    procedure Set_FrameID(Value: TAIID); safecall;
    //** Установить тип
    procedure Set_FrameType(Value: TAIID); safecall;
    procedure Set_Source2(const Value: AiSource2); safecall;
  protected
    {** Возвращает источник }
    function Get_Pool(): IAiFramePool; deprecated;
    {** Установить источник. Только если не инициализирован. }
    procedure Set_Pool(const Value: IAiFramePool); deprecated;
  public // IAiFrame
      {** Добавляет слот }
    function AddSlot(Slot: IAiSlot): Integer;
      {** Создает новый слот }
    function NewSlot(Name: WideString): IAiSlot;
  public
      //** Срабатывает при создании
    procedure DoCreate(); virtual;
      //** Срабатывает при уничтожении
    procedure DoDestroy(); virtual;
      // Return config interface
    function GetConfig(): IProfNode; safecall; deprecated; // Use TProfObject.GetConfigNode
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
      //** Возвращает слот по индексу
    function GetSlotByIndex(Index: Integer): IAiSlot;
      //** Возвращает слот по имени
    function GetSlotByName(Name: WideString): IAiSlot;
      //** Возвращает количество слотов
    function GetSlotCount(): Integer;
    function GetSlotValueAsString(SlotName: WideString): WideString;
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
      //** Установить Id. Если не инициализирован.
    procedure SetFrameID(Value: TAIID); safecall;
      //** Установить тип
    procedure SetFrameType(Value: TAIID); safecall;
      //** Установить тип
    procedure SetFreimType(Value: TAId);
      //** Установить Id. Если не инициализирован.
    procedure SetId(Value: TAId);
      //** Инициализировать/Финализировать
    procedure SetInitialized(Value: Boolean);
    procedure SetSlotValue(SlotName: WideString; SlotValue: Variant);
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
    function Finalize(): AError; virtual;
      //** Произвести инициализацию. Установить связь с источником.
    function Initialize(): AError; virtual;
      //** Загрузить из источника
    function Load(): TAIError; virtual; safecall;
      //** Загрузить из AIData
    function LoadFromData(Data: IAIData): TAIError; virtual; safecall;
      //** Загрузить из файла
    function LoadFromFile(const AFileName: WideString): AError; virtual; safecall;
    function LoadFromRecF64(Rec: TAIFreimRecF64): WordBool; safecall;
      //** Load frame data from xml
    function LoadFromXml(Xml: IXmlNode): WordBool; virtual; deprecated 'Use AiFrame_LoadFromXml()';
      //** Зарегистрировать тип фрейма в источнике
    function Regist(): Boolean; virtual; safecall;
      //** Сохранить в источник
    function Save(): TAIError; virtual; safecall;
      //** Сохранить в файл
    function SaveToFile(const AFileName: WideString): WordBool; virtual; safecall;
      //** Save frame data to FrameRec64
    function SaveToRecF64(var Rec: TAIFreimRecF64): Boolean;
      //** Сохранить список связей в XML
    function SaveToXml(Xml: IXmlNode): WordBool; virtual; deprecated 'Use AiFrame_SaveToXml()';
  public
    constructor Create();
      //** Освободить
    procedure Free(); virtual;
  public
    //** Связи
    property Connects: IAiConnects read GetConnects;
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
    //** Frame identifier
    //property FreimId: TAId read FId write FId;
    //** Frame type
    //property FreimType: TAId read GetFreimType write SetFreimType;
    //** ID фрейма
    property ID: TAIID read Get_FrameID write Set_FrameID;
    //** Пул (Источник) фрейма
    property Pool: IAIFramePool read Get_Pool write Set_Pool;
      //** Слот по индексу
    property SlotByIndex[Index: Integer]: IAiSlot read GetSlotByIndex;
      //** Слот по имени
    property SlotByName[Name: WideString]: IAiSlot read GetSlotByName;
      //** Количество слотов
    property SlotCount: Integer read GetSlotCount;
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

  {$ifdef UseOldFrameIntf}
type // Фрейм
  TAIFreim = class(TAiFrame, IAIFreim)
  protected // IAiFreim
    function Get_Connects(): IAiConnects; safecall;
    function Get_FreimName(): WideString; safecall; deprecated 'Use Get_FrameName()';
    function Get_FreimType(): TAId; safecall; deprecated 'Use Get_FrameType()';
    function Get_Source1(): AiSource1; safecall;
    procedure Set_FreimType(Value: TAId); safecall; deprecated 'Use Set_FrameType()';
    procedure Set_Source1(const Value: AiSource1); safecall;
  end;
  {$endif}

implementation

{ TAiFrame }

function TAiFrame.AddSlot(Slot: IAiSlot): Integer;
begin
  Result := Length(FSlots);
  SetLength(FSlots, Result + 1);
  FSlots[Result] := Slot;
end;

function TAiFrame.Clear(): WordBool;
begin
  if Assigned(FConnects) then
  begin
    FreeAndNil(FConnects);
    FConnects := nil;
  end;
  if Assigned(FData) then
  begin
    FreeAndNil(FData);
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

{constructor TAiFrame.Create(ASource: AiSource2; AId: TAId);
begin
  inherited Create();
  DoCreate();
  FSource := ASource;
  Self.FName := IntToStr(FId);
end;}

procedure TAiFrame.DoCreate();
begin
  FConnects := nil;
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

function TAiFrame.Finalize(): AError;
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
  if (FSource = 0) then
  begin
    FConnects := nil;
    FData := nil;
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

function TAiFrame.GetConnects(): IAiConnects;
begin
  {if not(Assigned(FConnects)) then begin
    if (FInitialized) and Assigned(FSource) then
      FConnects := FSource.GetFreimConnects(FId);
    if not(Assigned(FConnects)) then
      FConnects := TAiConnects.Create();
  end;}
  Result := FConnects;
end;

function TAIFrame.GetData(): IAiData;
begin
  {if not(Assigned(FData)) then begin
    if (FInitialized) and Assigned(FSource) then
      FData := FSource.GetFreimData(FId);
    if not(Assigned(FData)) then
      FData := TAiDataObject.Create(Self, dtNone, AddToLog);
  end;}
  Result := FData;
end;

function TAiFrame.GetDateTimeCreate(): TDateTime;
begin
  Result := FDateCreate;
end;

function TAiFrame.GetFrameId(): TAiId;
begin
  Result := FID;
end;

function TAiFrame.GetFrameType(): TAiId;
begin
  Result := FFrameType;
end;

function TAiFrame.GetFreimType(): TAId;
begin
  Result := FFrameType;
end;

function TAiFrame.GetId(): AId;
begin
  Result := FId;
end;

function TAiFrame.GetInitialized(): Boolean;
begin
  Result := FInitialized;
end;

function TAiFrame.GetSlotByIndex(Index: Integer): IAiSlot;
begin
  if (Index >= 0) and (Index < Length(FSlots)) then
    Result := FSlots[Index]
  else
    Result := nil;
end;

function TAiFrame.GetSlotByName(Name: WideString): IAiSlot;
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

function TAiFrame.GetSlotCount(): Integer;
begin
  Result := Length(FSlots);
end;

function TAiFrame.GetSlotValueAsString(SlotName: WideString): WideString;
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
      FData := TAiDataObject.Create(Self, dtNone, AddToLog);
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

function TAiFrame.Get_Pool(): IAIFramePool;
begin
  Result := FPool;
end;

function TAiFrame.Get_Source2(): AiSource2;
begin
  Result := FSource;
end;

function TAiFrame.Initialize(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;
  Result := Load();
end;

function TAiFrame.Load(): TAIError;
begin
  Result := LoadFromData(Get_Data());
end;

function TAiFrame.LoadFromData(Data: IAIData): TAIError;
begin
  Result := -1;
end;

function TAiFrame.LoadFromFile(const AFileName: WideString): AError;
begin
  Result := -1; //False;
end;

function TAiFrame.LoadFromRecF64(Rec: TAiFreimRecF64): WordBool;
begin
  FId := Rec.Id;
  FFrameType := Rec.Typ;
  FDateCreate := Rec.DTCreate;
  Result := True;
end;

function TAiFrame.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := (AiFrameUtils.AiFrame_LoadFromXml(Self, Xml) >= 0);
end;

function TAiFrame.NewSlot(Name: WideString): IAiSlot;
var
  slot: TAiSlot;
begin
  slot := TAiSlot.Create();
  slot.Name := Name;
  AddSlot(slot);
  Result := slot;
end;

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

function TAiFrame.SaveToRecF64(var Rec: TAIFreimRecF64): Boolean;
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

function TAiFrame.SaveToXml(Xml: IXmlNode): WordBool;
begin
  Result := (AiFrame_SaveToXml(Self, Xml) >= 0);
end;

procedure TAiFrame.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
end;

procedure TAiFrame.SetFrameID(Value: TAIID);
begin
  if FInitialized then Exit;
  FID := Value;
end;

procedure TAiFrame.SetFrameType(Value: TAIID);
begin
  if FInitialized then Exit;
  FFrameType := Value;
end;

procedure TAiFrame.SetFreimType(Value: TAId);
begin
  if FInitialized then Exit;
  FFrameType := Value;
end;

procedure TAiFrame.SetId(Value: TAId);
begin
  SetFrameId(Value);
end;

procedure TAiFrame.SetInitialized(Value: Boolean);
begin
  FInitialized := Value;
end;

procedure TAiFrame.SetSlotValue(SlotName: WideString; SlotValue: Variant);
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

procedure TAiFrame.Set_Source2(const Value: AiSource2);
begin
  FSource := Value;
end;

procedure TAiFrame.Set_Pool(const Value: IAIFramePool);
begin
  FPool := Value;
end;

{ TAiFreim }

{$ifdef UseOldFrameIntf}
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
{$endif}

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
