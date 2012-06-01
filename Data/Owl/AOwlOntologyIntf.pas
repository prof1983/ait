{**
@Abstract(Онтология)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(26.04.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OwlOntology
}
unit AiOwlOntology;

interface

uses
  AiCollection;

type //** Онтология
  IAIWSOwlOntology = interface
    function GetAnnotationProperties(): IAiCollection;
    function GetBackwardCompatibleWith(): IAiCollection;
    function GetClassAxioms(): IAiCollection;
    function GetClasses(): IAiCollection;
    function GetDataProperties(): IAiCollection;
    function GetDatatypes(): IAiCollection;
    function GetIncludedOntologies(): IAiCollection;
    function GetIndividualAxioms(): IAiCollection;
    function GetIndividuals(): IAiCollection;
    function GetObjectProperties(): IAiCollection;
    function GetPropertyAxioms(): IAiCollection;
    function GetPriorVersion(): IAiCollection;
    function GetIncompatibleWith(): IAiCollection;
    function GetIsMutable(): WordBool;
    function GetLogicalUri(): WideString;
    function GetPhysicalUri(): WideString;

    property IsMutable: WordBool read GetIsMutable;
  end;

implementation

end.
