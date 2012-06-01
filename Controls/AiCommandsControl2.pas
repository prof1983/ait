{**
@Abstract(Контрол команд)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.10.2006)
@LastMod(28.04.2012)
@Version(0.5)
}
unit AiCommandsControl2;

interface

uses
  AMessagesMemoControl;

type //** @abstract(Контрол команд)
  TAICommandsControl = class(TMessagesMemoControl)
  protected
    function DoMessageAdd(const AMessage: WideString; AID: Integer): Integer; override;
  end;

implementation

{ TAICommandsControl }

function TAICommandsControl.DoMessageAdd(const AMessage: WideString; AID: Integer): Integer;
//var
//  node: TProfXmlNode1;
begin
  Result := inherited DoMessageAdd(AMessage, AID);
  {// ...
  node := unXml.TProfXmlNode1.Create();
  node.SetXml(AMessage);

  Self.memMessages.Lines.Add('NodeName=' + node.NodeName);
  Self.memMessages.Lines.Add('NodeValue=' + node.AsString);

  if node.NodeName = 'do' then
  begin
    Self.memMessages.Lines.Add('DO!');
    // ...
  end;

  node := nil;}
end;

end.
