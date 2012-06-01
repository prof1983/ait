{**
@Abstract(Ai Config util functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.05.2012)
@LastMod(16.05.2012)
@Version(0.5)
}
unit AiConfigUtils;

interface

uses
  ABase, AiBase, AConfigObj;

function AiConfig_ReadParamValueByNameAsId(Config: TConfig; const Name: APascalString; var Value: TAId): AError;

implementation

function AiConfig_ReadParamValueByNameAsId(Config: TConfig; const Name: APascalString; var Value: TAId): AError;
var
  Id: UInt64;
begin
  if not(Config.ReadParamValueByNameAsUInt64(Name, Id)) then
  begin
    Result := -1;
    Exit;
  end;
  Value := Id;
  Result := 0
end;

end.
 