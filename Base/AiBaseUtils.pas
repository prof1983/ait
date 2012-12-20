{**
@Abstract Базовые типы для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 26.04.2005
@LastMod 20.12.2012
}
unit AiBaseUtils;

interface

uses
  AiTypes;

// --- Functions ---

procedure FreimRecClear(var Rec: TAIFreimRec);
procedure FreimRecF32Clear(var Rec: TAIFreimRecF32);
procedure FreimRecF32ToFreimRec(const F: TAIFreimRecF32; var R: TAIFreimRec);
procedure FreimRecF64Clear(var Rec: TAIFreimRecF64);
procedure FreimRecF64ToFreimRec(const F: TAIFreimRecF64; var R: TAIFreimRec);
procedure FreimRecToFreimRecF32(const F: TAIFreimRec; var R: TAIFreimRecF32);

implementation

// Procedures and Functions ----------------------------------------------------

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
 