{**
@Abstract AiConnects
@Author Prof1983 <prof1983@ya.ru>
@Created 12.03.2012
@LastMod 27.11.2012
}
unit AiConnectsImpl;

interface

uses
  XmlIntf,
  ATypes, AXml2007, AXmlNodeImpl, AXmlUtils, 
  AiBase, AiFrameImpl, AiIntf, AiTypes;

type //** Связи
  TAIConnects = class(TInterfacedObject, IAiConnects)
  protected
      //** Связи
    FConnects: array of TAiId;
      //** Фрейм-владелец
    //FOwner: TAIFreim;
      //** ID фрейма владельца - Кому принадлежит список связей
    FOwnerID: TAId;
  public
    function GetFreimID(): TAIID;
    procedure SetFreimID(Value: TAIID);
  public
    function GetCountConnects(): Integer; virtual;
    function GetConnect(Index: Integer): TAId; virtual;
      //** Задать Id связанного фрейма
    procedure SetConnect(Index: Integer; Value: TAId); virtual;
      //** Задать Id связанного фрейма
    function SetConnectA(Index: Integer; Value: TAId): TError; virtual;
  public
      //** Добавить связь
    function AddConnect(Connect: TAIID): Integer; virtual;
      //** Очистить
    function Clear(): TError; virtual;
      //** Удалить связь по идентификатору
    function DeleteConnect(Con: TAIID): TError; virtual;
      //** Удалить связь по индексу
    function DeleteConnectByIndex(Index: Integer): TError; virtual;
      //** Возвращает индекс связи по идентификатору
    function GetConnectIndex(Connect: TAIID): Integer; virtual;
      //** Загрузить из файла
    function LoadFromFile(const FileName: WideString): TError; virtual;
      //** Загрузить список связей из XML
    function LoadFromXml(const AXml: IXmlNode): WordBool; virtual;
    function LoadFromXml1(const AXml: TProfXmlNode1): WordBool; virtual;
      //** Сохранить в файл
    function SaveToFile(const FileName: WideString): WordBool; virtual;
      //** Сохранить список связей в XML
    function SaveToXml(const AXml: IXmlNode): WordBool; virtual;
    function SaveToXml1(const AXml: TProfXmlNode1): WordBool; virtual;
  public
    //** Колличество связей
    property Count: Integer read GetCountConnects;
    //** Идентификатор фрейма-владельца
    property FreimID: TAIID read GetFreimID write SetFreimID;
    //** Идетификаторы связвных фреймов
    property Connects[Index: Integer]: TAIID read GetConnect write SetConnect;
  end;

implementation

{ TAIConnects }

function TAIConnects.AddConnect(Connect: TAIID): Integer;
begin
  Result := Length(FConnects);
  SetLength(FConnects, Result + 1);
  FConnects[Result] := Connect;
end;

function TAIConnects.Clear(): TError;
begin
  SetLength(FConnects, 0);
  Result := 0;
end;

function TAIConnects.DeleteConnect(Con: TAIID): TError;
begin
  Result := -1;
end;

function TAIConnects.DeleteConnectByIndex(Index: Integer): TError;
begin
  Result := -1;
end;

function TAIConnects.GetConnect(Index: Integer): TAIID;
begin
  if (Index >= 0) and (Index < Length(FConnects)) then
    Result := FConnects[Index]
  else
    Result := 0;
end;

function TAIConnects.GetConnectIndex(Connect: TAIID): Integer;
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

function TAIConnects.GetCountConnects(): Integer;
begin
  Result := Length(FConnects);
end;

function TAIConnects.GetFreimID(): TAIID;
begin
  Result := FOwnerID;
end;

function TAIConnects.LoadFromFile(const FileName: WideString): TError;
begin
  Result := -1;
end;

function TAIConnects.LoadFromXml(const AXml: IXmlNode): WordBool;
var
  Count: Integer;
  I: Int32;
  ID: TAI_Id;
  Node: IXmlNode;
  Xml: IXmlNode;
begin
  Xml := AXml;
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Count := Xml.Collection.Count;
  for I := 0 to Count - 1 do
  begin
    Node := Xml.Collection.Nodes[I];
    if Node.NodeName = 'Connect' then
    begin
      ID := 0;
      if AXmlUtils.ProfXmlNode_ReadInt64(Node, 'IdFreim', ID) then
        AddConnect(ID);
    end;
  end;
  Result := True;

  {Xml := AXml;
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Count := Xml.Collection.Count;
  for I := 0 to Count - 1 do
  begin
    Node := Xml.Collection.Nodes[I];
    if Node.NodeName = 'Connect' then
    begin
      ID := 0;
      if ProfXmlUtils.ProfXmlNode_ReadInt64(Node, 'IdFreim', ID) then
        AddConnect(ID);
    end;
  end;
  Result := True;}
end;

function TAIConnects.LoadFromXml1(const AXml: TProfXmlNode1): WordBool;
var
  Count: Integer;
  I: Int32;
  ID: TAIId;
  Node: TProfXmlNode1;
  Xml: TProfXmlNode1;
begin
  Xml := AXml;
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Count := Xml.Collection.Count;
  for I := 0 to Count - 1 do
  begin
    Node := Xml.Collection.Nodes[I];
    if Node.NodeName = 'Connect' then
    begin
      ID := 0;
      if Node.ReadInt64('IdFreim', ID) then
        AddConnect(ID);
    end;
  end;
  Result := True;
end;

function TAIConnects.SaveToFile(const FileName: WideString): WordBool;
begin
  Result := False;
end;

function TAIConnects.SaveToXml(const AXml: IXmlNode): WordBool;
var
  Count: Integer;
  I: Int32;
  Xml: IXmlNode;
  //con: IXmlNode;
begin
  //Xml := TProfXmlNode(AXml);
  Xml := AXml;
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Count := GetCountConnects;
  //con := TProfXmlNode.GetNodeByNameA(Xml, 'Connect');
  for I := 0 to Count - 1 do
  begin
    Xml.AddChild('Connect').NodeValue := GetConnect(I);
    //TProfXmlNode.WriteInt64(con, 'IdFreim', GetConnect(I));
  end;
  Result := True;
end;

function TAIConnects.SaveToXml1(const AXml: TProfXmlNode1): WordBool;
var
  Count: Integer;
  I: Int32;
  Xml: TProfXmlNode1;
begin
  Xml := AXml;
  Result := False;
  if not(Assigned(Xml)) then Exit;
  Count := GetCountConnects;
  for I := 0 to Count - 1 do begin
    Xml.GetNodeByName('Connect').WriteUInt64('IdFreim', GetConnect(I));
  end;
  Result := True;
end;

procedure TAIConnects.SetConnect(Index: Integer; Value: TAIID);
begin
  // ...
end;

function TAIConnects.SetConnectA(Index: Integer; Value: TAId): TError;
begin
  Result := -1;
end;

procedure TAIConnects.SetFreimID(Value: TAIID);
begin
  FOwnerID := Value;
end;

end.
