{**
@Abstract Базовые типы для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 20.03.2006
@LastMod 12.11.2012
}
unit AiTypes;

interface

uses
  ABase, ATypes,
  AiBase;

type
  {** @abstract(Тип ассоциативной связи)
   0 - не обоснованая связь
   1 - ответ вводимый пользователем на строку, выведеную AI

   2 - ассоциация с ф-файлом и наоборот
   3 - ф-заголовок-родитель (для всех)
   4 - ф-заголовок-дочерний (для всех), ф-абзац-дочерний (для заголовков)
   5 - ф-абзац(заголовок,строка) следующий (для поврорения последовательности)
   6 - ф-абзац(заголовок,строка) предыдущий (для поврорения последовательности)
   7 - связь ключевого слова с ответом
   8 - ключевое слово синоним
   9 - вторая часть составного ключевого слова

   10 - связь графического фрейма с названием и наоборот

   11 - связь слова со строкой, связь строки со словом
   12 -

   13 - ответ AI на строку введеную пользователем
  }
  TAiAssociationType = type Integer;
  TAiAssocoationTypeA = (
    atNone,
    atAswer,
    atFile,
    atParent,
    atDoter,
    atNext,
    atPrevious,
    atKeyWord,
    atSinonym,
    atDescription,
    atUncnown
    );

  //TAI_Id = AiBase.TAId;

type //** Тип данных
  TAiDataType = (
      //** Нет данных
    dtNone,
      //** Поток байтов
    dtStream,
      //** Текстовая строка (WideString)
    dtText,
      //** XML формат
    dtXml,
      //** Не изветсно
    dtUncnown
    );

type //** Тип данных
  AiDataTypeEnum = Integer;
const
    //** Нет данных
  edtNone    = $00000001;
    //** Неизвестный тип данных
  edtUncnown = $00000002;
    //** Массив байтов
  edtStream  = $00000004;
    //** Текст (WideString)
  edtText    = $00000008;
    //** XML вид
  edtXml     = $00000010;

type //** Тип данных
  TAiDataTypeInt = AiDataTypeEnum;
const
  //** Нет данных
  AI_DATA_TYPE_NONE    = $01;
  //** Не изветсно
  AI_DATA_TYPE_UNCNOWN = $02;
  //** Поток байтов
  AI_DATA_TYPE_STREAM  = $04;
  //** Текстовая строка (WideString)
  AI_DATA_TYPE_TEXT    = $08;
  //** XML формат
  AI_DATA_TYPE_XML     = $10;
{const
  dtNone = AI_DATA_TYPE_NONE;
  dtStream = AI_DATA_TYPE_STREAM;
  dtText = AI_DATA_TYPE_TEXT;
  dtXml = AI_DATA_TYPE_XML;
  dtUncnown = AI_DATA_TYPE_UNCNOWN;}

type //** Тип данных
  EnumAIDataType = AiDataTypeEnum;

{
type
  //** @abstract(Тип данных)
  AIDataTypeEnum = Integer;
const
    //** Нет данных
  edtNone    = AI_DATA_TYPE_NONE;
    //** Неизвестный тип данных
  edtUncnown = AI_DATA_TYPE_UNCNOWN;
    //** Массив байтов
  edtStream  = AI_DATA_TYPE_STREAM;
    //** Текст (WideString)
  edtText    = AI_DATA_TYPE_TEXT;
    //** XML вид
  edtXml     = AI_DATA_TYPE_XML;
}

type // Тип сообщения
  TAiMsgType = TMessageType;

type //** Сообщение
  TAiMessageRec = ATypes.TProfMessageRec;

// ---

type
  PConnects = ^TConnects;
  TConnects = array of TAId;

type //** @abstract(Тип элемента данных фрейма структуры XML)
  TElementType = (
    etString,
    etInt,
    etFloat,
    etDateTime,
    etMemo,
    etXml
    );

type
  PElements = ^TElements;

  //** @abstract(Элемнт данных фрейма структуры XML)
  TElement = record
    Name: WideString;        // Имя поля
    Typ: TElementType;       // Тип элемента
    Title: WideString;       // Отображаемое имя
    Default: WideString;     // Значение по умолчанию
    Description: WideString; // Коментарии
    Required: Boolean;       // Обязательно ли поле
    Elements: PElements;     // Дочерние элементы
  end;

  //** @abstract(Массив элементов описания структуры данных ф-типа)
  TElements = array of TElement;

// ---

type //** @abstract(Запись для фрема)
  TAiFrameRec3 = packed record
    ID: Integer;
    Typ: Integer;
    ConnectCount: Integer;
    Reserved: Integer;
    DTCreate: TDateTime;
  end;

type //** Для передачи внутри программы
  TAiFreimRec = record
    Id: TAId;
    Typ: TAId;
    DTCreate: TDateTime;
    DataSize: UInt64;
    ConnectCount: UInt64;
  end;

type //** Для записи в файл (24 байта)
  TAiFreimRecF32 = packed record
    ID: TAiId32;
    Typ: TAiId32;
    DTCreate: TDateTime;
    DataSize: UInt32;
    ConnectCount: UInt32;
  end;

type //** Для записи в файл (40 байт)
  TAiFreimRecF64 = packed record
    ID: TAId;
    Typ: TAId;
    DTCreate: TDateTime;
    DataSize: UInt64;
    ConnectCount: UInt64;
  end;


type //** @abstract(Для записи структуры базовых фреймов AIFreims)
  TFreimRec = record
      //** ID фрейма. Если 0, то задается автоматически
    ID: TAId;
      //** Тип фрейма
    Typ: TAId;
      //** Дата создания
    DTCreate: TDateTime;
      //** Тип данных: XML, Stream
    DataType: TAIDataType;
      //** Только если DataType = dtXml
    Data: PElements;
      //** Текстовые данные в виде одной строки (в том числе для AI.Code)
    DataStr: WideString;
      //** Данные для массива байтов (Stream)
    DataStream: string;
      //** Колличество связей
    ConnectCount: UInt64;
      //** Список связей
    Connects: PConnects;
      //** Описание фрейма
    Descript: WideString;
  end;
  _Freim = TFreimRec;

// --------

type //** @abstract(Прототип ф-типа. Указывается Id или имя прототипа. Прототип - родительский объект.)
  TPrototype = record
    ID: TAId;
    Name: WideString;
  end;

type
  PPrototypes = ^TPrototypes;
  TPrototypes = array of TPrototype;

type
  PStructFreimType = ^TStructFreimType;
  //** @abstract(Структура записи ф-типа (Type=1))
  TStructFreimType = record
      //** Название ф-типа
    Name: WideString;
      //** Отображаемое имя
    Title: WideString;
      //** Описание ф-типа
    Description: WideString;
      //** Элементы данных
    Elements: PElements;
      //** Прототипы
    Prototypes: PPrototypes;
  end;

type //** @abstract(Запись для фрема)
  TAiFrameRec = packed record
    ID: Integer;
    Typ: Integer;
    DTCreate: TDateTime;
    DataSize: Integer;
    ConnectCount: Integer;
    Reserved05: Integer;
    Reserved06: Integer;
    Reserved07: Integer;
  end;

// --- from Prof_AI.pas ---

{Костанты номеров объектов с фиксироваными типами}

const // Идентифкаторы базовых объектов, которыми оперирует среда выполнения
  frAgentsId      = 0;
  frARId          = 640; {272}
  frWorldId       = 641; {273}
  frKBId          = 642; {256}
  frAgentMainId   = 643; {276}
  frModuleMainId  = 644; {277}
  ftSourcesId     = 0;

const // Константы преобразования типов ----------------------------------------
  ENG_DATA_TYPE: array[TAiDataType] of string = ('None', 'Stream', 'Text', 'Xml', 'Uncnown');
  INT_DATA_TYPE: array[TAiDataType] of Integer = (0, 1, 2, 3, 255);
  RUS_DATA_TYPE: array[TAiDataType] of string = ('Нет данных', 'Поток байтов', 'Текст', 'XML формат', 'Не изветсно');

implementation

end.
