{**
@Abstract(UAI)
@Author(Prof1983 prof1983@yandex.ru)
@Created(<10.01.2004)
@LastMod(18.05.2012)
@Version(0.0.5)
}
unit UAI;

interface

uses
  AiBase0, AiFrameObj, AiSourceObj;

procedure Ai_Close();
procedure Ai_Open();

function AiFreim03BodyGetS(Id: THandle064): string;
function AiFreim03NameGet(Id: THandle064): string;
procedure AiFreim03NameSet(Id: THandle064; const Name: string);
procedure AiFreim50Create();
procedure AiFreim55Run(I: Integer);
function AiListGet(T: TAiFreimType): THandle064;
procedure AiListRefresh(Id: THandle064);
function AiListsGet(): THandle064;

function KbFreimTypGet(Id: THandle064): THandle064;
procedure KbSave();

var
  Source: TAiSource2004;

implementation

procedure Ai_Close();
begin
  Source.Free();
  Source := nil;
end;

procedure Ai_Open();
begin
  Source := TAiSource2004.Create();
end;

function AiFreim03BodyGetS(Id: THandle064): string;
begin
  Result := '';
end;

function AiFreim03NameGet(Id: THandle064): string;
begin
  Result := '';
end;

procedure AiFreim03NameSet(Id: THandle064; const Name: string);
begin
end;

procedure AiFreim50Create();
begin
end;

procedure AiFreim55Run(I: Integer);
begin
end;

function AiListGet(T: TAiFreimType): THandle064;
begin
  Result := -1;
end;

procedure AiListRefresh(Id: THandle064);
begin
end;

function AiListsGet(): THandle064;
begin
  Result := -1;
end;

function KbFreimTypGet(Id: THandle064): THandle064;
begin
  Result := 0;
end;

procedure KbSave();
begin
end;

end.
 