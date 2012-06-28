{**
@Abstract(Описания структур и типов для фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AiGlobals;

TODO: Separate AiGlobals -> AiConsts, AiTypes, AiUtils

interface

uses
  ATypes,
  AiBase, AiTypes;

type // Тип сообщения
  TAiMsgType = TMessageType;

type // Для передачи внутри программы
  TAiFreimRecFull = record
    Id: TAiId;
    Typ: TAiId;
    DTCreate: TDateTime;
    DataSize: UInt64;
    ConnectCount: UInt64;
    Data: String;
    Connects: array of TAIID;
  end;

const // Константы для преобразования типа сообщения ---------------------------
  AI_STR_MSG_TYPE: array[TAiMsgType] of string = ('', cMsgComand, cMsgEvent, cMsgAnswer, cMsgPing, '');
  AI_INT_MSG_TYPE: array[TAiMsgType] of Integer = (0, 1, 2, 3, 4, 5);

// Структуры для KnowlegeBase ==================================================

{type
  PConnects = AiTypes.PConnects;
  TConnects = AiTypes.TConnects;}

{type //** @abstract(Тип элемента данных фрейма структуры XML)
  TElementType = AiTypes.TElementType;}

{type
  TElement = AiTypes.TElement;
  PElements = AiTypes.PElements;
  TElements = AiTypes.TElements;}

type //** @abstract(Для записи структуры базовых фреймов AIFreims)
  _Freim = AiTypes.TAiFreimRec;

{type
  TPrototype = AiTypes.TPrototype;
  PPrototypes = AiTypes.PPrototypes;
  TPrototypes = AiTypes.TPrototypes;}

{type
  PStructFreimType = AiTypes.PStructFreimType;
  TStructFreimType = AiTypes.TStructFreimType;}

// Functions ===================================================================

function AIStrToMsgType(Value: string): TAIMsgType;
function IntToAIDataType(Value: Integer): TAIDataType;

implementation

// Functions -------------------------------------------------------------------

function AIStrToMsgType(Value: string): TAIMsgType;
var
  tmpMsgType: TAIMsgType;
begin
  Result := mtUncnown;
  for tmpMsgType := Low(TAIMsgType) to High(TAIMsgType) do
    if Value = AI_STR_MSG_TYPE[tmpMsgType] then begin
      Result := tmpMsgType;
      Exit;
    end;
end;

function IntToAIDataType(Value: Integer): TAIDataType;
var
  tmpDataType: TAIDataType;
begin
  Result := dtUncnown;
  for tmpDataType := Low(TAIDataType) to High(TAIDataType) do
    if INT_DATA_TYPE[tmpDataType] = Value then begin
      Result := tmpDataType;
      Exit;
    end;
end;

end.
