{**
@Abstract(Класс для разбора исходного кода на языке AIL)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.07.2007)
@LastMod(17.07.2007)
@Version(0.5)

История изменений:
0.0.1.0 - 17.07.2007
}

unit AilTokenizer;

interface

const
  POINT_TOKEN = '.';

type
  TTokenType = (
    CLASS_NAME_TOKEN_TYPE,
    METHOD_NAME_TOKEN_TYPE,
    PARAM_TOKEN_TYPE,
    STRING_PARAM_TOKEN_TYPE
    );

type
  TTokenizer = class
  private
    FPosition: Integer;
    FInputString: WideString;
    FPrevTokenType: TTokenType;
    FTokenType: TTokenType;
  public
    // Вперед
    procedure AheadTokenType(TokenType: TTokenType);
    // Назад
    function BackTokenType(): TTokenType;
    constructor Create();
    function Eof(): Boolean;
    function NextChar(): WideChar;
  public
    property InputString: WideString read FInputString write FInputString;
    property Position: Integer read FPosition;
    property TokenType: TTokenType read FTokenType;
  end;

implementation

{ TTokenizer }

procedure TTokenizer.AheadTokenType(TokenType: TTokenType);
begin
  FPrevTokenType := FTokenType;
  FTokenType := TokenType;
end;

function TTokenizer.BackTokenType(): TTokenType;
begin
  FTokenType := FPrevTokenType;
  Result := FTokenType;
end;

constructor TTokenizer.Create();
begin
  FPosition := 1;
end;

function TTokenizer.Eof(): Boolean;
begin
  Result := (FPosition > Length(FInputString));
end;

function TTokenizer.NextChar(): WideChar;
begin
  if not(Eof()) then
  begin
    Result := FInputString[FPosition];
    Inc(FPosition);
  end
  else
    Result := #0;
end;

end.
