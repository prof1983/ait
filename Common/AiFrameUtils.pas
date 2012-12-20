{**
@Abstract AiFrame functions
@Author Prof1983 <prof1983@ya.ru>
@Created 21.06.2012
@LastMod 20.12.2012
}
unit AiFrameUtils;

interface

uses
  XmlIntf,
  ABase, AXmlUtils;

{**
  Load frame data from xml
  @param Frame - AiFrameImpl.TAiFreim
}
function AiFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;

{**
  Save frame data to xml
  @param Frame - AiFrameImpl.TAiFreim
}
function AiFrame_SaveToXml(Frame: TObject; Xml: IXmlNode): AError;

{**
  Load frame data from xml
  @param Frame - AiBaseObj2006.TAiFreimNamed
}
function AiNamedFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;

{**
  Save frame data to xml
  @param Frame - AiBaseObj2006.TAiFreimNamed
}
function AiNamedFrame_SaveToXml(Frame: TObject; Xml: IXmlNode): AError;

implementation

uses
  AiFrameImpl, AiNamedFrameObj;

// --- Private ---

function _AiFrame_LoadFromXml(Frame: {AiFrameImpl.}TAiFrame; Xml: IXmlNode): AError;
var
  Connects: IXmlNode;
  Id: AInt64;
  DateCreate: TDateTime;
  FrameType: AInt64;
begin
  if not(Assigned(Xml)) then
  begin
    Result := -2;
    Exit;
  end;
  Frame.Clear();
  AXmlUtils.ProfXmlNode_ReadInt64(Xml, 'ID', Id);
  Frame.Id := Id;
  AXmlUtils.ProfXmlNode_ReadDateTime(Xml, 'DateTimeCreate', DateCreate);
  Frame.DateCreate := DateCreate;
  AXmlUtils.ProfXmlNode_ReadInt64(Xml, 'Type', FrameType);
  Frame.SetEntityType(FrameType);
  Connects := AXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connects');
  Frame.GetConnects.LoadFromXml(Connects);
  //GetData.LoadFromXml(Xml.GetNodeByName('Data'));
  Result := 0;
end;

function _AiFrame_SaveToXml(Frame: TAiFrame; Xml: IXmlNode): AError;
var
  Connects: IXmlNode;
begin
  if not(Assigned(Xml)) then
  begin
    Result := -2;
    Exit;
  end;

  AXmlUtils.ProfXmlNode_WriteInt64(Xml, 'Id', Frame.GetId());
  AXmlUtils.ProfXmlNode_WriteDateTime(Xml, 'DateTimeCreate', Frame.GetDateTimeCreate());
  AXmlUtils.ProfXmlNode_WriteInt64(Xml, 'Type', Frame.GetFrameType());
  Connects := AXmlUtils.ProfXmlNode_GetNodeByName(Xml, 'Connects');
  Frame.GetConnects().SaveToXml(Connects);
  //Data.SaveToXml(Xml.GetNodeByName('Data'));
  Result := 0;
end;

function _AiNamedFrame_LoadFromXml(Frame: {AiBaseObj2006.}TAiNamedFrameObject; Xml: IXmlNode): AError;
var
  S: WideString;
begin
  if (AiFrame_LoadFromXml(Frame, Xml) < 0) then
  begin
    Result := -2;
    Exit;
  end;

  S := Frame.Description;
  ProfXmlNode_ReadString(Xml, 'Description', S);
  Frame.Description := S;
  S := Frame.Name;
  ProfXmlNode_ReadString(Xml, 'Name', S);
  Frame.Name := S;
  S := Frame.Title;
  ProfXmlNode_ReadString(Xml, 'Title', S);
  Frame.Title := S;

  Result := 0;
end;

function _AiNamedFrame_SaveToXml(Frame: {AiBaseObj2006.}TAiNamedFrameObject; Xml: IXmlNode): AError;
begin
  if (AiFrame_SaveToXml(Frame, Xml) < 0) then
  begin
    Result := -2;
    Exit;
  end;

  ProfXmlNode_WriteString(Xml, 'Description', Frame.Description);
  ProfXmlNode_WriteString(Xml, 'Name', Frame.Name);
  ProfXmlNode_WriteString(Xml, 'Title', Frame.Title);

  Result := 0;
end;

// --- AiFrame ---

function AiFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;
begin
  if (Frame is TAiFrame) then
    Result := _AiFrame_LoadFromXml(TAiFrame(Frame), Xml)
  else
    Result := -3;
end;

function AiFrame_SaveToXml(Frame: TObject; Xml: IXmlNode): AError;
begin
  if (Frame is TAiFrame) then
    Result := _AiFrame_SaveToXml(TAiFrame(Frame), Xml)
  else
    Result := -3;
end;

// --- AiNamedFrame ---

function AiNamedFrame_LoadFromXml(Frame: TObject; Xml: IXmlNode): AError;
begin
  if (Frame is TAiNamedFrameObject) then
    Result := _AiNamedFrame_LoadFromXml(TAiNamedFrameObject(Frame), Xml)
  else if (Frame is {AiFrameImpl.}TAiFrame) then
    Result := _AiFrame_LoadFromXml({AiFrameImpl.}TAiFrame(Frame), Xml)
  else
    Result := -3;
end;

function AiNamedFrame_SaveToXml(Frame: TObject; Xml: IXmlNode): AError;
begin
  if (Frame is TAiNamedFrameObject) then
    Result := _AiNamedFrame_SaveToXml(TAiNamedFrameObject(Frame), Xml)
  else
    Result := -3;
end;

end.
