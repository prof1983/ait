{**
@Abstract(Базовые типы для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2005)
@LastMod(08.06.2012)
@Version(0.5)

15.05.2012 - Move functions to AiBaseUtils.pas
[*] Перенес AiFreim в AiFrameImpl.pas
}
unit AiBaseObj2006;

interface

uses
  Classes, ComObj, Forms, SysUtils, XmlIntf,
  ATypes, AXml3,
  AiBase, AiConnectsObj, AiFrameImpl, {AiGlobals,} {AiIntf,} AiTypes;

type //** Связи
  TAI_Connects = AiConnectsObj.TAiConnectsObject; //AiConnectsImpl.TAI_Connects;
  TAiConnects = AiConnectsObj.TAiConnectsObject; //TAI_Connects;

//type
  //TAiFreim = AiFrameImpl.TAiFreim;

type //** Фрейм с названием, заголовком и описанием ------------------------------
  TAIFreimNamed = class(TAIFreim)
  private
    FDescription: WideString;
    FName: WideString;
    FTitle: WideString;
  published
      //** Описание фрейма
    property Description: WideString read FDescription write FDescription;
      //** Короткое название фрейма
    property Name: WideString read FName write FName;
      //** Заголовок для отображени
    property Title: WideString read FTitle write FTitle;
    function LoadFromXml(Xml: IXmlNode): WordBool; override;
    function SaveToXml(Xml: IXmlNode): WordBool; override;
  end;

{type // Выборка фреймов --------------------------------------------------------
  TAI_Select = AiSelect.TAI_Select;
  TAiSelect = TAI_Select;}

{const // Константы преобразования типов ----------------------------------------
  OLE_DATA_TYPE: array[TAIDataType] of EnumAIDataType = (edtNone, edtStream, edtXml, edtUncnown);}

const
  stNotOverrideA       = 'Функция "%s" не переопределена';

implementation

{ TAIFreimNamed }

function TAIFreimNamed.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited LoadFromXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.ReadStringA(Xml, 'Description', FDescription);
  TProfXmlNode.ReadStringA(Xml, 'Name', FName);
  TProfXmlNode.ReadStringA(Xml, 'Title', FTitle);
end;

function TAIFreimNamed.SaveToXml(Xml: IXmlNode): WordBool;
begin
  Result := inherited SaveToXml(Xml);
  if not(Result) then Exit;
  TProfXmlNode.WriteStringA(Xml, 'Description', FDescription);
  TProfXmlNode.WriteStringA(Xml, 'Name', FName);
  TProfXmlNode.WriteStringA(Xml, 'Title', FTitle);
end;

end.
