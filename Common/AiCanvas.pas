{**
@Abstract(AiCanvas)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2012)
@LastMod(03.05.2012)
@Version(0.5)
}
unit AiCanvas;

interface

uses
  ABase,
  AiFrameImpl;

type
  UInt32 = AUInt32;

type //** Канва для TAIScene и TAIModel
  TAiCanvas = class(TAiFreim)
  private
    FHeight: UInt32;
    FWidth: UInt32;
  public
    function GetHeight: UInt32;
    function GetWidth: UInt32;
    function SetHeight(Value: UInt32): AError;
    function SetWidth(Value: UInt32): AError;
  end;

implementation

{ TAiCanvas }

function TAiCanvas.GetHeight: UInt32;
begin
  Result := FHeight;
end;

function TAiCanvas.GetWidth: UInt32;
begin
  Result := FWidth;
end;

function TAiCanvas.SetHeight(Value: UInt32): AError;
begin
  FHeight := Value;
  Result := 0;
end;

function TAiCanvas.SetWidth(Value: UInt32): AError;
begin
  FWidth := Value;
  Result := 0;
end;

end.
