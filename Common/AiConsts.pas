{**
@Abstract(Базовые типы сущностей)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(25.04.2012)
@Version(0.5)

История версий:
0.0.2.2 - 04.07.2007
0.0.2.1 - 10.06.2007 - Добавил AISlot, AIFrame, AIID
0.0.2.0 - 31.05.2007 - Добавил AIType
0.0.1.1 - 25.05.2007 - Добавил AILocalSettings
}
unit AiConsts;

interface

// Базовые типы сущностей [0..1024]

const
  AIEmptyType = 300;      // Пусто
  AINullType = 301;       // Null
  AIBoolType = 302;       // Boolean
  AIIntType = 303;        // Целое
  AIFloatType = 304;      // Значение с плавающей точкой
  AIStringType = 305;     // строка
  AIDateTimeType = 306;   // дата/время
  AICollectionType = 307; // коллекция

const
  AISlot = 9;             // слот. содержит имя, тип данных и данные слота
  AIFrame = 10;           // коллекция слотов
  AIID = 11;              // Идентификатор (используется в AISlot для указания типа данных как указателя на сущность в БЗ)

const
  AILocalSettings = 1024;

// Рекомендуемые типы сущностей [1025..2048]

const
  AISlotedEntityType = 1025;
  AISlotEntityType = 1026;
  AINamedEntityType = 1027;

const
  AIOwlClass = 1028;
  AIOwlProperty = 1029;

(*
const
  AIEmptyType    = $0000; { vt_empty        0 }
  AINullType     = $0001; { vt_null         1 }
  AISmallintType = $0002; { vt_i2           2 }
  AIIntegerType  = $0003; { vt_i4           3 }
  AISingleType   = $0004; { vt_r4           4 }
  AIDoubleType   = $0005; { vt_r8           5 }
  AICurrencyType = $0006; { vt_cy           6 }
  AIDateType     = $0007; { vt_date         7 }
  AIStringType   = $0008; { vt_bstr         8 } // AIOleStr
  AIDispatchType = $0009; { vt_dispatch     9 }
  AIErrorType    = $000A; { vt_error       10 }
  AIBooleanType  = $000B; { vt_bool        11 }
  AIVariantType  = $000C; { vt_variant     12 }
  AIUnknownType  = $000D; { vt_unknown     13 }
//AIDecimal  = $000E; { vt_decimal     14 } {UNSUPPORTED as of v6.x code base}
//AIUndef0F  = $000F; { undefined      15 } {UNSUPPORTED per Microsoft}
  AIShortIntType = $0010; { vt_i1          16 }
  AIByteType     = $0011; { vt_ui1         17 }
  AIWordType     = $0012; { vt_ui2         18 }
  AILongWordType = $0013; { vt_ui4         19 }
  AIInt64Type    = $0014; { vt_i8          20 }

  AIArray    = $000E;
  AIType     = $000F;

//  varStrArg   = $0048; { vt_clsid       72 }
//  AIString   = $0100; { Pascal string 256 } {not OLE compatible }
//  AIAny      = $0101; { Corba any     257 } {not OLE compatible }
  // custom types range from $110 (272) to $7FF (2047)

//  varTypeMask = $0FFF;
//  varArray    = $2000;
//  varByRef    = $4000;

const
  AITypes: array[0..20] of Integer = (
    AIEmpty,
    AINull,
    AISmallint,
    AIInteger,
    AISingle,
    AIDouble,
    AICurrency,
    AIDate,
    AIOleStr,
    AIDispatch,
    AIError,
    AIBoolean,
    AIVariant,
    AIUnknown,

    AIArray,
    AIType,

    AIShortInt,
    AIByte,
    AIWord,
    AILongWord,
    AIInt64
    );
*)

// --- from AiConst.pas ---

const // Идентифкаторы базовых объектов, которыми оперирует среда выполнения ---
  // Экземпляр искусственного разума
  AIAR            = 640; // Экземпляр класса 272
  // Экземпляр внутреннего мира
  AIWorld         = 641; // Экземпляр класса 273
  // Экземпляр базы знаний
  AIKB            = 642; // Экземпляр класса 256
  // Главный агент
  AIAgentMain     = 643; // Экземпляр класса 276
  // Главный модуль
  AIModuleMain    = 644; // Экземпляр класса 277
  // Список агентов
  AIAgents        = 0;
  // Список источников
  AISources       = 0;

const // Костанты номеров типов ------------------------------------------------
  AIBase           = 0;
  // Основное описание типов (1..14)
  AIType           = 1; // Тип
  AITypeRecord     = 2; // Запись
  AITypeObject     = 3; // Объект
  AITypeArray      = 4; // Массив
  AITypeProperty   = 5; // Свойство класса или объекта
  AITypeMethod     = 6; // Метод класса или объекта
  AITypeMember     = 7; // Член класса или объекта
  AITypeClass      = 8; // Класс
  // Атомарные типы (9..15)
  AITypeBit        = 9; // Бит
  AITypeBitFuzzy   = 10; // Не четкий бит
  AITypeBool       = 11; // Boolean
  AITypeBoolFuzzy  = 12; // Не четкое Boolean
  // Целочисленные типы без знака (16..23)
  AITypeUInt       = 16; // Целое без знака
  AITypeUInt08     = 17; // Целое без знака (0..255)
  AITypeUInt16     = 18; // Целое без знака (0..65536)
  AITypeUInt32     = 19; // Целое без знака (0..2^32)
  AITypeUInt64     = 20; // Целое без знака (0..2^64)
  // Целочисленные типы со знаком (24..31)
  AITypeInt        = 24; // Целое со знаком (-128..127)
  AITypeInt08      = 25; // Целое со знаком ..
  AITypeInt16      = 26; // Целое со знаком ..
  AITypeInt32      = 27; // Целое со знаком ..
  AITypeInt64      = 28; // Целое со знаком ..
  // Типы с плавающей точкой (32..47)
  AITypeFloat      = 32; // С плавающей точкой
  AITypeFloat32    = 33; // С плавающей точкой (32 бита)
  AITypeFloat64    = 34; // С плавающей точкой (64 бита)
  // Типы дата/время (48..63)
  AITypeDateTime   = 48; // Дата-время
  AITypeDateTime32 = 49; // Дата-время
  AITypeDateTime64 = 50; // Дата-время
  // Символьные типы (64..79)
  AITypeChar       = 64; // Символ
  AITypeChar08     = 65; // Символ
  AITypeChar16     = 66; // Символ
  // Строковые типы (80..95)
  AITypeString     = 80; // Строка
  AITypeWord       = 81; // Слово
  AITypeWordsComb  = 82; // Словосочетание
  AITypeSemanticUnit = 83; // Семантическая единица
  AITypeSugPart    = 84; // Часть предложения
  AITypeSuggestion = 85; // Предложение
  // Графические типы (96-111)
  AITypeGraph      = 96;
  AITypeGraph2D    = 97;
  AITypeGraph3D    = 98;
  // Типы-правила (112-127)
  AITypeRule       = 112;
  AITypeRuleFuzzy  = 113;
  AITypeRules      = 114;
  // Типы-задания (128-143)
  AITypeTask       = 128;
  AITypeTasks      = 129;
  // Типы-действия (144-254)
  AITypeAction     = 144;
  AITypeActions    = 145;
  // Типы-источники знаний (фреймов)
  AITypeSource     = 255;           // Источник знаний
  AITypeKB         = 256;
  AITypeKBMemory   = 257;
  AITypeKBFile     = 258;
  AITypeKBFileCashe = 259;
  AITypeKBNet      = 260;
  AITypeKBNetCasheMemory     = 261;
  AITypeKBNetCasheFile       = 262;
  AITypeKBNetCasheFileMemory = 263;
  // Типы базовых объектов, которыми оперирут среда выполнения
  AITypeAR          = 272;          // Искусственный разум (ядро системы)
  AITypeWorld       = 273;          // Внутренний мир
  AITypeAgent       = 274;          // Агент
  AITypeModule      = 275;          // Модуль
  AITypeAgentMain   = 276;          // Главный агент
  AITypeModuleMain  = 277;          // Главнй модуль

implementation

end.

