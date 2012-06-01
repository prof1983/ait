{**
@Abstract(Класс для сохранения напоминаний в XML файл)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2007)
@LastMod(01.06.2012)
@Version(0.5)

История версий:
0.0.0.3 - 06.07.2007 - Saver -> RemindSaver
0.0.0.2 - 04.07.2007
0.0.0.1 - 29.06.2007
}
unit ARemindSaver;

interface

uses
  SysUtils, Variants,
  MSXML24_TLB,
  ARemind;

//** Сохраняет напоминания в XML файл
function Reminder_Save(Tasks: TReminds; FileName: WideString): Boolean;

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

{ Private }

function Reminder_CreateRoot(XmlDocument: IXMLDOMDocument2; RootName, NameSpace, Encoding: string): Boolean;
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

{ Public }

function Reminder_Save(Tasks: TReminds; FileName: WideString): Boolean;
var
  document: IXMLDOMDocument2;
  de: IXMLDOMElement;
  node: IXMLDOMNode;
  attrTitle: IXMLDOMNode;
  attrDateTime: IXMLDOMNode;
  i: Integer;
begin
  Result := False;
  document := CoDOMDocument.Create();
  //de.nodeName := 'Reminder';
  //document.createElement('Task');
  document.setProperty('SelectionLanguage', 'XPath');
  if not(Reminder_CreateRoot(document, 'Reminder', '', 'Windows-1251')) then
    Exit;
  de := document.documentElement;

  for i := 0 to High(Tasks) do
  begin
    node := document.createNode(NODE_ELEMENT, 'Remind', '');
    attrTitle := document.createNode(NODE_ATTRIBUTE, 'Title', '');
    attrTitle.nodeValue := Tasks[i].Title;
    attrDateTime := document.createNode(NODE_ATTRIBUTE, 'DateTime', '');
    attrDateTime.nodeValue := DateTimeToStr(Tasks[i].DateTime); //FormatDateTime('dd.mm.yyyy hh:nn:ss', Tasks[i].DateTime);
    node.attributes.setNamedItem(attrTitle);
    node.attributes.setNamedItem(attrDateTime);
    de.appendChild(node);
  end;
  document.save(FileName);
end;

end.
