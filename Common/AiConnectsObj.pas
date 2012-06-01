{**
@Abstract(AiConnects)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.03.2012)
@LastMod(17.05.2012)
@Version(0.5)
}
unit AiConnectsObj;

interface

// TODO: Delete XmlIntf, AStreamObj, AXmlUtils, AiTypes

uses
  XmlIntf,
  AStreamObj, ATypes, AXmlObj, AXmlUtils,
  AiBase, AiTypes;

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
    function Clear(): TError; virtual;
      //** Удалить связь по идентификатору
    function DeleteConnect(Con: TAId): TError; virtual;
      //** Удалить связь по индексу
    function DeleteConnectByIndex(Index: Integer): TError; virtual;
      //** Возвращает идентификатор связи по индексу
    function GetConnect(Index: Integer): TAId; virtual;
      //** Возвращает индекс связи по идентификатору
    function GetConnectIndex(Connect: TAId): Integer; virtual;
      //** Возвращает колличество связей
    function GetCountConnects(): Integer; virtual;
      //** Возвращает идентификатор фрейма-владельца
    function GetFreimId(): TAId;
      //** Загрузить из файла
    function LoadFromFile(const FileName: WideString): TError; virtual;
      //** Загрузить из файла
    function LoadFromFileN(const FileName: String): TError; virtual;
      //** Загрузить список связей из XML (20050911)
    function LoadFromXml(Xml: TProfXml): TError; virtual;
      //** Загрузить список связей из XML
    function LoadFromXml20050819(Xml: IXmlNode): TError; virtual;
      //** Загрузить список связей из XML
    //function LoadFromXml(const AXml: IXmlNode): WordBool; virtual;
    //function LoadFromXml1(const AXml: TProfXmlNode1): WordBool; virtual;
      //** Сохранить в файл
    function SaveToFile(const FileName: WideString): WordBool; virtual;
      //** Сохранить в файл
    function SaveToFile2005(F: AStreamObj.TProfFile): TError; virtual;
      //** Сохранить в файл
    function SaveToFile20050911(F: AStreamObj.TProfFile): TError; virtual; deprecated; // Use SaveToFile2005()
      //** Сохранить в файл
    function SaveToFileN(FileName: String): TError; virtual;
      //** Сохранить список связей в XML (20050911)
    function SaveToXml(Xml: TProfXml): TError; virtual;
      //** Сохранить список связей в XML
    //function SaveToXml(const AXml: IXmlNode): WordBool; virtual;
    //function SaveToXml1(const AXml: TProfXmlNode1): WordBool; virtual;
      //** Сохранить список связей в XML
    function SaveToXml20050819(Xml: IXmlNode): TError; virtual;
      //** Задает Id связанного фрейма
    procedure SetConnect(Index: Integer; Value: TAId); virtual;
      //** Задать Id связанного фрейма
    function SetConnectA(Index: Integer; Value: TAId): TError; virtual;
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

type
  TAiConnectsObject20050819 = class(TAiConnectsObject)
  public
    function LoadFromXml(Xml: IXmlNode): TError; virtual; deprecated; // Use LoadFormXml20050819()
    function SaveToFile(F: AStreamObj.TProfFile): TError; virtual; deprecated; // Use SaveToFile2005()
    function SaveToXml(Xml: IXmlNode): TError; virtual; deprecated; // Use SaveToXml20050819()
  end;

  TAiConnectsObject20050911 = TAiConnectsObject;
  {TAiConnectsObject20050911 = class(TAiConnectsObject)
  public
    function SaveToFile(F: AStreamObj.TProfFile): TError; virtual; deprecated; // Use SaveToFile20050911()
  end;}

(*
  //TAIConnects2 = TAiConnectsObject; (From AiBaseObj.pas)
  //TAI_Connects = TAiConnectsObject; (From AiBaseObj2006.pas)
  //TAI_Connects_20060920 = TAiConnectsObject;
*)

implementation

{ TAiConnectsObject }

function TAiConnectsObject.AddConnect(Connect: TAIID): Integer;
begin
  Result := Length(FConnects);
  SetLength(FConnects, Result + 1);
  FConnects[Result] := Connect;
end;

function TAiConnectsObject.Clear(): TError;
begin
  SetLength(FConnects, 0);
  Result := 0;
end;

function TAiConnectsObject.DeleteConnect(Con: TAIID): TError;
begin
  Result := -1;
end;

function TAiConnectsObject.DeleteConnectByIndex(Index: Integer): TError;
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

function TAiConnectsObject.LoadFromFile(const FileName: WideString): TError;
begin
  Result := -1;
end;

function TAiConnectsObject.LoadFromFileN(const FileName: String): TError;
begin
  Result := 1;
end;

function TAiConnectsObject.LoadFromXml(Xml: TProfXml): TError;
var
  Count: UInt32;
  I: Int32;
  Id: TAI_Id;
  Param: TProfXml;
begin
  Result := -1;
  {
  if not(Assigned(Xml)) then Exit;
  Count := Xml.GetCountParams;
  for I := 0 to Count - 1 do begin
    Param := Xml.GetParam(I);
    if Param.GetName = 'Connect' then begin
      if Param.GetParamValueByNameAsUInt64('IdFreim', Id) then
        AddConnect(Id);
    end;
  end;
  Result := 0;
  }
end;

(*function TAiConnectsObject.LoadFromXml(const AXml: IXmlNode): WordBool;
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
      if ProfXmlUtils.ProfXmlNode_ReadInt64(Node, 'IdFreim', ID) then
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
end;*)

(*function TAiConnectsObject.LoadFromXml1(const AXml: TProfXmlNode1): WordBool;
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
end;*)

function TAiConnectsObject.LoadFromXml20050819(Xml: IXmlNode): TError;
var
  Count: UInt32;
  I: Int32;
  Id: Integer; //TAI_Id;
  Node: IXmlNode;
begin
  if not(Assigned(Xml)) then
  begin
    Result := -2;
    Exit;
  end;

  Node := ProfXmlNode_GetNodeByName(Xml, 'Connect');
  if not(Assigned(Node)) then
  begin
    Result := -3;
    Exit;
  end;

  if not(AXmlUtils.ProfXmlNode_ReadInt(Node, 'IdFreim', Id)) then
  begin
    Result := -3;
    Exit;
  end;
  AddConnect(Id);
  Result := 0;
end;

function TAiConnectsObject.SaveToFile(const FileName: WideString): WordBool;
begin
  Result := False;
end;

function TAiConnectsObject.SaveToFile2005(F: AStreamObj.TProfFile): TError;
begin
  Result := 1;
end;

function TAiConnectsObject.SaveToFile20050911(F: AStreamObj.TProfFile): TError;
begin
  Result := SaveToFile2005(F);
end;

function TAiConnectsObject.SaveToFileN(FileName: String): TError;
begin
  Result := 1;
end;

function TAiConnectsObject.SaveToXml(Xml: TProfXml): TError;
var
  Count: UInt32;
  I: Int32;
begin
  Result := -1;
  {
  if not(Assigned(Xml)) then Exit;
  Count := GetCountConnects;
  for I := 0 to Count - 1 do begin
    Xml.GetParamByName('Connect').SetParamValue('IdFreim', cUInt64ToStr(GetConnect(I)));
  end;
  Result := 0;
  }
end;

(*function TAiConnectsObject.SaveToXml(const AXml: IXmlNode): WordBool;
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
end;*)

(*function TAiConnectsObject.SaveToXml1(const AXml: TProfXmlNode1): WordBool;
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
end;*)

function TAiConnectsObject.SaveToXml20050819(Xml: IXmlNode): TError;
var
  Count: UInt32;
  I: Int32;
  Node: IXmlNode;
begin
  Result := 1;
  if not(Assigned(Xml)) then Exit;
  Count := GetCountConnects;
  for I := 0 to Count - 1 do
  begin
    Node := AXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connect');
    if Assigned(Node) then
    begin
      AXmlUtils.ProfXmlNode_WriteInt32(Node, 'IdFreim', GetConnect(I));
    end;
  end;
  Result := 0;
end;

procedure TAiConnectsObject.SetConnect(Index: Integer; Value: TAIID);
begin
  // ...
end;

function TAiConnectsObject.SetConnectA(Index: Integer; Value: TAId): TError;
begin
  Result := -1;
end;

procedure TAiConnectsObject.SetFreimID(Value: TAIID);
begin
  FOwnerID := Value;
end;

{ TAiConnectsObject20050819 }

function TAiConnectsObject20050819.LoadFromXml(Xml: IXmlNode{TMyXml}): TError;
begin
  Result := LoadFromXml20050819(Xml);
end;

function TAiConnectsObject20050819.SaveToFile(F: AStreamObj.TProfFile): TError;
begin
  Result := SaveToFile2005(F);
end;

function TAiConnectsObject20050819.SaveToXml(Xml: IXmlNode{TMyXml}): TError;
begin
  Result := SaveToXml20050819(Xml);
end;

{ TAiConnectsObject20050911 }

{function TAiConnectsObject20050911.SaveToFile(F: AStreamObj.TProfFile): TError;
begin
  Result := SaveToFile20050911(F);
end;}

end.
