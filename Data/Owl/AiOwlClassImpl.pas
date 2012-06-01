{**
@Abstract(OWL класс)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.05.2007)
@LastMod(06.03.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OwlClass

Является сущностью.

История версий:
0.0.5.5 - 09.07.2011
[*] Переименовал AIWSOwlClassImpl -> AIOwlClassImpl
0.0.1.1 - Добавил Name
}
unit AiOwlClassImpl;

interface

uses
  AiCollection, AiEntityIntf, AiEntityImpl, AiOwlClassIntf;

type //** @abstract(OWL класс)
  TAIOwlClass = class(TAIEntity, IAIOwlClass)
  private
    FName: WideString;
  protected
    function GetName(): WideString;
    procedure SetName(Value: WideString);
  public
    function GetEnumerations(Ontologies: IAICollection): IAICollection;
    function GetEquivalentClasses(Ontologies: IAICollection): IAICollection;
    function GetSuperClasses(Ontologies: IAICollection): IAICollection;
  public
      //** Созранить в пул
    function Commit(): Boolean; override;
  public
    property Name: WideString read GetName write SetName;
  end;

implementation

{ TAIOwlClass }

function TAIOwlClass.Commit(): Boolean;
begin
  // ...
  Result := inherited Commit();
end;

function TAIOwlClass.GetEnumerations(Ontologies: IAICollection): IAICollection;
begin
  Result := nil;
  // ...
end;

function TAIOwlClass.GetEquivalentClasses(Ontologies: IAICollection): IAICollection;
begin
  Result := nil;
  // ...
end;

function TAIOwlClass.GetName(): WideString;
begin
  Result := FName;
end;

function TAIOwlClass.GetSuperClasses(Ontologies: IAICollection): IAICollection;
begin
  Result := nil;
  // ...
end;

procedure TAIOwlClass.SetName(Value: WideString);
begin
  FName := Value;
end;

end.
