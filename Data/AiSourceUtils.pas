{**
@Abstract AiSource functions
@Author Prof1983 <prof1983@ya.ru>
@Created 21.06.2012
@LastMod 17.12.2012
}
unit AiSourceUtils;

interface

uses
  ABase,
  AiBase, AiFrameObj;

function AiSource_GetFrameById(FSource: AiSourceObject; Id: AId): TAiFrameObject;

implementation

uses
  AiSourceObj;

function AiSource_GetFrameById(FSource: AiSourceObject; Id: AId): TAiFrameObject;
begin
  if (FSource = 0) then
  begin
    Result := nil;
    Exit;
  end;

  if not(TObject(FSource) is TAiSourceObject) then
  begin
    Result := nil;
    Exit;
  end;
  try
    Result := TAiSource2005(FSource).Freims[Id];
  except
    Result := nil;
  end;
end;

end.
