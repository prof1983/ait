{**
@Abstract Правило
@Author Prof1983 <prof1983@ya.ru>
@Created 17.03.2005
@LastMod 23.11.2012
}
unit AiRule;

interface

uses
  ABase,
  AiBase, AiFrameImpl;

type
  IAIRule = interface
    function Get_ListParams: TAIID;
    procedure Set_ListParams(Value: TAIID);
    property ListParams: TAIID read Get_ListParams write Set_ListParams;
  end;

type // Список условий
  TAIConditionList = class //(TAIList)
  end;

type
  TAIRule = class(TAIFrame, IAIRule)
  private
    //FParams: TAIListParams;         // Список параметров
    FParamsCreate: Boolean;         // Создано при инициализации
    FConditions: TAIConditionList;  // Условия
    FConditionsCreate: Boolean;
    function Get_ListParams(): TAIID;
    procedure Set_ListParams(Value: TAIID);     // Объект создан при инициализации?
  public
    procedure Free(); override;
    //property Params: TAIListParams read FParams write FParams;
    function Initialize(): AError; override;
    //** Вычисление правила
    procedure Run();
  end;

type // Список правил
  TAIRuleList = class(TAIFrame)
  private
    FItems: array of record
      H: TAIID;
      F: TAIRule;
    end;
    function GetItemH(Index: UInt32): TAIID;
    function GetItemF(Index: UInt32): TAIRule;
  public
    function Add(ARule: TAIRule): Integer;
    property ItemsF[Index: UInt32]: TAIRule read GetItemF;
    property ItemsH[Index: UInt32]: TAIID read GetItemH;
    procedure Free; override;
    procedure Save();
  end;

implementation

{ TAIRule }

procedure TAIRule.Free();
var
  I: Int32;
begin
  Save;
  if Assigned(FConditions) and (FConditionsCreate) then
  begin
    //FConditions.ConfigureLoad;
    //FConditions.Finalize;
//    FreeAndNil(FConditions);
  end;
  FConditionsCreate := False;
  //if Assigned(FParams) and (FParamsCreate) then begin
    //FParams.ConfigureLoad;
    //FParams.Finalize;
    //FreeAndNil(FParams);
  //end;
  FParamsCreate := False;
  inherited Free;
end;

function TAIRule.Get_ListParams(): TAIID;
begin
  Result := 0;
end;

function TAIRule.Initialize(): AError;
//var
//  Config1: TConfigNode;
//  Id: TAI_Id;
begin
  Result := inherited Initialize;
  if not(Assigned(FConditions)) then
  begin
//    Config1 := nil;
//    Id := 0;
    (*if Assigned(Config) then begin
      Config1 := Config.GetNodeByName('ListCondition');
      Config.ReadAIId('ListConditionId', Id);
    end;*)
    FConditions := TAIConditionList.Create();
    //FConditions.ConfigureLoad;
    //FConditions.Initialize;
    FConditionsCreate := True;
  end;
  (*if not(Assigned(FParams)) then begin
    Config1 := nil;
    Id := 0;
    {if Assigned(Config) then begin
      Config1 := Config.GetNodeByName('LiatParams');
      Config.ReadAIId('ListParams', Id);
    end;}
    FParams := TAIListParams.Create(Config1, nil{Log}, FSource, Id);
    FParams.ConfigureLoad;
    FParams.Initialize;
    FParamsCreate := True;
  end;*)
end;

procedure TAIRule.Run();
var
  Count: Int32;
  I: Int32;
begin
  {if not(Assigned(FConditions)) or not(Assigned(FParams)) then Exit;
  Count := FConditions.Count;
  for I := 0 to Count - 1 do begin
  end;}
end;

procedure TAIRule.Set_ListParams(Value: TAIID);
begin
  //
end;

{ TAIRuleList }

function TAIRuleList.Add(ARule: TAIRule): Integer;
begin
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result].H := ARule.Id;
  FItems[Result].F := ARule;
end;

procedure TAIRuleList.Free();
var
  I: Int32;
begin
  Save;
  for I := 0 to High(FItems) do FItems[I].F.Free;
  inherited Free;
end;

function TAIRuleList.GetItemF(Index: UInt32): TAIRule;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index].F;
end;

function TAIRuleList.GetItemH(Index: UInt32): TAIID;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := 0
  else
    Result := FItems[Index].H;
end;

procedure TAIRuleList.Save();
//var
//  I: Int32;
//  H: TAIID;
begin
  inherited Save;
  {Rec.CountRules := Length(FItems);
  GetSource.DataWrite(GetId, Rec, SizeOf(Rec), UInt32(-1));
  for I := 0 to High(FItems) do begin
    H := FItems[I].H;
    Source.DataWrite(FreimId, H, SizeOf(H), UInt32(-1));
  end;}
end;

end.
