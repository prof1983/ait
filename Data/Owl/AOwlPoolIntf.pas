{**
@Abstract(Пул (источник) работы с OWL элементами)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(13.06.2012)
@Version(0.5)

Prototype: org.mindswap.pellet.KnowledgeBase

История версий:
0.0.0.5 - 05.07.2007
0.0.0.4 - 04.07.2007
0.0.0.3 - 21.06.2007 - Переименовал AIOwlPool -> AIWSOwlPool
}
unit AOwlPoolIntf;

interface

uses
  ACollectionIntf, AEntityIntf, AOwlClassIntf;

type
  IAiOwlPool = interface
    //function GetAllClasses(): IJavaSet;
    //function GetAllEquivalentClasses(c: IATermAppl): IJavaSet;
    //function GetAllEquivalentProperties(prop: IATermAppl): IJavaSet;
    //function GetAllSames(name: IATermAppl): IJavaSet;
    //function GetAntisymmetricProperties(): IJavaSet;
    function GetClasses(): IACollection;
    //function GetComplements(c: IATermAppl): IJavaSet;
    //function GetDataProperties(): IJavaSet;
    //function GetDataPropertyValues(r, x: IATermAppl; datatype: IPelletDatatype): IJavaList;
    //function GetDataPropertyValuesA(r, x: IATermAppl): IJavaList;
    //function GetDataPropertyValuesB(r, x: IATermAppl; const lang: WideString): IJavaList;
    //function GetDifferents(name: IAIEntity): IJavaSet;
    //function GetDisjointClasses(c: IATermAppl): IJavaSet;
    //function GetDisjointProperties(p: IATermAppl): IJavaSet;
    //function GetDisjoints(c: IATermAppl): IJavaSet;
    //function GetDomains(name: IATermAppl): IJavaSet;
    //function GetEquivalentClasses(c: IATermAppl): IJavaSet;
    //function GetEquivalentProperties(prop: IATermAppl): IJavaSet;
    //function GetFunctionalProperties(): IJavaSet;
    //function GetIndividuals(): IJavaSet;
    //function GetIndividualsWithDataProperty(r, litValue: IATermAppl): IJavaList;
    //function GetIndividualsWithObjectProperty(r, o: IATermAppl): IJavaList;
    //function GetIndividualsWithProperty(r, x: IATermAppl): IJavaList;
    //function GetInverseFunctionalProperties(): IJavaSet;
    //function GetIrreflexiveProperties(): IJavaSet;
    //function GetInstances(c: IATermAppl): IJavaSet;
    //function GetInstancesA(c: IATermAppl; direct: Boolean): IJavaSet;
    //function GetInverse(name: IATerm): IATermAppl;
    //function GetInverses(name: IATerm): IJavaSet;
    //function GetObjectProperties(): IJavaSet;
    //function GetObjectPropertyValues(r, x: IATermAppl): IJavaList;
    //function GetPossibleProperties(x: IATermAppl): IJavaSet;
    //function GetProperties(): IJavaSet;
    //function GetPropertiesA(s, o: IATermAppl): IJavaList;
    //function GetProperty(r: IAIEntity): IPelletRole;
    //function GetPropertyType(r: IAIEntity): Integer;
    //function GetPropertyValues(r, x: IATermAppl): IJavaList;
    //function GetPropertyValuesA(pred: IATermAppl): IJavaMap;
    //function GetRanges(name: IATerm): IJavaSet;
    //function GetReflexiveProperties(): IJavaSet;
    //function GetRole(term: IATerm): IPelletRole;
    //function GetRoleTaxonomy(): IPelletTaxonomy;
    //function GetRules(): IJavaSet;
    //function GetSames(name: IATermAppl): IJavaSet;
    //function GetSizeEstimate(): IPelletSizeEstimate;
    //function GetSubClasses(c: IATermAppl): IJavaSet;
    //function GetSubClassesA(c: IATermAppl; direct: Boolean): IJavaSet;
    //function GetSubProperties(prop: IATermAppl): IJavaSet;
    //function GetSubPropertiesA(prop: IATermAppl; direct: Boolean): IJavaSet;
    //function GetSuperClasses(c: IATermAppl): IJavaSet;
    //function GetSuperClassesA(c: IATermAppl; direct: Boolean): IJavaSet;
    //function GetSuperProperties(prop: IATermAppl): IJavaSet;
    //function GetSuperPropertiesA(prop: IATermAppl; direct: Boolean): IJavaSet;
    //function GetSymmetricProperties(): IJavaSet;
    //function GetTaxonomy(): IPelletTaxonomy;
    //function GetTaxonomyBuilder(): IPelletTaxonomyBuilder;
    //function GetTransitiveProperties(): IJavaSet;
    //function GetType(ind: IATermAppl): IATermAppl;
    //function GetTypeA(ind: IATermAppl; direct: Boolean): IATermAppl;
    //function GetTypes(ind: IATermAppl): IJavaSet;
    //function GetTypesA(ind: IATermAppl; direct: Boolean): IJavaSet;

////    function RunQuery(const queryStr: WideString): IPelletQueryResults;

    function AddAnnotationProperty(p: IAEntity): WordBool;
    procedure AddAntisymmetricProperty(p: IAEntity);
    procedure AddClass(c: IAEntity);
    procedure AddComplementClass(c1, c2: IAEntity);
    procedure AddDataPropertyValue(p, s, o: IAEntity);
    procedure AddDataRange(const DatatypeUri: WideString; Values: IACollection);
    procedure AddDatatype(p: IAEntity);
    //function AddDatatypeA(DataType: IPelletDatatype): WideString;
    //procedure AddDatatypeB(const DataTypeUrl: WideString; Datatype: IPelletDatatype);
    function AddDatatypeProperty(p: IAEntity): WordBool;
    procedure AddDifferent(i1, i2: IAEntity);
    procedure AddDisjointClass(c1, c2: IAEntity);
    procedure AddDisjointClasses(classes: IACollection);
    procedure AddDisjointProperty(p1, p2: IAEntity);
    procedure AddDomain(p, c: IAEntity);
    procedure AddEquivalentProperty(p1, p2: IAEntity);
    procedure AddFunctionalProperty(p: IAEntity);
    //function AddIndividual(i: IAIEntity): IPelletIndividual;
    procedure AddInverseFunctionalProperty(p: IAEntity);
    procedure AddInverseProperty(p1, p2: IAEntity);
    procedure AddIrreflexiveProperty(p: IAEntity);
    function AddNegatedPropertyValue(p, s, o: IAEntity): Boolean;
    function AddObjectProperty(p: IAEntity): Boolean;
    procedure AddObjectPropertyValue(p, s, o: IAEntity);
    procedure AddOntologyProperty(p: IAEntity);
    function AddProperty(p: IAEntity): Boolean;
    function AddPropertyValue(p, s, o: IAEntity): Boolean;
    procedure AddRange(p, c: IAEntity);
    procedure AddReflexiveProperty(p: IAEntity);
    //procedure AddRule(rule: IPelletRule);
    procedure AddSame(i1, i2: IAEntity);
    procedure AddSameClass(c1, c2: IAEntity);
    procedure AddSameProperty(p1, p2: IAEntity);
    procedure AddSubClass(sub, sup: IAEntity);
    procedure AddSubProperty(sub, sup: IAEntity);
    procedure AddSymmetricProperty(p: IAEntity);
    procedure AddTransitiveProperty(p: IAEntity);
    procedure AddType(i, c: IAEntity);

    function HasDomain(p, c: IAEntity): Boolean;
    function HasInstance(d: IAEntity): Boolean;
    function HasKnownPropertyValue(s, p, o: IAEntity): Boolean;
    function HasPropertyValue(s, p, o: IAEntity): Boolean;
    function HasRange(p, c: IAEntity): Boolean;

    function IsABoxProperty(p: IAEntity): Boolean;
    function IsAnnotationProperty(p: IAEntity): Boolean;
    function IsAntisymmetricProperty(p: IAEntity): Boolean;
    function IsClass(c: IAEntity): Boolean;
    function IsComplement(c1, c2: IAEntity): Boolean;
    function IsDatatype(p: IAEntity): Boolean;
    function IsDatatypeProperty(p: IAEntity): Boolean;
    function IsDifferentFrom(t1, t2: IAEntity): Boolean;
    function IsDisjoint(c1, c2: IAEntity): Boolean;
    function IsDisjointClass(c1, c2: IAEntity): Boolean;
    function IsDisjointProperty(r1, r2: IAEntity): Boolean;
    function IsEquivalentClass(c1, c2: IAEntity): Boolean;
    function IsEquivalentProperty(p1, p2: IAEntity): Boolean;
    function IsFunctionalProperty(p: IAEntity): Boolean;
    function IsIndividual(ind: IAEntity): Boolean;
    function IsInverse(r1, r2: IAEntity): Boolean;
    function IsInverseFunctionalProperty(p: IAEntity): Boolean;
    function IsIrreflexiveProperty(p: IAEntity): Boolean;
    function IsKnownType(x, c: IAEntity): Boolean;
    function IsObjectProperty(p: IAEntity): Boolean;
    function IsOntologyProperty(p: IAEntity): Boolean;
    function IsProperty(p: IAEntity): Boolean;
    function IsReflexiveProperty(p: IAEntity): Boolean;
    function IsSameAs(t1, t2: IAEntity): Boolean;
    function IsSatisfiable(c: IAEntity): Boolean;
    function IsSubClassOf(c1, c2: IAEntity): Boolean;
    function IsSubPropertyOf(sub, sup: IAEntity): Boolean;
    function IsSubTypeOf(d1, d2: IAEntity): Boolean;
    function IsSymmetricProperty(p: IAEntity): Boolean;
    function IsTransitiveProperty(r: IAEntity): Boolean;
    function IsType(x, c: IAEntity): Boolean;
    // ...
    procedure LoadDatatype(p: IAEntity);
    function RemoveObjectPropertyValue(p, i1, i2: IAEntity): Boolean;
    procedure RemoveType(ind, c: IAEntity);
    procedure RemoveIndividual(c: IAEntity);

    //procedure SetRules(rules: IJavaSet);

    //** Создать новый класс
    function NewClass(Name: WideString): IAIOwlClass;
  end;

implementation

end.
