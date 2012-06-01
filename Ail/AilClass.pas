{**
@Abstract(Ai lang class)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AilClass;

interface

type
  TAilClass = class
  public
    Name: WideString; // ID
    SuperClass: TAilClass; // SubClassOf
    Title: WideString; // Label
    Title_ru: WideString;
    Title_en: WideString;
  end;

implementation

end.
