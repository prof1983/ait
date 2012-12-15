{**
@Abstract Типы для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 18.06.2004
@LastMod 15.12.2012

A - для записи в файл
B - для памяти
}
unit AiBase0;

interface

uses
  ABase, ABaseUtils2, ATypes;

type
  TError = Boolean;
  UInt032 = AUInt32;
  UInt008 = AUInt08;
  UInt064 = AUInt64;
  Int032 = AInt32;

const
  AssociationUseLength = 3;     // Число записей использований в теле ассоциации
  FreimAssociationLength = 16;  // Число ассоциаций, записываемых в теле фрейма TAIFreim2.Association
  FreimDataLength = 2588;       // Длина данных, записываемых в теле фрейма TAIFreim2.Data
  FreimUseLength = 3;           // Число записей использований в теле фрейма TAIFreim2.Use
  FDataL = 1024;
  FConnectL = 379;

type
  THandle064 = Int64;
  TDateTime064 = TDateTime;

type
  TAIUseType = type UInt32;
  {1 - создание (запись времени создания)
   2 - использован
  }

  PAIUseA = ^TAIUseA;
  TAIUseA = packed record {20}{Для записи в файл}
    HUser: THandle064;          {Идентификатор пользователя}
    DateTime: TDateTime064;     {Дата/время использования}
    UseType: TAIUseType;        {Тип использования}
  end;

  PAIUseB = ^TAIUseB;
  TAIUseB = record {Для памяти}
    HUser: THandle064;          {Идентификатор пользователя}
    DateTime: TDateTime064;     {Дата/время использования}
    UseType: TAIUseType;        {Тип использования}
  end;

  TAIAccess = type UInt32; {Доступ к запрашиваемому фрейму}
  {
   $01 - только чтение
   $02 - только запись
   $03 - чтение и запись
  }

{Типы даных для фреймов}

  TAIAssociationType = type UInt32;  {Тип ассоциативной связи}
  {0 - не обоснованая связь
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

  TAIFreimAtribute = type UInt32; {Атрибуты фрейма}
  { 0000000x - различные атрибуты
   $01 - часть фрейма, записаная в отдельном файле сжата
   $02 - нет смысла сжимать
   $04 - идентификатор не по главной БЗ (главная БЗ только у меня). Сделано для совместимости с локальными БЗ.
   $08 -
    000000x0 - язык
   $00 - не определен
   $10 - английский
   $20 - русский (кодировка win-1251)
   $30 - смешанный
    0x000000
   $01000000 - Этот фрейм изменялся (требует сохранения в БЗ)
  }

type
  PAIAssociationA = ^TAIAssociationA;
  TAIAssociationA = packed record {88}{Тип ассоциации}
    H: THandle064;               {Идентификатор ассоциируемого фрейма}
    AType: TAIAssociationType;   {Тип ассоциативной связи}
    Weight: Int32;              {Вес связи}
    Reliance: UInt32;           {Уверенность}
    UseCount: UInt32;           {Колличество записей об использовании}
    PUse: UInt32;               {Номер блока с использованиями}
    Use: array[0..AssociationUseLength - 1] of TAIUseA;  {Первые записи об использовании. 0 - дата/время/юзер создания; 1 - дата/время/юзер последнего использования}
  end;

  PAIAssociationB = ^TAIAssociationB;
  TAIAssociationB = record {Для памяти}
    H: THandle064;               {Идентификатор ассоциируемого фрейма}
    AType: TAIAssociationType;   {Тип ассоциативной связи}
    Weight: Int32;              {Вес связи}
    Reliance: UInt32;           {Уверенность}
    UseCount: UInt32;           {Колличество записей об использовании}
    PUse: UInt32;               {Номер блока с использованиями}
    Use: array of PAIUseB;       {Записи об использовании. 0 - дата/время/юзер создания; 1 - дата/время/юзер последнего использования}
  end;

  TAiError = ABase.AError;
  //TAiError = type UInt32;

  TAIFreim30 = record
    Handle: THandle064;
    Number: UInt32;
    Name: String;
    Prop: array of record
      Name: THandle064;  {1}
      Value: THandle064; {61}
    end;
  end;

  TAIFreimType = type UInt32;        {Тип фрейма}
  {1 - ф-слово
   2 - ф-предложение
   3 - ф-действие (см. Описание) name,body:string, параметры и результаты - в виде связей
   ----
   4 - ф-название документа
   5 - ф-заголовок1
   6 - ф-заголовок2
   7 - ф-заголовок3
   8 - ф-заголовок4
   9 - ф-заголовок5
   10 - ф-заголовок6
   11 - ф-описание документа
   12 - ф-текст темы (от заголовка до следующего заголовка того же уровня или выше)
   13 - ф-абзац

   14 - ф-главная часть слова (корень)
   15 - ф-суффикс
   16 - ф-окончание
   17 - ф-приставка
   18 - ф-буква (символ)

   19 - ф-файл (путь к файлу)
   20 - ф-ключевое слово(выражение)

   21 - точка (графический объект)
   22 - линия (графический объект)

   23 - строка-ответ просто
   24 - строка-ответ в чате на ключевое слово
   25 - первая строка-ответ в разговоре
   26 - последняя строка-ответ
   27 - строка-выражение Фоменко
   28 - мужское имя
   29 - женское имя
   30 - ф-тип фрейма (класс фрейма) number,name:string
   31 - ф-файл (в Data содержится тело файла)
   32 - ф-логическое выражение (условие)
   33 - ф-строка (любая текстовая строка)
   34 - ф-список тем(содержание)
   35 - ф-файл (имя файла)
   36 - ф-список слов, начинающихся на данные буквы
   37 - ф-навигация по БЗ
   38 - ф-название типа фрейма
   39 - ф-список фреймов
   40 - Базовый фрейм (Base)
   41 - ф-задание (Task)
   42 - ф-результат поиска решения
   43 - Базовый ф-метод (MethodBase)
   44 - Ф-AI (AI)
   45 - ф-Источники даных (Sources)
   46 - ф-источник данных (Source)
   47 - ф-запросы (Questions)
   48 - ф-запрос (Question)
   49 - ф-список методов (Methods)
   50 - ф-параметр (Param, Result)  - name,value:string
   51 - ф-список параметров (Params, Results)
   52 - ф-список заданий (Tasks)
   53 - ф-пользователь - name:string

Фрейм-действие (3)
Состав Data:
1. Тип записи действия (= 1) (UInt032)
2. Размер названия в байтах (без завершающего #0) (UInt032)
3. Размер описания входных параметров в байтах (UInt032)
4. Размер описания выходных параметров в байтах (UInt032)
5. Размер команд в байтах (UInt032)
6. Название действия
7. Разделитель (#0)
  Описание входных параметров
8. Колличество входных переменных (UInt032)
9. Handle переменной 1 (THandle064)
...
  Описание выходных параметров
10. Колличество входных переменных (UInt032)
11. Handle переменной 1 (THandle064)
...
Список выполняемых команд и действий. (О командах)
Команды - базовые функции, заложеные в программе.
Действия - запуск выполнения других фреймов-действий.

Ф-Тип фрейма (30)
Создан для записи медов обработки фреймов.
Состав Data:
1. Идентификатор фрейма-названия этого типа. (THande064)
2. Колличество ф-методов (UInt032)
3. Список идентификаторов ф-методов

Фрейм-логическое выражение (32)
Состав Data:
1. Тип записи логического выражения (=1) (UInt032)
2. Typ: UInt032 - тип логической связи (UInt032)
3. Importance: Int032 - Значимость этого логического выражения
4. CountIn: UInt032
5. CountOut: UInt032
6. Список FIn по порядку
7. Список FOut по порядку

Фрейм-список тем(содержание) (34)
Состав Data:
1. Длина названия (UInt008)
2. Название (1..длина названия)
3. Колличество записей (UInt032)
4. Длина первой записи (UInt032)
5. Первая запись (1..длина)
...

Ф-Список слов (36)
Состав Data:
1. Колличество букв (UInt008)
2. Буквы по порядку(начала слов) (0..10)
3. Список слов или следующий уровень [0..321]

Ф-Навигация по БЗ (37)
Создан для структурированого представления БЗ, как дерева фреймов.
См. Ф-Тип фрейма (30).
Состав Data:
1. Колличество букв названия (UInt008)
2. Название [0..82] of Char
3. Reserved [0..2503] of UInt008

Ф-Название типа фрейма (38)
Состав Data:
1. Тип фрейма, назвние которого представлено (UInt032)
2. Длина названия (UInt032)
3. Название [array]

Ф-Список фреймов (39)
Состав Data:
1. Колличество элементов в списке (UInt032)
2. Список идентификаторов фреймов (array of THandle064)

Базовый фрейм (40)
Состав Data: (0)
1. Версия = 0 (UInt064)
2. Идентификатор ф-списка типов фреймов (39) (THandle064)
Состав Data: (2)
1. Версия = 2 (UInt064)
2. Идентификатор ф-списка типов фреймов (39) (THandle064)
3. Идентификатор ф-метода построения html навигации по БЗ (3) (THandle064)
4. Идентификатор ф-метода решения заданий (3) (THandle064)
5. Идентификатор ф-AI (44) (THandle064)

Ф-Задание (41)
Состав Data:
1. Длина названия (UInt032)
2. Колличество параметров In (UInt032)
3. Колличество результатов Out (UInt032)
4. Время на выполнение задания (TDateTime064)
5. Главный метод (THandle064)
6. Время начала выполнения (TDateTime064)
7. Завершеность выполнения задания (UInt032) 0-не начато, High(UInt032)-закончено
8. Название (array[CountName] of Char)
9. Разделитель #0 (UInt008)
10. Список параметров In (array[CountIn] of THandle064)
11. Список результатов Out (array[CountOut] of THandle064)

Базовый ф-метод (43)
Выполнение небольшого колличества команд, реализованых в программе.
Команды различаются по номеру:
  _0000: aiFreimList_Create
Состав Data: как у ф-метода (3)
  }

  TAIFreimA = packed record {32} {Для передачи}
    Handle: THandle064;
    Typ: THandle064;
    DTCreate: TDateTime064;
    DataSize: UInt032;
    ConnectCount: UInt032;
  end;

  TAIFreimB = record {Для хранения в памяти}
    Handle: THandle064;         {Идентификатор фрейма}
    Typ: THandle064;            {Тип фрейма}
    DTCreate: TDateTime064;     {Дата создания фрейма}
    Atribute: TAIFreimAtribute; {Атрибуты фрейма (сжатый, ...)}
    ConnectCount: UInt032;      {Колличество ассоциаций}
    DataSize: UInt032;          {Размер данных. Если строка, то учитывая завершающий 0}
    Data: string; //TArrayChar008;        {Данные (String)}
    Connect: array of THandle064; {Связи}
    {Load: UInt032;              {Что загружено $01-Assoc,$02-AssocUses,$04-Uses,$08-Data,$FF-All}
    {Rewrite: UInt032;           {Что изменено $01-Assoc,$02-AssocUses,$04-Uses,$08-Data,$10-Freim}
    {DTRead: TDateTime064;       {Время чтения. Для сортировки буфера.}
  end;

  TAIFreimC = packed record {Для БД}
    Handle: THandle064;         {Идентификатор фрейма}
    Typ: TAIFreimType;          {Тип фрейма}
    CountConnect: UInt032;      {Колличество ассоциаций}
    CountData: UInt032;         {Размер данных. Если строка, то учитывая завершающий 0}
    DTCreate: TDateTime064;     {Время создания}
    DTChange: TDateTime064;     {Время последнего изменения}
    Reserved: UInt032;          {Зарезервировано}
    Data: array[0..1023] of AChar; {Данные фрейма}
    Connect: array[0..378] of THandle064; {Связи с другими фреймами}
  end;

  TAIFreimF = packed record {4096} {Для записи в файл}
    Handle: THandle064;         {Идентификатор фрейма}
    FreimType: TAIFreimType;    {Тип фрейма}
    AssociationCount: UInt032;  {Колличество ассоциаций}
    DataCount: UInt032;         {Размер данных. Если строка, то учитывая завершающий 0}
    UseCount: UInt032;          {Колличество использований}
    Association: array [0..FreimAssociationLength - 1] of TAIAssociationA; {Первые ассоциации}
    Data: array [0..FreimDataLength - 1] of Char; {Данные, если их размер не больше FreimDataLength, иначе только начало}
    Use: array [0..FreimUseLength - 1] of TAIUseA; {Первые записи об использовании. 0 - дата/время/юзер создания; 1 - дата/время/юзер последнего использования}
    PAssociation: UInt032;      {Указатель на первый блок ассоциаций}
    PData: UInt032;             {Указатель на первый блок данных (если размер > FreimDataLength, иначе nil)}
    PUse: UInt032;              {Указатель на первый блок использований}
    Atribute: TAIFreimAtribute; {Атрибуты фрейма (сжатый, ...)}
  end;

{}
type
  TAIServCom = type UInt032; {Команды посылаемые серверу БЗ}
{const
  comDisconnect    = 1;
  comFreimCountGet = 3;}

type
  TAISourceMode = type UInt032; {Способ открытия}
  {
  0-не использовать cashe. Запись напрямую на диск
  1-использовать cashe файла (автовыбор) - не реализовано
  2-Все хранить в памяти. Сохранение и загрузка только при открытии и закрытии.
  10..10000 - максимальное колличество фреймов в буфере
  }

{Блоки}

  TAIBlockAssociation = packed record {4096} {Блок для записи в файл}
    HFreim: THandle064;         {Идентификатор фрейма}
    LastB: UInt032;             {Предыдущий блок.0-этот блок первый}
    NextB: UInt032;             {Следующий блок.0-этот блок последний}
    A: array [0..45] of TAIAssociationA; {Массив ассоциаций}
    Use: TAIUseA;               {Запись об использовании блока}
    Reserved: array [0..11] of UInt008;
  end;

  TAIBlockData = packed record {4096} {Блок для записи в файл}
    HFreim: THandle064;         {Идентификатор фрейма}
    LastB: UInt032;             {Предыдущий блок.0-этот блок первый}
    NextB: UInt032;             {Следующий блок.0-этот блок последний}
    Data: array[0..4079] of Char; {Данные}
  end;

  (*TFileAIBlockTable = array [0..4095] of TFileAITableB; {Блок распределения}

  TAIBlockType = TFileAITableB;
  {0 - блок свободен
   1 - таблица распределения блоков
   2 - таблица распределения фреймов
   3 - фрейм
   4 - ассоциации фрейма
   5 - данные фрейма
   6 - записи об использовании фрейма (принадлежат фрейму)
   7 - записи об использовании фрейма (принадлежат ассоциации)
   255 - блока не существует
  }*)

  TAIBlockUse = packed record {4096} {Блок для записи в файл}
    HFreim: THandle064;         {Идентификатор фрейма, если блок принадлежит фрейму, иначе = 0}
    LastB: UInt032;             {Предыдущий блок.0-этот блок первый}
    NextB: UInt032;             {Следующий блок.0-этот блок последний}
    U: array[0..203] of TAIUseA; {Массив использований}
  end;

{Данные}
  TAIData01 = packed record
    Version: UInt032;           {=1}
    CountStr: Uint032;          {Колличество символов}
    {Str: String;}
  end;

  TAIData03 = packed record
    T: UInt032;                 {Тип записи действия (= 1)}
    SizeName: UInt032;          {Размер названия в байтах (без завершающего #0)}
    Params: THandle064;         {Идентификатор списка параметров}
    Results: THandle064;        {Идентификатор списка результатов}
    SizeComand: UInt032;        {Размер команд в байтах (UInt032)
    {Name: String;               Название действия}
    {-Список выполняемых команд и действий. (О командах)
      {Команды - базовые функции, заложеные в программе. Действия - запуск выполнения других фреймов-действий.}
  end;

  TAIData30 = packed record
    Version: UInt032; {=1}
    Number: UInt032;            {Тип фрейма}
    CountName: UInt032;         {Размер названия}
    CountProperty: UInt032;     {Колличество описаний параметров}
    {Name: String;}
    {Prop: array[CountProperty] of record
      Name: THandle064;    (1)
      Value: THandle064;   (61)
    end;}
  end;

  TAIData36 = packed record {ф-список слов, начинающихся на данные буквы}
    Count: UInt008;             {Колличество букв}
    Chars: array[0..10] of Char; {Буквы по порядку(начала слов)}
    Words: array[0..321] of THandle064; {Список слов или следующий уровень}
  end;

  TAIData39 = packed record
    Version: UInt032;           {=1}
    Count: UInt032;             {Колличество}
    Name: THandle064;           {Название}
    {Items: array[n] of THandle064;}
  end;

  TAIData40 = packed record {Базовый фрейм}
    (*Ver: UInt064;               {Версия = 1}
    HListFTyp: THandle064;      {Идентификатор ф-списка типов фреймов (39)}
    HMethod: THandle064;        {Идентификатор ф-метода построения html навигации по БЗ (3)}*)
    Ver: UInt064;               {Версия = 2}
    HListFTyp: THandle064;      {Идентификатор ф-списка типов фреймов (39)}
    HMethodHtml: THandle064;    {Идентификатор ф-метода построения html навигации по БЗ (3)}
    HMethodTask: THandle064;    {Идентификатор ф-метода решения заданий (3)}
    HAI: THandle064;            {Идентификатор ф-AI (44)}
    HMethodBase: THandle064;    {Идентификатор ф-метода базового (3)}
    HList: THandle064;          {Идентификатор ф-списка списков по типам}
  end;

  TAIData41 = packed record
    Version: Uint032;           {=1}
    Name: THandle064;
  end;

  TAIData43 = type TAIData03;

  TAIData44 = packed record
    Methods: THandle064;
    Questions: THandle064;
    Sources: THandle064;
    Tasks: THandle064;
  end;

  TAIData45 = packed record {2588}
    SourceMain: THandle064;
    Count: UInt032;
    Sources: array [0..321] of THandle064;
  end;

  TAIData46 = packed record
    Fil: THandle064;            {Идентификатор файла (35)}
  end;

  TAIData48 = packed record
    QuestionSize: UInt032;      {Размер вопроса в байтах}
    Params: THandle064;         {Параметры}
    Received: Boolean;          {Результат получен}
    Results: THandle064;        {Результаты}
    {Question: String;}
  end;

  TAIData53 = packed record {Person}
    Version: UInt032;           {=1}
    Name: THandle064;
    Email: THandle064;
    Name1: THandle064;          {Имя}
    Name2: THandle064;          {Фамилия}
    Name3: THandle064;          {Отчество}
  end;

  TAIData64 = packed record {Association}
    Freim: THandle064;          {Фрейм, к которому принадлежит ассоциация}
    FreimA: THandle064;         {Ассоциированый фрейм}
    TypeA: TAIAssociationType;  {Тип ассоциативной связи}
    Weigtht: Int032;            {Вес связи}
    Reliance: UInt032;          {Уверенность}
  end;

  TAIData139 = record {Html файл, составленый из фреймов}
    Name: String;               {Заголовок}
    Parent: THandle064;         {Родительская страница}
    Coment: String;             {Коментарий}
    Lists: array of THandle064; {Списки}
    DT: TDateTime064;           {Дата последнего изменения}
  end;

  TAIDataAssoc = record {ф-ассоциация}
    H1: THandle064;              {Идентификатор ассоциируемого фрейма 1}
    H2: THandle064;              {Идентификатор ассоциируемого фрейма 2}
    Typ: THandle064;             {Тип ассоциативной связи}
    Weight: Int032;              {Вес связи}
    Reliance: UInt032;           {Уверенность}
    Name: String;                {Название связи}
  end;
  TAIDataAssocR = packed record
    H1: THandle064;              {Идентификатор ассоциируемого фрейма 1}
    H2: THandle064;              {Идентификатор ассоциируемого фрейма 2}
    Typ: THandle064;             {Тип ассоциативной связи}
    Weight: Int032;              {Вес связи}
    Reliance: UInt032;           {Уверенность}
    L: UInt032;                  {Длина названия}
  end;

  TAIDataSelect = record {Выборка из БЗ (Select) (138)}
    Name: String;
    Params: TUrlParams;
    Items: array of THandle064;
  end;

  TAIDataTask = record {Задение (Task) (137)}
    Name: String;
    TStart: TDateTime064;
    TEnd: TDateTime064;
  end;

  TAIDataType = record {ф-тип фрейма}
    Name: String;
  end;

  TAIDataUrlParam = record {Url параметр (136)}
    Name: String;
    Value: String;
  end;

  TAIDataUrlParams = record {Url параметры (135)}
    Params: array of THandle064; {}
  end;

  TAIDataSug = record {ф-предложение}
    Text: String;
    Ch: TStrPosChar;
  end;
  TAIDataSugR = packed record
    Ch: TStrPosChar;
    L: UInt032;
  end;

  TFileAIInfo = record
    CountF: UInt064;            {Колличество записей фреймов в файле}
    CountTableB: UInt032;       {Колличество блоков распределения свободного места}
    CountB: UInt032;            {Колличество блоков всего = CountF + CountTableB + Колличество дополнительных блоков}
    Date: TDateTime064;         {Дата и время последнего использования (закрытия)}
    HBase: THandle064;          {Идентификатор базового фрейма}
  end;

  TFileAIMode = type UInt032; {Способ открытия}
  {
  0-не использовать cashe. Запись напрямую на диск
  1-использовать cashe файла
  }

  TFileAITableB = type UInt008; {Запись о блоке}

procedure aiFreimAClear(
  var Freim: TAIFreimA
  );

procedure aiFreimAToFreimB(
  const FreimA: TAIFreimA;
  var FreimB: TAIFreimB
  );

procedure aiFreimBClear(
  var Freim: TAIFreimB
  );

procedure aiFreimBToFreimA(
  const FreimB: TAIFreimB;
  var FreimA: TAIFreimA
  );

procedure aiFreimCToFreimA(
  const FreimC: TAIFreimC;
  var FreimA: TAIFreimA
  );

function cAITypToStr(
  Typ: TAIFreimType
  ): String;

function cDataAssocRToDataAssoc(
  D: TAIDataAssocR;
  Name: String;
  var Data: TAIDataAssoc
  ): TError;

implementation

procedure aiFreimAClear(var Freim: TAIFreimA);
begin
  Freim.Handle := 0;
  Freim.Typ := 0;
  Freim.DTCreate := 0;
  Freim.DataSize := 0;
  Freim.ConnectCount := 0;
end;

procedure aiFreimAToFreimB(const FreimA: TAIFreimA; var FreimB: TAIFreimB);
begin
  {aiFreimBClear(FreimB);}
  FreimB.Handle := FreimA.Handle;
  FreimB.Typ := FreimA.Typ;
  FreimB.DTCreate := FreimA.DTCreate;
  FreimB.ConnectCount := FreimA.ConnectCount;
  FreimB.DataSize := FreimA.DataSize;
end;

procedure aiFreimBClear(var Freim: TAIFreimB);
begin
  Freim.Handle := 0;
  Freim.Typ := 0;
  Freim.DTCreate := 0;
  Freim.ConnectCount := 0;
  Freim.DataSize := 0;
  Freim.Atribute := 0;
  SetLength(Freim.Data, 0);
  SetLength(Freim.Connect, 0);
end;

procedure aiFreimBToFreimA(const FreimB: TAIFreimB; var FreimA: TAIFreimA);
begin
  FreimA.Handle := FreimB.Handle;
  FreimA.Typ := FreimB.Typ;
  FreimA.DTCreate := FreimB.DTCreate;
  FreimA.DataSize := FreimB.DataSize;
  FreimA.ConnectCount := FreimB.ConnectCount;
end;

procedure aiFreimCToFreimA(const FreimC: TAIFreimC; var FreimA: TAIFreimA);
begin
  FreimA.Handle := FreimC.Handle;
  FreimA.Typ := FreimC.Typ;
  FreimA.DTCreate := FreimC.DTCreate;
  FreimA.DataSize := FreimC.CountData;
  FreimA.ConnectCount := FreimC.CountConnect;
end;

function cAITypToStr(Typ: TAIFreimType): String;
begin
  case Typ of
    1: Result := 'Слово';
    2: Result := 'Предложение';
    3: Result := 'Действие';
    4: Result := 'Название документа';
    5: Result := 'Заголовок 1';
    6: Result := 'Заголовок 2';
    7: Result := 'Заголовок 3';
    8: Result := 'Заголовок 4';
    9: Result := 'Заголовок 5';
    10: Result := 'Заголовок 6';
    11: Result := 'Описание документа';
    12: Result := 'Текст темы';
    13: Result := 'Абзац';
    14: Result := 'Корень слова';
    15: Result := 'Суффикс';
    16: Result := 'Окончание';
    17: Result := 'Приставка';
    18: Result := 'Буква';
    19: Result := 'Путь к файлу';
    20: Result := 'Ключевое слово';
    21: Result := 'Точка';
    22: Result := 'Линия';
    23: Result := 'Строка-ответ просто';
    24: Result := 'Строка ответ в чате на ключевое слово';
    25: Result := 'Первая строка-ответ в разговоре';
    26: Result := 'Последняя строка-ответ';
    27: Result := 'Строка-выражение Фоменко';
    28: Result := 'Мужское имя';
    29: Result := 'Женское имя';
    30: Result := 'Тип фрейма';
    31: Result := 'Файл';
    32: Result := 'Логическое выражение';
    33: Result := 'Строка';
    34: Result := 'Список тем';
    35: Result := 'Имя файла';
    36: Result := 'Список слов, начинающихся на данную букву';
    37: Result := 'Навигация по БЗ';
    38: Result := 'Название типа фрейма';
    39: Result := 'Список фреймов';
    40: Result := 'Базовый фрейм';
    41: Result := 'Задание';
    42: Result := 'Результат поиска решения';
    43: Result := 'Базовый метод';
    44: Result := 'AI';
    45: Result := 'Источники данных';
    46: Result := 'Источник данных';
    47: Result := 'Запросы';
    48: Result := 'Запрос';
    49: Result := 'Список методов';
    50: Result := 'Параметр';
    51: Result := 'Список параметров';
    52: Result := 'Список заданий';
    53: Result := 'Пользователь';
    54: Result := 'Название инженерного расчета';
    55: Result := 'Инженерный расчет';
    56: Result := 'Сайт';
    57: Result := 'Статья';
    58: Result := 'Ссылка';
    59: Result := 'Таблица';
  end;
end;

function cDataAssocRToDataAssoc(D: TAIDataAssocR; Name: String; var Data: TAIDataAssoc): TError;
begin
  Result := True;
  Data.H1 := D.H1;
  Data.H2 := D.H2;
  Data.Typ := D.Typ;
  Data.Weight := D.Weight;
  Data.Reliance := D.Reliance;
  {SetLength(Data.Name, D.L);}
  Data.Name := Name;
end;

end.
