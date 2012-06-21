{**
@Abstract(AiFrame functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.06.2012)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AiFrameUtils;

interface

uses
  XmlIntf,
  ABase, AXmlUtils;

{** Load frame data from xml
    @param(Frame - AiFrameImpl.TAiFreim) }
function AiFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;

{** Load frame data from xml
    @param(Frame - AiBaseObj2006.TAiFreimNamed) }
function AiNamedFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;

{** Save frame data to xml
    @param(Frame - AiBaseObj2006.TAiFreimNamed) }
function AiNamedFrame_SaveToXml(Frame: TObject; Xml: IXmlNode): WordBool;

implementation

uses
  AiBaseObj2006, AiFrameImpl;

// --- Private ---

function _AiFrame_LoadFromXml(Frame: {AiFrameImpl.}TAiFreim; Xml: IXmlNode): AError;
var
  Connects: IXmlNode;
begin
  if not(Assigned(Xml)) then
  begin
    Result := -2;
    Exit;
  end;
  Frame.Clear();
  AXmlUtils.ProfXmlNode_ReadInt64(Xml, 'ID', FId);
  AXmlUtils.ProfXmlNode_ReadDateTime(Xml, 'DateTimeCreate', FDateCreate);
  AXmlUtils.ProfXmlNode_ReadInt64(Xml, 'Type', FFrameType);
  Connects := AXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connects');
  Frame.GetConnects.LoadFromXml(Connects);
  //GetData.LoadFromXml(Xml.GetNodeByName('Data'));
  Result := 0;
end;

function _AiNamedFrame_LoadFromXml(Frame: {AiBaseObj2006.}TAiFreimNamed; Xml: IXmlNode): AError;
begin
  if (AiFrame_LoadFromXml(Frame, Xml) < 0) then
  begin
    Result := -2;
    Exit;
  end;

  TProfXmlNode.ReadStringA(Xml, 'Description', FDescription);
  TProfXmlNode.ReadStringA(Xml, 'Name', FName);
  TProfXmlNode.ReadStringA(Xml, 'Title', FTitle);

  Result := 0;
end;

function _AiNamedFrame_SaveToXml(Frame: {AiBaseObj2006.}TAiFreimNamed; Xml: IXmlNode): WordBool;
begin
  if (AiFrame_SaveToXml(Frame, Xml) < 0) then
  begin
    Result := -2;
    Exit;
  end;

  TProfXmlNode.WriteStringA(Xml, 'Description', FDescription);
  TProfXmlNode.WriteStringA(Xml, 'Name', FName);
  TProfXmlNode.WriteStringA(Xml, 'Title', FTitle);

  Result := 0;
end;

// --- AiFrame ---

function AiFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;
var
  Connects: IXmlNode;
begin
  if (Frame is TAiFreim) then
    Result := _AiFrame_LoadFromXml(TAiFreim(Frame), Xml)
  else
    Result := -3;
end;

// --- AiNamedFrame ---

function AiNamedFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;
begin
  if (Frame is TAiFreimNamed) then
    Result := _AiNamedFrame_LoadFromXml(TAiFreimNamed(Frame), Xml)
  else
    Result := -3;
end;

function AiNamedFrame_SaveToXml(Frame: TObject; Xml: IXmlNode): WordBool;
begin
  if (Frame is TAiFreimNamed) then
    Result := _AiNamedFrame_SaveToXml(TAiFreimNamed(Frame), Xml)
  else
    Result := -3;
end;

end.
