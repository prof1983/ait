{**
@Abstract(Пул (источник) работы с OWL элементами)
@Author(Prof1983 prof183@ya.ru)
@Created(12.05.2006)
@LastMod(06.03.2012)
@Version(0.5)

Prototype: Pellet.KnowledgeBase

Реализует работу с OWL сущностями

История версий:
0.0.0.2 - 31.05.2007 - Переделал TAIWSID на TAIID
}
unit AiOwlPoolImpl;

interface

uses
  ABase,
  AiBase, AiBaseTypes, AiConsts, AiCollection, AiCollectionEntity, AiEntityIntf, AiLogingObject,
  AiOntologyIndividual, AiOwlClassIntf, AiOwlClassImpl, AiOwlPoolIntf, AiPoolIntf;

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
    FAnnotationPropertyTypeID: TAIID;
    FAntisymmetricPropertyTypeID: TAIID;
    // Идентификатор типа класс
    FClassTypeID: TAIID;
    FDatatypeTypeID: TAIID;
    FDatatypePropertyTypeID: TAIID;
    FDifferentTypeID: TAIID;
    FDisjointClassTypeID: TAIID;
    FDisjointPropertyTypeID: TAIID;
    FDomainTypeID: TAIID;
    FEquivalentPropertyTypeID: TAIID;
    FObjectPropertyTypeID: TAIID;
    FOntologyPropertyID: TAIID;
    FPropertyTypeID: TAIID;
    FPropertyValueTypeID: TAIID;
    FReflexivePropertyTypeID: TAIID;
  public
    function GetClasses: IAICollection;
  public //from org.mindswap.pellet.utils.ATermUtils
    // Проверяет тип сущности. Тип сущности должен быть ValueID
    function IsNominal(Entity: IAIEntity): Boolean;
    // Дедает проверку иерархии классов. (IsNormal)
    function IsOneOf(Entity: IAIEntity): Boolean;
  public
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
//    function AddIndividual(i: IAIEntity): IAIWSIndividual;
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
    function IsAnnotationProperty(p: TAIID): Boolean; overload;
    function IsAnnotationProperty(p: IAIEntity): Boolean; overload;
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
  public
    function NewAnnotationProperty(): IAIEntity;
    function NewAntisymmetricProperty(): IAIEntity;
    function NewClass(Name: WideString): IAIOwlClass;
    //procedure NewComplementClass(c1, c2: IAIEntity);
    //procedure NewDataPropertyValue(p, s, o: IAIEntity);
    //procedure NewDataRange(const DatatypeUri: WideString; Values: IAIEntityList);
    function NewDatatype: IAIEntity;
    //function AddDatatypeA(DataType: IPelletDatatype): WideString;
    //procedure AddDatatypeB(const DataTypeUrl: WideString; Datatype: IPelletDatatype);
    function NewDatatypeProperty: IAIEntity;
    //procedure NewDifferent(i1, i2: IAIEntity);
    //procedure NewDisjointClass(c1, c2: IAIEntity);
    //procedure NewDisjointClasses(classes: IAIEntityList);
    //procedure NewDisjointProperty(p1, p2: IAIEntity);
    //procedure NewDomain(p, c: IAIEntity);
    //procedure NewEquivalentProperty(p1, p2: IAIEntity);
    function NewFunctionalProperty: IAIEntity;
    function NewIndividual: IAIOntologyIndividual;
    function NewIndividual2(const Name: APascalString): IAIOntologyIndividual;
    function NewInverseFunctionalProperty: IAIEntity;
    //procedure NewInverseProperty(p1, p2: IAIEntity);
    function NewIrreflexiveProperty(): IAIEntity;
    //function NewNegatedPropertyValue(p, s, o: IAIEntity): Boolean;
    function NewObjectProperty(): IAIEntity;
    //procedure NewObjectPropertyValue(p, s, o: IAIEntity);
    function NewOntologyProperty(): IAIEntity;
    function NewProperty(Name: WideString): IAIEntity;
    //function NewPropertyValue(p, s, o: IAIEntity): Boolean;
    //procedure NewRange(p, c: IAIEntity);
    function NewReflexiveProperty(): IAIEntity;
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
    class function IsComplexClass(c: IAIEntity): Boolean;
  public // Идентификаторы основных объектов для работы с OWL
    // from org.mindswap.pellet.ABox
    //** Верхний индивид
    TopIndividualID: TAIID; //TOP_IND: IPelletIndividual;
    //** Нижний индивид
    BottomIndividualID: TAIID; //BOTTOM_IND: IPelletIndividual;
    DummyIndividualID: TAIID; //DUMMY_IND: IPelletIndividual;
  public
    procedure Close();
    //** Открыть
    function Open(): TAiError;
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

function TAIOwlPool.AddAnnotationProperty(p: IAIEntity): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
  //Result := Assigned(FRBox.AddAnnotationRole(p));

  //Result := Assigned(AddAnnotationRole(p));
end;

procedure TAIOwlPool.AddAntisymmetricProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddClass(c: IAIEntity);
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

procedure TAIOwlPool.AddComplementClass(c1, c2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDataPropertyValue(p, s, o: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDataRange(const DatatypeUri: WideString; Values: IAICollection);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDatatype(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddDatatypeProperty(p: IAIEntity): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDifferent(i1, i2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDisjointClass(c1, c2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDisjointClasses(classes: IAICollection);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDisjointProperty(p1, p2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddDomain(p, c: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddEquivalentProperty(p1, p2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddFunctionalProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddInverseFunctionalProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddInverseProperty(p1, p2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddIrreflexiveProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddNegatedPropertyValue(p, s, o: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddObjectProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddObjectPropertyValue(p, s, o: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddOntologyProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.AddProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...

//  Result := Assigned(FPool);
//  if not(Result) then Exit;
//  Result := FPool.AddEntity(p);
end;

function TAIOwlPool.AddPropertyValue(p, s, o: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddRange(p, c: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddReflexiveProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSame(i1, i2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSameClass(c1, c2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSameProperty(p1, p2: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSubClass(sub, sup: IAIEntity);
begin
  if sub = sup then Exit;
  {if IsOneOf(sub) then
  begin

  end;}

  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSubProperty(sub, sup: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddSymmetricProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddTransitiveProperty(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.AddType(i, c: IAIEntity);
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

function TAIOwlPool.GetClasses({Ontology: TAIID}): IAICollection;
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

function TAIOwlPool.HasDomain(p, c: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasInstance(d: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasKnownPropertyValue(s, p, o: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasPropertyValue(s, p, o: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.HasRange(p, c: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsABoxProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsAnnotationProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  if not(Assigned(p)) then Exit;
  Result := (p.EntityType = FAnnotationPropertyTypeID);
end;

function TAIOwlPool.IsAnnotationProperty(p: TAIID): Boolean;
begin
  Result := False;
  if not(Assigned(FPool)) then Exit;
  Result := (FPool.GetEntityValueType(p) = FAnnotationPropertyTypeID);
end;

function TAIOwlPool.IsAntisymmetricProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  if not(Assigned(p)) then Exit;
  Result := (p.EntityType = FAntisymmetricPropertyTypeID);
end;

function TAIOwlPool.IsClass(c: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsComplement(c1, c2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

class function TAIOwlPool.IsComplexClass(c: IAIEntity): Boolean;
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

function TAIOwlPool.IsDatatype(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDatatypeProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDifferentFrom(t1, t2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDisjoint(c1, c2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDisjointClass(c1, c2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsDisjointProperty(r1, r2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsEquivalentClass(c1, c2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsEquivalentProperty(p1, p2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsFunctionalProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsIndividual(ind: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsInverse(r1, r2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsInverseFunctionalProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsIrreflexiveProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsKnownType(x, c: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsNominal(Entity: IAIEntity): Boolean;
begin
  Result := (Entity.EntityType = FValueID);

	//public final static boolean isNominal(ATermAppl a)
  {
		return a.getAFun().equals(VALUEFUN);
	}
end;

function TAIOwlPool.IsObjectProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsOneOf(Entity: IAIEntity): Boolean;
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

function TAIOwlPool.IsOntologyProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsReflexiveProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSameAs(t1, t2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSatisfiable(c: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSubClassOf(c1, c2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSubPropertyOf(sub, sup: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSubTypeOf(d1, d2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsSymmetricProperty(p: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsTransitiveProperty(r: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.IsType(x, c: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.LoadDatatype(p: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewAnnotationProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewAntisymmetricProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewClass(Name: WideString): IAiOwlClass;
var
  id: TAIID;
  OwlClass: TAiOwlClass;
begin
  Result := nil;
  if not(Assigned(FPool)) then Exit;
  try
    id := FPool.NewEntity(FClassTypeID);
    OwlClass := TAiOwlClass.Create2(FPool, Id);
    OwlClass.Name := Name;
    Result := OwlClass;
  except
    Result := nil;
  end;
end;

function TAIOwlPool.NewDatatype(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewDatatypeProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewFunctionalProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewIndividual{(i: IAIEntity)}: IAIOntologyIndividual;
begin
  Result := nil;
  // ...
end;

function TAIOwlPool.NewIndividual2(const Name: APascalString): IAIOntologyIndividual;
begin
  Result := nil;
  // ...
end;

function TAIOwlPool.NewInverseFunctionalProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewIrreflexiveProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewObjectProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewOntologyProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.NewProperty(Name: WideString): IAIEntity;
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

function TAIOwlPool.NewReflexiveProperty(): IAIEntity;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.Open(): TAIError;
begin
  Result := FPool.Open();
  if Result < 0 then Exit;

  if FIsDebug then
    AddToLog('Создаем необходимые типы сущностей');

  //FPool.OnAddToLog := AddToLog;

  FAllID := FPool.NewEntity(AINullType);
  FAndID := FPool.NewEntity(AINullType);
  FCardID := FPool.NewEntity(AINullType);
  FInvID := FPool.NewEntity(AINullType);
  FNotID := FPool.NewEntity(AINullType);
  FMaxID := FPool.NewEntity(AINullType);
  FMinID := FPool.NewEntity(AINullType);
  FOrID := FPool.NewEntity(AINullType);
  FSameID := FPool.NewEntity(AINullType);
  FSelfID := FPool.NewEntity(AINullType);
  FSomeID := FPool.NewEntity(AINullType);
  FSubID := FPool.NewEntity(AINullType);
  FValueID := FPool.NewEntity(AINullType);

  FAnnotationPropertyTypeID := FPool.NewEntity(AINullType);
  FAntisymmetricPropertyTypeID := FPool.NewEntity(AINullType);
  FClassTypeID := FPool.NewEntity(AINullType);
  FDatatypeTypeID := FPool.NewEntity(AINullType);
  FDatatypePropertyTypeID := FPool.NewEntity(AINullType);
  FDifferentTypeID := FPool.NewEntity(AINullType);
  FDisjointClassTypeID := FPool.NewEntity(AINullType);
  FDisjointPropertyTypeID := FPool.NewEntity(AINullType);
  FDomainTypeID := FPool.NewEntity(AINullType);
  FEquivalentPropertyTypeID := FPool.NewEntity(AINullType);
  FObjectPropertyTypeID := FPool.NewEntity(AINullType);
  FOntologyPropertyID := FPool.NewEntity(AINullType);
  FPropertyTypeID := FPool.NewEntity(AINullType);
  FPropertyValueTypeID := FPool.NewEntity(AINullType);
  FReflexivePropertyTypeID := FPool.NewEntity(AINullType);
end;

procedure TAIOwlPool.RemoveIndividual(c: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIOwlPool.RemoveObjectPropertyValue(p, i1, i2: IAIEntity): Boolean;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIOwlPool.RemoveType(ind, c: IAIEntity);
begin
  // TODO -oProf: Make
  // ...
end;

end.
