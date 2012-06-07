{**
@Abstract(AiPoolUtils)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(07.06.2012)
@Version(0.5)
}
unit AiPoolUtils;

interface

uses
  AiBase, AiFrameObj;

{** Return frame by identifier
    @return(frame object) }
function Pool_GetFrameById(Pool: AiPool; Id: TAId): TAiFrameObject;

implementation

function Pool_GetFrameById(Pool: AiPool; Id: TAId): TAiFrameObject;
begin
  if not(TObject(Pool) is TAiPoolObject) then
  begin
    Result := nil;
    Exit;
  end;

  Result := TAiFrameObject(TAiPoolObject(Pool).Frames.FrameById[Id]);
end;

end.
