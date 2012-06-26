{**
@Abstract(Объект AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.09.2006)
@LastMod(26.06.2012)
@Version(0.5)

Объект AI наследник от фрейма.
Объект AI содержит в себе свойства и методы для интерпретации и выполнения.
Объект AI содержит в себе также информацию об авторе, версиии т.д.

PushMessage выполняет команду.
Команды:
  GetAttributes - Получить базовые (не изменяемые) свойства объекта
    Возвращает ответ:
      ...Answer GetAttributes Attr1="<Attr1>" ... AttrN="<AttrN>"
  GetPropertyCount - Получить колличество свойств
  GetPropertyByIndex - Получить свойство по индексу
  GetPropertyByName - Получить свойство по имени
  GetMethodCount - Получить колличество методов
  GetMethodByIndex - Получить метод по индексу
  GetMethodByName - Получить метод по имени
}
unit AiObjectImpl;

interface

uses
  SysUtils,
  AiFrameIntf, AiNamedFrameImpl, AiObjectIntf, AiSlotIntf;

type //** Объект AI
  TAiObject = class(TAiNamedFrame, IAiObject)
  private
    FAuthor: WideString;
    FCopyright: WideString;
    FHomePage: WideString;
  private
    function GetMethodCodeByName(const MethodName: WideString): WideString;
  public // IAiFrame
      //** Добавляет слот
    function AddSlot(Slot: IAiSlot2007): Integer;
      //** Создает новый слот
    function NewSlot(Name: WideString): IAiSlot2007;
  public
      // Срабатывает при получении сообщения
    //function AddMessageStr(const Msg: WideString): Integer; override;
  public
    property Author: WideString read FAuthor write FAuthor;
    property Copyright: WideString read FCopyright write FCopyright;
    property HomePage: WideString read FHomePage write FHomePage;
  public
    //property MethodCodeByIndex[Index: Integer]: WideString read GetMethodCodeByIndex;
    property MethodCodeByName[const MethodName: WideString]: WideString read GetMethodCodeByName;
  end;

implementation

{ TAiObject }

(*function TAIObject.AddMessageStr(const Msg: WideString): Integer;
{var
  m: TArlMessage;}
begin
  (*if TArlCodec.CheckIsARMessage(Msg) then
  begin
    m := TArlMessage.Create();
    if TArlCodec.Decode(Msg, m) = 0 then
    begin
      if m.MsgType = ARL_MESSAGE_TYPE_COMMAND then
      begin
        if m.MsgName = ARL_CMD_GET_ATTRIBUTES then
        begin
          SendMessage(TArlCodec.EncodeA(m.Receiver, m.Sender, ARL_Message_ANSWER,
            ARL_CMD_GET_ATTRIBUTES + ' ' +
            'Author='+'="'+FAuthor+'" '+
            'Copyright'+'="'+FCopyright+'" '+
            'HomePage'+' "'+FHomePage+'"'));
        end
        else if m.MsgName = ARL_CMD_GET_PROPERTY_COUNT then
        begin
          {SendMessage(TArlCodec.EncodeA(m.Receiver, m.Sender, ARL_MESSAGE_ANSWER,
            ARL_CMD_GET_PROPERTY_COUNT + ' ' +
            'PropertyCount'+'="'+IntToStr(Properties.Count)+'"'));}
        end
        else if m.MsgName = ARL_CMD_GET_PROPERTY_BY_INDEX then
        begin
          // ...
        end
        else if m.MsgName = ARL_CMD_GET_PROPERTY_BY_NAME then
        begin
          // ...
        end
        else if m.MsgName = ARL_CMD_GET_METHOD_COUNT then
        begin
          // ...
        end
        else if m.MsgName = ARL_CMD_GET_METHOD_BY_INDEX then
        begin
          // ...
        end
        else if m.MsgName = ARL_CMD_GET_METHOD_BY_NAME then
        begin
          // ...
        end;
      end
      else if m.MsgType = ARL_MESSAGE_TYPE_PING then
        Result := SendMessage(TArlCodec.EncodeA(m.Receiver, m.Sender,
          ARL_MESSAGE_ANSWER, ARL_MESSAGE_PING + ' ' + m.Content))
      else
        Result := inherited AddMessage(Msg);
    end;
    m.Free();
  end
  else*
    Result := inherited AddMessage(Msg);
end;*)

function TAiObject.AddSlot(Slot: IAiSlot2007): Integer;
begin
  Result := -1;
end;

function TAiObject.GetMethodCodeByName(const MethodName: WideString): WideString;
begin
  Result := '';
  // ...
  // TODO: Реализовать
end;

function TAiObject.NewSlot(Name: WideString): IAiSlot2007;
begin
  Result := nil;
end;

end.
