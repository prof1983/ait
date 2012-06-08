{**
@Abstract(Типы AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.04.2005)
@LastMod(08.06.2012)
@Version(0.5)

Класс для фрейм-тип (1)
Структура данных всегда XML
Структура данных DTD
}
unit AiType;

interface

uses
  AiBase, AiFrameObj;

type
  TAiRecType = record
    Id: TAId;
    Freim: TAiFrameObject;
  end;

  {** Класс для фрейм-тип (1)
      Структура данных всегда XML
      Структура данных DTD
      (Type=1) }
  TAiType = TAiFrameObject;
  TAiTypeClass = TAiType;
  TAiTypeInt = TAiType;
  TAiTypeUInt = TAiType;
  TAiFloat = TAiFrameObject; {32}
  TAiFloat32 = TAiFrameObject; {33}
  TAiFloat64 = TAiFrameObject; {34}
  TAiUInt = TAiFrameObject; {16}
  TAiUInt08 = TAiFrameObject; {17}
  TAiUInt16 = TAiFrameObject; {18}
  TAiUInt32 = TAiFrameObject; {19}
  TAiUInt64 = TAiFrameObject; {20}

implementation

end.

