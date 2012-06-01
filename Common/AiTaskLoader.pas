{**
@Abstract(Класс для загрузки заданий из XML файла)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.07.2007)
@LastMod(05.05.2012)
@Version(0.5)

История версий:
0.0.0.1 - 06.07.2007 - Создал на основе Loader.pas
}
unit AiTaskLoader;

interface

uses
  SysUtils,
  MSXML24_TLB,
  AiTask;

type //** @abstract(Класс для загрузки заданий из XML файла)
  TTaskLoader = class
  public
    class function GetChildNodeByName(Node: IXMLDOMNode; NodeName: WideString): IXMLDOMNode;
    class function Load(var Tasks: TTasks; FileName: WideString): Boolean;
  end;

implementation

{ TLoader }

class function TTaskLoader.GetChildNodeByName(Node: IXMLDOMNode; NodeName: WideString): IXMLDOMNode;
var
  c: Integer;
  i: Integer;
begin
  Result := nil;
  if not(Assigned(Node)) or (NodeName = '') then Exit;
  c := Node.childNodes.length;
  for i := 0 to c - 1 do
    if (Node.childNodes.item[i].nodeName = NodeName) then
    begin
      Result := Node.childNodes.item[i];
      Exit;
    end;
end;

class function TTaskLoader.Load(var Tasks: TTasks; FileName: WideString): Boolean;
var
  document: IXMLDOMDocument;
  de: IXMLDOMElement;
  nodes: IXMLDOMNodeList;
  c: Integer;
  i: Integer;
  node: IXMLDOMNode;
  titleNode: IXMLDOMNode;
  commentNode: IXMLDOMNode;
  taskTitle: WideString;
  n: Integer;
begin
  Result := False;
  try
    document := CoDOMDocument.Create();
    if document.load(FileName) then
    begin
      SetLength(Tasks, 0);
      de := document.documentElement;
      if Assigned(de) and (de.nodeName = 'Tasks') then
      begin
        nodes := de.childNodes;
        if Assigned(nodes) then
        begin
          c := nodes.length;
          for i := 0 to c - 1 do
          begin
            node := nodes.item[i];
            if (node.nodeName = 'Task') then
            try
              titleNode := node.attributes.getNamedItem('Title');
              commentNode := GetChildNodeByName(node, 'Comment');

              if Assigned(titleNode) and (titleNode.text <> '') then
              begin
                taskTitle := titleNode.text;

                n := Length(Tasks);
                SetLength(Tasks, n + 1);
                Tasks[n] := TTask.Create();
                Tasks[n].Title := taskTitle;
                if Assigned(commentNode) then
                  Tasks[n].Comment := commentNode.text;
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
