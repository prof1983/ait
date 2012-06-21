{**
@Abstract(Базовые типы сущностей)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(21.06.2012)
@Version(0.5)

История версий:
0.0.2.2 - 04.07.2007
0.0.2.1 - 10.06.2007 - Добавил AISlot, AIFrame, AIID
0.0.2.0 - 31.05.2007 - Добавил AIType
0.0.1.1 - 25.05.2007 - Добавил AILocalSettings
}
unit AiConsts;

interface

const
  AiNone = 0; //**< Нет записи

// --- Базовые типы сущностей [0..1024] ---

const // Костанты номеров типов
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
  AiTypeAR = 272;               //**< Искусственный разум (ядро системы)
  AiTypeWorld = 273;            //**< Внутренний мир
  AiTypeAgent = 274;            //**< Агент
  AiTypeModule = 275;           //**< Модуль
  AiTypeAgentMain = 276;        //**< Главный агент
  AiTypeModuleMain = 277;       //**< Главнй модуль
  AiEmptyType = 300;            //**< Пусто - AiEmptyType = $0000;
  AiNullType = 301;             //**< Null - AiNullType = $0001;
  AiBoolType = 302;             //**< Boolean - AiBooleanType = $000B;
  AiIntType = 303;              //**< Целое - AiIntegerType = $0003;
  AiFloatType = 304;            //**< Значение с плавающей точкой
  AiStringType = 305;           //**< Строка - AiStringType = $0008;
  AiDateTimeType = 306;         //**< Дата/время - AiDateType = $0007;
  AiCollectionType = 307;       //**< Коллекция
  AiSlot = 409;                 //**< Слот. содержит имя, тип данных и данные слота
  AiFrame = 410;                //**< Коллекция слотов
  AiId = 411;                   //**< Идентификатор (используется в AISlot для указания типа данных как указателя на сущность в БЗ)
  // --- Идентифкаторы базовых объектов, которыми оперирует среда выполнения ---
  {** Экземпляр искусственного разума
      Экземпляр класса 272 }
  AiAr = 640;
  {** Экземпляр внутреннего мира
      Экземпляр класса 273 }
  AiWorld = 641;
  {** Экземпляр базы знаний
      Экземпляр класса 256 }
  AiKb = 642;
  {** Главный агент
      Экземпляр класса 276 }
  AiAgentMain = 643;
  {** Главный модуль
      Экземпляр класса 277 }
  AiModuleMain = 644;
  {** Список агентов }
  AiAgents = 645;
  {** Список источников }
  AiSources = 646;
  {** Локальные настройки }
  AiLocalSettings = 1024;

// --- Рекомендуемые типы сущностей [1025..2048] ---

const
  AiSlotedEntityType = 1025;
  AiSlotEntityType = 1026;
  AiNamedEntityType = 1027;
  AiOwlClass = 1028;
  AiOwlProperty = 1029;

implementation

end.

