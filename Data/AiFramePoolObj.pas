{**
@Abstract Базовый класс для источника фреймов
@Author Prof1983 <prof1983@ya.ru>
@Created 22.09.2005
@LastMod 15.12.2012
}
unit AiFramePoolObj;

interface

uses
  SysUtils,
  ABase, AConsts2, ATypes,
  AiBase, AiBaseTypes, AiDataObj, AiFrameObj, AiPoolObj;

type
    //** Запись для источника фреймов
  TAiPoolRec = record
    Id: TAId;
    Pool: AiPool;
  end;

  TAiFrameListObject = class
  public
    function GetCount(): Integer;
    function GetFrameById(Id: TAId): TAiFrameObject;
    function GetFrameByUri(const Uri: WideString): TAiFrameObject;
    function GetFrameByGuid(Guid: TGuid): TAiFrameObject;
  public
      //** Колличество фреймов
    property Count: Integer read GetCount;
      //** Фреймы по ID
    property FrameById[Id: TAId]: TAiFrameObject read GetFrameById;
    property FrameByUri[const Uri: WideString]: TAiFrameObject read GetFrameByUri;
    property FrameByGuid[Guid: TGuid]: TAiFrameObject read GetFrameByGuid;
  end;

    //** Базовый класс для источника фреймов
  TAiFramePoolObject = class(TAiPoolObject)
  protected
    //** Начальный идентификатор для этого пула (источника) фреймов
    FBase: TAId;
    //** Вместимость хранилища
    FCapacity: Int64;
    //** Фреймы
    FFrames: TAiFrameListObject;
    //** Следующий свободный ID фрейма
    FNextFreeFreimID: Integer;
    //** Источник открыт
    FIsOpened: WordBool;
    //** Родительские БЗ
    FParents: array of TAiPoolRec;
  protected
    //** Возвращает базовый идентификатор (идентификатор с которого будет начинаться отсчет ID для фреймов)
    function GetBase(): TAId;
    //** Возвращает вместимость хранилища
    function GetCapacity(): Int64;
    //** Возвращает объект работы со списком фреймов
    function GetFrames(): TAiFrameListObject;
    function GetIsOpened(): WordBool; virtual;
    //** Возвращает объект для работы с родительской БЗ
    function GetParent(Index: Integer): AiPool;
    //** Возвращает Id фрейма родительской БЗ
    function GetParentId(Index: Integer): TAId;

    //** Возвращает колличество фреймов
    function Get_FrameCount(): Integer; virtual;
    //** Возвращает фрейм
    function Get_FrameById(Id: TAId): TAiFrameObject; virtual;
    //** Возвращает объект работы с данными фрейма
    function Get_FrameDataById(Id: TAId): TAiDataObject; virtual;
    function Get_NextFreeFrameId(): TAId; virtual;
    //** Задать фрейм
    procedure Set_FrameById(Id: TAId; Value: TAiFrameObject); virtual;
    //** Задать данные фрейма
    procedure Set_FrameDataById(Id: TAId; Data: TAiDataObject); virtual;
    procedure SetParent(Index: Integer; Value: AiPool);
    procedure SetParentId(Index: Integer; Value: TAId);
  protected
    function Get_FrameDateTimeCreate(Id: TAId): TDateTime; virtual;
    function Get_ItemId(Index: Integer): TAId; virtual;
  public
    //** Проверяет и создает базовые фреймы AIFreims
    function CheckFreims(): Boolean;
    function ToString(): WideString; virtual;
  public // IAiFramePool
    //** Закрыть источник
    procedure Close(); virtual;
    //** Сохранить все
    procedure Commit(); virtual;
    //** Пул (источник) содержит в себе фрейм
    function Contains(Id: TAId): WordBool; virtual;
    //** Заблокировать фрейм
    function LockFrame(x: TAId): WordBool; virtual;
    //** Заблокировать фрейм
    function LockFrameA(x: TAiFrameObject): WordBool; virtual;
    //** Заблокировать пул (источник)
    function LockPool(): WordBool; virtual;
    //** Пометить как измененый
    procedure MarkModified(x: TAId); virtual;
    //** Пометить как измененый
    procedure MarkModifiedA(x: TAiFrameObject); virtual;
    //** Создать новый фрейм
    function NewFrame(): TAId; virtual;
    //** Создать новый фрейм
    function NewFrameA(): TAiFrameObject; virtual;
    //** Новый фрейм
    function NewFrameB(Typ: TAId; Id: TAId = 0): TAId; virtual;
    //** Создает и регистрирует новый тип фрейма Если AStructure задан, то AName игнорируется
    //function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAIID; virtual;
    //** Открыть источник
    function Open(): AError; virtual;
  public
    //** Начальный идентификатор для этого пула (источника) фреймов
    property Base: TAIID read FBase write FBase;
    //** Вместимость хранилища
    property Capacity: Int64 read FCapacity write FCapacity;
    //** Объект работы со списком фреймов
    property Frames: TAiFrameListObject read FFrames;
    //** Родительские БЗ
    property Parents[Index: Integer]: AiPool read GetParent write SetParent;
    //** ID фреймов родительских БЗ
    property ParentsId[Index: Integer]: TAId read GetParentId write SetParentId;
  end;

const // Сообщения -------------------------------------------------------------
  stCheckFreimsStart  = 'Проверка базовых фреймов в БЗ';
  stCheckFreimsCreate = 'Фрейм не найден -> Создание Id=%d Type=%d ConnectCount=%d DataType=%s Descript=%s';

implementation

{ TAiFramePoolObject }

function TAiFramePoolObject.CheckFreims(): Boolean;
//var
//  Freim: TAIFreim;
//  I: Integer;
begin
  // TODO: Где-то здесь ошибка, приводящая к зависанию
  AddToLog(lgDataBase, ltInformation, stCheckFreimsStart);
  (*for I := 0 to High(AIFreims) do
  begin
    Freim := TAIFreim(GetFreim(AIFreims[I].Id));
    if not(Assigned(Freim)) and (AIFreims[I].Id > 0) then
    try
      AddToLog(lgDataBase, ltInformation, stCheckFreimsCreate, [AIFreims[I].Id, AIFreims[I].Typ, AIFreims[I].ConnectCount, RUS_DATA_TYPE[AIFreims[I].DataType], AIFreims[I].Descript]);
      // Создание фрейма
      Freim := TAIFreim(GetFreim(NewFreim(AIFreims[I].Typ, AIFreims[I].Id)));
      if not(Assigned(Freim)) then
      begin
        AddToLog(lgDataBase, ltError, 'Ошибка при создании фрейма. Фрейм не создан.', []);
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
        AddToLog(lgDataBase, ltError, 'Ошибка при проверке типа фрейма. "%s" <%s.%s>', [E.Message, ClassName, 'CheckFreims'])
      end;
    end;
  end;*)
  Result := False;
end;

procedure TAiFramePoolObject.Close();
begin
  FIsOpened := False;
  SetLength(FParents, 0);
end;

procedure TAiFramePoolObject.Commit();
begin
  // ...
end;

function TAiFramePoolObject.Contains(ID: TAIID): WordBool;
begin
  Result := False;
  // ...
end;

function TAiFramePoolObject.GetBase(): TAIID;
begin
  Result := FBase;
end;

function TAiFramePoolObject.GetCapacity(): Int64;
begin
  Result := FCapacity;
end;

function TAiFramePoolObject.GetFrames(): TAiFrameListObject;
begin
  Result := FFrames;
end;

function TAiFramePoolObject.GetIsOpened(): WordBool;
begin
  Result := FIsOpened;
end;

function TAiFramePoolObject.GetParent(Index: Integer): AiPool;
begin
  Result := 0;
  {if Index >= UInt32(Length(FParents)) then
    Result := nil
  else begin
    if not(Assigned(FParents[Index].Source)) then
    begin
      FParents[Index].Source := TAISource(GetSource.Freims[FParents[Index].ID]);
    end;
    Result := FParents[Index].Source;
  end;}
end;

function TAiFramePoolObject.GetParentID(Index: Integer): TAIID;
begin
  if Index >= Length(FParents) then
    Result := 0
  else
    Result := FParents[Index].ID;
end;

function TAiFramePoolObject.Get_FrameDateTimeCreate(ID: TAIID): TDateTime;
begin
  Result := 0;
end;

{function TAISource.Get_FrameDateTimeCreateByID(ID: TAIID): TDateTime;
begin
  Result := 0;
end;}

{function TAISource.Get_FrameTypeByID(ID: TAIID): TAIID;
begin

end;}

function TAiFramePoolObject.Get_FrameByID(ID: TAId): TAiFrameObject;
begin
  Result := nil;
  AddToLog(lgDataBase, ltError, stNotOverride + '"GetFreim"');
end;

function TAiFramePoolObject.Get_FrameCount(): Integer;
begin
  Result := 0;
end;

{function TAISource3.Get_FrameConnectsByID(ID: TAIID): IAIConnects;
begin
  Result := nil;
  AddToLog(lgDataBase, ltInformation, stNotOverride + ' "GetFreimConnects"');
end;}

function TAiFramePoolObject.Get_FrameDataByID(ID: TAId): TAiDataObject;
{var
  Freim: TAI_Freim;}
begin
  {Result := TAiDataObject.Create(Id);}
  {Freim := GetFreim(Id);
  if not(Assigned(Freim)) then begin
    Result := TAiDataObject.Create(nil, dtNone, AddToLogProf);
    Exit;
  end;
  Result := Freim.GetData;}
  Result := nil;
  AddToLog(lgDataBase, ltInformation, stNotOverride + ' "GetFreimData"');
end;

function TAiFramePoolObject.Get_ItemID(Index: Integer): TAIID;
begin
  Result := 0;
end;

function TAiFramePoolObject.Get_NextFreeFrameID(): TAIID;
begin
  Result := FNextFreeFreimID;
  Inc(FNextFreeFreimID);
end;

function TAiFramePoolObject.LockFrame(x: TAIID): WordBool;
begin
  Result := False;
  // ...
end;

function TAiFramePoolObject.LockFrameA(x: TAiFrameObject): WordBool;
begin
  Result := False;
  // ...
end;

function TAiFramePoolObject.LockPool(): WordBool;
begin
  Result := False;
  // ...
end;

procedure TAiFramePoolObject.MarkModified(x: TAIID);
begin
  // ...
end;

procedure TAiFramePoolObject.MarkModifiedA(x: TAiFrameObject);
begin
  // ...
end;

function TAiFramePoolObject.Open(): AError;
begin
  Result := -1;
end;

procedure TAiFramePoolObject.SetParent(Index: Integer; Value: AiPool);
begin
  if Index >= Length(FParents) then Exit;
  FParents[Index].Pool := Value;
  {if Assigned(Value) then
    FParents[Index].Id := Value.FrameID
  else
    FParents[Index].Id := 0;}
end;

procedure TAiFramePoolObject.SetParentID(Index: Integer; Value: TAId);
begin
  if Index >= Length(FParents) then Exit;
  FParents[Index].Id := Value;
  //FParents[Index].Pool := nil;
end;

function TAiFramePoolObject.NewFrame(): TAIID;
begin
  Result := 0;
  // ...
end;

function TAiFramePoolObject.NewFrameA(): TAiFrameObject;
begin
  Result := nil;
  // ...
end;

function TAiFramePoolObject.NewFrameB(Typ: TAIID; ID: TAIID = 0): TAIID;
begin
  Result := 0;
  AddToLog(lgDataBase, ltError, stNotOverride + ' "NewFrame"');
end;

{function TAISource.NewFreimType(const AName: WideString; AStruct: PStructFreimType): TAIID;
begin
  Result := 0;
  //AddToLog(lgDataBase, ltError, stNotOverrideA, ['NewFreimType']);
end;}

procedure TAiFramePoolObject.Set_FrameByID(ID: TAIID; Value: TAiFrameObject);
begin
end;

procedure TAiFramePoolObject.Set_FrameDataByID(ID: TAIID; Data: TAiDataObject);
begin
  // ...
end;

function TAiFramePoolObject.ToString(): WideString;
begin
  Result := 'Base = ' + IntToStr(FBase) + #13#10 +
            'Capacity = ' + IntToStr(FCapacity);
end;

{ TAiFrameListObject }

function TAiFrameListObject.GetCount(): Integer;
begin
  Result := 0;
end;

function TAiFrameListObject.GetFrameByGuid(Guid: TGuid): TAiFrameObject;
begin
  Result := nil;
end;

function TAiFrameListObject.GetFrameById(Id: TAId): TAiFrameObject;
begin
  Result := nil;
end;

function TAiFrameListObject.GetFrameByUri(const Uri: WideString): TAiFrameObject;
begin
  Result := nil;
end;

end.
