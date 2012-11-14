{**
@Abstract Класс для сохранения заданий в XML файл
@Author Prof1983 <prof1983@ya.ru>
@Created 06.07.2007
@LastMod 14.11.2012
}
unit AiTaskSaver;

interface

uses
  SysUtils, Variants,
  MSXML24_TLB,
  ATaskObj;

type //** @abstract(Класс для сохранения заданий в XML файл)
  TTaskSaver = class
  public
    class function CreateRoot(XmlDocument: IXMLDOMDocument2;
        RootName, NameSpace, Encoding: string): Boolean;
    class function Save(Tasks: TATasks; FileName: WideString): Boolean;
  end;

implementation

const
  CHAR_COLON = ':';
	END_OF_LINE = #13#10;

{
const
	XML_ROOT = '<?xml version="1.0" %1:s?>' + END_OF_LINE +
    '<%0:s xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' + END_OF_LINE +
    '</%0:s>';
}
const
	XML_NAMESPACE = 'xmlns:%0:s="%1:s"';
	XML_ROOT_NAMESPACE = '<?xml version="1.0" %3:s?>' + END_OF_LINE +
    '<%2:s xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' + END_OF_LINE +
    XML_NAMESPACE + '>' + END_OF_LINE +
    '</%2:s>';

{ TSaver }

class function TTaskSaver.CreateRoot(XmlDocument: IXMLDOMDocument2; RootName,
  NameSpace, Encoding: string): Boolean;
var
  iPos: Integer;
  sNS: string;
  sRoot: string;
  sNameSpaceAlias: string;
begin
  Result := False;
	try
    iPos := Pos(CHAR_COLON, RootName);
    if iPos = 0 then
    begin
      sRoot := '<?xml version="1.0" encoding="'+Encoding+'"?>' + END_OF_LINE +
        '<'+RootName+'>' + END_OF_LINE +
        '</'+RootName+'>';
    end
    else
    begin
      if NameSpace = '' then
      begin
        //RaiseError('Invalid argument value (NameSpace)');
        Result := False;
        Exit;
      end;

    	sNameSpaceAlias := Copy(RootName, 1, iPos - 1);
    	sRoot := Format(XML_ROOT_NAMESPACE, [sNameSpaceAlias, NameSpace,
      	RootName, Encoding]);
    end;

  	//Result := loadXML(sRoot);
    Result := XmlDocument.loadXML(sRoot);

    if not(Result) then
    	Exit;

    if iPos <> 0 then
    begin
    	sNS := Format(XML_NAMESPACE, [sNameSpaceAlias, NameSpace]);
			XmlDocument.setProperty('SelectionNamespaces', sNS);
    end;
    Result := True;
  except
    on E: Exception do
  	begin
    	//Result := ProcessException(E);
      Exit;
    end;
  end;
end;

class function TTaskSaver.Save(Tasks: TATasks; FileName: WideString): Boolean;
var
  document: IXMLDOMDocument2;
  de: IXMLDOMElement;
  node: IXMLDOMNode;
  attrTitle: IXMLDOMNode;
  //attrDateTime: IXMLDOMNode;
  i: Integer;
begin
  Result := False;
  document := CoDOMDocument.Create();
  document.setProperty('SelectionLanguage', 'XPath');
  if not(CreateRoot(document, 'Tasks', '', 'Windows-1251')) then
    Exit;
  de := document.documentElement;

  for i := 0 to High(Tasks) do
  begin
    node := document.createNode(NODE_ELEMENT, 'Task', '');
    attrTitle := document.createNode(NODE_ATTRIBUTE, 'Title', '');
    attrTitle.nodeValue := Tasks[i].Title;
    //attrComment := document.createNode(NODE_ATTRIBUTE, 'DateTime', '');
    //attrDateTime.nodeValue := DateTimeToStr(Tasks[i].DateTime); //FormatDateTime('dd.mm.yyyy hh:nn:ss', Tasks[i].DateTime);
    node.attributes.setNamedItem(attrTitle);
    //node.attributes.setNamedItem(attrDateTime);
    de.appendChild(node);
  end;
  document.save(FileName);
end;

end.
