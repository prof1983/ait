{**
@Abstract(Фрейм)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.06.2007)
@LastMod(18.05.2012)
@Version(0.5)

Prototype: FramerD.OID

Фрейм содержит слоты.
Является коолекцией слотов.
Слот не может быть записан в фрейме 2 раза.
Не может быть 2 слота с одинаковыми именами. (?)
Каждый фрейм является некоторой сущностью. (?)

История версий:
0.0.5.5 - 09.07.2011
[+] Добавил: Каждый фрейм является некоторой сущностью.
[*] Переименовал AIFrame -> AIFrameIntf
0.0.0.1 - 20.06.2007 - Перенес из AIFrameImpl
}
unit AiFrameIntf;

interface

uses
  AiSlotIntf;

type
  IAiFrame2007 = interface // LastMod(20.06.2007)
      //** Добавляет слот
    function AddSlot(Slot: IAiSlot2007): Integer;
      //** Создает новый слот
    function NewSlot(Name: WideString): IAiSlot2007;
  end;
  IAiFrame = IAiFrame2007;

implementation

end.
