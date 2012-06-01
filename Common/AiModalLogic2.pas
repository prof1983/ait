{**
@Abstract(Модальная логика)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.03.2006)
@LastMod(02.05.2012)
@Version(0.5)

GGKHMAS.DOC стр. 8
}
unit AiModalLogic2;

interface

type
  //** Язык этой логики включает в себя традиционные компоненты
  TModalLogicComponent = (
    lcNull,          // Пустое множество
    lcSpace,         // Непустое множество примитивных пропозиций
    lcOperator,      // Пропозициональные связки
    lcModalOperator, // Модальные операторы
    lcTimeOperator   // Временные операторы
    );

type
  // Пропозициональные связки
  TModalLogicOperator = (
    // Основные
    loOr,  // or - Или
    loNot, // not - Не
    // Дополнительные (могут быть выражены через уже введенные)
    loAnd, // and - И
    loIn   // in - Входящий в множество (Принадлежащий множеству)
    );

type
  // Модальные операторы
  TModalLogicModalOperator = (
    lmoBel,    // Bel ("агент убежден, верит")
    lmoDes,    // Des ("агент желает")
    lmoInstend // Intend ("агент намерен");
    );

type
  // Временные операторы
  TModalLogicTimeOperator = (
    // Основные
    ltoX, // X ("следующий")
    ltoU, // U ("до тех пор, пока")
    ltoF, // F ("когда-нибудь в будущем")
    ltoE, // E ("некоторый путь в будущем")
    // Дополнительные (могут быть выражены через уже введенные)
    ltoG, // G ("всегда в будущем")
    ltoB, // B ("раньше")
    ltoA  // A ("неизбежно в будущем")
    );

type
  // Тип правила
  TRuleType = (
    rtAxiom // Аксиома
    );

type
  // Правило
  TModalLogicRule = class
  private
    FRuleType: TRuleType;
  public
    property RuleType: TRuleType read FRuleType;
  end;

type
  // Правила
  TModalLogicRuleList = class
  private
    // Аксиомы
    //FAxioms: TAxiomsList;
    //FRules: array of Rules
    FItems: array of TModalLogicRule;
    function GetAxiom(Index: Integer): TModalLogicRule;
    function GetCount: Integer;
    function GetCountAxiom: Integer;
    function GetItem(Index: Integer): TModalLogicRule;
  public
    // Аксиомы
    property Axioms[Index: Integer]: TModalLogicRule read GetAxiom;
    // Колличество всех правил
    property Count: Integer read GetCount;
    // Колличество аксиом
    property CountAxiom: Integer read GetCountAxiom;
    // Все правила
    property Items[Index: Integer]: TModalLogicRule read GetItem;
  end;

type
  // Множества
  TModalLogicSpaceList = class
  private
    function GetCount: Integer;
  public
    // Колличество
    property Count: Integer read GetCount;
  end;

type
  // Главный класс
  TModalLogic = class
  private
    // Правила
    FRules: TModalLogicRuleList;
    // Множества
    FSpaces: TModalLogicSpaceList;
    function GetData: string;
    procedure SetData(Value: string);
  public
    constructor Create;
    // Данные для логического вывода
    property Data: string read GetData write SetData;
    procedure Free();
    // Правила для логического вывода
    property Rules: TModalLogicRuleList read FRules;
    // Запуск выполнения логического вывода
    function Run(AData: string = ''): Boolean;
    // Множества для логического вывода
    property Spaces: TModalLogicSpaceList read FSpaces;
  end;

const // -----------------------------------------------------------------------
  CHR_COMPONENT: array[TModalLogicComponent] of Char = ('N', 'S', 'O', 'M', 'T');
  CHR_LOGIC_OPERATOR: array[TModalLogicOperator] of Char = ('O', 'N', 'A', 'I');
  INT_COMPONENT: array[TModalLogicComponent] of Integer = (0, 1, 2, 3, 4);
  STR_RULE_TYPE: array[TRuleType] of string = ('Аксиома');

implementation

// TModalLogic -----------------------------------------------------------------
// -----------------------------------------------------------------------------
constructor TModalLogic.Create;
begin
  inherited Create();
  FRules := TModalLogicRuleList.Create();
  FSpaces := TModalLogicSpaceList.Create();
end;

// -----------------------------------------------------------------------------
procedure TModalLogic.Free();
begin
  if Assigned(FRules) then
  try
    FRules.Free();
  finally
    FRules := nil;
  end;
  if Assigned(FSpaces) then
  try
    FSpaces.Free();
  finally
    FSpaces := nil;
  end;
  inherited Free();
end;

// -----------------------------------------------------------------------------
function TModalLogic.GetData: string;
begin
  Result := '';
  // ...
end;

// -----------------------------------------------------------------------------
function TModalLogic.Run(AData: string = ''): Boolean;
// AData - XML в виде одной строки
begin
  Result := False;
  // Применить данные для логического вывода
  if AData <> '' then
    Data := AData;
  // ...
end;

// -----------------------------------------------------------------------------
procedure TModalLogic.SetData(Value: string);
begin
  // ...
end;

// TModalLogicRuleList ---------------------------------------------------------
// -----------------------------------------------------------------------------
function TModalLogicRuleList.GetAxiom(Index: Integer): TModalLogicRule;
var
  I: Integer;
  Ind: Integer;
begin
  Result := nil;
  Ind := -1;
  for I := 0 to High(FItems) do
    if FItems[I].RuleType = rtAxiom then begin
      Inc(Ind);
      if Ind = Index then begin
        Result := FItems[I];
        Exit;
      end;
    end;
end;

// -----------------------------------------------------------------------------
function TModalLogicRuleList.GetCount: Integer;
begin
  Result := Length(FItems);
end;

// -----------------------------------------------------------------------------
function TModalLogicRuleList.GetCountAxiom: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(FItems) do
    if FItems[I].RuleType = rtAxiom then
      Inc(Result);
end;

// -----------------------------------------------------------------------------
function TModalLogicRuleList.GetItem(Index: Integer): TModalLogicRule;
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    Result := FItems[Index]
  else
    Result := nil;
end;

// TModalLogicSpaceList --------------------------------------------------------
// -----------------------------------------------------------------------------
function TModalLogicSpaceList.GetCount: Integer;
begin
  Result := 0;
  // ...
end;

end.
