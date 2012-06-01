{**
@Abstract(Класс для загрузки напоминаний из XML файла)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2007)
@LastMod(01.06.2012)
@Version(0.5)

История версий:
0.0.0.3 - 06.07.2007
0.0.0.2 - 03.07.2007
0.0.0.1 - 29.06.2007
}
unit ARemindLoader;

interface

uses
  SysUtils,
  MSXML24_TLB,
  ARemind;

//** Загружает напоминания из XML файла
function Reminder_Load(var Reminds: TReminds; FileName: WideString): Boolean;

implementation

{ Public }

function Reminder_Load(var Reminds: TReminds; FileName: WideString): Boolean;
var
  document: IXMLDOMDocument;
  de: IXMLDOMElement;
  nodes: IXMLDOMNodeList;
  c: Integer;
  i: Integer;
  node: IXMLDOMNode;
  titleNode: IXMLDOMNode;
  dtNode: IXMLDOMNode;
  taskTitle: WideString;
  taskDateTime: TDateTime;
  n: Integer;
begin
  Result := False;
  try
    document := CoDOMDocument.Create();
    if document.load(FileName) then
    begin
      SetLength(Reminds, 0);
      de := document.documentElement;
      if Assigned(de) and (de.nodeName = 'Reminder') then
      begin
        nodes := de.childNodes;
        if Assigned(nodes) then
        begin
          c := nodes.length;
          for i := 0 to c - 1 do
          begin
            node := nodes.item[i];
            if (node.nodeName = 'Remind') then
            try
              titleNode := node.attributes.getNamedItem('Title');
              dtNode := node.attributes.getNamedItem('DateTime');
              if Assigned(titleNode) and Assigned(dtNode) and (titleNode.text <> '') then
              begin
                taskTitle := titleNode.text;
                taskDateTime := StrToDateTime(dtNode.text);

                n := Length(Reminds);
                SetLength(Reminds, n + 1);
                Reminds[n] := TRemind.Create();
                Reminds[n].Title := taskTitle;
                Reminds[n].DateTime := taskDateTime;
              end;
            except
            end;
          end;
        end;
      end;
    end;
    // ...
  except
  end;
end;

end.
