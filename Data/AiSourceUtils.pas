{**
@Abstract(AiSource functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.06.2012)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AiSourceUtils;

interface

uses
  ABase,
  AiBase, AiFrameObj;

function AiSource_GetFrameById(FSource: AiSourceObject2005; Id: AId): TAiFrameObject;

implementation

uses
  AiSourceObj;

function AiSource_GetFrameById(FSource: AiSourceObject2005; Id: AId): TAiFrameObject;
begin
  if (FSource = 0) then
  begin
    Result := nil;
    Exit;
  end;

  if (TObject(FSource) is TAiSourceObject2005) then
  begin
    Result := TAiSource2005(FSource).Freims[Id];
  end;
end;

end.
