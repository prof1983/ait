{**
@Abstract(Коллекция)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(16.03.2012)
@Version(0.5)

История версий:
0.0.5.5 - 14.07.2011 - [+] ACollection, AIterator, Collection_GetCount, Collection_GetIterator
0.0.1.1 - 01.06.2007 - IAICollection.Iterator
}
unit AiCollection;

// TODO: Rename to AiCollectionIntf.pas

interface

uses
  ABase, AiBase, AiBaseTypes, AiIteratorIntf;

type //** Коллекция
  IAiCollection = interface
    //** Создает и возвращает итератор
    function GetIterator(): IAIIterator;

    property Iterator: IAIIterator read GetIterator;
  end;

type
  IAiArray = interface(IAiCollection)
    //** Колличество элементов
    function GetCount(): Integer;
    function Insert(Index: Integer; Element: TAId): Boolean;
    function RemoteByIndex(Index: Integer): Boolean;
  end;

type
  IAiSet = interface(IAiCollection)
  end;

type
  IAiMap = interface(IAiCollection)
    function GetElement(Key: TAId): TAId;
    procedure SetElement(Key, Value: TAId);
    procedure AddElement(Key, Value: TAId);
    function RemoteKey(Key: TAId): Boolean;     // RemoteElementByKey
    function RemoteValue(Value: TAId): Boolean; // RemoteElementByValue
  end;

{type
  // Поток данных
  IAIStream = interface
    function ReadBool(): Boolean;
    function ReadInt(): Integer;
    function ReadFloat(): Double;
    function ReadString(): WideString;

    procedure SetPosition(Pos: Integer);

//    function ReadBool8(): Boolean;
//    function ReadBool16(): Boolean;
//    function ReadBool32(): Boolean;
  end;}

type
  ACollection = IAiCollection;
  AIterator = IAiIterator;

function Collection_GetCount(Collection: ACollection): AInteger;
// Создает и возвращает итератор
function Collection_GetIterator(Collection: ACollection): AIterator;

implementation

function Collection_GetCount(Collection: IAICollection): AInteger;
begin
  Result := 0;
end;

function Collection_GetIterator(Collection: ACollection): AIterator;
begin
  Result := Collection.GetIterator;
end;

end.
