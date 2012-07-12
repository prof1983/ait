{**
@Abstract(AiKbLocalObj)
@Author(Prof1983 prof1983@ya.ru)
@Created(10.07.2012)
@LastMod(12.07.2012)
@Version(0.5)
}
unit AiKbLocalObj;

interface

uses
  ABase,
  AiKbObj;

type
  TAiKbLocal = class(TAIKBMemory)
  private
    //FARLocal: TAIARLocal;
    //FBaseLocal: TAIBaseLocal;
    //FMashineLocal: TAIMashineLocal;
    //FWorldLocal: TAIWorldLocal;
  public
    function Initialize(): AError; override;
    function Clear(): AError; override;
    //function GetARLocal: TAIARLocal;
    //function GetBaseLocal: TAIBaseLocal;
    //function GetMashineLocal: TAIMashineLocal;
    //function GetWorldLocal: TAIWorldLocal;
  end;

implementation

{ TAiKbLocal }

function TAiKbLocal.Clear(): AError;
begin
  Result := inherited Clear();
  if Result <> 0 then Exit;
  {FARLocal := nil;
  FBaseLocal := nil;
  FMashineLocal := nil;
  FWorldLocal := nil;}
end;

{function TAiKbLocal.GetARLocal: TAIARLocal;
begin
  Result := FARLocal;
end;}

{function TAiKbLocal.GetBaseLocal: TAIBaseLocal;
begin
  Result := FBaseLocal;
end;}

{function TAiKbLocal.GetMashineLocal: TAIMashineLocal;
begin
  Result := FMashineLocal;
end;}

{function TAiKbLocal.GetWorldLocal: TAIWorldLocal;
begin
  Result := FWorldLocal;
end;}

function TAiKbLocal.Initialize(): AError;
{var
  TypeARLocal: TAITypeARLocal;
  TypeBaseLocal: TAITypeBaseLocal;
  TypeKBLocal: TAITypeKBLocal;
  TypeMashineLocal: TAITypeMashineLocal;
  TypeWorldLocal: TAITypeWorldLocal;}
begin
  Result := inherited Initialize();
  (*{=== Инициальзация типов ===}
  TypeARLocal := TAITypeARLocal.Create;
  KBLocal.SetFreim(TypeARLocalId, TypeARLocal);
  TypeARLocal.Initialize;

  TypeBaseLocal := TAITypeBaseLocal.Create;
  KBLocal.SetFreim(TypeBaseLocalId, TypeBaseLocal);
  TypeBaseLocal.Initialize;

  TypeKBLocal := TAITypeKBLocal.Create;
  KBLocal.SetFreim(TypeKBLocalId, TypeKBLocal);
  TypeKBLocal.Initialize;

  TypeMashineLocal := TAITypeMashineLocal.Create;
  KBLocal.SetFreim(TypeMashineLocalId, TypeMashineLocal);
  TypeMashineLocal.Initialize;

  TypeWorldLocal := TAITypeWorldLocal.Create;
  KBLocal.SetFreim(TypeWorldLocalId, TypeWorldLocal);
  TypeWorldLocal.Initialize;*)

  {=== Инициальзация объектов ===}
  {Добавление записи о текущей БЗ в БЗ}
  {Self.SetType(TypeKBLocalId);
  KBLocal.NewFreim(Self);}

  (*
  {Инициализация разума с добавлением в БЗ}
  if not(Assigned(FARLocal)) then
  begin
    FARLocal := TAiArLocal.Create(0, 0);
    FARLocal.SetType(TypeARLocalId);
    Self.NewFreim(FARLocal);
  end;
  FARLocal.Initialize;
  {Добавление информации в базовый фрейм}
  if not(Assigned(FBaseLocal)) then
  begin
    FBaseLocal := TAIBaseLocal.Create(0, 0);
    FBaseLocal.SetType(TypeBaseLocalId);
    Self.NewFreim(FBaseLocal);
  end;
  FBaseLocal.Initialize;
  {Инициализация машины с добавлением в БЗ}
  if not(Assigned(FMashineLocal)) then
  begin
    FMashineLocal := TAIMashineLocal.Create(0, 0);
    FMashineLocal.SetType(TypeMashineLocalId);
    Self.NewFreim(FMashineLocal);
  end;
  FMashineLocal.Initialize;
  {Инициализация мира с добавлением в БЗ}
  if not(Assigned(FWorldLocal)) then
  begin
    FWorldLocal := TAIWorldLocal.Create(0, 0);
    FWorldLocal.SetType(TypeMashineLocalId);
    Self.NewFreim(FWorldLocal);
  end;
  FWorldLocal.Initialize;
  *)
end;

end.
