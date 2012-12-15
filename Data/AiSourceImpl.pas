{**
@Abstract Базовый класс для источника фреймов
@Author Prof1983 <prof1983@ya.ru>
@Created 22.09.2005
@LastMod 15.12.2012
}
unit AiSourceImpl;

interface

uses
  SysUtils,
  AConsts2, ATypes,
  AiBase, AiDataIntf, AiFrameIntf, AiModuleImpl, AiSourceIntf;

type //** Запись для источника фреймов
  TAISourceRec3 = record
    ID: TAiId;
    Source: IAiSource2;
  end;

// TODO: Remove TAiModule from TAiSource

type //** Базовый класс для источника фреймов
  TAISource = class(TAIModule, IAiSource1, IAiSource2)
  protected
    //** Следующий свободный ID фрейма
    FNextFreeFreimID: Integer;
    //** Источник открыт
    FIsOpened: WordBool;
    //** Родительские БЗ
    FParents: array of TAISourceRec3;
  protected // IAiFreim
    function Get_FreimName(): WideString; safecall;
    function Get_FreimType(): TAId; safecall;
    function Get_Source1(): AiSource1; safecall;
    procedure Set_FreimType(Value: TAId); safecall;
    procedure Set_Source1(const Value: AiSource1); safecall;
  protected // IAiSource1
    function Get_Freim(Id: TAId): IAiFreim;
  protected
    //** Возвращает колличество фреймов
    function Get_FrameCount(): Integer; virtual; safecall;
    //** Возвращает фрейм
    function Get_FrameById(Id: TAiId): IAIFrame; virtual; safecall;
    //** Возвращает объект работы со связями фрейма
//    function Get_FrameConnectsByID(ID: TAIID): IAIConnects; virtual; safecall;
    //** Возвращает объект работы с данными фрейма
    function Get_FrameDataById(Id: TAiId): IAIData; virtual; safecall;
    //** Возвращает тип фрейма
    //function Get_FrameTypeByID(ID: TAIID): TAIID; virtual; safecall;
    function Get_IsOpened(): WordBool; virtual; safecall;
    function Get_NextFreeFrameID(): TAIID; virtual; safecall;
    //** Возвращает объект для работы с родительской БЗ
    function GetParent(Index: Integer): IAiSource2; safecall;
    //** Возвращает ID фрейма родительской БЗ
    function GetParentID(Index: Integer): TAIID;
    //** Задать фрейм
    procedure Set_FrameById(Id: TAiId; Value: IAIFrame); virtual; safecall;
    //** Задать связи фрейма
//    procedure Set_FrameConnectsByID(ID: TAIID; Value: IAIConnects); virtual; safecall;
    //** Задать данные фрейма
    procedure Set_FrameDataByID(ID: TAIID; Data: IAIData); virtual; safecall;
    procedure SetParent(Index: Integer; Value: IAiSource2); safecall;
    procedure SetParentID(Index: Integer; Value: TAIID); safecall;
  protected
    function Get_FrameDateTimeCreate(ID: TAIID): TDateTime; virtual;
    function Get_ItemID(Index: Integer): TAIID; virtual;
  public // IAiSource1
    function GetFreim(Id: TAId): IAiFreim;
  public
    //** Проверяет и создает базовые фреймы AIFreims
    function CheckFreims(): Boolean;
    function GetSelf1(): AiSource1;
    function GetSelf2(): AiSource2;
    //** Закрыть источник
    procedure Close(); virtual; safecall;
    //** Освободить объект
    procedure Free(); override;
    //** Открыть источник
    function Open(): AError; virtual; safecall;
  public
    //** Новый фрейм
    function NewFrame(Typ: TAIID; ID: TAIID = 0): TAIID; virtual; safecall;
    //** Создает и регистрирует новый тип фрейма Если AStructure задан, то AName игнорируется
    //function NewFreimType(const AName: WideString; AStruct: PStructFreimType = nil): TAIID; virtual;
  public
    property FrameById[Id: TAiId]: IAIFrame read Get_FrameById write Set_FrameById;
//    property FrameConnects[ID: TAIID]: IAIConnects read Get_FrameConnectsByID write Set_FrameConnectsByID;
    property FrameCount: Integer read Get_FrameCount;
    property FrameDatas[ID: TAIID]: IAIData read Get_FrameDataByID write Set_FrameDataByID;
    property NextFreeFrameID: TAIID read Get_NextFreeFrameID;
    //** Родительские БЗ
    property Parents[Index: Integer]: IAiSource2 read GetParent write SetParent;
    //** ID фреймов родительских БЗ
    property ParentsID[Index: Integer]: TAIID read GetParentID write SetParentID;
  end;

const // Сообщения -------------------------------------------------------------
  stCheckFreimsStart  = 'Проверка базовых фреймов в БЗ';
  stCheckFreimsCreate = 'Фрейм не найден -> Создание Id=%d Type=%d ConnectCount=%d DataType=%s Descript=%s';

implementation

{ TAiSource }

function TAISource.CheckFreims(): Boolean;
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

procedure TAISource.Close();
begin
  FIsOpened := False;
  SetLength(FParents, 0);
end;

procedure TAISource.Free();
begin
  {FSearch.Free;
  FSelect.Free;}
  inherited Free;
end;

function TAISource.GetFreim(Id: TAId): IAiFreim;
begin
  Result := nil;
end;

function TAISource.GetParent(Index: Integer): IAiSource2;
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

function TAISource.GetParentID(Index: Integer): TAIID;
begin
  if Index >= Length(FParents) then
    Result := 0
  else
    Result := FParents[Index].ID;
end;

function TAISource.GetSelf1(): AiSource1;
var
  S: IAiSource1;
begin
  S := Self;
  Result := AiSource1(S);
end;

function TAISource.GetSelf2(): AiSource2;
var
  S: IAiSource2;
begin
  S := Self;
  Result := AiSource2(S);
end;

function TAISource.Get_FrameDateTimeCreate(ID: TAIID): TDateTime;
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

function TAISource.Get_FrameById(ID: TAiId): IAIFrame;
begin
  Result := nil;
  AddToLog(lgDataBase, ltError, stNotOverride + '"GetFreim"');
end;

function TAISource.Get_FrameCount(): Integer;
begin
  Result := 0;
end;

{function TAISource3.Get_FrameConnectsByID(ID: TAIID): IAIConnects;
begin
  Result := nil;
  AddToLog(lgDataBase, ltInformation, stNotOverride + ' "GetFreimConnects"');
end;}

function TAISource.Get_FrameDataByID(ID: TAIID): IAIData;
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

function TAISource.Get_Freim(Id: TAId): IAiFreim;
begin
  Result := nil;
end;

function TAISource.Get_FreimName(): WideString;
begin
  Result := Self.FName;
end;

function TAISource.Get_FreimType(): TAId;
begin
  Result := Self.FFrameType;
end;

function TAISource.Get_IsOpened(): WordBool;
begin
  Result := FIsOpened;
end;

function TAISource.Get_ItemID(Index: Integer): TAIID;
begin
  Result := 0;
end;

function TAISource.Get_NextFreeFrameID(): TAIID;
begin
  Result := FNextFreeFreimID;
  Inc(FNextFreeFreimID);
end;

function TAISource.Get_Source1(): AiSource1;
begin
  Result := GetSelf1();
end;

function TAISource.NewFrame(Typ: TAIID; ID: TAIID = 0): TAIID;
begin
  Result := 0;
  AddToLog(lgDataBase, ltError, stNotOverride + ' "NewFrame"');
end;

{function TAISource.NewFreimType(const AName: WideString; AStruct: PStructFreimType): TAIID;
begin
  Result := 0;
  //AddToLog(lgDataBase, ltError, stNotOverrideA, ['NewFreimType']);
end;}

function TAISource.Open(): AError;
begin
  Result := -1;
end;

procedure TAISource.SetParent(Index: Integer; Value: IAiSource2);
begin
  if Index >= Length(FParents) then Exit;
  FParents[Index].Source := Value;
  if Assigned(Value) then
    FParents[Index].ID := Value.FrameID
  else
    FParents[Index].ID := 0;
end;

procedure TAISource.SetParentID(Index: Integer; Value: TAIID);
begin
  if Index >= Length(FParents) then Exit;
  FParents[Index].Id := Value;
  FParents[Index].Source := nil;
end;

procedure TAISource.Set_FrameById(Id: TAiId; Value: IAIFrame);
begin
end;

{procedure TAISource3.Set_FrameConnectsByID(ID: TAIID; Value: IAIConnects);
begin
  // ...
end;}

procedure TAISource.Set_FrameDataByID(ID: TAIID; Data: IAIData);
begin
  // ...
end;

{procedure TAISource.Set_FrameTypeByID(ID, Value: TAIID);
begin
  // ...
end;}

procedure TAISource.Set_FreimType(Value: TAId);
begin
  Self.FFrameType := Value;
end;

procedure TAISource.Set_Source1(const Value: AiSource1);
begin
end;

end.
