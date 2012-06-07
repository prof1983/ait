{**
@Abstract(Базовые типы для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2006)
@LastMod(30.05.2012)
@Version(0.5)

Prototype: org.framerd.OID

Каждый фрейм является некоторой сущностью.
}
unit AiFrameComImpl;

interface

uses
  Classes, ComObj, Forms, SysUtils,
  AConsts2, ANodeIntf, AObjectImpl, ATypes,
  AiBase, AiBaseTypes, AiDataIntf, AiFrame, AiIntf, AiFramePoolIntf;

{type
  // Аналог - org.framerd.FDType
  IAIValue = interface
  end;}

type
  //** @abstract(Фрейм)
  TAIFrame = class(TProfObject, IAIFrame)
  private
  protected
    //** Данные - объект источника. Если источника нет - локальный объект
    FData: IAIData;
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
  protected
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
      //** Возвращает источник
    function Get_Source2(): IAiSource2; safecall;
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
    function Get_Source(): IAISource2; safecall;
  public // IProfObject
    function GetConfig(): IProfNode; safecall;
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
    //** Разобрать и выполнить сообщение
    function AddMessage(const Msg: WideString): Integer; override; safecall;
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
    //** Источник фрейма
    property Source: IAISource2 read Get_Source;
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

implementation

{ TAIFrame }

function TAIFrame.AddMessage(const Msg: WideString): Integer;
begin
  Result := inherited AddMessage(Msg);
end;

function TAIFrame.Clear(): WordBool;
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

function TAIFrame.ConfigureLoad(AConfig: IProfNode): TProfError;
begin
  Result := 0;
end;

function TAIFrame.ConfigureSave(AConfig: IProfNode): TProfError;
begin
  Result := 0;
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
  FFreimType := 0;
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
  Result := IntToStr(FID);
end;

function TAIFrame.Get_FrameType(): TAIID;
begin
  Result := FFreimType;
end;

function TAIFrame.Get_IsReadOnly(): WordBool;
begin
  Result := False;
end;

function TAIFrame.Get_Pool(): IAIFramePool;
begin
  Result := FPool;
end;

function TAIFrame.Get_Source(): IAISource2;
begin
  Result := nil;
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

{function TAIFreim.SaveToXml(Xml: IXmlNode): WordBool;
var
  con: TAI_Connects;
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

procedure TAIFrame.SetDateTimeCreate(Value: TDateTime);
begin
  if FInitialized then Exit;
  FDateCreate := Value;
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
  FFreimType := Value;
end;

procedure TAIFrame.Set_Pool(const Value: IAIFramePool);
begin
  FPool := Value;
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
