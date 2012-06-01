{**
@Abstract(Описание интерфейса IAiFrame)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(26.04.2012)
@Version(0.5)

Prototype: org.framerd.OID

Каждый фрейм является некоторой сущностью.
}
unit AiFrame;

interface

uses
  AObjectIntf,
  AiBase, AiBaseTypes, AiDataIntf, AiIntf, AiSlotIntf;

type
  IAiEntity = IProfObject;

type
  IAiSlot = AiSlotIntf.IAiSlot_20071128;

type
  IAiSlotList = interface
    function GetSlotByID(SlotID: TAIID): IAISlot; safecall;
    function GetSlotByIndex(Index: Integer): IAISlot; safecall;
    function GetSlotByName(const SlotName: WideString): IAISlot; safecall;
    function GetSlotValueByID(SlotID: TAIID): Variant; safecall;
    function GetSlotValueByIndex(Index: Integer): Variant; safecall;
    function GetSlotValueByName(const SlotName: WideString): Variant; safecall;

    property SlotByID[SlotID: TAIID]: IAISlot read GetSlotByID;
    property SlotByIndex[Index: Integer]: IAISlot read GetSlotByIndex;
    property SlotByName[const SlotName: WideString]: IAISlot read GetSlotByName;
  end;

type
  //** Аналог - org.framerd.FDType
  IAiValue = IAiSlotList;

type
  {**
    Фрейм - единица знаний.
    В случае использования БЗ OWL тип фрейма всегда edtXml.
  }
  IAiFrame = AiIntf.IAiFrame;

implementation

end.
