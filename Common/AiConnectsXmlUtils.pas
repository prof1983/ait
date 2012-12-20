{**
@Author Prof1983 <prof1983@ya.ru>
@Created 20.12.2012
@LastMod 20.12.2012
}
unit AiConnectsXmlUtils;

interface

{
uses
  XmlIntf,
  ABase, AStreamObj, AXmlObj, AXmlUtils,
  AiBase, AiTypes;
}

{** Загружает список связей из XML (20050911) }
function AiConnects_LoadFromXml(Connects: TAiConnectsObject; Xml: TProfXml): AError;

{** Загружает список связей из XML }
//function AiConnects_LoadFromXml20050819(Connects: TAiConnectsObject; Xml: IXmlNode): AError;

{** Сохраняет список связей в XML (20050911) }
function AiConnects_SaveToXml(Xml: TProfXml): AError;

{** Сохраняет список связей в XML }
//function AiConnects_SaveToXml20050819(Xml: IXmlNode): AError;

implementation

// --- AiConnectsObject ---

function AiConnects_LoadFromXml(Connects: TAiConnectsObject; Xml: TProfXml): AError;
var
  Count: UInt32;
  I: Int32;
  Id: TAId;
  Param: TProfXml;
begin
  if not(Assigned(Xml)) then
  begin
    Result := -1;
    Exit;
  end;
  Count := Xml.GetCountParams();
  for I := 0 to Count - 1 do
  begin
    Param := Xml.GetParam(I);
    if (Param.GetName = 'Connect') then
    begin
      if Param.GetParamValueByNameAsUInt64('IdFreim', Id) then
        Connects.AddConnect(Id);
    end;
  end;
  Result := 0;
end;

{function AiConnects_LoadFromXml20050819(Connects: TAiConnectsObject; Xml: IXmlNode): AError;
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
  Connects.AddConnect(Id);
  Result := 0;
end;}

function AiConnects_SaveToXml(Connects: TAiConnectsObject; Xml: TProfXml): AError;
var
  Count: UInt32;
  I: Int32;
begin
  if not(Assigned(Xml)) then
  begin
    Result := -1;
    Exit;
  end;
  Count := Connects.GetCountConnects();
  for I := 0 to Count - 1 do begin
    Xml.GetParamByName('Connect').SetParamValue('IdFreim', cUInt64ToStr(Connects.GetConnect(I)));
  end;
  Result := 0;
end;

{function AiConnects_SaveToXml20050819(Connects: TAiConnectsObject; Xml: IXmlNode): AError;
var
  Count: UInt32;
  I: Int32;
  Node: IXmlNode;
begin
  if not(Assigned(Xml)) then
  begin
    Result := 1;
    Exit;
  end;
  Count := Connects.GetCountConnects();
  for I := 0 to Count - 1 do
  begin
    Node := AXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connect');
    if Assigned(Node) then
    begin
      AXmlUtils.ProfXmlNode_WriteInt32(Node, 'IdFreim', Connects.GetConnect(I));
    end;
  end;
  Result := 0;
end;}

end.
