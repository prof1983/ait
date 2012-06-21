{**
@Abstract(События для объекта AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.10.2006)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AiEventsObj;

interface

uses
  ABase, AEventObj, ATypes,
  AiFrameObj;

type
  TAIProc = TProcMessage;
  TAiProc2006 = function(Sender, Params, Results: AId): AError of object;

type
  TEventAI = class(TEventShablon)
    // Подписаться на получение события
    function Connect(Proc: TAIProc): WordBool;
    // Отписаться от события
    function Disconnect(Proc: TAIProc): WordBool;
    function Run(const AMsg: WideString): WordBool;
  end;

  {** Событие }
  TAiEvent = class(TAiFrameObject)
  private
    {** Кто подписан на выполнение при возникновении события }
    FItems: array of TAIProc;
    FEvent: TEventAI;
  public
    function GetCount: UInt32;
    function GetItem(Index: UInt32): TAIProc;
    function Run(const AMsg: WideString): WordBool;
    function Sign(Proc: TAIProc): TError;
    function UnSign(Proc: TAIProc): TError;
  end;

  {** Событие }
  TAiEvent2006 = class(TAiEvent)
  private
    {** Кто подписан на выполнение при возникновении события }
    FItems: array of TAiProc2006;
  public
    function GetCount(): UInt32;
    function GetItem(Index: UInt32): TAiProc2006;
    function Run(Sender: AId): AError;
    function Sign(Proc: TAiProc2006): AError;
    function UnSign(Proc: TAiProc2006): AError;
  end;

  {** Событие }
  TAiEvent20050915 = class(TAiEvent2006)
  private
    {** Кто подписан на выполнение при возникновении события }
    FItems: array of TAiProc2006;
  public
    function GetCount(): UInt32;
    function GetItem(Index: UInt32): TAiProc2006;
    function Run(Sender: AId): AError;
    function Sign(Proc: TAiProc2006): AError;
    function UnSign(Proc: TAiProc2006): AError;
  end;

  {** Событие }
  TAiEvent20050830 = class(TAiEvent20050915)
  protected
    {** Кто подписан на выполнение при возникновении события }
    FItems: array of TAiProc2006;
  public
    function GetCount(): UInt32;
    function GetItem(Index: UInt32): TAiProc2006;
    function Run(Sender: AId): AError;
    function Sign(Proc: TAiProc2006): AError;
    function UnSign(Proc: TAiProc2006): AError;
  end;

  TAiEvent20050525 = TAiEvent20050830;

  {** События }
  TAiEvents = class(TAiFrameObject)
  private
    FEvents: array of TAiEvent;
  end;

  TAiEvents20050525 = TAiEvents;
  TAiEvents20050830 = TAiEvents;
  TAiEvents20050915 = TAiEvents;

  {** Исключительные события }
  TAiExceptions = class(TAiFrameObject)
  private
    FExceptions: array of TAiEvent;
  end;

  TAiExceptions20050525 = TAiExceptions;
  TAiExceptions20050830 = TAiExceptions;

implementation

{ TAiEvent }

function TAiEvent.GetCount(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiEvent.GetItem(Index: UInt32): TAIProc;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiEvent.Run(const AMsg: WideString {Sender: TAI_Id}): WordBool;
// Sender - идентивикатор объекта, который вызвал это событие
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
  begin
    FItems[I](AMsg);
  end;
  //Result := 0;
end;

function TAiEvent.Sign(Proc: TAIProc): TError;
{Подписка на событие}
var
  I: Int32;
begin
  //Result := 1;
  if not(Assigned(Proc)) then Exit;
  I := Length(FItems);
  SetLength(FItems, I + 1);
  FItems[I] := Proc;
  //Result := 0;
end;

function TAiEvent.UnSign(Proc: TAIProc): TError;
{Отписка от события}
{var
  I: Int32;}
begin
  //Result := 1;
  {if not(Assigned(Proc)) then Exit;
  for I := 0 to High(FItems) do begin
    if Proc = FItems[I] then begin
      FItems[I] := FItems[High(FItems)];
      SetLength(FItems, High(FItems));
      Result := 0;
    end;
  end;}
end;

{ TAiEvent20050830 }

function TAiEvent20050830.GetCount(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiEvent20050830.GetItem(Index: UInt32): TAiProc2006;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiEvent20050830.Run(Sender: AId): AError;
{Sender - идентивикатор объекта, который вызвал это событие}
var
  I: Int32;
begin
  for I := 0 to High(FItems) do
  begin
    FItems[I](Sender, 0, 0);
  end;
  Result := 0;
end;

function TAiEvent20050830.Sign(Proc: TAiProc2006): AError;
{Подписка на событие}
var
  I: Int32;
begin
  Result := 1;
  if not(Assigned(Proc)) then Exit;
  I := Length(FItems);
  SetLength(FItems, I + 1);
  FItems[I] := Proc;
  Result := 0;
end;

function TAiEvent20050830.UnSign(Proc: TAiProc2006): AError;
{Отписка от события}
{var
  I: Int32;}
begin
  Result := 1;
  {if not(Assigned(Proc)) then Exit;
  for I := 0 to High(FItems) do begin
    if Proc = FItems[I] then begin
      FItems[I] := FItems[High(FItems)];
      SetLength(FItems, High(FItems));
      Result := 0;
    end;
  end;}
end;

{ TAiEvent20050915 }

function TAiEvent20050915.GetCount(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiEvent20050915.GetItem(Index: UInt32): TAiProc2006;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiEvent20050915.Run(Sender: AId): AError;
{Sender - идентивикатор объекта, который вызвал это событие}
var
  I: Int32;
begin
  for I := 0 to High(FItems) do begin
    FItems[I](Sender, 0, 0);
  end;
  Result := 0;
end;

function TAiEvent20050915.Sign(Proc: TAiProc2006): AError;
{Подписка на событие}
var
  I: Int32;
begin
  Result := 1;
  if not(Assigned(Proc)) then Exit;
  I := Length(FItems);
  SetLength(FItems, I + 1);
  FItems[I] := Proc;
  Result := 0;
end;

function TAiEvent20050915.UnSign(Proc: TAiProc2006): AError;
{Отписка от события}
{var
  I: Int32;}
begin
  Result := 1;
  {if not(Assigned(Proc)) then Exit;
  for I := 0 to High(FItems) do begin
    if Proc = FItems[I] then begin
      FItems[I] := FItems[High(FItems)];
      SetLength(FItems, High(FItems));
      Result := 0;
    end;
  end;}
end;

{ TAiEvent2006 }

function TAiEvent2006.GetCount(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiEvent2006.GetItem(Index: UInt32): TAiProc2006;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAiEvent2006.Run(Sender: AId): AError;
{Sender - идентивикатор объекта, который вызвал это событие}
var
  I: Int32;
begin
  for I := 0 to High(FItems) do begin
    FItems[I](Sender, 0, 0);
  end;
  //Result := 0;
end;

function TAiEvent2006.Sign(Proc: TAiProc2006): AError;
{Подписка на событие}
var
  I: Int32;
begin
  //Result := 1;
  if not(Assigned(Proc)) then Exit;
  I := Length(FItems);
  SetLength(FItems, I + 1);
  FItems[I] := Proc;
  //Result := 0;
end;

function TAiEvent2006.UnSign(Proc: TAiProc2006): AError;
{Отписка от события}
{var
  I: Int32;}
begin
  //Result := 1;
  {if not(Assigned(Proc)) then Exit;
  for I := 0 to High(FItems) do begin
    if Proc = FItems[I] then begin
      FItems[I] := FItems[High(FItems)];
      SetLength(FItems, High(FItems));
      Result := 0;
    end;
  end;}
end;

// TEventAI --------------------------------------------------------------------
// -----------------------------------------------------------------------------
function TEventAI.Connect(Proc: TAIProc): WordBool;
begin
  // ...
end;

// -----------------------------------------------------------------------------
function TEventAI.Disconnect(Proc: TAIProc): WordBool;
begin
  // ...
end;

// -----------------------------------------------------------------------------
function TEventAI.Run(const AMsg: WideString): WordBool;
begin
  // ...
end;

end.
