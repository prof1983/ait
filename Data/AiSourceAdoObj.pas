{**
@Abstract(Источник знаний из БД ADO)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.09.2005)
@LastMod(30.05.2012)
@Version(0.5)

Структура описана в aiSourceAdoStruct.pas Необходимые фреймы описаны в aiGlobals.pas
}
unit AiSourceAdoObj;

interface

uses
  AdoDB, Forms, SysUtils,
  ABase, ADbDataModule1, ADbDescMain, ADbTypes, AConsts2, ATypes,
  AiFrameObj, AiIntf, AiSourceObj, AiSourceAdoStruct, AiType, AiTypes;

type //** @abstract(БЗ ADO)
  TAISourceAdo = class(TAISourceObject)
  private
    FDataModule: TProfDataModule;
    function GetDBFileName(): string;
    procedure SetDBFileName(Value: string);
  protected
    FTableConnects: TAdoTable;
    FTableFreims: TAdoTable;
  protected
    //FConnects: array of TAI_ConnectsFileCashe;
    //FDatas: array of TAI_DataFileCashe;
    FDBFileName: WideString;
    FNextId: Integer;
  public
    //** Возвращает True, если соединение активно
    function ActiveConnection(): Boolean;
    //** Возвращает True, если тиблица связей открыта
    function ActiveTableConnects(): Boolean;
    //** Возвращает True, если таблица фреймов открыта
    function ActiveTableFreims(): Boolean;
    function AssignedConnection(): Boolean;
    function AssignedTableConnects(): Boolean;
    function AssignedTableFreims(): Boolean;
    //** Проверяет связи в БД
    function CheckDBConnects(): Boolean;
    //** Проверяет и создает набор базовых фреймов в БД
    function CheckDBFreims(): Boolean;
    // Проверить фрейм "тип фрейма"
    // AId - Идентификатор проверяемого фрейма, если 0, то создается новый фрейм
    // AStruct - Описание структуры ф-типа
    // Result - Идентификатор фрейма после проверки (0 - проверка провалена/не создан)
    function CheckFreimType(AId: TAI_Id; AStruct: PStructFreimType): TAI_Id;
    function GetTableFreims(): TAdoTable;
    procedure SetTableFreims(Value: TAdoTable);
    function Open(): AError; override;
  public
    function Close(): AError; override;
    constructor Create(ADBFileName: WideString = ''; AAddToLog: TProcAddToLog = nil);
    function Finalize(): TProfError; override;
    procedure Free(); override;
    function Initialize(): TProfError; override;
  public
    property DataModule: TProfDataModule read FDataModule;
    property DBFileName: String read GetDBFileName write SetDBFileName;
    property TableConnects: TAdoTable read FTableConnects;
    property TableFreims: TAdoTable read GetTableFreims;
  public // Переопределение функций из TAI_Source
    //** Возвращает фрейм по его идентификатору. -Фрейм должен освобождаться вызывающей процедурой.
    function Get_Freim(ID: TAI_ID): TAiFrame2005; override;
    function NewFreim(AType: TAI_Id; AId: TAI_Id = 0): TAI_Id; override;
      // Создает и регистрирует новый тип фрейма Если AStructure задан, то AName игнорируется
    function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAI_ID; override;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stConnect_Error      = 'Ошибка при сознании соединения (Connection) к БД "%s"';
  stConnect_Ok         = 'Соединение (Connection) с БД установлено';
  stCreateOk           = 'Объект источник Ado создан';
  stNotActiveConnection      = 'Connection в БЗ не активно';
  stNotActiveTableConnects   = 'Таблица связей не открыта';
  stNotActiveTableFreims     = 'Таблица фреймов не открыта';
  stNotAssignedTableConnects = 'Таблица связей не задана';
  stNotAssignedTableFreims   = 'Таблица фреймов не задана';
  stReadError          = 'Ошибка при чтении записи из БЗ "%s"';
  stFinalizeOk         = 'Финализировано';
  stInitialize_Ok      = 'Объект "%s" инициализирован';
  stInitializeOk       = 'Инициализировано';

const // Константы конфигураций ------------------------------------------------
  config_DBFileName = 'DBFileName';
  config_NextId     = 'NextId';

implementation

{ TAISourceAdo }

function TAISourceAdo.ActiveConnection: Boolean;
begin
  Result := AssignedConnection;
  if not(Result) then Exit;
  Result := FDataModule.Connection.Connected;
  if not(Result) then
    AddToLog(lgDataBase, ltError, stNotActiveConnection);
end;

function TAISourceAdo.ActiveTableConnects: Boolean;
begin
  Result := AssignedTableConnects;
  if not(Result) then Exit;
  Result := FTableConnects.Active;
  if not(Result) then
    AddToLog(lgDataBase, ltError, stNotActiveTableConnects);
end;

function TAISourceAdo.ActiveTableFreims: Boolean;
begin
  Result := AssignedTableFreims;
  if not(Result) then Exit;
  Result := FTableFreims.Active;
  if not(Result) then
    AddToLog(lgDataBase, ltError, stNotActiveTableFreims);
end;

function TAISourceAdo.AssignedConnection: Boolean;
begin
  Result := Assigned(FDataModule.Connection);
  if not(Result) then
    AddToLog(lgDataBase, ltError, 'Connection в БЗ не задано');
end;

function TAISourceAdo.AssignedTableConnects: Boolean;
begin
  Result := Assigned(FTableConnects);
  if not(Result) then
    AddToLog(lgDataBase, ltError, stNotAssignedTableConnects);
end;

function TAISourceAdo.AssignedTableFreims: Boolean;
begin
  Result := Assigned(FTableFreims);
  if not(Result) then
    AddToLog(lgDataBase, ltError, stNotAssignedTableFreims);
end;

function TAISourceAdo.CheckDBConnects: Boolean;
begin
  Result := False;
end;

function TAISourceAdo.CheckDBFreims: Boolean;
begin
  Result := CheckFreims();
end;

function TAISourceAdo.CheckFreimType(AId: TAI_Id; AStruct: PStructFreimType): TAI_Id;
var
  Freim: TAIFreim;

  function Check: Boolean;
  {var
    S: WideString;}
  begin
    {Result := False;
    AStruct^.Name
    AStruct^.Title
    AStruct^.Description
    AStruct^.Elements
    AStruct^.Prototypes
    Freim.Data.Xml.ReadString('Name', S); if S <> AStruct^.Name then Exit;}

    Result := True;
  end;

begin
  Result := 0;
  // Чтение и проверка фрейма
  if AId > 0 then begin
    Freim := TAIFreim(GetFreim(AId));
    if Check then Result := AId;
    FreeAndNil(Freim);
    Exit;
  end;

  // Создание фрейма
  Result := NewFreimType('', AStruct);
end;

function TAISourceAdo.Close(): AError;
begin
  if Assigned(FTableFreims) then
  begin
    FTableFreims.Active := False;
    FTableFreims.Free;
    FTableFreims := nil;
  end;
  Result := inherited Close;
end;

constructor TAISourceAdo.Create(ADBFileName: WideString = ''; AAddToLog: TProcAddToLog = nil);
var
  DllPath: WideString;
begin
  inherited Create();
  Self.FOnAddToLog := AAddToLog;
  FDBFileName := ADBFileName;
  FNextId := 1024;
  FName := 'Ado';
  FTitle := 'SourceAdo';

  DllPath := ExtractFilePath(Application.ExeName)+'..\'+DEFAULT_MODULE_DIR+'\';
  if FDBFileName = '' then
    FDBFileName := ExtractFilePath(Application.ExeName)+'..\'+DEFAULT_DB_DIR+'\AR32.mdb';
  FDataModule := TProfDataModule.Create(DllPath, '', FDBFileName, DBMain, DescrDBMain, True, nil, False, AddToLog);

  AddToLog(lgDataBase, ltInformation, stCreateOk);
end;

function TAISourceAdo.Finalize: TProfError;
begin
  Result := inherited Finalize;
  AddToLog(lgDataBase, ltInformation, stFinalizeOk);
end;

procedure TAISourceAdo.Free;
begin
  {if Assigned(FConnection) then begin
    //FreeAndNil(FConnection);
  end;}

  if Assigned(FDataModule) then try
    FDataModule.Free;
  finally
    FDataModule := nil;
  end;

  inherited Free;
end;

function TAISourceAdo.GetDBFileName(): String;
begin
  Result := FDBFileName;
end;

function TAISourceAdo.Get_Freim(ID: TAI_ID): TAiFrame2005;
var
  Rec: TAIFreimRecF64;
begin
  Result := nil;
  if not(ActiveTableFreims) then Exit;
  FTableFreims.Locate(cFreimId, IntToStr(Id), []);
  try
    Rec.Id := FTableFreims.FieldByName(cFreimId).Value;
    Rec.Typ := FTableFreims.FieldByName(cFreimType).Value;
    Rec.DataSize := FTableFreims.FieldByName(cFreimDataSize).Value;
    Rec.ConnectCount := FTableFreims.FieldByName(cFreimConnectCount).Value;
    Rec.DTCreate := FTableFreims.FieldByName(cFreimDTCreate).Value;
  except
    on E: Exception do
    begin
      AddToLog(lgDataBase, ltError, Format(stReadError, [E.Message]));
      Exit;
    end;
  end;

  if Rec.ID = ID then
  begin
    Result := TAiFrame2005.Create();
    TAIFreim(Result).LoadFromRecF64(Rec);
  end;
end;

function TAISourceAdo.GetTableFreims: TAdoTable;
begin
  Result := FTableFreims;
end;

function TAISourceAdo.Initialize: TProfError;
begin
  Result := inherited Initialize;
  FDataModule.DBFileName := FDBFileName;
  FDataModule.CheckDB();
  FDataModule.OpenDB();
  FTableFreims := FDataModule.OpenTable(cFreim);
  FTableConnects := FDataModule.OpenTable(cConnects);

  CheckDBFreims;   // Проверить наличие базовых фреймов
  CheckDBConnects; // Проверить связи.

  AddToLog(lgDataBase, ltInformation, stInitializeOk);
end;

function TAISourceAdo.NewFreim(AType: TAI_Id; AId: TAI_Id = 0): TAI_Id;
begin
  Result := 0;
  if not(ActiveConnection) then Exit;
  if not(ActiveTableFreims) then Exit;
  if not(ActiveTableConnects) then Exit;

  if AId = 0 then begin
    if FNextId = 0 then Exit;
    AId := FNextId;
    Inc(FNextId);
  end;

  try
    FTableFreims.Insert;
    FTableFreims.FieldByName(cFreimId).Value := AId;
    FTableFreims.FieldByName(cFreimType).Value := 1{FFreimType};
    FTableFreims.FieldByName(cFreimConnectCount).Value := 0;
    FTableFreims.FieldByName(cFreimDataSize).Value := 0;
    FTableFreims.FieldByName(cFreimDTCreate).Value := Now;
    FTableFreims.Post;
    Result := AId;
  except
    on E: Exception do
    begin
      AddToLog(lgDataBase, ltError, Format('Произоша ошибка при добавлении новйо записи "%s" <%s.%s>', [E.message, ClassName, 'NewFreim']));
      Result := 0;
    end;
  end;
end;

function TAISourceAdo.NewFreimType(const AName: WideString; AStruct: PStructFreimType): TAI_ID;
var
  Freim: TAIType;
begin
  AddToLog(lgGeneral, ltInformation, Format('Регистрация типа фрейма "%s"', [AName]));
  Result := NewFreim(1);
  if Result > 0 then begin
    Freim := TAIType.Create;
    Freim.FreimType := 1;
    Freim.Id := Result;
    //Freim.Data.Clear;
    {with Freim.Data.Xml.NewNode('ELEMENT') do begin
      GetAttrByName('Name').Value := 'Name';
      GetAttrByName('Description').Value := 'Короткое имя фирмы';
    end;}

    FreeAndNil(Freim);
    AddToLog(lgGeneral, ltInformation, Format('Тип фрейма "%s" зарегистрирован. Id=%d', [AName, Result]));
  end else AddToLog(lgGeneral, ltError, Format('Тип фрейма "%s" не зарегистрирован', [AName]));
end;

function TAISourceAdo.Open(): AError;
begin
  if FOpened then
  begin
    Result := 1;
    Exit;
  end;
  {Result := False;
  if Asigned(FDataModule) then try
    FDataModule.DBFileName := FDBFileName;
    FDataModule.OpenDB();
  except
  end;}
  Result := Initialize();
end;

procedure TAISourceAdo.SetDBFileName(Value: String);
begin
  if FOpened then Exit;
  FDBFileName := Value;
end;

procedure TAISourceAdo.SetTableFreims(Value: TAdoTable);
begin
  if FOpened then Exit;
  FTableFreims := Value;
end;

end.
