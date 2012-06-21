{**
@Abstract(AiNamedFrameObj)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.11.2011)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AiNamedFrameObj;

interface

uses
  AiFrameObj;

type
  {** Фрейм с названием, заголовком и описанием }
  TAiNamedFrameObject = class(TAiFrameObject)
  protected
    {** Описание фрейма }
    FDescription: WideString;
    {** Короткое название фрейма }
    FName: WideString;
    {** Заголовок для отображения }
    FTitle: WideString;
  public
    //function LoadFromXml(Xml: IXmlNode): WordBool; override; deprecated; // Use AiNamedFrame_LoadFromXml()
    //function SaveToXml(Xml: IXmlNode): WordBool; override; deprecated; // Use AiNamedFrame_SaveToXml()
  published
    {** Описание фрейма }
    property Description: WideString read FDescription write FDescription;
    {** Короткое название фрейма }
    property Name: WideString read FName write FName;
    {** Заголовок для отображения }
    property Title: WideString read FTitle write FTitle;
  end;
  TAiNamedFrame = TAiNamedFrameObject;
  TAiFreimNamed = TAiNamedFrameObject;

implementation

end.
 