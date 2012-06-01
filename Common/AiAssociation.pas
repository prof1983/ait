{**
@Abstract(Ассоциативная связь)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.09.2006)
@LastMod(04.05.2012)
@Version(0.5)
}
unit AiAssociation;

interface

uses
  AiFrameImpl, AiTypes;

type //** Ассоциация
  TAIAssociation = class(TAiFrame2007)
  private
    FFreim1Id: TAI_ID;      // Идентификатор ассоциируемого фрейма 1
    FFreim2Id: TAI_ID;      // Идентификатор ассоциируемого фрейма 1
    FAssociationType: TAIAssociationType; // Тип ассоциативной связи
    FWeight: Integer;               // Вес связи
    FReliance: Integer;             // Уверенность
  public
    function GetAssociationType(): TAIAssociationType;
    function GetFreim1(): TAiFrame2007;
    function GetFreim1Id(): TAI_Id;
    function GetFreim2(): TAiFrame2007;
    function GetFreim2Id(): TAI_Id;
    function GetReliance(): Integer;
    function GetWeight(): Integer;
  published
    property AssociationType: TAIAssociationType read FAssociationType write FAssociationType;
    property Freim1ID: TAI_ID read FFreim1ID write FFreim1ID;
    property Freim2ID: TAI_ID read FFreim2ID write FFreim2ID;
    // Надежность связи
    property Reliance: Integer read FReliance write FReliance;
    // Вес связи
    property Weight: Integer read FWeight write FWeight;
  end;

implementation

{ TAIAssociation }

function TAIAssociation.GetAssociationType: TAIAssociationType;
begin
  Result := FAssociationType;
end;

function TAIAssociation.GetFreim1: TAiFrame2007;
{var
  Source: TAISource;}
begin
  {Result := nil;
  Source := TAISource(GetSource);
  if not(Assigned(Source)) then Exit;
  Result := TAIFreim(Source.GetFreim(FFreim1Id));}
end;

function TAIAssociation.GetFreim1Id: TAI_ID;
begin
  Result := FFreim1Id;
end;

function TAIAssociation.GetFreim2: TAiFrame2007;
{var
  Source: TAISource;}
begin
  {Result := nil;
  Source := TAISource(GetSource);
  if not(Assigned(Source)) then Exit;
  Result := TAIFreim(Source.GetFreim(FFreim2ID));}
end;

function TAIAssociation.GetFreim2Id: TAI_ID;
begin
  Result := FFreim2Id;
end;

function TAIAssociation.GetReliance: Integer;
begin
  Result := FReliance;
end;

function TAIAssociation.GetWeight: Integer;
begin
  Result := FWeight;
end;

end.
