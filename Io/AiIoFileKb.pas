{**
@Abstract БЗ фреймов
@Author Prof1983 <prof1983@ya.ru>
@Created 17.03.2005
@LastMod 20.12.2012
}
unit AiIoFileKb;

interface

uses
  Classes,
  SysUtils,
  ABase,
  ABaseUtils2,
  AIoTypes,
  ATypes,
  AiBaseUtils, AiIoFile, AiTypes;

type
  TFileProfKbHeader3 = packed record {32} {Заголовок файла БД фреймов}
    CountF: UInt64;             {Колличество записей фреймов в файле}
    Date: TDateTime64;          {Дата и время последнего использования (закрытия)}
    //Version1: UInt32;           {=0}
    //Version2: UInt32;           {=1}
    Reserved1: UInt32;          {=0}
    Reserved2: UInt32;          {=0}
    {CountTableB: UInt032;       {Колличество блоков распределения свободного места}
    {CountB: UInt032;            {Колличество блоков всего = CountF + CountTableB + Колличество дополнительных блоков}
    {HBase: TAIFreimId;          {Идентификатор базового фрейма}
  end;

type
  TFileProfKbHeader4 = packed record {32} {Заголовок файла БД фреймов}
    CountF: UInt64;             {Колличество записей фреймов в файле}
    Date: TDateTime64;          {Дата и время последнего использования (закрытия)}
    Version1: UInt32;           {=0}
    Version2: UInt32;           {=1}
    Reserved1: UInt32;          {=0}
    Reserved2: UInt32;          {=0}
    {CountTableB: UInt032;       {Колличество блоков распределения свободного места}
    {CountB: UInt032;            {Колличество блоков всего = CountF + CountTableB + Колличество дополнительных блоков}
    {HBase: TAIFreimId;          {Идентификатор базового фрейма}
  end;

type
  TFileProfKbHeader = TFileProfKbHeader4;

type
  TFileProfKB = class(TFileProf)
  private
    FHeaderKB: TFileProfKBHeader;
    FHeaderKb3: TFileProfKbHeader3;
    FPath: String;
    function HeaderKBRead(var Header: TFileProfKBHeader): AError;
    function HeaderKbRead3(var Header: TFileProfKbHeader3): AError;
    function HeaderKBWrite(const Header: TFileProfKBHeader): AError;
  public
    constructor Create;
    function FreimNew(Typ: TAId): TAId;
    function FreimRead(Id: TAId; var Rec: TAiFreimRec): AError;
    function FreimRead64(Id: TAId; var Rec: TAiFreimRecF64): AError;
    function FreimWrite(Id: TAId; const RecF: TAiFreimRec): Boolean;
    function FreimWrite64(Id: TAId; const RecF: TAiFreimRecF64): Boolean;
    function FreimWrite64_2(Id: TAId; const Value: TAiFreimRecF64): AError;
    function FreimWriteNext(const Rec: TAiFreimRecF64): AError;
    function GetHeaderKB: TFileProfKBHeader;
    function GetPath: String;
    function HeaderSet(var Header: TFileProfHeader): AError;
    function Open(FileName: String; Path: String = ''): Boolean;
    function Open2(const FileName, Path: APascalString): AError;
    function OpenCreate(FileName: String; Path: String = ''): AError;
  end;

procedure ArrayByteToHeaderKB(
  const A: TArrayByte;
  var Header: TFileProfKBHeader
  );

(*
function IOFileProfKBCreate(
  FileName: String
  ): THandle;*)

procedure HeaderKBClear(
  var Header: TFileProfKBHeader
  );

procedure HeaderKbClear3(var Header: TFileProfKbHeader3);

implementation

{Procedures and Functions}

function cUInt64ToArrayByte(Value: UInt64): TArrayByte;
begin
  SetLength(Result, 8);
end;

function ArrayByteInsert(var A: TArrayByte; const Source: TArrayByte; Offset: UInt32): UInt32;
var
  I: Int32;
  L: Int32;
begin
  Result := 0;
  L := MinInt32(Length(A) - Offset, Length(Source));
  if L <= 0 then Exit;
  Result := L;
  for I := 0 to L do
    A[I+Offset] := Source[I];
end;

procedure ArrayByteToHeaderKB(const A: TArrayByte; var Header: TFileProfKBHeader);
begin
  Header.CountF := 0;
  Header.Date := 0;
  Header.Version1 := 0;
  Header.Version2 := 0;
  Header.Reserved1 := 0;
  Header.Reserved2 := 0;
end;

function DateTimeNow: TDateTime;
begin
  Result := SysUtils.Now();
end;

function Float64ToDateTime64(Value: AFloat64): TDateTime;
begin
  Result := Value;
end;

(*
function IOFileProfKBCreate(FileName: String): THandle;
var
  Header: TFileProfKBHeader;
  HProf: TFileProfHeader;
  Freim: TAIFreimRecF64;
  I: Int32;
const
  CountFBase = 1024; {Колличество зарезервированых и базовых фреймов}
begin
  HProf.Prof := 'Prof';
  HProf.Ident := 1;
  HProf.Version1 := 2;
  HProf.Version2 := 4;
  Result := IOFileProfCreate(FileName, HProf);
  if Result = 0 then Exit;
  Header.CountF := CountFBase;
  Header.Date := DateTimeNow;
  if IOFileWrite(Result, Header, SizeOf(Header)) <> SizeOf(Header) then begin
    IOFileProfClose(Result);
    Result := 0;
    Exit;
  end;
  Freim.Typ := 0;
  Freim.DTCreate := DateTimeNow;
  Freim.DataSize := 0;
  Freim.ConnectCount := 0;
  for I := 0 to CountFBase - 1 do begin
    Freim.Id := I;
    IOFileWrite(Result, Freim, SizeOf(Freim));
  end;
end;
*)

procedure HeaderKBClear(var Header: TFileProfKBHeader);
begin
  Header.CountF := 0;
  Header.Date := 0;
  Header.Version1 := 0;
  Header.Version2 := 0;
  Header.Reserved1 := 0;
  Header.Reserved2 := 0;
end;

procedure HeaderKbClear3(var Header: TFileProfKbHeader3);
begin
  Header.CountF := 0;
  Header.Date := 0;
  //Header.Version1 := 0;
  //Header.Version2 := 0;
  Header.Reserved1 := 0;
  Header.Reserved2 := 0;
end;

procedure HeaderToArrayByte(var A: TArrayByte; Header: TFileProfKBHeader);
var
  A1: TArrayByte;
begin
  SetLength(A, 32);
  A1 := cUInt64ToArrayByte(Header.CountF);
  ArrayByteInsert(A, A1, 0);
  A1 := cFloat64ToArrayByte(Header.Date);
  ArrayByteInsert(A, A1, 8);
  A1 := cUInt32ToArrayByte(Header.Version1);
  ArrayByteInsert(A, A1, 12);
  A1 := cUInt32ToArrayByte(Header.Version2);
  ArrayByteInsert(A, A1, 16);
  A1 := cUInt32ToArrayByte(Header.Reserved1);
  ArrayByteInsert(A, A1, 20);
  A1 := cUInt32ToArrayByte(Header.Reserved2);
  ArrayByteInsert(A, A1, 24);
end;

{TFileProfKB}

constructor TFileProfKB.Create;
begin
  inherited Create;
  FHeaderKB.CountF := 0;
  FHeaderKB.Date := 0;
  FHeaderKB.Version1 := 0;
  FHeaderKB.Version2 := 0;
  FHeaderKB.Reserved1 := 0;
  FHeaderKB.Reserved2 := 0;
end;

function TFileProfKB.FreimNew(Typ: TAId): TAId;
var
  RecF: TAIFreimRecF64;
begin
  Result := 0;
  RecF.Id := FHeaderKB.CountF;
  RecF.Typ := Typ;
  RecF.DTCreate := DateTimeNow;
  RecF.DataSize := 0;
  RecF.ConnectCount := 0;
  if FreimWrite64(RecF.Id, RecF) then
  begin
    Result := RecF.Id;
    Inc(FHeaderKB.CountF);
    HeaderKBWrite(FHeaderKB);
  end;
end;

function TFileProfKB.FreimRead(Id: TAId; var Rec: TAiFreimRec): AError;
var
  {A: TArrayByte;}
  {Stream: TFileStream;}
  I64: UInt64;
  Fl: AFloat64;
begin
  {Result := 1;}

  {Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Seek(SizeOf(TFileProfHeader) + SizeOf(TFileProfKBHeader) + Id * SizeOf(TAIFreimRecF64));
  Stream.Read(RecF.Id, SizeOf(RecF.Id));
  Stream.Read(RecF.Typ, SizeOf(RecF.Typ));
  Stream.Read(RecF.DTCreate, SizeOf(RecF.DTCreate));
  Stream.Read(RecF.DataSize, SizeOf(RecF.DataSize));
  Stream.Read(RecF.ConnectCount, SizeOf(RecF.ConnectCount));}

  ReadUInt64(I64); Rec.Id := I64;
  ReadUInt64(I64); Rec.Typ := I64;
  ReadFloat64(Fl); Rec.DTCreate := Float64ToDateTime64(Fl);
  ReadUInt64(Rec.DataSize);
  ReadUInt64(Rec.ConnectCount);

  Result := 0;
end;

function TFileProfKB.FreimRead64(Id: TAId; var Rec: TAiFreimRecF64): AError;
var
  {A: TArrayByte;}
  {Stream: TFileStream;}
  I64: UInt64;
  Fl: AFloat64;
begin
  {Result := 1;}

  {Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Seek(SizeOf(TFileProfHeader) + SizeOf(TFileProfKBHeader) + Id * SizeOf(TAIFreimRecF64));
  Stream.Read(RecF.Id, SizeOf(RecF.Id));
  Stream.Read(RecF.Typ, SizeOf(RecF.Typ));
  Stream.Read(RecF.DTCreate, SizeOf(RecF.DTCreate));
  Stream.Read(RecF.DataSize, SizeOf(RecF.DataSize));
  Stream.Read(RecF.ConnectCount, SizeOf(RecF.ConnectCount));}

  ReadUInt64(I64); Rec.Id := I64;
  ReadUInt64(I64); Rec.Typ := I64;
  ReadFloat64(Fl); Rec.DTCreate := Float64ToDateTime64(Fl);
  ReadUInt64(Rec.DataSize);
  ReadUInt64(Rec.ConnectCount);

  Result := 0;
end;

function TFileProfKB.FreimWrite(Id: TAId; const RecF: TAiFreimRec): Boolean;
var
  A: TArrayByte;
  Stream: TFileStream;
begin
  Result := False;
  {Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Seek(SizeOf(TFileProfHeader) + SizeOf(TFileProfKBHeader) + Id * SizeOf(TAIFreimRecF64));
  Result := FreimWriteNext(RecF);}
end;

function TFileProfKB.FreimWrite64(Id: TAId; const RecF: TAiFreimRecF64): Boolean;
var
  A: TArrayByte;
  Stream: TFileStream;
begin
  Result := False;
  {Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Seek(SizeOf(TFileProfHeader) + SizeOf(TFileProfKBHeader) + Id * SizeOf(TAIFreimRecF64));
  Result := FreimWriteNext(RecF);}
end;

function TFileProfKB.FreimWrite64_2(Id: TAId; const Value: TAiFreimRecF64): AError;
begin
  if FreimWrite64(Id, Value) then
    Result := 0
  else
    Result := -1;
end;

function TFileProfKB.FreimWriteNext(const Rec: TAIFreimRecF64): AError;
var
  Stream: TFileStream;
begin
  Result := 1;
  {Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Stream.Write(Rec.Id, SizeOf(Rec.Id));
  Stream.Write(Rec.Typ, SizeOf(Rec.Typ));
  Stream.Write(Rec.DTCreate, SizeOf(Rec.DTCreate));
  Stream.Write(Rec.DataSize, SizeOf(Rec.DataSize));
  Stream.Write(Rec.ConnectCount, SizeOf(Rec.ConnectCount));
  Result := 0;}
end;

function TFileProfKB.GetHeaderKB: TFileProfKBHeader;
begin
  Result := FHeaderKB;
end;

function TFileProfKB.GetPath: String;
begin
  Result := FPath;
end;

function TFileProfKB.HeaderKBRead(var Header: TFileProfKBHeader): AError;
begin
  HeaderKBClear(Header);
  Self.Seek(SizeOf(TFileProfHeader));
  Self.ReadUInt64(Header.CountF);
  Self.ReadFloat64(Header.Date);
  Self.ReadUInt32(Header.Version1);
  Self.ReadUInt32(Header.Version2);
  Self.ReadUInt32(Header.Reserved1);
  Self.ReadUInt32(Header.Reserved2);
  Result := 0;
end;

function TFileProfKB.HeaderKbRead3(var Header: TFileProfKbHeader3): AError;
begin
  HeaderKbClear3(Header);
  Self.Seek(SizeOf(TFileProfHeader));
  Self.ReadUInt64(Header.CountF);
  Self.ReadFloat64(Header.Date);
  //Self.ReadUInt32(Header.Version1);
  //Self.ReadUInt32(Header.Version2);
  Self.ReadUInt32(Header.Reserved1);
  Self.ReadUInt32(Header.Reserved2);
  Result := 0;
end;

function TFileProfKB.HeaderKBWrite(const Header: TFileProfKBHeader): AError;
var
  Stream: TFileStream;
begin
  Result := 1;
  {Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Seek(SizeOf(TFileProfHeader));
  Stream.Write(Header.CountF, SizeOf(Header.CountF));
  Stream.Write(Header.Date, SizeOf(Header.Date));
  Stream.Write(Header.Version1, SizeOf(Header.Version1));
  Stream.Write(Header.Version2, SizeOf(Header.Version2));
  Stream.Write(Header.Reserved1, SizeOf(Header.Reserved1));
  Stream.Write(Header.Reserved2, SizeOf(Header.Reserved2));
  Result := 0;}
end;

function TFileProfKB.HeaderSet(var Header: TFileProfHeader): AError;
begin
  Result := inherited HeaderSet(Header, 1, 2, 4);
end;

function TFileProfKB.Open(FileName: String; Path: String = ''): Boolean;
begin
  Result := inherited Open(FileName, Prof_fmOpenReadWrite);
  if not(Result) then Exit;
  Result := False;
  if (Header.Ident <> 1) or (Header.Version1 <> 2) then
  begin
    Close;
    Exit;
  end;
  if (Header.Version2 <> 3) and (Header.Version2 <> 4) then
  begin
    Close();
    Exit;
  end;

  if (Header.Version2 = 3) then
  begin
    if (HeaderKbRead3(FHeaderKb3) <> 0) then
    begin
      Close();
      Exit;
    end;
  end
  else
  begin
    if (HeaderKbRead(FHeaderKb) <> 0) then
    begin
      Close();
      Exit;
    end;
    if (FHeaderKb.Version1 <> 0) and (FHeaderKb.Version2 <> 1) then Exit;
  end;
  FPath := Path;
  Result := True;
end;

function TFileProfKB.Open2(const FileName, Path: APascalString): AError;
begin
  if Open(FileName, Path) then
    Result := 0
  else
    Result := -1;
end;

function TFileProfKB.OpenCreate(FileName: String; Path: String = ''): AError;
var
  I: Int32;
  Header: TFileProfHeader;
  Rec: TAIFreimRecF64;
begin
  FPath := Path;
  {FHeaderKB := HeaderKB;}
  FHeaderKB.CountF := 1024;
  FHeaderKB.Date := DateTimeNow;
  FHeaderKB.Version1 := 0;
  FHeaderKB.Version2 := 1;
  FHeaderKB.Reserved1 := 0;
  FHeaderKB.Reserved2 := 0;
  HeaderSet(Header);
  {Создание файла Prof}
  Result := inherited OpenCreate(FileName, Header);
  if Result <> 0 then Exit;
  {Запись заголовка KB}
  if HeaderKBWrite(FHeaderKB) <> 0 then begin
    Result := 1;
    Close;
    Exit;
  end;
  {Заполнение фреймами}
  FreimRecF64Clear(Rec);
  for I := 0 to FHeaderKB.CountF do begin
    Rec.Id := I;
    FreimWriteNext(Rec);
  end;
  {Rec.Id := 0; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 1; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 2; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 3; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 4; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 5; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 6; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 7; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 8; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 9; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 10; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 11; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 12; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 13; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 14; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 15; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 16; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 17; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 18; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 19; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 20; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 21; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 22; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 23; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 24; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 25; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 26; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 27; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 28; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 29; Rec.Typ := 0; FreimWriteNext(Rec);
  Rec.Id := 30; Rec.Typ := 0; FreimWriteNext(Rec);}
end;

end.
