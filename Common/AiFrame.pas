{**
@Abstract(Описание интерфейса IAiFrame)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(08.06.2012)
@Version(0.5)

Prototype: org.framerd.OID

Каждый фрейм является некоторой сущностью.
}
unit AiFrame;

interface

uses
  AObjectIntf,
  AiBase, AiBaseTypes, AiConnectsIntf, AiDataIntf, AiSlotIntf;

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

  //** Аналог - org.framerd.FDType
  IAiValue = IAiSlotList;

  {** Фрейм - единица знаний.
      В случае использования БЗ OWL тип фрейма всегда edtXml. }
  IAiFrame = interface
    function Get_Data(): AiDataIntf.IAiData2; safecall;
    function Get_DateTimeCreate(): TDateTime; safecall;
    function Get_FrameId(): TAId; safecall;
    function Get_FrameName(): WideString; safecall;
    function Get_FrameType(): TAId; safecall;
    function Get_Source2(): AiSource2; safecall;
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    procedure Set_FrameId(Value: TAId); safecall;
    procedure Set_FrameType(Value: TAId); safecall;

      {** Данные фрейма }
    property Data: AiDataIntf.IAiData2 read Get_Data;
      {** Дата создания }
    property DateTimeCreate: TDateTime read Get_DateTimeCreate write Set_DateTimeCreate;
      {** Идентификатор }
    property FrameId: TAId read Get_FrameId write Set_FrameId;
      {** Тип фрейма }
    property FrameType: TAId read Get_FrameType write Set_FrameType;
      {** Имя фрейма }
    property Name: WideString read Get_FrameName;
      {** Источник фрейма }
    property Source2: AiSource2 read Get_Source2;
  end;

  IAiFreim = interface(IAiFrame)
    function Get_Connects: IAiConnects; safecall;
    function Get_FreimName: WideString; safecall;
    function Get_FreimType(): TAId; safecall;
    function Get_Source1(): AiSource1; safecall;
    procedure Set_FreimType(Value: TAId); safecall;
    procedure Set_Source1(const Value: AiSource1); safecall;

      {** Связи с другими фреймами }
    property Connects: IAiConnects read Get_Connects;
    property FreimType: TAId read Get_FreimType write Set_FreimType;
    property Name: WideString read Get_FreimName;
    property Source: AiSource1 read Get_Source1 write Set_Source1;
  end;

implementation

end.
