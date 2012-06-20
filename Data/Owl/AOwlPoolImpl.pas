{**
@Abstract(Пул (источник) работы с OWL элементами)
@Author(Prof1983 prof183@ya.ru)
@Created(12.05.2006)
@LastMod(20.06.2012)
@Version(0.5)

Prototype: Pellet.KnowledgeBase

Реализует работу с OWL сущностями

История версий:
0.0.0.2 - 31.05.2007 - Переделал TAIWSID на TAIID
}
unit AOwlPoolImpl;

// TODO: Remove Ai* uses

interface

uses
  ABase, ACollectionIntf, AEntityIntf,
  AOwlClassIntf, AOwlClassImpl, AOwlPoolIntf,
  AiConsts, AiLogingObject,
  AiOntologyIndividual, AiPoolIntf;

type
  // Пул (источник) работы с OWL элементами
  TAIOwlPool = class(TAILogingObject, IAIOwlPool)
  private
    // Режим отладки
    FIsDebug: Boolean;
    // Пул хранения сущностей
    FPool: IAIPool;
  protected // Идентификаторы основных типов OWL элементов
  protected // from org.mindswap.pellet.utils.ATermUtils
    //** Все (для всех)
    FAllID: TAId;   // ALLFUN: IAFun;
    //** "И"
    FAndID: TAId;   // ANDFUN: IAFun;
    FBottomID: TAId; //BOTTOM: IATermAppl;
    FBottomLitID: TAId; //BOTTOM_LIT: IATermAppl;
    FCardID: TAId;  // CARDFUN: IAFun;
    FDifferentID: TAId; // DIFFERENTFUN: IAFun;
    FDpID: TAId; //DPFUN: IAFun;
    FEmptyID: TAId; //EMPTY: IATermAppl;
    FEmptyListID: TAId; //EMPTY_LIST: IATermList;
    FInvID: TAId;   // INVFUN: IAFun;
    FIpID: TAId; //IPFUN: IAFun;
    FLitID: TAId; //LITFUN: IAFun;
    //** "MAX"
    FMaxID: TAId;   // MAXFUN: IAFun;
    //** "MIN"
    FMinID: TAId;   // MINFUN: IAFun;
    FNoDatatype: TAId; //NO_DATATYPE: IATermAppl;
    //** "НЕ"
    FNotID: TAId;   // NOTFUN: IAFun;
    FOne: TAId; //ONE: IATermInt;
    //** "OR"
    FOrID: TAId;    // ORFUN: IAFun;
    FPropID: TAId; //PROPFUN: IAFun;
    FSameID: TAId;  // SAMEFUN: IAFun;
    FSelfID: TAId;  // SELFFUN: IAFun;
    FSomeID: TAId;  // SOMEFUN: IAFun;
    FSubID: TAId;   // SUBFUN: IAFun;
    FTopID: TAId; //TOP: IATermAppl;
    FTopLitID: TAId; //TOP_LIT: IATermAppl;
    FTypeID: TAId; //TYPEFUN: IAFun;
    //** Значение
    FValueID: TAId; // VALUEFUN: IAFun;
    FVarID: TAId; //VARFUN: IAFun;
  public // Идентификаторы сущностей-типов
    FAnnotationPropertyTypeID: TAId;
    FAntisymmetricPropertyTypeID: TAId;
    // Идентификатор типа класс
    FClassTypeID: TAId;
    FDatatypeTypeID: TAId;
    FDatatypePropertyTypeID: TAId;
    FDifferentTypeID: TAId;
    FDisjointClassTypeID: TAId;
    FDisjointPropertyTypeID: TAId;
    FDomainTypeID: TAId;
    FEquivalentPropertyTypeID: TAId;
    FObjectPropertyTypeID: TAId;
    FOntologyPropertyID: TAId;
    FPropertyTypeID: TAId;
    FPropertyValueTypeID: TAId;
    FReflexivePropertyTypeID: TAId;
  public
    function GetClasses: IACollection;
  public //from org.mindswap.pellet.utils.ATermUtils
    // Проверяет тип сущности. Тип сущности должен быть ValueID
    function IsNominal(Entity: IAEntity): Boolean;
    // Дедает проверку иерархии классов. (IsNormal)
    function IsOneOf(Entity: IAEntity): Boolean;
  public
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
//    function AddIndividual(i: IAIEntity): IAIWSIndividual;
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
    function IsAnnotationProperty(p: TAId): Boolean; overload;
    function IsAnnotationProperty(p: IAEntity): Boolean; overload;
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
  public
    function NewAnnotationProperty(): IAEntity;
    function NewAntisymmetricProperty(): IAEntity;
    function NewClass(Name: WideString): IAIOwlClass;
    //procedure NewComplementClass(c1, c2: IAIEntity);
    //procedure NewDataPropertyValue(p, s, o: IAIEntity);
    //procedure NewDataRange(const DatatypeUri: WideString; Values: IAIEntityList);
    function NewDatatype: IAEntity;
    //function AddDatatypeA(DataType: IPelletDatatype): WideString;
    //procedure AddDatatypeB(const DataTypeUrl: WideString; Datatype: IPelletDatatype);
    function NewDatatypeProperty: IAEntity;
    //procedure NewDifferent(i1, i2: IAIEntity);
    //procedure NewDisjointClass(c1, c2: IAIEntity);
    //procedure NewDisjointClasses(classes: IAIEntityList);
    //procedure NewDisjointProperty(p1, p2: IAIEntity);
    //procedure NewDomain(p, c: IAIEntity);
    //procedure NewEquivalentProperty(p1, p2: IAIEntity);
    function NewFunctionalProperty: IAEntity;
    function NewIndividual: IAIOntologyIndividual;
    function NewIndividual2(const Name: APascalString): IAIOntologyIndividual;
    function NewInverseFunctionalProperty: IAEntity;
    //procedure NewInverseProperty(p1, p2: IAIEntity);
    function NewIrreflexiveProperty(): IAEntity;
    //function NewNegatedPropertyValue(p, s, o: IAIEntity): Boolean;
    function NewObjectProperty(): IAEntity;
    //procedure NewObjectPropertyValue(p, s, o: IAIEntity);
    function NewOntologyProperty(): IAEntity;
    function NewProperty(Name: WideString): IAEntity;
    //function NewPropertyValue(p, s, o: IAIEntity): Boolean;
    //procedure NewRange(p, c: IAIEntity);
    function NewReflexiveProperty(): IAEntity;
    //procedure AddRule(rule: IPelletRule);
    //procedure NewSame(i1, i2: IAIEntity);
    //procedure NewSameClass(c1, c2: IAIEntity);
    //procedure NewSameProperty(p1, p2: IAIEntity);
    //procedure NewSubClass(sub, sup: IAIEntity);
    //procedure NewSubProperty(sub, sup: IAIEntity);
    //procedure NewSymmetricProperty(p: IAIEntity);
    //procedure NewTransitiveProperty(p: IAIEntity);
    //procedure NewType(i, c: IAIEntity);
  public // from PelletATermUtils
    //function AddAnnotationRole(r: IAIEntity): IAIWSRole;
    class function IsComplexClass(c: IAEntity): Boolean;
  public // Идентификаторы основных объектов для работы с OWL
    // from org.mindswap.pellet.ABox
    //** Верхний индивид
    TopIndividualID: TAId; //TOP_IND: IPelletIndividual;
    //** Нижний индивид
    BottomIndividualID: TAId; //BOTTOM_IND: IPelletIndividual;
    DummyIndividualID: TAId; //DUMMY_IND: IPelletIndividual;
  public
    procedure Close();
    //** Открыть
    function Open(): AError;
  public
    //** Режим отладки
    property IsDebug: Boolean read FIsDebug write FIsDebug;
    //** Пул для работы с сущностями
    property Pool: IAIPool read FPool write FPool;
  end;

//const
//  PELLET_NOT  = 'not';
//  RELLET_AND  = 'and';
//  PELLET_OR   = 'or';
//  PELLET_SOME = 'some';
//  PELLET_ALL  = 'all';
//  PELLET_MIN  = 'min';
//  PELLET_MAX  = 'max';
//  PELLET_CARD = 'card';
//  PELLET_VALUE= 'value';
//  PELLET_SELF = 'self';
//  // role
//  PELLET_INV  = 'inv';
//  //tbox
//  PELLET_SUB  = 'sub';
//  PELLET_SAME = 'same';

implementation

{ TAIOwlPool }

function TAIOwlPool.AddAnnotationProperty(p: IAEntity): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
  //Result := Assigned(FRBox.AddAnnotationRole(p));

  //Result := Assigned(AddAnnotationRole(p));
end;

procedure TAIOwlPool.AddAntisymmetricProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddClass(c: IAEntity);
begin
  if IsComplexClass(c) then Exit;

  //FPool.NewEntity (c);

  // TODO -oProf: Make
  // ...
	//public void addClass( ATermAppl c )
  {
		if(c.equals(ATermUtils.TOP) || ATermUtils.isComplexClass(c))
			return;

		status |= TBOX_CHANGED;
		tbox.addClass( c );

		if( log.isDebugEnabled() ) log.debug("class " + c);
	}
end;

procedure TAIOwlPool.AddComplementClass(c1, c2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDataPropertyValue(p, s, o: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDataRange(const DatatypeUri: WideString; Values: IACollection);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDatatype(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddDatatypeProperty(p: IAEntity): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDifferent(i1, i2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDisjointClass(c1, c2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDisjointClasses(classes: IACollection);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDisjointProperty(p1, p2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDomain(p, c: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddEquivalentProperty(p1, p2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddFunctionalProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddInverseFunctionalProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddInverseProperty(p1, p2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddIrreflexiveProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddNegatedPropertyValue(p, s, o: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddObjectProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddObjectPropertyValue(p, s, o: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddOntologyProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...

//  Result := Assigned(FPool);
//  if not(Result) then Exit;
//  Result := FPool.AddEntity(p);
end;

function TAIOwlPool.AddPropertyValue(p, s, o: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddRange(p, c: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddReflexiveProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSame(i1, i2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSameClass(c1, c2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSameProperty(p1, p2: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSubClass(sub, sup: IAEntity);
begin
  if sub = sup then Exit;
  {if IsOneOf(sub) then
  begin

  end;}

  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSubProperty(sub, sup: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSymmetricProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddTransitiveProperty(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddType(i, c: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.Close();
begin
  if Assigned(FPool) then
  try
    FPool.Close();
  except
  end;
end;

function TAIOwlPool.GetClasses({Ontology: TAIID}): IACollection;
begin
  if not(Assigned(FPool)) then
  begin
    Result := nil;
    Exit;
  end;

  try
    // Выбрать все классы из пула //определенной онтологии
    Result := FPool.SelectT(FClassTypeID);
  except
    Result := nil;
  end;
end;

function TAIOwlPool.HasDomain(p, c: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasInstance(d: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasKnownPropertyValue(s, p, o: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasPropertyValue(s, p, o: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasRange(p, c: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsABoxProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsAnnotationProperty(p: IAEntity): Boolean;
begin
  Result := False;
  if not(Assigned(p)) then Exit;
  Result := (p.EntityType = FAnnotationPropertyTypeID);
end;

function TAIOwlPool.IsAnnotationProperty(p: TAId): Boolean;
begin
  Result := False;
  if not(Assigned(FPool)) then Exit;
  Result := (FPool.GetEntityValueType(p) = FAnnotationPropertyTypeID);
end;

function TAIOwlPool.IsAntisymmetricProperty(p: IAEntity): Boolean;
begin
  Result := False;
  if not(Assigned(p)) then Exit;
  Result := (p.EntityType = FAntisymmetricPropertyTypeID);
end;

function TAIOwlPool.IsClass(c: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsComplement(c1, c2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

class function TAIOwlPool.IsComplexClass(c: IAEntity): Boolean;
//var
//  classEntity: IAIEntity;
begin
  Result := False;
//  classEntity := FPool.EntityByID[ClassID];

    //public static boolean isComplexClass(ATerm c)
    (*
    	if (c instanceof ATermAppl)
      {
    		ATermAppl a = (ATermAppl) c;
    		AFun f = a.getAFun();
    		return CLASS_FUN.contains( f );
    	}
    	return false;
    *)
end;

function TAIOwlPool.IsDatatype(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDatatypeProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDifferentFrom(t1, t2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDisjoint(c1, c2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDisjointClass(c1, c2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDisjointProperty(r1, r2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsEquivalentClass(c1, c2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsEquivalentProperty(p1, p2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsFunctionalProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsIndividual(ind: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsInverse(r1, r2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsInverseFunctionalProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsIrreflexiveProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsKnownType(x, c: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsNominal(Entity: IAEntity): Boolean;
begin
  Result := (Entity.EntityType = FValueID);

	//public final static boolean isNominal(ATermAppl a)
  {
		return a.getAFun().equals(VALUEFUN);
	}
end;

function TAIOwlPool.IsObjectProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsOneOf(Entity: IAEntity): Boolean;
//var
//  list: IAICollection;
begin
  Result := False;
  if not(Assigned(Entity)) then Exit;
  if not(Entity.EntityType = FOrID) then Exit;

  if not(FPool.IsCollectionEntity(Entity)) then Exit;

  {list := IAICollection(IAICollectionEntity(Entity).GetArgument(0));
  while not(list.IsEmpty) do
  begin
    if not(IsNominal(list.GetFirst)) then Exit;
    list := list.GetNext();
  end;

  Result := True;}

	//public final static boolean isOneOf(ATermAppl a)
  (*
		if(!a.getAFun().equals(ORFUN))
			 return false;

		ATermList list = (ATermList) a.getArgument(0);
		while(!list.isEmpty())
    {
			if(!isNominal((ATermAppl) list.getFirst()))
				return false;
			list = list.getNext();
		}
		return true;
	*)
end;

function TAIOwlPool.IsOntologyProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsReflexiveProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSameAs(t1, t2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSatisfiable(c: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSubClassOf(c1, c2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSubPropertyOf(sub, sup: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSubTypeOf(d1, d2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSymmetricProperty(p: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsTransitiveProperty(r: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsType(x, c: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.LoadDatatype(p: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewAnnotationProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewAntisymmetricProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewClass(Name: WideString): IAiOwlClass;
var
  id: TAId;
  OwlClass: TAiOwlClass;
begin
  Result := nil;
  if not(Assigned(FPool)) then Exit;
  try
    id := FPool.NewEntity2(FClassTypeID);
    OwlClass := TAiOwlClass.Create2(FPool, Id);
    OwlClass.Name := Name;
    Result := OwlClass;
  except
    Result := nil;
  end;
end;

function TAIOwlPool.NewDatatype(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewDatatypeProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewFunctionalProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewIndividual{(i: IAEntity)}: IAIOntologyIndividual;
begin
  Result := nil;
  // ...
end;

function TAIOwlPool.NewIndividual2(const Name: APascalString): IAIOntologyIndividual;
begin
  Result := nil;
  // ...
end;

function TAIOwlPool.NewInverseFunctionalProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewIrreflexiveProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewObjectProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewOntologyProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewProperty(Name: WideString): IAEntity;
//var
//  id: TAIID;
begin
  Result := nil;
  if not(Assigned(FPool)) then Exit;
  // Создаем сущность-свойство
//  id := FPool.NewEntity();
//  Result := TAIWSProperty.Create(id, Name, PropertyID);
  // Добавляем сущность-свойство в пул
  //AddProperty(Result);
end;

function TAIOwlPool.NewReflexiveProperty(): IAEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.Open(): AError;
begin
  Result := FPool.Open();
  if Result < 0 then Exit;

  if FIsDebug then
    AddToLog('Создаем необходимые типы сущностей');

  //FPool.OnAddToLog := AddToLog;

  FAllId := FPool.NewEntity2(AiNullType);
  FAndId := FPool.NewEntity2(AiNullType);
  FCardId := FPool.NewEntity2(AiNullType);
  FInvId := FPool.NewEntity2(AiNullType);
  FNotId := FPool.NewEntity2(AiNullType);
  FMaxId := FPool.NewEntity2(AiNullType);
  FMinId := FPool.NewEntity2(AiNullType);
  FOrId := FPool.NewEntity2(AiNullType);
  FSameId := FPool.NewEntity2(AiNullType);
  FSelfId := FPool.NewEntity2(AiNullType);
  FSomeId := FPool.NewEntity2(AiNullType);
  FSubId := FPool.NewEntity2(AiNullType);
  FValueId := FPool.NewEntity2(AiNullType);

  FAnnotationPropertyTypeId := FPool.NewEntity2(AiNullType);
  FAntisymmetricPropertyTypeId := FPool.NewEntity2(AiNullType);
  FClassTypeId := FPool.NewEntity2(AiNullType);
  FDatatypeTypeId := FPool.NewEntity2(AiNullType);
  FDatatypePropertyTypeId := FPool.NewEntity2(AiNullType);
  FDifferentTypeId := FPool.NewEntity2(AiNullType);
  FDisjointClassTypeId := FPool.NewEntity2(AiNullType);
  FDisjointPropertyTypeId := FPool.NewEntity2(AiNullType);
  FDomainTypeId := FPool.NewEntity2(AiNullType);
  FEquivalentPropertyTypeId := FPool.NewEntity2(AiNullType);
  FObjectPropertyTypeId := FPool.NewEntity2(AiNullType);
  FOntologyPropertyId := FPool.NewEntity2(AiNullType);
  FPropertyTypeId := FPool.NewEntity2(AiNullType);
  FPropertyValueTypeId := FPool.NewEntity2(AiNullType);
  FReflexivePropertyTypeId := FPool.NewEntity2(AiNullType);
end;

procedure TAIOwlPool.RemoveIndividual(c: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.RemoveObjectPropertyValue(p, i1, i2: IAEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.RemoveType(ind, c: IAEntity);
begin
  // TODO -oProf: Make
  // ...
end;

end.
