{**
@Abstract(Слот фрейма)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.06.2007)
@LastMod(27.06.2012)
@Version(0.5)

Содержит имя слота и значение слота.
Аналог - org.framerd.FDType

История версий:
0.0.0.2 - 21.06.2007 - Добавил GetName, GetValue, SetName, SetValue
0.0.0.1 - 20.06.2007
}
unit AiSlotIntf;

interface

uses
  ABase;

type //** Слот фрейма
  IAiSlot = interface
    function GetName: WideString;
    function GetSlotId(): TAId;
    function GetSlotName(): WideString;
    function GetSlotValue(): Variant;
    function GetSlotType(): TAId;
    function GetValue: Variant;
    procedure SetName(Value: WideString);
    procedure SetValue(Value: Variant);

    // TODO: Удалить
    function ToString: WideString; {deprecated;}

    property Name: WideString read GetName write SetName;
      {** Идентификатор слота - уникальный идентификатор }
    property SlotId: TAId read GetSlotId;
      {** Имя слота }
    property SlotName: WideString read GetSlotName;
      {** Данные слота }
    property SlotValue: Variant read GetSlotValue;
      {** Тип слота }
    property SlotType: TAId read GetSlotType;
    property Value: Variant read GetValue write SetValue;
  end;

  IAiSlotList = interface
    function GetSlotById(SlotId: TAId): IAiSlot; safecall;
    function GetSlotByIndex(Index: Integer): IAiSlot; safecall;
    function GetSlotByName(const SlotName: WideString): IAiSlot; safecall;
    function GetSlotValueById(SlotId: TAId): Variant; safecall;
    function GetSlotValueByIndex(Index: Integer): Variant; safecall;
    function GetSlotValueByName(const SlotName: WideString): Variant; safecall;

    property SlotById[SlotId: TAId]: IAiSlot read GetSlotById;
    property SlotByIndex[Index: Integer]: IAiSlot read GetSlotByIndex;
    property SlotByName[const SlotName: WideString]: IAiSlot read GetSlotByName;
  end;

implementation

end.
