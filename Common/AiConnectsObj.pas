{**
@Abstract AiConnects
@Author Prof1983 <prof1983@ya.ru>
@Created 12.03.2012
@LastMod 20.12.2012
}
unit AiConnectsObj;

interface

uses
  ABase,
  AiBase;

type //** Связи
  TAiConnectsObject = class
  protected
      //** Связи
    FConnects: array of TAiId;
      //** ID фрейма владельца - Кому принадлежит список связей
    FOwnerId: TAId;
  public
      //** Добавить связь
    function AddConnect(Connect: TAId): Integer; virtual;
      //** Очистить
    function Clear(): AError; virtual;
      //** Удалить связь по идентификатору
    function DeleteConnect(Con: TAId): AError; virtual;
      //** Удалить связь по индексу
    function DeleteConnectByIndex(Index: Integer): AError; virtual;
      //** Возвращает идентификатор связи по индексу
    function GetConnect(Index: Integer): TAId; virtual;
      //** Возвращает индекс связи по идентификатору
    function GetConnectIndex(Connect: TAId): Integer; virtual;
      //** Возвращает колличество связей
    function GetCountConnects(): Integer; virtual;
      //** Возвращает идентификатор фрейма-владельца
    function GetFreimId(): TAId;
      //** Загрузить из файла
    function LoadFromFile(const FileName: WideString): AError; virtual;
      //** Загрузить из файла
    function LoadFromFileN(const FileName: String): AError; virtual;
      //** Сохранить в файл
    function SaveToFile(const FileName: WideString): WordBool; virtual;
      //** Сохранить в файл
    function SaveToFileN(FileName: String): AError; virtual;
      //** Задает Id связанного фрейма
    procedure SetConnect(Index: Integer; Value: TAId); virtual;
      //** Задать Id связанного фрейма
    function SetConnectA(Index: Integer; Value: TAId): AError; virtual;
      //** Задает идентификатор фрейма-владельца
    procedure SetFreimId(Value: TAId);
  public
    //** Колличество связей
    property Count: Integer read GetCountConnects;
    //** Идентификатор фрейма-владельца
    property FreimID: TAIID read GetFreimID write SetFreimID;
    //** Идетификаторы связвных фреймов
    property Connects[Index: Integer]: TAIID read GetConnect write SetConnect;
  end;

  TAiConnects = TAiConnectsObject;

implementation

{ TAiConnectsObject }

function TAiConnectsObject.AddConnect(Connect: TAIID): Integer;
begin
  Result := Length(FConnects);
  SetLength(FConnects, Result + 1);
  FConnects[Result] := Connect;
end;

function TAiConnectsObject.Clear(): AError;
begin
  SetLength(FConnects, 0);
  Result := 0;
end;

function TAiConnectsObject.DeleteConnect(Con: TAIID): AError;
begin
  Result := -1;
end;

function TAiConnectsObject.DeleteConnectByIndex(Index: Integer): AError;
begin
  Result := -1;
end;

function TAiConnectsObject.GetConnect(Index: Integer): TAIID;
begin
  if (Index >= 0) and (Index < Length(FConnects)) then
    Result := FConnects[Index]
  else
    Result := 0;
end;

function TAiConnectsObject.GetConnectIndex(Connect: TAIID): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(FConnects) do
    if FConnects[i] = Connect then
    begin
      Result := i;
      Exit;
    end;
end;

function TAiConnectsObject.GetCountConnects(): Integer;
begin
  Result := Length(FConnects);
end;

function TAiConnectsObject.GetFreimID(): TAIID;
begin
  Result := FOwnerID;
end;

function TAiConnectsObject.LoadFromFile(const FileName: WideString): AError;
begin
  Result := -1;
end;

function TAiConnectsObject.LoadFromFileN(const FileName: String): AError;
begin
  Result := 1;
end;

function TAiConnectsObject.SaveToFile(const FileName: WideString): WordBool;
begin
  Result := False;
end;

function TAiConnectsObject.SaveToFileN(FileName: String): AError;
begin
  Result := 1;
end;

procedure TAiConnectsObject.SetConnect(Index: Integer; Value: TAIID);
begin
  // ...
end;

function TAiConnectsObject.SetConnectA(Index: Integer; Value: TAId): AError;
begin
  Result := -1;
end;

procedure TAiConnectsObject.SetFreimID(Value: TAIID);
begin
  FOwnerID := Value;
end;

end.
