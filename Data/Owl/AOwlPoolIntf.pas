{**
@Abstract(Пул (источник) работы с OWL элементами)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(06.03.2012)
@Version(0.5)

Prototype: org.mindswap.pellet.KnowledgeBase

История версий:
0.0.0.5 - 05.07.2007
0.0.0.4 - 04.07.2007
0.0.0.3 - 21.06.2007 - Переименовал AIOwlPool -> AIWSOwlPool
}
unit AiOwlPoolIntf;

interface

uses
  AiCollection, AiEntityIntf, AiOwlClassIntf;

type
  IAiOwlPool = interface
    //function GetAllClasses(): IJavaSet;
    //function GetAllEquivalentClasses(c: IATermAppl): IJavaSet;
    //function GetAllEquivalentProperties(prop: IATermAppl): IJavaSet;
    //function GetAllSames(name: IATermAppl): IJavaSet;
    //function GetAntisymmetricProperties(): IJavaSet;
    function GetClasses(): IAiCollection;
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

    function AddAnnotationProperty(p: IAIEntity): WordBool;
    procedure AddAntisymmetricProperty(p: IAIEntity);
    procedure AddClass(c: IAIEntity);
    procedure AddComplementClass(c1, c2: IAIEntity);
    procedure AddDataPropertyValue(p, s, o: IAIEntity);
    procedure AddDataRange(const DatatypeUri: WideString; Values: IAICollection);
    procedure AddDatatype(p: IAIEntity);
    //function AddDatatypeA(DataType: IPelletDatatype): WideString;
    //procedure AddDatatypeB(const DataTypeUrl: WideString; Datatype: IPelletDatatype);
    function AddDatatypeProperty(p: IAIEntity): WordBool;
    procedure AddDifferent(i1, i2: IAIEntity);
    procedure AddDisjointClass(c1, c2: IAIEntity);
    procedure AddDisjointClasses(classes: IAICollection);
    procedure AddDisjointProperty(p1, p2: IAIEntity);
    procedure AddDomain(p, c: IAIEntity);
    procedure AddEquivalentProperty(p1, p2: IAIEntity);
    procedure AddFunctionalProperty(p: IAIEntity);
    //function AddIndividual(i: IAIEntity): IPelletIndividual;
    procedure AddInverseFunctionalProperty(p: IAIEntity);
    procedure AddInverseProperty(p1, p2: IAIEntity);
    procedure AddIrreflexiveProperty(p: IAIEntity);
    function AddNegatedPropertyValue(p, s, o: IAIEntity): Boolean;
    function AddObjectProperty(p: IAIEntity): Boolean;
    procedure AddObjectPropertyValue(p, s, o: IAIEntity);
    procedure AddOntologyProperty(p: IAIEntity);
    function AddProperty(p: IAIEntity): Boolean;
    function AddPropertyValue(p, s, o: IAIEntity): Boolean;
    procedure AddRange(p, c: IAIEntity);
    procedure AddReflexiveProperty(p: IAIEntity);
    //procedure AddRule(rule: IPelletRule);
    procedure AddSame(i1, i2: IAIEntity);
    procedure AddSameClass(c1, c2: IAIEntity);
    procedure AddSameProperty(p1, p2: IAIEntity);
    procedure AddSubClass(sub, sup: IAIEntity);
    procedure AddSubProperty(sub, sup: IAIEntity);
    procedure AddSymmetricProperty(p: IAIEntity);
    procedure AddTransitiveProperty(p: IAIEntity);
    procedure AddType(i, c: IAIEntity);

    function HasDomain(p, c: IAIEntity): Boolean;
    function HasInstance(d: IAIEntity): Boolean;
    function HasKnownPropertyValue(s, p, o: IAIEntity): Boolean;
    function HasPropertyValue(s, p, o: IAIEntity): Boolean;
    function HasRange(p, c: IAIEntity): Boolean;

    function IsABoxProperty(p: IAIEntity): Boolean;
    function IsAnnotationProperty(p: IAIEntity): Boolean;
    function IsAntisymmetricProperty(p: IAIEntity): Boolean;
    function IsClass(c: IAIEntity): Boolean;
    function IsComplement(c1, c2: IAIEntity): Boolean;
    function IsDatatype(p: IAIEntity): Boolean;
    function IsDatatypeProperty(p: IAIEntity): Boolean;
    function IsDifferentFrom(t1, t2: IAIEntity): Boolean;
    function IsDisjoint(c1, c2: IAIEntity): Boolean;
    function IsDisjointClass(c1, c2: IAIEntity): Boolean;
    function IsDisjointProperty(r1, r2: IAIEntity): Boolean;
    function IsEquivalentClass(c1, c2: IAIEntity): Boolean;
    function IsEquivalentProperty(p1, p2: IAIEntity): Boolean;
    function IsFunctionalProperty(p: IAIEntity): Boolean;
    function IsIndividual(ind: IAIEntity): Boolean;
    function IsInverse(r1, r2: IAIEntity): Boolean;
    function IsInverseFunctionalProperty(p: IAIEntity): Boolean;
    function IsIrreflexiveProperty(p: IAIEntity): Boolean;
    function IsKnownType(x, c: IAIEntity): Boolean;
    function IsObjectProperty(p: IAIEntity): Boolean;
    function IsOntologyProperty(p: IAIEntity): Boolean;
    function IsProperty(p: IAIEntity): Boolean;
    function IsReflexiveProperty(p: IAIEntity): Boolean;
    function IsSameAs(t1, t2: IAIEntity): Boolean;
    function IsSatisfiable(c: IAIEntity): Boolean;
    function IsSubClassOf(c1, c2: IAIEntity): Boolean;
    function IsSubPropertyOf(sub, sup: IAIEntity): Boolean;
    function IsSubTypeOf(d1, d2: IAIEntity): Boolean;
    function IsSymmetricProperty(p: IAIEntity): Boolean;
    function IsTransitiveProperty(r: IAIEntity): Boolean;
    function IsType(x, c: IAIEntity): Boolean;
    // ...
    procedure LoadDatatype(p: IAIEntity);
    function RemoveObjectPropertyValue(p, i1, i2: IAIEntity): Boolean;
    procedure RemoveType(ind, c: IAIEntity);
    procedure RemoveIndividual(c: IAIEntity);

    //procedure SetRules(rules: IJavaSet);

    //** Создать новый класс
    function NewClass(Name: WideString): IAIOwlClass;
  end;

implementation

end.
