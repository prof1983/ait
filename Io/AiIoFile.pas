{**
@Abstract(Io)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.04.2005)
@LastMod(08.06.2012)
@Version(0.5)

0.0.0.6 - 03.04.2005
0.0.0.5 - 17.03.2005 - TFileProf
0.0.0.4 - 31.05.2004 -
0.0.0.3 - 19.05.2004 -
0.0.0.2 - 27.01.2004 - Ident=2 - архив
0.0.0.1 - 09.01.2004 - Сознан тип: TFileProfHeader
}
unit AiIoFile;

interface

uses
  Classes,
  ABaseUtils3, AIoTypes, AStreamObj, ATypes;

type
  UInt032 = UInt32;

type
  TFileProfInfo = record
    Prof: array[0..3] of Char; {='Prof'}
    Ident: UInt032;            {Идентификатор - тип файла}
    Version1: UInt032;         {Версия типа файла}
    Version2: UInt032;         {Версия файла}
    IdentS: String;
    Version1S: String;
    Version2S: String;
  end;

  (*TFileProfHeader = packed record {16}
    Prof: array[0..3] of Char; {='Prof'}
    Ident: UInt032;            {Идентификатор - тип файла}
    Version1: UInt032;         {Версия типа файла}
    Version2: UInt032;         {Версия файла}
  end;*)

  TFileProfHeader = packed record {16}
    Prof: array[0..3] of Byte; {=Char'Prof'}
    Ident: UInt32;             {Идентификатор - тип файла}
    Version1: UInt32;          {Версия типа файла}
    Version2: UInt32;          {Версия файла}
  end;

  {Ident
   1 - база данных
     Version1
     1 - свободная структура
       Version2
       1 - БД для ИИ (AIFreim, AIFreimA) (БЗ)
       2 - Дополнительный файл для БЗ
       3 - БД для ИИ (v3.0)
     2 - БД для ИИ (v4.0)
       Version2
       1 - HProf, HFileAI, Блоки фреймов, Дополнительные блоки. Блоки по 4096 байт.
       2 - HProf, HFileAI, Блоки FAT(1024 блоков), Блоки фреймов, Дополнительные блоки. Блоки по 4096 байт. v. 0.0.2
       3 - то-же, HProf3 v. 0.0.3
       4 - HProf, HFileProfAIRecF, Записи фреймов TAIFreimRecF начиная с 0
   2 - архив
     Version1
     1 -
   'text' - текстовый файл
     Version1
     '_dos' - текстовый файл в колировке DOS 866. Переносы строки $0A$0D
     '_win' - текстовый файл в кодировке Windows 1251. Переносы строки $0A$0D
     'unix' - текстовый файл с переносами строки #0.
  }

  TFileProf = class(TProfFile)
  private
    FHeader: TFileProfHeader;
  public
    function HeaderSet(var Header: TFileProfHeader; Ident, Version1,
      Version2: UInt32): TError;
    function HeaderWrite(const Header: TFileProfHeader): TError;
    function HeaderRead(var Header: TFileProfHeader): TError;
    function Open(FileName: String; Mode: TProfFileOpenMode): Boolean; override;
    function OpenCreate(FileName: String; Header: TFileProfHeader): TError;
  public
    property Header: TFileProfHeader read FHeader;
  end;

procedure ArrayByteToHeader(
  const A: TArrayByte;
  var Header: TFileProfHeader
  );

function IoFileOpen(const FileName: String; Mode: TProfFileOpenMode): THandle;

(*procedure IOFileProfClose( {Закрывает prof-файл}
  HFile: THandle             {in}{Идентификатор файла}
  );

function IOFileProfCreate(
  FileName: String;
  Header: TFileProfHeader
  ): THandle;

procedure IOFileProfInfoGet( {Возвращает инфармацию о prof-файле}
  HFile: THandle;            {in}{Идентификатор файла}
  var Info: TFileProfInfo       {out}{Информация}
  );

function IOFileProfOpen( {Открывает prof-файл и проверяет тип}
  FileName: String;             {in}{Имя файла}
  Ident: UInt032 = 0            {in}{Тип файла}
  ): THandle;                {Идентификатор}*)

procedure HeaderClear(
  var Header: TFileProfHeader
  );

procedure HeaderToArrayByte(
  var A: TArrayByte;
  Header: TFileProfHeader
  );

implementation

procedure ArrayByteToHeader(const A: TArrayByte; var Header: TFileProfHeader);
begin
  Header.Prof[0] := A[0];
  Header.Prof[1] := A[1];
  Header.Prof[2] := A[2];
  Header.Prof[3] := A[3];
  Header.Ident := cArrayByteToUInt32(ArrayByteCopy(A, 4, 4));
  Header.Version1 := cArrayByteToUInt32(ArrayByteCopy(A, 8, 4));
  Header.Version2 := cArrayByteToUInt32(ArrayByteCopy(A, 12, 4));
end;

procedure HeaderClear(var Header: TFileProfHeader);
begin
  Header.Prof[0] := 0;
  Header.Prof[1] := 0;
  Header.Prof[2] := 0;
  Header.Prof[3] := 0;
  Header.Ident := 0;
  Header.Version1 := 0;
  Header.Version2 := 0;
end;

procedure HeaderToArrayByte(var A: TArrayByte; Header: TFileProfHeader);
begin
  SetLength(A, 16);
  A[0] := Header.Prof[0];
end;

(*var
  Files: array of record
    F: THandle;
    H: TFileProfHeader;
  end;

{Procedures and Functions}

function _FreeGet: UInt032;
var
  I: Int032;
begin
  for I := 0 to High(Files) do if Files[I].F = 0 then begin Result := I; Exit; end;
  Result := Length(Files); SetLength(Files, Result+1);
end;

function _IndGet(HFile: THandle): Int032;
var
  I: Int032;
begin
  Result := -1;
  for I := 0 to High(Files) do if Files[I].F = HFile then begin Result := I; Exit; end;
end;

procedure _FileProfClose(I: UInt032);
begin
  ioFileProfClose(Files[I].F);
  Files[I].F := 0;
end;

function _FileProfIdentToStr(Ident: UInt032): String;
begin
  case Ident of
    1: Result := 'База данных';
    2: Result := 'Архив';
  else
    Result := 'Uncnown';
  end;
end;

function _FileProfVersion1ToStr(Ident: UInt032; Version1: UInt032): String;
begin
  Result := '';
end;

function _FileProfVersion2ToStr(Ident: UInt032; Version1, Version2: UInt032): String;
begin
  Result := '';
end;
*)

function IoFileOpen(const FileName: String; Mode: TProfFileOpenMode): THandle;
var
  F: TProfFile;
begin
  F := TProfFile.Create();
  F.Open(FileName, Mode);
  Result := THandle(F);
end;

(*
procedure IOFileProfClose(HFile: THandle);
var
  I: Int032;
begin
  I := _IndGet(HFile);
  if I < 0 then begin
    IOFileClose(HFile);
    Exit;
  end;
  _FileProfClose(I);
end;

function IOFileProfCreate(FileName: String; Header: TFileProfHeader): THandle;
begin
  Result := IOFileCreate(FileName);
  if Result = 0 then Exit;
  if IOFileWrite(Result, Header, SizeOf(Header)) <> SizeOf(Header) then begin
    IOFileClose(Result);
    Result := 0;
    Exit;
  end;
end;

procedure IOFileProfInfoGet(HFile: THandle; var Info: TFileProfInfo);
var
  I: Int032;
begin
  I := _IndGet(HFile);
  if I < 0 then Exit;
  Info.Prof[0] := Files[I].H.Prof[0];
  Info.Prof[1] := Files[I].H.Prof[1];
  Info.Prof[2] := Files[I].H.Prof[2];
  Info.Prof[3] := Files[I].H.Prof[3];
  Info.Ident := Files[I].H.Ident;
  Info.Version1 := Files[I].H.Version1;
  Info.Version2 := Files[I].H.Version2;
  Info.IdentS := _FileProfIdentToStr(Info.Ident);
  Info.Version1S := _FileProfVersion1ToStr(Info.Ident, Info.Version1);
  Info.Version2S := _FileProfVersion2ToStr(Info.Ident, Info.Version1, Info.Version2);
end;

function IOFileProfOpen(FileName: String; Ident: UInt032 = 0): THandle;
var
  I: Int032;
begin
  Result := IOFileOpen(FileName, fmOpenReadWrite, False);
  if Result = 0 then Exit;
  I := _FreeGet;
  Files[I].F := Result;
  ioFileRead(Result, Files[I].H, SizeOf(Files[I].H));
  if (Files[I].H.Prof <> 'Prof') or ((Ident > 0) and (Files[I].H.Ident <> Ident)) then begin
    _FileProfClose(I);
    Result := 0;
  end;
end;*)

{TFileProf}

function TFileProf.HeaderRead(var Header: TFileProfHeader): TError;
var
  B: UInt08;
  Stream: TProfStream;
begin
  Result := 1;
  HeaderClear(Header);
  Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Seek(0);
  Stream.ReadUInt08(B); Header.Prof[0] := B;
  Stream.ReadUInt08(B); Header.Prof[1] := B;
  Stream.ReadUInt08(B); Header.Prof[2] := B;
  Stream.ReadUInt08(B); Header.Prof[3] := B;
  Stream.ReadUInt32(Header.Ident);
  Stream.ReadUInt32(Header.Version1);
  Stream.ReadUInt32(Header.Version2);
  Result := 0;
end;

function TFileProf.HeaderSet(var Header: TFileProfHeader; Ident, Version1,
  Version2: UInt32): TError;
begin
  {Result := 1;}
  HeaderClear(Header);
  Header.Prof[0] := cCharToByte('P');
  Header.Prof[1] := cCharToByte('r');
  Header.Prof[2] := cCharToByte('o');
  Header.Prof[3] := cCharToByte('f');
  {Header.Ident := 1;
  Header.Version1 := 2;
  Header.Version2 := 4;}
  Header.Ident := Ident;
  Header.Version1 := Version1;
  Header.Version2 := Version2;
  Result := 0;
end;

function TFileProf.HeaderWrite(const Header: TFileProfHeader): TError;
{var
  Stream: TFileStream;}
begin
  Result := 1;
  {Stream := GetStream;
  if not(Assigned(Stream)) then Exit;
  Seek(0);
  Stream.Write(Header.Prof, SizeOf(Header.Prof));
  Stream.Write(Header.Ident, SizeOf(Header.Ident));
  Stream.Write(Header.Version1, SizeOf(Header.Version1));
  Stream.Write(Header.Version2, SizeOf(Header.Version2));
  Result := 0;}
end;

function TFileProf.Open(FileName: String; Mode: TProfFileOpenMode): Boolean;
begin
  Result := inherited Open(FileName, Mode);
  if not(Result) then Exit;
  if HeaderRead(FHeader) <> 0 then
  begin
    Close();
    Result := False;
    Exit;
  end;
  if (FHeader.Prof[0] <> cCharToByte('P')) or
    (FHeader.Prof[1] <> cCharToByte('r')) or
    (FHeader.Prof[2] <> cCharToByte('o')) or
    (FHeader.Prof[3] <> cCharToByte('f')) then
  begin
    Close();
    Result := False;
    Exit;
  end;
  Result := True;
end;

function TFileProf.OpenCreate(FileName: String; Header: TFileProfHeader): TError;
begin
  FHeader := Header;
  Result := inherited OpenCreate(FileName);
  if Result <> 0 then Exit;
  if HeaderWrite(FHeader) <> 0 then
  begin
    Result := 1;
    Close;
    Exit;
  end;
end;

end.

