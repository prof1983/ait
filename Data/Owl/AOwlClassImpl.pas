{**
@Abstract(OWL класс)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.05.2007)
@LastMod(13.06.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OwlClass

Является сущностью.

История версий:
0.0.5.5 - 09.07.2011
[*] Переименовал AIWSOwlClassImpl -> AIOwlClassImpl
0.0.1.1 - Добавил Name
}
unit AOwlClassImpl;

interface

uses
  ACollectionIntf, AEntityIntf, AiEntityImpl,
  AOwlClassIntf;

type //** @abstract(OWL класс)
  TAIOwlClass = class(TAIEntity, IAIOwlClass)
  private
    FName: WideString;
  protected
    function GetName(): WideString;
    procedure SetName(Value: WideString);
  public
    function GetEnumerations(Ontologies: IACollection): IACollection;
    function GetEquivalentClasses(Ontologies: IACollection): IACollection;
    function GetSuperClasses(Ontologies: IACollection): IACollection;
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

function TAIOwlClass.GetEnumerations(Ontologies: IACollection): IACollection;
begin
  Result := nil;
  // ...
end;

function TAIOwlClass.GetEquivalentClasses(Ontologies: IACollection): IACollection;
begin
  Result := nil;
  // ...
end;

function TAIOwlClass.GetName(): WideString;
begin
  Result := FName;
end;

function TAIOwlClass.GetSuperClasses(Ontologies: IACollection): IACollection;
begin
  Result := nil;
  // ...
end;

procedure TAIOwlClass.SetName(Value: WideString);
begin
  FName := Value;
end;

end.
