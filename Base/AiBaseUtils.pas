{**
@Abstract Базовые типы для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 26.04.2005
@LastMod 15.05.2012
}
unit AiBaseUtils;

interface

uses
  AiTypes;

// --- Functions ---

//procedure ArrayByteToFreimRecF64(var Rec: TAIFreimRecF64; const A: TArrayByte);
procedure FreimRecClear(var Rec: TAIFreimRec);
procedure FreimRecF32Clear(var Rec: TAIFreimRecF32);
procedure FreimRecF32ToFreimRec(const F: TAIFreimRecF32; var R: TAIFreimRec);
procedure FreimRecF64Clear(var Rec: TAIFreimRecF64);
//function FreimRecF64ToArrayByte(const F: TAIFreimRecF64): TArrayByte;
procedure FreimRecF64ToFreimRec(const F: TAIFreimRecF64; var R: TAIFreimRec);
procedure FreimRecToFreimRecF32(const F: TAIFreimRec; var R: TAIFreimRecF32);

implementation

// Procedures and Functions ----------------------------------------------------

{procedure ArrayByteToFreimRecF64(var Rec: TAIFreimRecF64; const A: TArrayByte);
var
  A1: TArrayByte;
begin
  A1 := ArrayByteCopy(A, 0, 8);
  Rec.Id := cArrayByteToUInt64(A1);
  A1 := ArrayByteCopy(A, 8, 8);
  Rec.Typ := cArrayByteToUInt64(A1);
  A1 := ArrayByteCopy(A, 16, 8);
  Rec.DTCreate := cArrayByteToFloat64(A1);
  A1 := ArrayByteCopy(A, 24, 8);
  Rec.DataSize := cArrayByteToUInt32(A1);
  A1 := ArrayByteCopy(A, 32, 8);
  Rec.ConnectCount := cArrayByteToUInt32(A1);
end;}

procedure FreimRecClear(var Rec: TAIFreimRec);
begin
  Rec.Id := 0;
  Rec.Typ := 0;
  Rec.DTCreate := 0;
  Rec.DataSize := 0;
  Rec.ConnectCount := 0;
end;

procedure FreimRecF32Clear(var Rec: TAIFreimRecF32);
begin
  Rec.Id := 0;
  Rec.Typ := 0;
  Rec.DTCreate := 0;
  Rec.DataSize := 0;
  Rec.ConnectCount := 0;
end;

procedure FreimRecF32ToFreimRec(const F: TAIFreimRecF32; var R: TAIFreimRec);
begin
  R.Id := F.Id;
  R.Typ := F.Typ;
  R.DTCreate := F.DTCreate;
  R.DataSize := F.DataSize;
  R.ConnectCount := F.ConnectCount;
end;

procedure FreimRecF64Clear(var Rec: TAIFreimRecF64);
begin
  Rec.Id := 0;
  Rec.Typ := 0;
  Rec.DTCreate := 0;
  Rec.DataSize := 0;
  Rec.ConnectCount := 0;
end;

{function FreimRecF64ToArrayByte(const F: TAIFreimRecF64): TArrayByte;
begin
  SetLength(Result, 40);
  ArrayByteInsert(Result, cUInt64ToArrayByte(F.Id), 0);
  ArrayByteInsert(Result, cUInt64ToArrayByte(F.Typ), 8);
  ArrayByteInsert(Result, cFloat64ToArrayByte(F.DTCreate), 16);
  ArrayByteInsert(Result, cUInt32ToArrayByte(F.DataSize), 24);
  ArrayByteInsert(Result, cUInt32ToArrayByte(F.ConnectCount), 32);
end;}

procedure FreimRecF64ToFreimRec(const F: TAIFreimRecF64; var R: TAIFreimRec);
begin
  R.Id := F.Id;
  R.Typ := F.Typ;
  R.DTCreate := F.DTCreate;
  R.DataSize := F.DataSize;
  R.ConnectCount := F.ConnectCount;
end;

procedure FreimRecToFreimRecF32(const F: TAIFreimRec; var R: TAIFreimRecF32);
begin
  R.Id := F.Id;
  R.Typ := F.Typ;
  R.DTCreate := F.DTCreate;
  R.DataSize := F.DataSize;
  R.ConnectCount := F.ConnectCount;
end;

end.
 