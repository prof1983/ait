{**
@Abstract(AiPoolUtils)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiPoolUtils;

interface

uses
  AiBase, AiFrameObj, AiFramePoolObj;

{** Return frame by identifier
    @return(frame object) }
function Pool_GetFrameById(Pool: AiPool; Id: TAId): TAiFrameObject;

implementation

function Pool_GetFrameById(Pool: AiPool; Id: TAId): TAiFrameObject;
begin
  if not(TObject(Pool) is TAiFramePoolObject) then
  begin
    Result := nil;
    Exit;
  end;

  Result := TAiFrameObject(TAiFramePoolObject(Pool).Frames.FrameById[Id]);
end;

end.
