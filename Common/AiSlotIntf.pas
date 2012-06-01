{**
@Abstract(Слот фрейма)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.06.2007)
@LastMod(18.05.2012)
@Version(0.5)

Содержит имя слота и значение слота.

История версий:
0.0.0.2 - 21.06.2007 - Добавил GetName, GetValue, SetName, SetValue
0.0.0.1 - 20.06.2007
}
unit AiSlotIntf;

interface

uses
  AiBase;

type //** Слот фрейма
  IAiSlot2007 = interface // LastMod(21.06.2007)
    function GetName: WideString;
    function GetValue: Variant;
    procedure SetName(Value: WideString);
    procedure SetValue(Value: Variant);

    // TODO: Удалить
    function ToString: WideString; {deprecated;}

    property Name: WideString read GetName write SetName;
    property Value: Variant read GetValue write SetValue;
  end;
  //IAiSlot = IAiSlot2007;

type //** Слот фрейма
  IAiSlot_20071128 = interface
    function GetSlotID(): TAiID;
    function GetSlotName(): WideString;
    function GetSlotValue(): Variant;
    function GetSlotType(): TAiID;

    //** Идентификатор слота - уникальный идентификатор
    property SlotID: TAiID read GetSlotID;
    //** Имя слота
    property SlotName: WideString read GetSlotName;
    //** Данные слота
    property SlotValue: Variant read GetSlotValue;
    //** Тип слота
    property SlotType: TAiID read GetSlotType;
  end;

implementation

end.
