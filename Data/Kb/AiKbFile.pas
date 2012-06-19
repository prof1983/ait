{**
@Abstract(БЗ фреймов v. 0.1)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.03.2005)
@LastMod(19.06.2012)
@Version(0.5)

Функции доступа к файлу БЗ (идентификаторы фреймов - 64 бита)

0.0.0.3 - 04.04.2005 - Добавлен модуль Prof_KB_File_1 0.0.0.3
0.0.0.2 - 03.04.2005
0.0.0.1 - 15.03.2005

Prof_KB_File_1
0.0.0.3 - 03.04.2005
0.0.0.2 - 29.03.2005 - Добавлен модуль UAI_File 0.0.0.2
0.0.0.1 - 15.03.2005
}
unit AiKbFile;

interface

uses
  Classes,
  ABase2, ABaseUtils2, AIoTypes, AStreamObj, ATypes,
  AiBase, AiKbObj, AiTypes;

type
  UInt32 = Integer;
  TMyFile = AStreamObj.TProfFile;
  TAI_Id = TAId;
  TAI_Id64 = TAId;

type
  TFileConnect = class(TMyFile)
  public
    function CRead(Index: UInt32): TAI_Id;
    function CWrite(Index: UInt32; Value: TAI_Id): TError;
    function Open(Path: String; Id: TAI_Id): Boolean;
    function Open2(Path: String; Id: TAI_Id): TError;
  end;

  TFileData = class(TMyFile)
  public
    function Delete(Path: String; Id: TAI_Id): TError;
    function Open(Path: String; Id: TAI_Id): Boolean;
    function Open2(Path: String; Id: TAI_Id): TError;
  end;

{ Закрытие БЗ }
function KBClose(): TError;

{Добавление связи}
function KBConnectAdd(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  Connect: TAI_Id64         {in}{Идентификатор связи}
  ): UInt32;                    {Индекс добавленой связи}

{Возвращает колличество связей}
function KBConnectCount(
  Id: TAI_Id64              {in}{Идентификатор фрейма}
  ): UInt32;                    {Колличество связей}

{Удаляет связь}
function KBConnectDelete(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  Con: TAI_Id64             {in}{Идентификатор связи}
  ): TError;                    {0-ошибок нет, иначе произошла ошибка}

{Удаляет связь}
function KBConnectDeleteI(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  Index: UInt32                 {in}{Индекс связи}
  ): TError;                    {0-ошибок нет, иначе произошла ошибка}

{Возвращает связь}
function KBConnectGet(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  Index: UInt32                 {in}{Индекс связи}
  ): TAI_Id64;              {Идентификатор связи}

{Возвращает индекс связи}
function KBConnectIndexGet(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  Connect: TAI_Id64         {in}{Идентификатор связи}
  ): UInt32;                    {Индекс связи}

{Очищает данные}
function KBDataClear(
  Id: TAI_Id64              {in}{Идентификатор фрейма}
  ): TError;                    {}

{Читает данные}
function KBDataRead(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  var Buf;                      {out}{Буфер чтения}
  Size: UInt32;                 {in}{Размер читаемых данных в байтах}
  Seek: UInt32                  {in}{Начальный байт чтения данных}
  ): UInt32;                    {Колличество прочинаных байт}

{Возвращает размер данных}
function KBDataSize(
  Id: TAI_Id64              {in}{Идентификатор фрейма}
  ): UInt32;                    {Размер данных}

{Записывает данные}
function KBDataWrite(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  const Buf;                    {in}{Буфер данных для записи}
  Size: UInt32;                 {in}{Размер записываемых данных в байтах}
  Seek: UInt32                  {in}{Точка вставки. -1 - текущее положение}
  ): UInt32;                    {Колличество записаных байтов}

{Возвращает дату/время создания фрейма}
function KBDTCreateGet(
  Id: TAI_Id64              {in}{Идентификатор фрейма}
  ): TDateTime64;               {Дата/время создания фрейма}

{Возвращает дату/время последнего использования (изменения)}
(*function KBDTUseGet(
  Handle: TAIFreimId64          {in}{Идентификатор фрейма}
  ): TDateTime64;

{Устанавливает дату/время последнего использования (изменения)}
function KBDTUseSet(
  Handle: TAIFreimId64;         {in}{Идентификатор фрейма}
  DT: TDateTime64               {in}{Дата/время}
  ): TError;*)

{Возвращает колличество фреймов в БЗ}
function KBFreimCount(): UInt64;

{Освобождает занятый фрейм}
function KBFreimFree(
  Id: TAI_Id64                  {in}{Идентификатор фрейма}
  ): TError;

{Возвращает фрейм как структуру TAIFreimRec64}
function KBFreimRecF64Get(
  Id: TAI_Id64;                 {in}{Идентификатор фрейма}
  var Freim: TAIFreimRec        {out}{Структура}
  ): TError;                    {0-ошибок нет, иначе произошла ошибка}

{Создает новый фрейм}
function KBFreimNew(
  Typ: TAI_Id64             {in}{Тип нового фрейма}
  ): TAI_Id64;              {Идентификатор нового фрейма}

{Сохранить изменения фрейма}
function KBFreimSave(
  Id: TAI_Id64              {in}{Идентификатор фрейма}
  ): TError;                    {0-ошибок нет, иначе произошла ошибка}

{ Возвращяет файл БЗ (KbFileGet) }
function KbGetFile(): TAiKbFile;

{Открывает БЗ}
function KBOpen(
  FileName: String;             {in}{Имя файла записей. Файл Prof.KB v.0.1}
  Path: String;                 {in}{Путь для расположения дополнительных файлов БЗ}
  CasheCount: UInt32 = 1024     {in}{Размер внутреннего кеша для ускорения чтения}
  ): TError;                    {0-ошибок нет, иначе произошла ошибка}

{Создает БЗ}
function KBOpenCreate(
  FileName: String;             {in}{Имя файла записей. Файл Prof.KB v.0.1}
  Path: String;                 {in}{Путь для расположения дополнительных файлов БЗ}
  CasheCount: UInt32 = 1024     {in}{Размер внутреннего кеша для ускорения чтения}
  ): TError;                    {0-ошибок нет, иначе произошла ошибка}

(*function KBSave: TError; {Сохраняет БЗ}*)

{Ищет следующий фрейм с заданым типом}
(*function KBSearchByTyp(
  Typ: TAIFreimId64;            {in}{Тип фрейма}
  HStart: TAIFreimId64          {in}{Начальный идентификатор}
  ): TAIFreimId64;              {Идентификатор найденого фрейма или 0-если не найден}*)

{Возвращает тип фрейма}
function KBTypeGet(
  Id: TAI_Id64              {in}{Идентификатор фрейма}
  ): TAI_Id64;

{Устанавливает тип фрейма}
function KBTypeSet(
  Id: TAI_Id64;             {in}{Идентификатор фрейма}
  Typ: TAI_Id64             {in}{Новый тип}
  ): TError;                    {0-ошибок нет, иначе произошла ошибка}

implementation

{uses
  Prof_AI_Base;}

var
  (*FCount: UInt64;               {Колличество фреймов в БЗ}
  FFile: THandle = 0;           {Идентификатор файла записей}
  FPath: String = '';           {Путь для дополнительных файлов БЗ}
  FFreims: array of record {Cashe - кеш}
    C: THandle;                 {File for Connects - файл связей}
    D: THandle;                 {File for Data - файл данных}
    DPos: UInt32;               {Текущее положение указателя}
    F: TAIFreimRecF64;          {Фрейм как структура}
    {Used: UInt32;              {Сколькими подпрограмма используется фрейм}
    {T: TDateTime;              {Дата/время последнего запроса этого фрейма}
  end;
  FHeader: TFileProfKBHeader;
  ICashe: UInt32;               {Текущее положение для записи в кеш следующего фрейма}
  FUses: UInt32;                {Колличество программ, использующих БЗ}*)
  KB: TAiKbFile;

{}

{function _ConnectIndexGet(
  IndFreim: UInt32;
  Con: TAIFreimId64
  ): UInt32; forward;

function _ConnectRead(
  IndFreim: UInt32;
  IndCon: UInt32
  ): TAIFreimId64; forward;

function _FreimNew(
  Typ: TAIFreimId64
  ): TAIFreimId64; forward;

function _FreimReadCashe(
  Id: TAIFreimId64
  ): Int32; forward;

function _FreimReadFile(
  Id: TAIFreimId64
  ): Int32; forward;

function _FreimWrite(
  Id: TAIFreimId64;
  RecF: TAIFreimRecF64
  ): TError; forward;}

{}

(*function _ConnectCount(IndFreim: UInt32): UInt32;
begin
  Result := FFreims[IndFreim].F.ConnectCount;
end;

function _ConnectIndexGet(IndFreim: UInt32; Con: TAIFreimId64): UInt32;
var
  I: Int32;
begin
  Result := High(UInt32);
  for I := 0 to FFreims[IndFreim].F.ConnectCount - 1 do begin
    if _ConnectRead(IndFreim, I) = Con then begin
      Result := I;
      Exit;
    end;
  end;
end;

function _ConnectRead(IndFreim: UInt32; IndCon: UInt32): TAIFreimId64;
begin
  Result := 0;
  if FFreims[IndFreim].C = 0 then begin
    FFreims[IndFreim].C := IOFileOpen(FPath + 'c' + cUInt64ToStr(FFreims[IndFreim].F.Id) + '.prof', fmOpenReadWrite, False);
    if FFreims[IndFreim].C = 0 then Exit;
  end;
  IOFilePosSet(FFreims[IndFreim].C, (IndCon) * SizeOf(TAIFreimId64));
  IOFileRead(FFreims[IndFreim].C, Result, SizeOf(TAIFreimId64));
end;

procedure _ConnectWrite(IndFreim: UInt32; IndCon: UInt32; Connect: TAIFreimId64);
begin
  if FFreims[IndFreim].C = 0 then begin
    FFreims[IndFreim].C := IOFileOpen(FPath + 'c' + cUInt064ToStr(FFreims[IndFreim].F.Id) + '.prof', fmOpenReadWrite, False);
    if FFreims[IndFreim].C = 0 then IOFileOpenCreate(FPath + 'c' + cUInt064ToStr(FFreims[IndFreim].F.Id) + '.prof');
    if FFreims[IndFreim].C = 0 then Exit;
  end;
  IOFilePosSet(FFreims[IndFreim].C, (IndCon) * SizeOf(TAIFreimId64));
  IOFileWrite(FFreims[IndFreim].C, Connect, SizeOf(TAIFreimId64));
end;

procedure _DataOpen(Ind: UInt32);
begin
  FFreims[Ind].D := IOFileOpen(FPath + 'd' + cUInt064ToStr(FFreims[Ind].F.Id) + '.prof', fmOpenReadWrite);
end;

function _DataRead(Ind: UInt32; var Buf; Size: UInt32; Seek: UInt32 = High(UInt32)): UInt32;
begin
  Result := 0;
  if FFreims[Ind].D = 0 then _DataOpen(Ind);
  if FFreims[Ind].D = 0 then Exit;
  if Seek <> High(UInt32) then begin
    IOFilePosSet(FFreims[Ind].D, Seek);
    FFreims[Ind].DPos := Seek;
  end;
  Result := IOFileRead(FFreims[Ind].D, Buf, Size);
end;

function _FreimNew(Typ: TAIFreimId64): TAIFreimId64;
var
  F: TAIFreimRecF64;
begin
  Result := FCount;
  Inc(FCount);
  FreimRecF64Clear(F);
  F.Id := Result;
  _FreimWrite(F.Id, F);
end;

function _FreimRead(Handle: TAIFreimId64): UInt32;
begin
  Result := _FreimReadCashe(Handle);
  if Int032(Result) >= 0 then begin {FFreims[Result].T := Now;} Exit; end;
  Result := _FreimReadFile(Handle);
end;

function _FreimReadCashe(Id: TAIFreimId64): Int32;
{Поиск в cashe}
var
  I: Int032;
begin
  for I := 0 to High(FFreims) do if FFreims[I].F.Id = Id then begin
    Result := I;
    Exit;
  end;
  Result := -1;
end;

function _FreimReadFile(Id: TAIFreimId64): Int32;
{var
  I: Int032;
  Umin: UInt032;
  Tmax, Tnow: TDateTime;}
begin
  {Поиск в файле}
  if Id >= FCount then begin
    Result := 0;
    Exit;
    {if FCreate = False then begin
      Result := nil;
      Exit;
    end else begin
      memClear(@F, SizeOf(F));
      for I := ioFileSizeGet(FFile) div SizeOf(F) to Handle do begin
        ioFilePosSet(FFile, Handle * SizeOf(F));
        F.Handle := I;
        ioFileWrite(FFile, @F, SizeOf(F));
      end;
    end;

    Inc(FCount);}
  end;
  (*{Поиск места в буфере}
  Umin := 100000;
  Tmax := 0;
  for I := 0 to High(FFreims) do begin
    if FFreims[I].F.Handle = 0 then begin Result := I; Break; end;
    if FFreims[I].Used < Umin then begin Result := I; Umin := FFreims[I].Used; Tmax := Tnow - FFreims[I].T; end else
    if FFreims[I].Used = Umin then if (Tnow - FFreims[I].T) > Tmax then begin Result := I; Tmax := Tnow - FFreims[I].T; end;
  end;*
  Result := ICashe; Inc(ICashe); if ICashe > UInt032(High(FFreims)) then ICashe := 0;
  if FFreims[Result].C > 0 then IOFileClose(FFreims[Result].C);
  if FFreims[Result].D > 0 then IOFileClose(FFreims[Result].D);
  {Сохранение фрейма}
  _FreimWrite(FFreims[Result].F.Id, FFreims[Result].F);
  {Чтение из файла нового фрейма}
  IOFilePosSet(FFile, SizeOf(TFileProfHeader) + SizeOf(TFileProfKBHeader) + Id * SizeOf(TAIFreimRecF64));
  IOFileRead(FFile, FFreims[Result].F, SizeOf(TAIFreimRecF64));
  FFreims[Result].C := 0;
  FFreims[Result].D := 0;
  {FFreims[Result].Used := 0; {!}
  {FFreims[Result].T := Now;}
end;

function _FreimWrite(Id: TAIFreimId64; RecF: TAIFreimRecF64): TError;
begin
  Result := 1;
  IOFilePosSet(FFile, SizeOf(TFileProfHeader) + SizeOf(TFileProfKBHeader) + Id * SizeOf(RecF));
  if IOFileWrite(FFile, RecF, SizeOf(RecF)) = SizeOf(RecF) then Result := 0;
end;

function _Save: TError;
var
  I: Int032;
begin
  for I := 0 to High(FFreims) do if FFreims[I].F.Id > 0 then
    _FreimWrite(FFreims[I].F.Id, FFreims[I].F);
  Result := 0;
end;*)

{}

function KBClose: TError;
begin
  Result := 0;
  {if FFile = 0 then begin Result := 3; Exit; end;
  _Save;
  if FUses > 0 then Dec(FUses);
  if FUses = 0 then begin
    IOFileClose(FFile);
    FFile := 0;
    SetLength(FFreims, 0);
    FCount := 0;
  end;}
  if Assigned(KB) then KB.Free;
  KB := nil;
end;

function KBConnectAdd(Id: TAI_Id64; Connect: TAI_Id64): UInt32;
{var
  Ind: UInt032;}
begin
  (*Result := High(UInt32);
  if (Id >= FCount) then Exit;
  Ind := _FreimRead(Id);
  if Int032(_ConnectIndexGet(Ind, Connect)) >= 0 then Exit;
  {Добавление}
  Inc(FFreims[Ind].F.ConnectCount);
  Result := FFreims[Ind].F.ConnectCount - 1;
  _ConnectWrite(Ind, Result, Connect);*)
  Result := HighUInt32;
  if not(Assigned(KB)) then Exit;
  Result := KB.ConnectAdd(Id, Connect);
end;

function KBConnectCount(Id: TAI_Id64): UInt32;
begin
  {Result := 0; if (Id >= FCount) then Exit;
  Result := FFreims[_FreimRead(Id)].F.ConnectCount;}
  Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.ConnectCount(Id);
end;

function KBConnectDelete(Id: TAI_Id64; Con: TAI_Id64): TError;
{var
  I: UInt032;
  I2: UInt032;}
begin
  (*Result := 0; if (Id >= FCount) then Exit;
  I := _FreimRead(Id);
  I2 := _ConnectIndexGet(Id, Con);
  if I2 = High(UInt32) then Exit;
  {Помещение последней записи на удаляемую}
  Con := _ConnectRead(I, _ConnectCount(I)-1);
  _ConnectWrite(I, I2, Con);
  FFreims[I].F.ConnectCount := FFreims[I].F.ConnectCount - 1;
  _FreimWrite(FFreims[I].F.Id, FFreims[I].F);*)
  Result := 1;
  if not(Assigned(KB)) then Exit;
  Result := KB.ConnectDelete(Id, Con);
end;

function KBConnectDeleteI(Id: TAI_Id64; Index: UInt32): TError;
{var
  I: UInt32;
  Con: TAIFreimId64;}
begin
  (*Result := 0; if (Id >= FCount) then Exit;
  I := _FreimRead(Id);
  {Помещение последней записи на удаляемую}
  Con := _ConnectRead(I, _ConnectCount(I)-1);
  _ConnectWrite(I, Index, Con);
  FFreims[I].F.ConnectCount := FFreims[I].F.ConnectCount - 1;
  _FreimWrite(FFreims[I].F.Id, FFreims[I].F);*)
  Result := 1;
  if not(Assigned(KB)) then Exit;
  Result := KB.ConnectDeleteI(Id, Index);
end;

function KBConnectGet(Id: TAI_Id64; Index: UInt32): TAI_Id64;
{var
  I: UInt032;
  F: TAIFreimRecF64;}
begin
  {Result := 0; if (Id >= FCount) then Exit;
  I := _FreimRead(Id);
  F := FFreims[I].F;
  if (Index >= F.ConnectCount) then Exit;
  Result := _ConnectRead(I, Index);}
  Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.ConnectGet(Id, Index);
end;

function KBConnectIndexGet(Id: TAI_Id64; Connect: TAI_Id64): UInt32;
{var
  Ind: Int032;
  I: UInt032;}
begin
  {Int032(Result) := -1; if (Id >= FCount) then Exit;
  Ind := _FreimRead(Id);
  if FFreims[Ind].F.ConnectCount = 0 then Exit;
  for I := 0 to FFreims[Ind].F.ConnectCount-1 do begin
    if _ConnectRead(Ind, I) = Connect then begin
      Result := UInt032(I);
      Exit;
    end;
  end;}
  Result := HighUInt32;
  if not(Assigned(KB)) then Exit;
  Result := KB.ConnectIndexGet(Id, Connect);
end;

function KBDataClear(Id: TAI_Id64): TError;
{var
  Ind: Int032;}
begin
  {Result := 0; if (Id >= FCount) then Exit;
  Ind := _FreimRead(Id);
  Result := FFreims[Ind].F.DataSize;

  if FFreims[Ind].D > 0 then IOFileClose(FFreims[Ind].D);
  FFreims[Ind].D := 0;
  ioFileDelete(FPath + 'd' + cUInt064ToStr(FFreims[Ind].F.Id) + '.prof');

  FFreims[Ind].F.DataSize := 0;
  FFreims[Ind].DPos := 0;}
  Result := 1;
  if not(Assigned(KB)) then Exit;
  Result := KB.DataClear(Id);
end;

function KBDataRead(Id: TAI_Id64; var Buf; Size: UInt32; Seek: UInt32 {= High(UInt32)}): UInt32;
{var
  Ind: Int032;}
begin
  {Result := 0; if (Id >= FCount) then Exit;
  Ind := _FreimRead(Id);
  Result := _DataRead(Ind, Buf, Size, Seek);}
  {Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.D .DataRead(Id, Buf, Size, Seek)}
end;

function KBDataSize(Id: TAI_Id64): UInt32;
begin
  {Result := 0; if (Id >= FCount) then Exit;
  Result := FFreims[_FreimRead(Id)].F.DataSize;}
  {Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.DataSize(Id);}
end;

function KBDataWrite(Id: TAI_Id64; const Buf; Size: UInt32; Seek: UInt32 {= High(UInt32)}): UInt32;
{var
  Ind: UInt032;}
begin
  (*Result := 0; if (Id >= FCount) then Exit;
  Ind := _FreimRead(Id);
  {if Seek < 0 then Seek := FFreims[Ind].DPos;}

  {Создание файла}
  {FFreims[Ind].D := IOFileOpen(FPath + 'd' + cUInt064ToStr(FFreims[Ind].F.Id) + '.prof', fmCreate);
  ioFileWrite(FFreims[Ind].D, Buf, FFreims[Ind].F.DataSize);}

  {Запись в файл}
  if FFreims[Ind].D = 0 then _DataOpen(Ind);
    {FFreims[Ind].D := IOFileOpen(FPath + 'd' + cUInt064ToStr(FFreims[Ind].F.Id) + '.prof', fmOpenReadWrite);}
  if Seek <> High(UInt32) then IOFilePosSet(FFreims[Ind].D, Seek);
  Result := IOFileWrite(FFreims[Ind].D, Buf, Size);
  if (Seek + Size >= FFreims[Ind].F.DataSize) then FFreims[Ind].F.DataSize := Seek + Size;
  FFreims[Ind].DPos := Seek + Size;*)
  Result := 0;
  if not(Assigned(KB)) then Exit;
  {Result := KB.DataWrite(Id, Buf, Size, Seek);}
end;

function KBDTCreateGet(Id: TAI_Id64): TDateTime64;
{var
  Ind: Uint032;}
begin
  {Result := 0; if (Id >= FCount) then Exit;
  Ind := _FreimRead(Id);
  Result := FFreims[Ind].F.DTCreate;}
  Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.FreimDTCreateGet(Id);
end;

{function KBDTUseGet(Handle: TAIFreimId64): TDateTime64;
var
  Ind: UInt032;
begin
  Result := 0; if (Handle >= FCount) then Exit;
  Ind := _FreimRead(Handle);
  Result := FFreims[Ind].F.DTChange;
end;

function KBDTUseSet(Handle: TAIFreimId64; DT: TDateTime64): TError;
var
  Ind: UInt032;
begin
  Result := 0; if (Handle >= FCount) then Exit;
  Ind := _FreimRead(Handle);
  FFreims[Ind].F.DTChange := DT;
end;}

function KBFreimCount: UInt64;
begin
  {Result := FCount;}
  Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.FreimCount;
end;

function KBFreimFree(Id: TAI_Id64): TError;
{var
  Ind: Int032;}
begin
  {if (Handle >= FCount) then Exit;
  Ind := _FreimReadCashe(Handle);
  if Ind < 0 then Exit;
  if FFreims[Ind].Used > 0 then Dec(FFreims[Ind].Used);}
  Result := 0;
  if not(Assigned(KB)) then Exit;
end;

function KBFreimRecF64Get(Id: TAI_Id64; var Freim: TAIFreimRec): TError;
begin
  {Result := 0;
  FreimRecF64Clear(Freim);
  if (Id >= FCount) then Exit;
  Freim := FFreims[_FreimRead(Id)].F;}
  Result := 1;
  if not(Assigned(KB)) then Exit;
  Result := KB.GetFile.FreimRead(Id, Freim);
end;

function KBFreimNew(Typ: TAI_Id64): TAI_Id64;
begin
  {Result := _FreimNew(Typ);}
  Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.FreimNew(Typ);
end;

function KBFreimSave(Id: TAI_Id64): TError;
begin
  {Result := kbSave;}
  Result := 0;
  if not(Assigned(KB)) then Exit;
end;

function KbGetFile(): TAiKbFile;
begin
  Result := Kb;
end;

function KBOpen(FileName, Path: String; CasheCount: UInt32 = 1024): TError;
{var
  I: Int032;}
begin
  (*Result := 0;
  Inc(FUses);
  if FFile > 0 then Exit;
  FFile := Fil;
  FPath := Path;
  SetLength(FFreims, CasheCount); {1000*4096=4Mb}
  for I := 0 to High(FFreims) do FreimRecF64Clear(FFreims[I].F);
  {FCount := IOFileSizeGet(FFile) div SizeOf(TAIFreimRecF64);}
  {FCount := IOFileProfKBCount(FFile);}
  IOFilePosSet(FFile, SizeOf(TFileProfHeader));
  IOFileRead(FFile, FHeader, SizeOf(FHeader));
  FCount := FHeader.CountF;
  ICashe := 0;*)
  KbClose();
  Kb := TAiKbFile.Create();
  Result := Kb.Open(FileName, Path);
  if (Result <> 0) then
  begin
    Kb.Free();
    Kb := nil;
  end;
end;

function KBOpenCreate(FileName, Path: String; CasheCount: UInt32 = 1024): TError;
{var
  I: Int032;}
begin
  (*Result := 0;
  Inc(FUses);
  if FFile > 0 then Exit;
  FFile := Fil;
  FPath := Path;
  SetLength(FFreims, CasheCount);
  for I := 0 to High(FFreims) do FreimRecF64Clear(FFreims[I].F);
  {FCount := IOFileSizeGet(FFile) div SizeOf(TAIFreimRec);}
  {FCount := IOFileProfKBCount(FFile);}
  IOFilePosSet(FFile, SizeOf(TFileProfHeader));
  IOFileRead(FFile, FHeader, SizeOf(FHeader));
  FCount := FHeader.CountF;
  ICashe := 0;*)
  KbClose();
  Kb := TAiKbFile.Create();
  Result := Kb.OpenCreate(FileName, Path);
  if (Result <> 0) then
  begin
    Kb.Free();
    Kb := nil;
  end;
end;

function KBSave: TError;
begin
  {Result := _Save;}
  Result := 0;
  if not(Assigned(KB)) then Exit;
end;

(*function KBSearchByTyp(Typ: TAIFreimId64; HStart: TAIFreimId64): TAIFreimId64;
{var
  F: TAIFreimRecF64;
  I: UInt032;}
begin
  {Result := 0; if HStart >= FCount then Exit;
  IOFilePosSet(FFile, SizeOf(TFileProfHeader) + SizeOf(TFileProfKBHeader) + HStart * SizeOf(TAIFreimRecF64));
  for I := HStart to FCount-1 do begin
    IOFileRead(FFile, F, SizeOf(TAIFreimRecF64));
    if F.Typ = Typ then begin
      Result := I;
      Exit;
    end;
  end;}
end;*)

function KBTypeGet(Id: TAI_Id64): TAI_Id64;
begin
  {Result := 0; if (Id >= FCount) then Exit;
  Result := FFreims[_FreimRead(Id)].F.Typ;}
  Result := 0;
  if not(Assigned(KB)) then Exit;
  Result := KB.FreimTypeGet(Id);
end;

function KBTypeSet(Id, Typ: TAI_Id64): TError;
{var
  Ind: Int32;}
begin
  {Result := 1; if (Id >= FCount) then Exit;
  Ind := _FreimRead(Id);
  FFreims[Ind].F.Typ := Typ;
  Result := _FreimWrite(Id, FFreims[Ind].F);}
  {_DataClear(HFreim);}
  Result := 1;
  if not(Assigned(KB)) then Exit;
  Result := KB.FreimTypeSet(Id, Typ);
end;

{TFileConnect}

function TFileConnect.CRead(Index: UInt32): TAI_Id;
begin
  Seek(Index * SizeOf(TAI_Id64));
  if GetStream.ReadUInt64(UInt64(Result)) <> 0 then Result := 0;
end;

function TFileConnect.CWrite(Index: UInt32; Value: TAI_Id): TError;
begin
  Seek(Index * SizeOf(TAI_Id64));
  if GetStream.WriteUInt64(UInt64(Value)) <> 0 then
    Result := 1
  else
    Result := 0;
end;

function TFileConnect.Open(Path: String; Id: TAI_Id): Boolean;
begin
  Result := inherited Open(Path + 'c' + cUInt64ToStr(Id) + '.prof', Prof_fmOpenReadWrite);
end;

function TFileConnect.Open2(Path: String; Id: TAI_Id): TError;
begin
  if (inherited Open(Path + 'c' + cUInt64ToStr(Id) + '.prof', Prof_fmOpenReadWrite)) then
    Result := 0
  else
    Result := -1;
end;

{TFileData}

function TFileData.Delete(Path: String; Id: TAI_Id): TError;
begin
  if inherited FileDelete(Path + 'c' + cUInt64ToStr(Id) + '.prof') then
    Result := 0
  else
    Result := 1;
end;

function TFileData.Open(Path: String; Id: TAI_Id): Boolean;
begin
  Result := inherited Open(Path + 'd' + cUInt64ToStr(Id) + '.prof', Prof_fmOpenReadWrite);
end;

function TFileData.Open2(Path: String; Id: TAI_Id): TError;
begin
  if (inherited Open(Path + 'd' + cUInt64ToStr(Id) + '.prof', Prof_fmOpenReadWrite)) then
    Result := 0
  else
    Result := -1;
end;

end.

