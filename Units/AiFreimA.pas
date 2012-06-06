{**
@Abstract(AiFrame functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.06.2012)
@LastMod(06.06.2012)
@Version(0.0)

Recovered
}
unit AiFreimA;

interface

uses
  ABase;

function AiDomainClose(): AError;

function AiDomainCreate(): AError;

function AiSourceClose(): AError;

function AiSourceCreate(): AError;

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

// --- Source ---

function AiSourceClose(): AError;
begin
  Result := -1;
end;

function AiSourceCreate(): AError;
begin
  Result := -1;
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
