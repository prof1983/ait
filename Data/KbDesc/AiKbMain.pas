{**
@Abstract(Описания данных для автоматического создания фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.12.2005)
@LastMod(27.04.2012)
@Version(0.5)

http://www.w3schools.com/schema/
}
unit AiKbMain;

interface

uses
  AConsts2,
  AiConsts, AiTypes;

// Константы для AR кода =======================================================

const //** @abstract(Код класса реализации задания)
  AICodeTask: WideString =
    '<class name="Task">'+CRLF+
    '  <property name="TaskText" type="String" desctiption="Текст задания" />'+CRLF+
    '</class>';

// Описания отдельных фреймов ==================================================

const
  AI_FreimAction_Count = 1;
  AI_FreimAction: array[0..AI_FreimAction_Count-1] of TElement = (
    (Name: 'ActionType'; Typ: etString; Title: 'Тип записи действия'; Default: ''; Description: 'Всегда равно 1')
    //1. Тип записи действия (= 1) (UInt032)
    //2. Размер названия в байтах (без завершающего #0) (UInt032)
    //3. Размер описания входных параметров в байтах (UInt032)
    //4. Размер описания выходных параметров в байтах (UInt032)
    //5. Размер команд в байтах (UInt032)
    //6. Название действия
    //7. Разделитель (#0)
    //  Описание входных параметров
    //8. Колличество входных переменных (UInt032)
    //9. Handle переменной 1 (THandle064)
    //...
    //  Описание выходных параметров
    //10. Колличество входных переменных (UInt032)
    //11. Handle переменной 1 (THandle064)
    //...
    //Список выполняемых команд и действий. (О командах)
    //Команды - базовые функции, заложеные в программе.
    //Действия - запуск выполнения других фреймов-действий.
  );

const // Описание данных фрейма "тип фрейма" -----------------------------------
  AI_FreimType_Count = 5;
  AI_FreimType: array[0..AI_FreimType_Count-1] of TElement = (
    (Name: 'Name';        Typ: etString; Title: 'Название ф-типа'; Default: ''; Description: ''; Required: True; Elements: nil),
    (Name: 'Title';       Typ: etString; Title: 'Отображаемое имя'; Default: ''; Description: ''; Required: True; Elements: nil),
    (Name: 'Description'; Typ: etString; Title: 'Описание ф-типа'; Default: ''; Description: ''; Required: True; Elements: nil),
    (Name: 'Elements';    Typ: etString; Title: 'Элементы данных'; Default: ''; Description: ''; Required: True; Elements: nil),
    (Name: 'Prototypes';  Typ: etString; Title: 'Прототипы'; Default: ''; Description: ''; Required: True; Elements: nil)
    );

const
  AI_FreimTask_Count = 1;
  AI_FreimTask: array[0..AI_FreimTask_Count-1] of TElement = (
    (Name: 'Name';        Typ: etString; Title: 'Название ф-задания'; Default: ''; Description: ''; Required: True; Elements: nil)
    );

// Список фреймов БЗ ===========================================================

const // -----------------------------------------------------------------------
  AIFreimsCount = 61;
  AIFreims: array[0..AIFreimsCount - 1] of _Freim = (
    (Id: AIBase;         Typ: 0; DataType: dtXml; Data: @AI_FreimType; Descript: 'Локальные константы'),
    // Основное описание типов (1..14)
    (Id: AIType;         Typ: 0; DataType: dtXml; Descript: 'Базовый фрейм описания типов'),
    (Id: AITypeRecord;   Typ: 1; DataType: dtXml; Descript: 'Базовый фрейм описания записей (record)'),
    (Id: AITypeObject;   Typ: 1; DataType: dtXml; Descript: 'Базовый фрейм описания объектов'),
    (Id: AITypeArray;    Typ: 1; DataType: dtXml; Descript: 'Базовый фрейм описания массивов'),
    (Id: AITypeProperty; Typ: 1; DataType: dtXml; Descript: 'Базовый фрейм описания property'),
    (Id: AITypeMethod;   Typ: 1; DataType: dtXml; Descript: 'Базовый фрейм описания method'),
    // Атомарные типы (8..15)
    (Id: AITypeBit;       Typ: 1; DataType: dtXml; Descript: 'Bit'),
    (Id: AITypeBitFuzzy;  Typ: 1; DataType: dtXml; Descript: 'BitFuzzy'),
    (Id: AITypeBool;      Typ: 1; DataType: dtXml; Descript: 'Bool'),
    (Id: AITypeBoolFuzzy; Typ: 1; DataType: dtXml; Descript: 'BoolFuzzy'),
    // Целочисленные типы без знака (16..23)
    (Id: AITypeUInt;      Typ: 1; DataType: dtXml; Descript: 'AITypeUInt'),
    (Id: AITypeUInt08;    Typ: 1; DataType: dtXml; Descript: 'AITypeUInt08'),
    (Id: AITypeUInt16;    Typ: 1; DataType: dtXml; Descript: 'AITypeUInt16'),
    (Id: AITypeUInt32;    Typ: 1; DataType: dtXml; Descript: 'AITypeUInt32'),
    (Id: AITypeUInt64;    Typ: 1; DataType: dtXml; Descript: 'AITypeUInt64'),
    // Целочисленные типы со знаком (24..31)
    (Id: AITypeInt;       Typ: 1; DataType: dtXml; Descript: 'AITypeInt'),
    (Id: AITypeInt08;     Typ: 1; DataType: dtXml; Descript: 'AITypeInt08'),
    (Id: AITypeInt16;     Typ: 1; DataType: dtXml; Descript: 'AITypeInt16'),
    (Id: AITypeInt32;     Typ: 1; DataType: dtXml; Descript: 'AITypeInt32'),
    (Id: AITypeInt64;     Typ: 1; DataType: dtXml; Descript: 'AITypeInt64'),
    // Типы с плавающей точкой (32..47)
    (Id: AITypeFloat;     Typ: 1; DataType: dtXml; Descript: 'AITypeFloat'),
    (Id: AITypeFloat32;   Typ: 1; DataType: dtXml; Descript: 'AITypeFloat32'),
    (Id: AITypeFloat64;   Typ: 1; DataType: dtXml; Descript: 'AITypeFloat64'),
    // Типы дата/время (48..63)
    (Id: AITypeDateTime;   Typ: 1; DataType: dtXml; Descript: 'AITypeDateTime'),
    (Id: AITypeDateTime32; Typ: 1; DataType: dtXml; Descript: 'AITypeDateTime32'),
    (Id: AITypeDateTime64; Typ: 1; DataType: dtXml; Descript: 'AITypeDateTime64'),
    // Символьные типы (64..79)
    (Id: AITypeChar;       Typ: 1; DataType: dtXml; Descript: 'AITypeChar'),
    (Id: AITypeChar08;     Typ: 1; DataType: dtXml; Descript: 'AITypeChar08'),
    (Id: AITypeChar16;     Typ: 1; DataType: dtXml; Descript: 'AITypeChar16'),
    // Строковые типы (80..95)
    (Id: AITypeString;       Typ: 1; DataType: dtXml; Descript: 'AITypeString'),
    (Id: AITypeWord;         Typ: 1; DataType: dtXml; Descript: 'AITypeWord'),
    (Id: AITypeWordsComb;    Typ: 1; DataType: dtXml; Descript: 'AITypeWordsComb'),
    (Id: AITypeSemanticUnit; Typ: 1; DataType: dtXml; Descript: 'AITypeSemanticUnit'),
    (Id: AITypeSugPart;      Typ: 1; DataType: dtXml; Descript: 'AITypeSugPart'),
    (Id: AITypeSuggestion;   Typ: 1; DataType: dtXml; Descript: 'AITypeSuggestion'),
    // Графические типы (96)
    (Id: AITypeGraph;        Typ: 1; DataType: dtXml; Descript: 'AITypeGraph'),
    (Id: AITypeGraph2D;      Typ: 1; DataType: dtXml; Descript: 'AITypeGraph2D'),
    (Id: AITypeGraph3D;      Typ: 1; DataType: dtXml; Descript: 'AITypeGraph3D'),
    // Типы-правила
    (Id: AITypeRule;         Typ: 1; DataType: dtXml; Descript: 'AITypeRule'),
    (Id: AITypeRuleFuzzy;    Typ: 1; DataType: dtXml; Descript: 'AITypeRuleFuzzy'),
    (Id: AITypeRules;        Typ: 1; DataType: dtXml; Descript: 'AITypeRules'),
    // Типы-задания
    (Id: AITypeTask;         Typ: 1; DataType: dtXml; Data: @AI_FreimTask; Descript: 'AITypeTask'),
    (Id: AITypeTasks;        Typ: 1; DataType: dtXml; Descript: 'AITypeTasks'),
    // Типы-действия
    (Id: AITypeAction;       Typ: 1; DataType: dtXml; Data: @AI_FreimAction; Descript: 'AITypeAction'),
    (Id: AITypeActions;      Typ: 1; DataType: dtXml; Descript: 'AITypeActions'),
    // Типы-источники знаний (фреймов)
    (Id: AITypeSource;       Typ: 1; DataType: dtXml; Descript: 'AITypeSource'),
    (Id: AITypeKB;           Typ: 1; DataType: dtXml; Descript: 'AITypeKB'),
    (Id: AITypeKBMemory;     Typ: 1; DataType: dtXml; Descript: 'AITypeKBMemory'),
    (Id: AITypeKBFile;       Typ: 1; DataType: dtXml; Descript: 'AITypeKBFile'),
    (Id: AITypeKBFileCashe;  Typ: 1; DataType: dtXml; Descript: 'AITypeKBFileCashe'),
    (Id: AITypeKBNet;        Typ: 1; DataType: dtXml; Descript: 'AITypeKBNet'),
    (Id: AITypeKBNetCasheMemory;     Typ: 1; DataType: dtXml; Descript: 'AITypeKBNetCasheMemory'),
    (Id: AITypeKBNetCasheFile;       Typ: 1; DataType: dtXml; Descript: 'AITypeKBNetCasheFile'),
    (Id: AITypeKBNetCasheFileMemory; Typ: 1; DataType: dtXml; Descript: 'AITypeKBNetCasheFileMemory'),
    // Типы базовых объектов, которыми оперирут среда выполнения
    (Id: AITypeAR;           Typ: 1; DataType: dtXml; Descript: 'AITypeAR'),
    (Id: AITypeWorld;        Typ: 1; DataType: dtXml; Descript: 'AITypeWorld'),
    (Id: AITypeAgent;        Typ: 1; DataType: dtXml; Descript: 'AITypeAgent'),
    (Id: AITypeModule;       Typ: 1; DataType: dtXml; Descript: 'AITypeModule'),
    (Id: AITypeAgentMain;    Typ: 1; DataType: dtXml; Descript: 'AITypeAgentMain'),
    (Id: AITypeModuleMain;   Typ: 1; DataType: dtXml; Descript: 'AITypeModuleMain')

    //(ID: 0; Typ: 1; DataType: dtXml; Data: nil; DataStr: AI_FrameCode; Descript: 'Тип для кода')
    );

implementation

end.
