{**
@Abstract(Слот фрейма)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.06.2007)
@LastMod(13.06.2012)
@Version(0.5)

Содержит имя слота и значение слота.

История версий:
0.0.0.3 - 21.06.2007 - Добавил GetName, GetValue, SetName, SetValue
0.0.0.2 - 20.06.2007 - Перенес из AIFrameImpl
}
unit AiSlotImpl;

interface

uses
  Variants,
  ABase,
  AiEntityImpl, AiSlotIntf;

type //** Слот фрейма
  TAiSlot = class(TAiEntity, IAiSlot)
  private
    // Имя слота
    FName: WideString;
    // Данные слота. В том числе может быть указатель на сущность (AIID).
    FValue: Variant;
  public
    function GetName(): WideString;
    function GetSlotId(): TAId;
    function GetSlotName(): WideString;
    function GetSlotValue(): Variant;
    function GetSlotType(): TAId;
    function GetValue(): Variant;
    procedure SetName(Value: WideString);
    procedure SetValue(Value: Variant);
  public
    function ToString(): WideString;
  public
    // Имя слота
    property Name: WideString read FName write FName;
    // Данные слота. В том числе может быть указатель на сущность (AIID).
    property Value: Variant read FValue write FValue;
  end;

implementation

{ TAiSlot }

function TAiSlot.GetName(): WideString;
begin
  Result := FName;
end;

function TAiSlot.GetSlotId(): TAId;
begin
  Result := FId;
end;

function TAiSlot.GetSlotName(): WideString;
begin
  Result := FName;
end;

function TAiSlot.GetSlotType(): TAId;
begin
  Result := FEntityType;
end;

function TAiSlot.GetSlotValue(): Variant;
begin
  Result := FValue;
end;

function TAiSlot.GetValue(): Variant;
begin
  Result := FValue;
end;

procedure TAiSlot.SetName(Value: WideString);
begin
  FName := Value;
end;

procedure TAiSlot.SetValue(Value: Variant);
begin
  FValue := Value;
end;

function TAiSlot.ToString(): WideString;
begin
  Result := '';
end;

end.
