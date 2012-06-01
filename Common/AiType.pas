{**
@Abstract(Типы AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.04.2005)
@LastMod(16.04.2012)
@Version(0.5)

Класс для фрейм-тип (1)
Структура данных всегда XML
Структура данных DTD
}
unit AiType;

interface

uses
  AiBase, AiBaseObj2006;

type
  TAiType = class;

  TAiRecType = record
    Id: TAiId;
    Freim: TAiType;
  end;

  // Класс для фрейм-тип (1)
  // Структура данных всегда XML
  // Структура данных DTD
  TAiType = class(TAiFreim) {Type=1}
  private
    //FPrototypes: array of TAIRecType;
    //FElements: array of TElement;
  end;

type
  TAiTypeClass = class(TAIType)
  end;

type
  TAiTypeInt = class(TAIType)
  end;

type
  TAiTypeUInt = class(TAIType)
  end;

type
  TAiFloat = class(TAIFreim) {32}
  end;

type
  TAiFloat32 = class(TAIFreim) {33}
  end;

type
  TAiFloat64 = class(TAIFreim) {34}
  end;

type
  TAiUInt = class(TAIFreim) {16}
  end;

type
  TAiUInt08 = class(TAIFreim) {17}
  end;

type
  TAiUInt16 = class(TAIFreim) {18}
  end;

type
  TAiUInt32 = class(TAIFreim) {19}
  end;

type
  TAiUInt64 = class(TAIFreim) {20}
  end;

implementation

end.

