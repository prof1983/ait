{**
@Abstract(Файловый пул (источник знаний))
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(13.06.2012)
@Version(0.5)

Пул хранения сущностей в файле

История версий:
0.0.2.3 - 06.07.2007 - GetIsOpened()
0.0.2.2 - 04.07.2007
0.0.2.1 - 29.06.2007 - Модифицировал OpenCreate()
0.0.2.0 - 24.06.2007 - Добавил NextFreeID
0.0.1.2 - 24.06.2007 - Изменил Open()
0.0.1.1 - 24.06.2007 - Изменил TFileHeader.Prof -> TFileHeader.Prefix = 'AiXX'
0.0.1.0 - 01.06.2007 - Добавил GetIterator()
0.0.0.3 - Добавил TFileHeader
0.0.0.4 - Добавил методы: WriteBoolValue, WriteIntValue, WriteFloatValue, WriteStringValue, WriteEntity
}
unit AiFilePoolImpl;

interface

uses
  AIteratorIntf,
  AiBase, AiBaseTypes, AiPoolImpl;

type
  TFileHeader = packed record // 16 байт + 16 байт
    //** Префикс файла. Указывает принадлежность файла AiXX
    Prefix: array[0..3] of Char; // 'AiXX'
    //** Тип файла. Указывает тип файла "Pool"
    FileType: array[0..3] of Char; // 'Pool'
    //** Версия типа. Версия типа определяет структуру файла.
    FileTypeVersion: TAiVersion;   // $00000100 = 0.0.1.0
    {**
      Следующий свободный порядковый идентификатор фрейма начиная от FBase.
      Может принимать значения от 0 до Capacity.
    }
    NextFreeId: Integer;
    //** Начальный идентификатор для этого пула (источника) фреймов
    Base: Int64;
    //** Вместимость хранилища
    Capacity: Int64;
  end;

type
  TAiEntityRec = packed record // 32 байта - размер всего блока; 18 байт - размер заголовка блока
    // Задает смещение от FBase
    EntityOffset: Int64; //EntityID: Int64;
    EntityType: Int64;
    ValueType: Word;
    //Reserved1: Word;
    //Reserved2: Integer;
    //Reserved3: Int64;
  end;

type
  //** @abstract(Файловый пул (источник знаний))
  TAiFilePool = class(TAIPool)
  private
    //** Файл
    FFile: file;
    //** Имя файла
    FFileName: WideString;
    FIsOpened: Boolean;
    {**
      Следующий свободный порядковый идентификатор фрейма начиная от FBase.
      Может принимать значения от 0 до Capacity.
    }
    FNextFreeId: Integer;
  protected
    function ReadBoolValue(): Boolean;
    function ReadIntValue(): Integer;
    function ReadFloatValue(): Double;
    function ReadStringValue(): WideString;
    function ReadEntity(Index: Integer): TAIEntityRec;
    function ReadNextEntity(): TAIEntityRec;
    function WriteBoolValue(Value: Boolean): Boolean;
    function WriteIntValue(Value: Integer): Boolean;
    function WriteFloatValue(Value: Double): Boolean;
    function WriteStringValue(Value: WideString): Boolean;
    function WriteEntity(Index: Integer; Value: TAIEntityRec): Boolean;
  protected
    {**
    Возвращает колличество записаных сущностей
    (колличество использованых идентификаторов)
    }
    function GetCount(): Int64; override;
    {**
    Возвращает итератор.
    Служит для перечисления всех сущностей по порядку
    }
    function GetIterator(): IAIterator; override;
    //** Возвращает True, если открыт
    function GetIsOpened(): Boolean; override;
  public
    //** Закрыть пул (источник)
    procedure Close(); override;
    //** Пул (источник) содержит в себе сущность
    function Contains(ID: TAId): Boolean; override;
    // Создать новую сущность (заререзвировать идентификатор под сущность)
    function NewEntity(EntityType: TAId): TAId; override;
    //** Открыть пул (источник)
    function Open(): TAiError; override;
    //** Создать и открыть пул (источник)
    function OpenCreate(Base: Int64 = 0; Capacity: Int64 = 0): TAiError;
  public
    //** Имя файла
    property FileName: WideString read FFileName write FFileName;
  end;

implementation

{ TAIFilePool }

procedure TAiFilePool.Close();
var
  Header: TFileHeader;
  res: Integer;
begin
  inherited Close();

  // Запишем заголовок
  Seek(FFile, 0);
  BlockRead(FFile, Header, SizeOf(Header), res);
  //Header.Base := FBase;
  //Header.Capacity := FCapacity;
  Header.NextFreeID := FNextFreeID;
  Seek(FFile, 0);
  BlockWrite(FFile, Header, SizeOf(Header), res);

  CloseFile(FFile);

  FIsOpened := False;
end;

function TAiFilePool.Contains(ID: TAId): Boolean;
begin
  Result := inherited Contains(ID);
  // ...
end;

function TAiFilePool.GetCount(): Int64;
begin
  Result := 0;
  // ...
end;

function TAiFilePool.GetIsOpened(): Boolean;
begin
  Result := FIsOpened;
end;

function TAiFilePool.GetIterator(): IAIterator;
begin
  Result := nil;
  //Result := TAIIterator.Create();
  // ...
end;

function TAiFilePool.NewEntity(EntityType: TAId): TAId;
begin
  if FNextFreeID >= FCapacity then
    Result := 0
  else
  begin
    Result := FNextFreeID;
    Inc(FNextFreeID);
  end;
end;

function TAiFilePool.Open(): TAiError;
var
  Header: TFileHeader;
  res: Integer;
begin
  if FIsOpened then
  begin
    Result := 0;
    Exit;
  end;
  
  {$I-}
  AssignFile(FFile, FFileName);
  Reset(FFile, 1);
  {$I+}
  if (IOResult = 0) then
  begin
    Result := -1;
    BlockRead(FFile, Header, SizeOf(Header), res);
    if (SizeOf(Header) = res) then
    begin
      if (Header.Prefix = 'AiXX')
      and (Header.FileType = 'Pool')
      and (Header.FileTypeVersion = $00000100) then
        Result := 0;
      FBase := Header.Base;
      FCapacity := Header.Capacity;
      FNextFreeID := Header.NextFreeID;
    end;

    FIsOpened := True;
  end
  else
    Result := -1;
end;

function TAiFilePool.OpenCreate(Base: Int64 = 0; Capacity: Int64 = 0): TAiError;
var
  FileHeader: TFileHeader;
begin
  {$I-}
  AssignFile(FFile, FFileName);
  Rewrite(FFile, 1);
  {$I+}
  if (IOResult = 0) then
  begin
    if Base > 0 then
      FBase := Base;
    if Capacity > 0 then
      FCapacity := Capacity;

    Result := 0;
    FileHeader.Prefix := 'AiXX';
    FileHeader.FileType := 'Pool';
    FileHeader.FileTypeVersion := $00000100;
    FileHeader.NextFreeID := FNextFreeID;
    FileHeader.Base := FBase;
    FileHeader.Capacity := FCapacity;
    BlockWrite(FFile, FileHeader, SizeOf(FileHeader));

    FIsOpened := True;
  end
  else
    Result := -1;
end;

function TAiFilePool.ReadBoolValue(): Boolean;
var
  W: WordBool;
begin
  BlockRead(FFile, W, SizeOf(W));
  Result := W;
end;

function TAiFilePool.ReadEntity(Index: Integer): TAiEntityRec;
begin
  Seek(FFile, SizeOf(TFileHeader) + Index * 32);
  Result := ReadNextEntity();
end;

function TAiFilePool.ReadFloatValue(): Double;
begin
  BlockRead(FFile, Result, SizeOf(Result));
end;

function TAiFilePool.ReadIntValue(): Integer;
begin
  BlockRead(FFile, Result, SizeOf(Result));
end;

function TAiFilePool.ReadNextEntity(): TAiEntityRec;
begin
  BlockRead(FFile, Result, SizeOf(Result));
end;

function TAiFilePool.ReadStringValue(): WideString;
var
  Size: Integer;
  C: WideChar;
  i: Integer;
begin
  // Читаем размер данных
  BlockRead(FFile, Size, SizeOf(Size));
  if Size <= 8  then // (32 - 12 - 4) / 2 = 8
  begin
    // Читаем из блока
    SetLength(Result, Size);
    for i := 1 to Size do
    begin
      BlockRead(FFile, C, SizeOf(C));
      Result[i] := C;
    end;
  end
  else
  begin
    // Читаем из внешнего файла
    // ...
  end;
end;

function TAiFilePool.WriteBoolValue(Value: Boolean): Boolean;
var
  V: WordBool;
  //W: Word;
begin
  V := Value;
  BlockWrite(FFile, V, SizeOf(V));
  //for i := 0 to List.Count - 1 do
  Result := True;
end;

function TAiFilePool.WriteEntity(Index: Integer; Value: TAiEntityRec): Boolean;
begin
  Seek(FFile, SizeOf(TFileHeader) + Index * 32);
  BlockWrite(FFile, Value, SizeOf(Value));
  Result := True;
end;

function TAiFilePool.WriteFloatValue(Value: Double): Boolean;
begin
  BlockWrite(FFile, Value, SizeOf(Value));
  Result := True;
end;

function TAiFilePool.WriteIntValue(Value: Integer): Boolean;
begin
  BlockWrite(FFile, Value, SizeOf(Value));
  Result := True;
end;

function TAiFilePool.WriteStringValue(Value: WideString): Boolean;
var
  c: WideChar;
  S: Integer;
  i: Integer;
begin
  S := Length(Value);
  if S <= 8 then
  begin
    BlockWrite(FFile, S, SizeOf(S));
    for i := 1 to S do
    begin
      c := Value[i];
      BlockWrite(FFile, c, SizeOf(c));
    end;
  end
  else
  begin
    // Записывать во внешний файл
    // ...
  end;
  Result := True;
end;

end.
