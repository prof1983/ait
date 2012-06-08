{**
@Abstract(AiFrame functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.06.2012)
@LastMod(08.06.2012)
@Version(0.0)

Recovered
}
unit AiFreimA;

interface

uses
  ABase, AiBase0;

function AiDomainClose(): AError;

function AiDomainCreate(): AError;

procedure AiResultAddFromFreim(HFreim: TAId);

procedure AiResultClose();

procedure AiResultCreate();

function AiSourceClose(): AError;

function AiSourceCreate(): AError;

procedure AiSourceAssociationFreimsCreate(HKey, HFreim: TAId; I: AInt);

procedure AiSourceFreimAssociationOpen(H: TAId; var Associat: AiBase0.TAiAssociationA);

procedure AiSourceFreimKeyOpen(HKey: TAId{THandle064}; S: PChar);

procedure AiSourceFreimStrOpen(HFreim: TAId{THandle064}; S: PChar);

procedure AiSourceFreimsCount(out I: UInt032);

procedure AiSourceFreimSearch(var HFreim: TAId; S: PChar; I: AInt);

function AiSourceFreim_LineOpen(P: Pointer; HBase: AInt; lX, lY, oX, oY: AInt): AError;

function AiSourceFreim_PointOpen(P: Pointer; HBase: AInt; oX, oY: AInt): AError;

function AiSourceFreim_StrOpen(var HBase: AInt{THandle064}; S: PChar): AError;

function AiSourceLoad2(const FileName: APascalString): AError;

function AiSourceSave2(const FileName: APascalString): AError;

implementation

// --- Domain ---

function AiDomainClose(): AError;
begin
  Result := -1;
end;

function AiDomainCreate(): AError;
begin
  Result := -1;
end;

// --- Result ---

procedure AiResultAddFromFreim(HFreim: TAId);
begin
end;

procedure AiResultClose();
begin
end;

procedure AiResultCreate();
begin
end;

// --- Source ---

function AiSourceClose(): AError;
begin
  Result := -1;
end;

function AiSourceCreate(): AError;
begin
  Result := -1;
end;

procedure AiSourceAssociationFreimsCreate(HKey, HFreim: TAId; I: AInt);
begin
end;

procedure AiSourceFreimAssociationOpen(H: TAId; var Associat: AiBase0.TAiAssociationA);
begin
end;

procedure AiSourceFreimKeyOpen(HKey: TAId; S: PChar);
begin
end;

procedure AiSourceFreimStrOpen(HFreim: TAId; S: PChar);
begin
end;

procedure AiSourceFreimsCount(out I: UInt032);
begin
  I := 0;
end;

procedure AiSourceFreimSearch(var HFreim: TAId; S: PChar; I: AInt);
begin
end;

function AiSourceFreim_LineOpen(P: Pointer; HBase: AInt{THandle064}; lX, lY, oX, oY: AInt{UInt032}): AError;
begin
  Result := -1;
end;

function AiSourceFreim_PointOpen(P: Pointer; HBase: AInt{THandle064}; oX, oY: AInt{UInt032}): AError;
begin
  Result := -1;
end;

function AiSourceFreim_StrOpen(var HBase: AInt{THandle064}; S: PChar): AError;
begin
  Result := -1;
end;

function AiSourceLoad2(const FileName: APascalString): AError;
begin
  Result := -1;
end;

function AiSourceSave2(const FileName: APascalString): AError;
begin
  Result := -1;
end;

end.
