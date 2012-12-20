{**
@Abstract Фрейм
@Author Prof1983 <prof1983@ya.ru>
@Created 20.06.2007
@LastMod 20.12.2012

Prototype: FramerD.OID

Фрейм содержит слоты.
Является коолекцией слотов.
Слот не может быть записан в фрейме 2 раза.
Не может быть 2 слота с одинаковыми именами. (?)
Каждый фрейм является некоторой сущностью. (?)
}
unit AiFrameIntf;

interface

uses
  ABase,
  AiBase, AiConnectsIntf, AiDataIntf, AiSlotIntf;

type
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

      {** Добавляет слот }
    function AddSlot(Slot: IAiSlot): Integer;
      {** Создает новый слот }
    function NewSlot(Name: WideString): IAiSlot;

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

  {$ifdef UseOldFrameIntf}
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
  {$endif}

  // Аналог - org.framerd.FDType
  IAiValue = IAiSlotList;

implementation

end.
