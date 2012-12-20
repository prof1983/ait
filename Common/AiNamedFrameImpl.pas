{**
@Abstract AiNamedFrame
@Author Prof1983 <prof1983@ya.ru>
@Created 21.11.2011
@LastMod 20.12.2012
}
unit AiNamedFrameImpl;

interface

uses
  AiFrameImpl;

type //** Фрейм с названием, заголовком и описанием
  TAiNamedFrame = class(TAiFrame)
  private
      //** Описание фрейма
    FDescription: WideString;
      //** Короткое название фрейма
    FName: WideString;
      //** Заголовок для отображени
    FTitle: WideString;
  public
      //** Описание фрейма
    property Description: WideString read FDescription write FDescription;
      //** Короткое название фрейма
    property Name: WideString read FName write FName;
      //** Заголовок для отображени
    property Title: WideString read FTitle write FTitle;
    //function LoadFromXml(Xml: IXmlNode): WordBool; override;
    //function SaveToXml(Xml: IXmlNode): WordBool; override;
  end;

implementation

{ TAiFreimNamed }

{function TAIFreimNamed.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited LoadFromXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.ReadStringA(Xml, 'Description', FDescription);
  TProfXmlNode.ReadStringA(Xml, 'Name', FName);
  TProfXmlNode.ReadStringA(Xml, 'Title', FTitle);
end;}

{function TAIFreimNamed.SaveToXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited SaveToXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.WriteStringA(Xml, 'Description', FDescription);
  TProfXmlNode.WriteStringA(Xml, 'Name', FName);
  TProfXmlNode.WriteStringA(Xml, 'Title', FTitle);
end;}

end.
 