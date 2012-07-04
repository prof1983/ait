{**
@Abstract(AiAnalyser)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.09.2006)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AiAnalyser;

interface

uses
  AiBase, AiDecisions, AiFrameObj, AiSourceObj;

type
  Int32 = Integer;
  UInt32 = Integer;

type
  TAIAnalysis = class(TAiFrameObject)
  end;

type // Данные для анализа
  TAIAnalysisData = class(TAiFrameObject)
  end;

type // Анализатор
  TAIAnalyzer = class(TAIAnalysis)
  private
      // Данные для анализа
    FData: array of TAIAnalysisData;
      // Задание анализа
    FDecisions: TAiDecisions2006;
  public
    constructor Create(Source: AiSource2005; Id: TAId);
    procedure Free;
    function GetData(Index: UInt32): TAIAnalysisData;
    function NewData: TAIAnalysisData;
    procedure Run;
  end;

  // Анализатор
  {TAIAnalyzer = class (TAIAnalysis)
  private
    FData: array of TAIAnalysisData; // Данные для анализа
    FDecisions: TAIDecisions;        // Задание анализа
  public
    constructor Create(Source: TAISource; Id: TAI_Id);
    procedure Free; override;
    function GetData(Index: UInt32): TAIAnalysisData;
    function NewData: TAIAnalysisData;
    procedure Run;
  end;}

  { Анализатор для модели машинки }
  TAIAnalyzerMobile = class(TAIAnalyzer)
  private
    FDeX1: TAiDecision2006;
    FDeX2: TAiDecision2006;
    FDeY1: TAiDecision2006;
    FDeY2: TAiDecision2006;
    FDResX: TAIAnalysisData;
    FDResY: TAIAnalysisData;
    FDSpeedX: TAIAnalysisData;
    FDSpeedY: TAIAnalysisData;
    FDX1: TAIAnalysisData;
    FDX2: TAIAnalysisData;
    FDY1: TAIAnalysisData;
    FDY2: TAIAnalysisData;
  public
    constructor Create(Source: AiSource2005);
  public
    property DResX: TAIAnalysisData read FDResX;
    property DResY: TAIAnalysisData read FDResY;
    property DSpeedX: TAIAnalysisData read FDSpeedX;
    property DSpeedY: TAIAnalysisData read FDSpeedY;
    property DX1: TAIAnalysisData read FDX1;
    property DX2: TAIAnalysisData read FDX2;
    property DY1: TAIAnalysisData read FDY1;
    property DY2: TAIAnalysisData read FDY2;
  end;

  // Анализатор для модели мошинки Prof_AI_Modele_Mobile
  {TAIAnalyzerMobile = class(TAIAnalyzer)
  private
    FDeX1: TAIDecision;
    FDeX2: TAIDecision;
    FDeY1: TAIDecision;
    FDeY2: TAIDecision;
    FDResX: TAIAnalysisData;
    FDResY: TAIAnalysisData;
    FDSpeedX: TAIAnalysisData;
    FDSpeedY: TAIAnalysisData;
    FDX1: TAIAnalysisData;
    FDX2: TAIAnalysisData;
    FDY1: TAIAnalysisData;
    FDY2: TAIAnalysisData;
  public
    constructor Create(KB: TAISource);
    property DResX: TAIAnalysisData read FDResX;
    property DResY: TAIAnalysisData read FDResY;
    property DSpeedX: TAIAnalysisData read FDSpeedX;
    property DSpeedY: TAIAnalysisData read FDSpeedY;
    property DX1: TAIAnalysisData read FDX1;
    property DX2: TAIAnalysisData read FDX2;
    property DY1: TAIAnalysisData read FDY1;
    property DY2: TAIAnalysisData read FDY2;
    procedure Free; override;
  end;}

  {Анализатор}
  (*TAIAnalyzer = class(TAIAnalysis)
  private
    FData: array of TAIAnalysisData; {Данные для анализа}
    FDecisions: TAIDecisions;        {Задание анализа}
  public
    constructor Create(Source: TAI_Source; Id: TAI_Id);
    procedure Free; override;
    function GetData(Index: UInt32): TAIAnalysisData;
    function NewData: TAIAnalysisData;
    procedure Run;
  end;*)

  {Анализатор для модели мошинки Prof_AI_Modele_Mobile}
  {TAIAnalyzerMobile = class(TAIAnalyzer)
  private
    FDeX1: TAIDecision;
    FDeX2: TAIDecision;
    FDeY1: TAIDecision;
    FDeY2: TAIDecision;
    FDResX: TAIAnalysisData;
    FDResY: TAIAnalysisData;
    FDSpeedX: TAIAnalysisData;
    FDSpeedY: TAIAnalysisData;
    FDX1: TAIAnalysisData;
    FDX2: TAIAnalysisData;
    FDY1: TAIAnalysisData;
    FDY2: TAIAnalysisData;
  public
    constructor Create(KB: TAI_Source);
    property DResX: TAIAnalysisData read FDResX;
    property DResY: TAIAnalysisData read FDResY;
    property DSpeedX: TAIAnalysisData read FDSpeedX;
    property DSpeedY: TAIAnalysisData read FDSpeedY;
    property DX1: TAIAnalysisData read FDX1;
    property DX2: TAIAnalysisData read FDX2;
    property DY1: TAIAnalysisData read FDY1;
    property DY2: TAIAnalysisData read FDY2;
    procedure Free; override;
  end;}

implementation

{ TAIAnalyzer }

constructor TAIAnalyzer.Create(Source: AiSource2005; Id: TAId);
begin
  inherited Create();
  Self.FSource := Source;
  Self.FId := Id;
  FDecisions := TAiDecisions2006.Create(Source);
end;

procedure TAIAnalyzer.Free;
var
  I: Int32;
begin
  for I := 0 to High(FData) do FData[I].Free;
  FDecisions.Free;
  inherited Free;
end;

function TAIAnalyzer.GetData(Index: UInt32): TAIAnalysisData;
begin
  if Index >= UInt32(Length(FData)) then
    Result := nil
  else
    Result := FData[Index];
end;

function TAIAnalyzer.NewData: TAIAnalysisData;
var
  I: Int32;
begin
  I := Length(FData); SetLength(FData, I+1);
  FData[I] := TAIAnalysisData.Create(); //(GetSource, 0);
  Result := FData[I];
end;

procedure TAIAnalyzer.Run;
begin
end;

{ TAIAnalyzer }

{
constructor TAIAnalyzer.Create(Source: TAI_Source; Id: TAI_Id);
begin
  inherited Create(Source, Id);
  FDecisions := TAIDecisions.Create(Source, Id);
end;

procedure TAIAnalyzer.Free;
var
  I: Int32;
begin
  for I := 0 to High(FData) do FData[I].Free;
  FDecisions.Free;
  inherited Free;
end;

function TAIAnalyzer.GetData(Index: UInt32): TAIAnalysisData;
begin
  if Index >= UInt32(Length(FData)) then
    Result := nil
  else
    Result := FData[Index];
end;

function TAIAnalyzer.NewData: TAIAnalysisData;
var
  I: Int32;
begin
  I := Length(FData); SetLength(FData, I+1);
  FData[I] := TAIAnalysisData.Create(GetSource, 0);
  Result := FData[I];
end;

procedure TAIAnalyzer.Run;
begin
end;
}

{ TAIAnalyzerMobile }

constructor TAIAnalyzerMobile.Create(Source: AiSource2005);
begin
  inherited Create(Source, 0);
  {FDResX := DataNew;
  FDResY := DataNew;
  FDSpeedX := DataNew;
  FDSpeedY := DataNew;
  FDX1 := DataNew;
  FDX2 := DataNew;
  FDY1 := DataNew;
  FDY2 := DataNew;}

  {FDeX1 := Decisions.New;
  FDeX2 := Decisions.New;
  FDeY1 := Decisions.New;
  FDeY2 := Decisions.New;}
  {Зависимости}
  {FDeX1.Dependences.New(FDeX2, dNot);
  FDeX2.Dependences.New(FDeX1, dNot);
  FDeY1.Dependences.New(FDeY2, dNot);
  FDeY2.Dependences.New(FDeY1, dNot);}
end;

end.
