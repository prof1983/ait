{**
@Abstract(Структура БД фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.12.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiSourceAdoStruct;

interface

uses
  ADbTypes,
  ADbDescFields, ADbDescTable;

// -----------------------------------------------------------------------------
const
  //** Имя таблици
  cFreim             = 'Freims';

const // Имена полей -----------------------------------------------------------
  cFreimId           = 'ID';
  cFreimType         = 'Typ';
  cFreimDTCreate     = 'DTCreate';
  cFreimDataSize     = 'DataSize';
  cFreimData         = 'Data';
  cFreimConnectCount = 'ConnectCount';

const // Описание полей таблици ------------------------------------------------
  Freim_FieldsCount = 6;
  Freim_Fields: array [0..Freim_FieldsCount - 1] of TFieldRec = (
    (fldName: cFreimId;       fldDescription: 'Идентификатор';          fldType: ftInteger;  fldSize: 0; fldNotNull: True; fldDefault: ''),
    (fldName: cFreimType;     fldDescription: 'Тип фрейма';             fldType: ftInteger;  fldSize: 0; fldNotNull: True; fldDefault: ''),
    (fldName: cFreimDTCreate; fldDescription: 'Дата создания';          fldType: ftDateTime; fldSize: 0; fldNotNull: True; fldDefault: ''),
    (fldName: cFreimDataSize; fldDescription: 'Размер данных';          fldType: ftInteger;  fldSize: 0; fldNotNull: True; fldDefault: ''),
    (fldName: cFreimConnectCount; fldDescription: 'Колличество связей'; fldType: ftInteger;  fldSize: 0; fldNotNull: True; fldDefault: ''),
    (fldName: cFreimData;     fldDescription: 'Данные';                 fldType: ftFmtMemo;  fldSize: 0; fldNotNull: False; fldDefault: '')
    );

const // Описание индексов -----------------------------------------------------
  Freim_IndexCount = 1;
  Freim_Index: array [0..Freim_IndexCount - 1] of TIndexRec = (
    (idxName: 'IndexFreimId';   idxField: cFreimId;   idxType: idxPrimary)
    //(idxName: 'IndexFreimType'; idxField: cFreimType; idxType: idxNotUniqum{idxUniqum})
    );

const
  //** @abstract(Описание таблици фреймов)
  Table_Freim: TTableRec = (
      //** наименование таблицы
    tblName: cFreim;
      //** наименование таблицы по русский
    tblDescription: '';
      //** Доступ для других пользователей
    tblAccess: tbReadWrite;
      //** Количество столбцов
    tblFieldsCount: Freim_FieldsCount;
      //** Список полей
    tblFields: @Freim_Fields;
      //** Количество индексов в таблице
    tblIndexsCount: Freim_IndexCount;
      //** Список индексов
    tblIndexs: @Freim_Index;
      //** Количество объединений
    tblJoinsCount: 0;
      //** Список обьединений
    tblJoins: nil{PJoinArr};
    );


// -----------------------------------------------------------------------------
const // Имя таблици -----------------------------------------------------------
  cConnects          = 'Connects';

const // Имена полей -----------------------------------------------------------
  cConnectsId        = 'ID';
  cConnectsCon       = 'Con';

const // Описание полей таблици ------------------------------------------------
  Connects_Fields_Count = 2;
  Connects_Fields: array [0..Connects_Fields_Count - 1] of TFieldRec = (
    (fldName: cConnectsId; fldDescription: 'Идентификатор связываемого фрейма'; fldType: ftInteger;  fldSize: 0; fldNotNull: True; fldDefault: ''),
    (fldName: cConnectsCon; fldDescription: 'Идентификатор фрейма с которым производится связь'; fldType: ftInteger;  fldSize: 0; fldNotNull: True; fldDefault: '')
    );

const // Описание индексов -----------------------------------------------------
  Connects_Index_Count = 2;
  Connects_Index: array [0..Connects_Index_Count - 1] of TIndexRec = (
    (idxName: 'IndexConnectsId';  idxField: cConnectsId;  idxType: idxPrimary),
    (idxName: 'IndexConnectsCon'; idxField: cConnectsCon; idxType: idxNotUniqum)
    );

const
  //** @abstract(Описание таблици связей)
  Table_Connects: TTableRec = (
    tblName: cConnects;
    tblDescription: '';
    tblAccess: tbReadWrite;
    tblFieldsCount: Connects_Fields_Count;
    tblFields: @Connects_Fields;
    tblIndexsCount: Connects_Index_Count;
    tblIndexs: @Connects_Index;
    tblJoinsCount: 0;
    tblJoins: nil;
    );

// -----------------------------------------------------------------------------
const // Описание таблиц -------------------------------------------------------
  Tables_Count = 4;
  Tables: array [0..Tables_Count - 1] of PTableRec = (
    @Table_DescTable,
    @Table_DescField,
    @Table_Freim,
    @Table_Connects
    );

const
  //** @abstract(Описание данных)
  DBMain: TDBMain = (
      //** количество таблиц
    dbTablesCount: Tables_Count;
      //** описание таблиц
    dbTables: @Tables;
      //** количество представлений
    dbViewsCount: 0;
      //** описание представлений
    dbViews: nil{ViewArr};
    );

implementation

end.
