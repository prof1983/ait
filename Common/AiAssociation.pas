﻿{**
@Abstract Ассоциативная связь
@Author Prof1983 <prof1983@ya.ru>
@Created 23.09.2006
@LastMod 20.12.2012
}
unit AiAssociation;

interface

uses
  ABase,
  AiFrameImpl, AiTypes;

type //** Ассоциация
  TAIAssociation = class(TAiFrame)
  private
    {** Идентификатор ассоциируемого фрейма 1 }
    FFreim1Id: AId;
    {** Идентификатор ассоциируемого фрейма 1 }
    FFreim2Id: AId;
    FAssociationType: TAIAssociationType; // Тип ассоциативной связи
    FWeight: Integer;               // Вес связи
    FReliance: Integer;             // Уверенность
  public
    function GetAssociationType(): TAIAssociationType;
    function GetFreim1(): TAiFrame;
    function GetFreim1Id(): AId;
    function GetFreim2(): TAiFrame;
    function GetFreim2Id(): AId;
    function GetReliance(): Integer;
    function GetWeight(): Integer;
  public
    property AssociationType: TAIAssociationType read FAssociationType write FAssociationType;
    property Freim1Id: AId read FFreim1Id write FFreim1Id;
    property Freim2Id: AId read FFreim2Id write FFreim2Id;
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

function TAIAssociation.GetFreim1(): TAiFrame;
{var
  Source: TAISource;}
begin
  {Result := nil;
  Source := TAISource(GetSource);
  if not(Assigned(Source)) then Exit;
  Result := TAIFreim(Source.GetFreim(FFreim1Id));}
  Result := nil;
end;

function TAIAssociation.GetFreim1Id(): AId;
begin
  Result := FFreim1Id;
end;

function TAIAssociation.GetFreim2(): TAiFrame;
{var
  Source: TAISource;}
begin
  {Result := nil;
  Source := TAISource(GetSource);
  if not(Assigned(Source)) then Exit;
  Result := TAIFreim(Source.GetFreim(FFreim2ID));}
  Result := nil;
end;

function TAIAssociation.GetFreim2Id(): AId;
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
