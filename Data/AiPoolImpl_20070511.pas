{**
@Abstract(Базовый класс для источника фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(18.05.2012)
@Version(0.5)
}
unit AiPoolImpl_20070511;

// TODO: Rename to AiFramePoolImpl.pas

interface

uses
  SysUtils,
  AConsts2, ATypes,
  AiBase, AiBaseTypes, AiDataIntf, AiFrame, AiFrameListIntf, AiModuleImpl, AiFramePoolIntf;

type //** Запись для источника фреймов
  TAIPoolRec = record
    ID: TAIID;
    Source: IAIFramePool;
  end;

type //** Базовый класс для источника фреймов
  TAIFramePool = class(TAIModule, IAIFramePool)
  protected
    //** Начальный идентификатор для этого пула (источника) фреймов
    FBase: TAIID;
    //** Вместимость хранилища
    FCapacity: Int64;
    //** Фреймы
    FFrames: IAIFrameList;
    //** Следующий свободный ID фрейма
    FNextFreeFreimID: Integer;
    //** Источник открыт
    FIsOpened: WordBool;
    //** Родительские БЗ
    FParents: array of TAIPoolRec;
  protected
    //** Возвращает базовый идентификатор (идентификатор с которого будет начинаться отсчет ID для фреймов)
    function GetBase(): TAIID; safecall;
    //** Возвращает вместимость хранилища
    function GetCapacity(): Int64; safecall;
    //** Возвращает объект работы со списком фреймов
    function GetFrames(): IAIFrameList; safecall;
    function GetIsOpened(): WordBool; virtual; safecall;
    //** Возвращает объект для работы с родительской БЗ
    function GetParent(Index: Integer): IAIFramePool; safecall;
    //** Возвращает ID фрейма родительской БЗ
    function GetParentID(Index: Integer): TAIID;

    //** Возвращает колличество фреймов
    function Get_FrameCount(): Integer; virtual; safecall;
    //** Возвращает фрейм
    function Get_FrameByID(ID: TAIID): IAIFrame; virtual; safecall;
    //** Возвращает объект работы с данными фрейма
    function Get_FrameDataByID(ID: TAIID): IAIData; virtual; safecall;
    function Get_NextFreeFrameID(): TAIID; virtual; safecall;
    //** Задать фрейм
    procedure Set_FrameByID(ID: TAIID; Value: IAIFrame); virtual; safecall;
    //** Задать данные фрейма
    procedure Set_FrameDataByID(ID: TAIID; Data: IAIData); virtual; safecall;
    procedure SetParent(Index: Integer; Value: IAIFramePool); safecall;
    procedure SetParentID(Index: Integer; Value: TAIID); safecall;
  protected
    function Get_FrameDateTimeCreate(ID: TAIID): TDateTime; virtual;
    function Get_ItemID(Index: Integer): TAIID; virtual;
  protected
    procedure DoCreate(); override; safecall;
  public
    //** Проверяет и создает базовые фреймы AIFreims
    function CheckFreims(): Boolean;
    //** Финализировать
    function Finalize(): TProfError; override; //safecall;
    //** Освободить объект
    procedure Free(); override;
    //** Инициализировать
    function Initialize(): TProfError; override; //safecall;
    //** Загрузить данные из данных фрейма
    function Load(): TProfError; override; safecall;
    function ToString(): WideString; virtual; safecall;
  public // IAiFramePool
    //** Закрыть источник
    procedure Close(); virtual; safecall;
    //** Сохранить все
    procedure Commit(); virtual; safecall;
    //** Пул (источник) содержит в себе фрейм
    function Contains(ID: TAIID): WordBool; virtual; safecall;
    //** Заблокировать фрейм
    function LockFrame(x: TAIID): WordBool; virtual; safecall;
    //** Заблокировать фрейм
    function LockFrameA(x: IAIFrame): WordBool; virtual; safecall;
    //** Заблокировать пул (источник)
    function LockPool(): WordBool; virtual; safecall;
    //** Пометить как измененый
    procedure MarkModified(x: TAIID); virtual; safecall;
    //** Пометить как измененый
    procedure MarkModifiedA(x: IAIFrame); virtual; safecall;
    //** Создать новый фрейм
    function NewFrame(): TAIID; virtual; safecall;
    //** Создать новый фрейм
    function NewFrameA(): IAIFrame; virtual; safecall;
    //** Новый фрейм
    function NewFrameB(Typ: TAIID; ID: TAIID = 0): TAIID; virtual; safecall;
    //** Создает и регистрирует новый тип фрейма Если AStructure задан, то AName игнорируется
    //function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAIID; virtual;
    //** Открыть источник
    function Open(): TProfError; virtual; safecall;
  public
    //** Начальный идентификатор для этого пула (источника) фреймов
    property Base: TAIID read FBase write FBase;
    //** Вместимость хранилища
    property Capacity: Int64 read FCapacity write FCapacity;
    //** Объект работы со списком фреймов
    property Frames: IAIFrameList read FFrames;
    //** Родительские БЗ
    property Parents[Index: Integer]: IAIFramePool read GetParent write SetParent;
    //** ID фреймов родительских БЗ
    property ParentsID[Index: Integer]: TAIID read GetParentID write SetParentID;
  end;
  //TAIPool = TAIFramePool;
  //TAISource3 = TAIPool; // TODO: Удалить

const // Сообщения -------------------------------------------------------------
  stCheckFreimsStart  = 'Проверка базовых фреймов в БЗ';
  stCheckFreimsCreate = 'Фрейм не найден -> Создание Id=%d Type=%d ConnectCount=%d DataType=%s Descript=%s';

implementation

{ TAIPool }

function TAIFramePool.CheckFreims(): Boolean;
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

procedure TAIFramePool.Close();
begin
  FIsOpened := False;
  SetLength(FParents, 0);
end;

procedure TAIFramePool.Commit();
begin
  // ...
end;

function TAIFramePool.Contains(ID: TAIID): WordBool;
begin
  Result := False;
  // ...
end;

procedure TAIFramePool.DoCreate();
begin
  inherited DoCreate();
  FName := 'Source';
end;

function TAIFramePool.Finalize(): TProfError;
begin
  Result := inherited Finalize();
end;

procedure TAIFramePool.Free();
begin
  {FSearch.Free;
  FSelect.Free;}
  inherited Free;
end;

function TAIFramePool.GetBase(): TAIID;
begin
  Result := FBase;
end;

function TAIFramePool.GetCapacity(): Int64;
begin
  Result := FCapacity;
end;

function TAIFramePool.GetFrames(): IAIFrameList;
begin
  Result := FFrames;
end;

function TAIFramePool.GetIsOpened(): WordBool;
begin
  Result := FIsOpened;
end;

function TAIFramePool.GetParent(Index: Integer): IAIFramePool;
begin
  Result := nil;
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

function TAIFramePool.GetParentID(Index: Integer): TAIID;
begin
  if Index >= Length(FParents) then
    Result := 0
  else
    Result := FParents[Index].ID;
end;

function TAIFramePool.Get_FrameDateTimeCreate(ID: TAIID): TDateTime;
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

function TAIFramePool.Get_FrameByID(ID: TAIID): IAIFrame;
begin
  Result := nil;
  AddToLog(lgDataBase, ltError, stNotOverride + '"GetFreim"');
end;

function TAIFramePool.Get_FrameCount(): Integer;
begin
  Result := 0;
end;

{function TAISource3.Get_FrameConnectsByID(ID: TAIID): IAIConnects;
begin
  Result := nil;
  AddToLog(lgDataBase, ltInformation, stNotOverride + ' "GetFreimConnects"');
end;}

function TAIFramePool.Get_FrameDataByID(ID: TAIID): IAIData;
{var
  Freim: TAI_Freim;}
begin
  {Result := TAI_Data.Create(Id);}
  {Freim := GetFreim(Id);
  if not(Assigned(Freim)) then begin
    Result := TAI_Data.Create(nil, dtNone, AddToLogProf);
    Exit;
  end;
  Result := Freim.GetData;}
  Result := nil;
  AddToLog(lgDataBase, ltInformation, stNotOverride + ' "GetFreimData"');
end;

function TAIFramePool.Get_ItemID(Index: Integer): TAIID;
begin
  Result := 0;
end;

function TAIFramePool.Get_NextFreeFrameID(): TAIID;
begin
  Result := FNextFreeFreimID;
  Inc(FNextFreeFreimID);
end;

function TAIFramePool.Initialize(): TProfError;
begin
  Result := inherited Initialize();
end;

function TAIFramePool.Load(): TProfError;
begin
  LoadFromData(FData);
end;

function TAIFramePool.LockFrame(x: TAIID): WordBool;
begin
  Result := False;
  // ...
end;

function TAIFramePool.LockFrameA(x: IAIFrame): WordBool;
begin
  Result := False;
  // ...
end;

function TAIFramePool.LockPool(): WordBool;
begin
  Result := False;
  // ...
end;

procedure TAIFramePool.MarkModified(x: TAIID);
begin
  // ...
end;

procedure TAIFramePool.MarkModifiedA(x: IAIFrame);
begin
  // ...
end;

function TAIFramePool.Open(): TProfError;
begin
  Result := -1;
end;

procedure TAIFramePool.SetParent(Index: Integer; Value: IAIFramePool);
begin
  if Index >= Length(FParents) then Exit;
  FParents[Index].Source := Value;
  if Assigned(Value) then
    FParents[Index].ID := Value.FrameID
  else
    FParents[Index].ID := 0;
end;

procedure TAIFramePool.SetParentID(Index: Integer; Value: TAIID);
begin
  if Index >= Length(FParents) then Exit;
  FParents[Index].Id := Value;
  FParents[Index].Source := nil;
end;

function TAIFramePool.NewFrame(): TAIID;
begin
  Result := 0;
  // ...
end;

function TAIFramePool.NewFrameA(): IAIFrame;
begin
  Result := nil;
  // ...
end;

function TAIFramePool.NewFrameB(Typ: TAIID; ID: TAIID = 0): TAIID;
begin
  Result := 0;
  AddToLog(lgDataBase, ltError, stNotOverride + ' "NewFrame"');
end;

{function TAISource.NewFreimType(const AName: WideString; AStruct: PStructFreimType): TAIID;
begin
  Result := 0;
  //AddToLog(lgDataBase, ltError, stNotOverrideA, ['NewFreimType']);
end;}

procedure TAIFramePool.Set_FrameByID(ID: TAIID; Value: IAIFrame);
begin
end;

procedure TAIFramePool.Set_FrameDataByID(ID: TAIID; Data: IAIData);
begin
  // ...
end;

function TAIFramePool.ToString(): WideString;
begin
  Result := 'Base = ' + IntToStr(FBase) + #13#10 +
            'Capacity = ' + IntToStr(FCapacity);
end;

end.
