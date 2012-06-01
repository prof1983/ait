{**
@Abstract(Фрейм)
@Author(Prof1983 prof1983@ya.ru)
@Created(10.06.2007)
@LastMod(18.05.2012)
@Version(0.5)

Фрейм содержит слоты.
Является коолекцией слотов.
Слот не может быть записан в фрейме 2 раза.
Не может быть 2 слота с одинаковыми именами.

История версий:
0.0.1.2 - 20.06.2007 - GetSlotValueAsString()
0.0.1.1 - 20.06.2007 - Перенес TAISlot в AISlotImpl.pas, Создал IAIFrame, Сделал наследником от TAICollection
0.0.1.0 - 20.06.2007 - Убрал TAISlot.ValueType, Добавил TAISlot.Value
0.0.0.1 - 10.06.2007
}
unit AiFrameImpl20070620;

interface

uses
  AiBaseTypes, AiCollectionImpl, AiEntityImpl, AiFrameIntf, AiIteratorIntf, AiSlotIntf, AiSlotImpl;

type
  TAIFrame = class(TAICollection, IAIFrame)
  private
    // Слоты
    FSlots: array of IAiSlot2007;
    // Возвращает слот по индексу
    function GetSlotByIndex(Index: Integer): IAiSlot2007;
    // Возвращает слот по имени
    function GetSlotByName(Name: WideString): IAiSlot2007;
    // Возвращает количество слотов
    function GetSlotCount(): Integer;
  protected
    function GetSlotValueAsString(SlotName: WideString): WideString;
    procedure SetSlotValue(SlotName: WideString; SlotValue: Variant);
  public
    // Добавить слот
    function AddSlot(Slot: IAiSlot2007): Integer;
    // Сохранить в БЗ
    function Commit(): Boolean; override;
    // Новый слот
    function NewSlot(Name: WideString): IAiSlot2007;
    // Загрузить из БЗ
    function Update(): Boolean; override;
  public
    // Слот по индексу
    property SlotByIndex[Index: Integer]: IAiSlot2007 read GetSlotByIndex;
    // Слот по имени
    property SlotByName[Name: WideString]: IAiSlot2007 read GetSlotByName;
    // Количество слотов
    property SlotCount: Integer read GetSlotCount;
  end;

implementation

{ TAIFrame }

function TAIFrame.AddSlot(Slot: IAiSlot2007): Integer;
begin
  Result := Length(FSlots);
  SetLength(FSlots, Result + 1);
  FSlots[Result] := Slot;
end;

function TAIFrame.Commit: Boolean;
begin
  Result := inherited Commit;
end;

function TAIFrame.GetSlotByIndex(Index: Integer): IAiSlot2007;
begin
  if (Index >= 0) and (Index < Length(FSlots)) then
    Result := FSlots[Index]
  else
    Result := nil;
end;

function TAIFrame.GetSlotByName(Name: WideString): IAiSlot2007;
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

function TAIFrame.GetSlotCount(): Integer;
begin
  Result := Length(FSlots);
end;

function TAIFrame.GetSlotValueAsString(SlotName: WideString): WideString;
var
  slot: IAiSlot2007;
begin
  Result := '';
  slot := GetSlotByName(SlotName);
  if Assigned(slot) then
  try
    Result := slot.Value;
  except
  end;
end;

function TAIFrame.NewSlot(Name: WideString): IAiSlot2007;
var
  slot: TAISlot;
begin
  slot := TAISlot.Create();
  slot.Name := Name;
  AddSlot(slot);
  Result := slot;
end;

procedure TAIFrame.SetSlotValue(SlotName: WideString; SlotValue: Variant);
var
  slot: IAiSlot2007;
begin
  try
    slot := GetSlotByName(SlotName);
    if not(Assigned(slot)) then
      slot := NewSlot(SlotName);
    slot.Value := SlotValue;
  except
  end;
end;

function TAIFrame.Update(): Boolean;
begin
  Result := inherited Update();
end;

end.
