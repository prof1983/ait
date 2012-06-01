{**
@Abstract(Интерпретатор кода на языке AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.10.2006)
@LastMod(27.04.2012)
@Version(0.5)

0.0.5.9 - 12.03.2012 - Объединил AiInterpretator2 и AiInterpretator4
}
unit AiInterpretatorImpl;

(*
Пример записи условия:
(для простого условия x > y)
<if condition="$x gt $y">
  <then>
    ...
  </then>
  <else>
    ...
  </else>
</if>
или
(для сложного условия)
<if>
  <condition>
    (System.Input($s) == "InputText")
  </condition>
  <then>
    ...
  </then>
  <else>
    ...
  </else>
</if>

Пример записи вызова метода:
<do method="System.Out" text="ExampleText" />
или
<System.Out text="ExampleText" />
или
{ System.Out(text="ExampleText"); }
*)
// -----------------------------------------------------------------------------
{
Типы [.NET]
  Типы-значения
    Встроеные типы-значения
      System.Boolean
      System.Char     - UTF-16
      System.Int8
      System.Int16
      System.Int32
      System.Int64
      System.IntPtr
      System.UInt8
      System.UInt16
      System.UInt32
      System.UInt64
      System.UIntPtr
      System.Float32
      System.Float64
      System.DateTime - Дата/время
      System.Decimal
      System.TimeSpan
      System.Guid
  Ссылочные типы
    Объектные типы (Object)
      System.Object
        System.Type
      System.String    - UTF-16
    Интерфейсные типы (Interface)
      System.INullableValue
    Указательные типы (Pointer)

  Перечисления
    System.Enum
  Исключительное событие
    System.Exception
  Событие
    System.Delegate
  Тип значения
    System.ValueType
  Массив
    System.Array

Объект может содержать:
- атрибуты
- методы (статические и экземпляра)
- свойства
- константы
- события

Объект System.Object содержит следующие методы:
- Equals - возвращает true, если два объекта равны.
- Finalize - вызывается при сборке мусора
- GetHashCode - возвращает хэш-код
- GetType - Возвращает метаданные типа данных. Статический метод класса Type.
- MemberwiseClone - клонирует видимую часть объекта
- ReferenceEquals - возвращает true, если обе объектные ссылки, переданые методу относятся к одному объекту.
- ToString - возвращает строку, которая представляет этот объект

Методы объекта System.String:
- Compare - производит сравнение с учетом и без учета регистра
- Concat - возвращает новую строку
- ToLower, ToUpper
- Format - Заменяет символы подстановки и возвращает строковое представление каждого объекта.
- IndexOf - возвращает индекс местоположения первого искомого символа или подстроки.
- Insert - возвращает новую строку
- Lenght - возвращает длину строки

Методы класса System.Type
- BaseType - возвращает объект типа Type базового типа
- FindInterface - Возвращает массив объектов типа Type, представляющих интерфейсные типы, которые поддурживаются данным типом.
- FindMembers - Возвращает массив объектов типа MemberInfo, представляющих интерфейсные типы, которые поддерживаются данным типом.
- AssemblyQualifiedName - Возвращает полное имя данного типа
- GetConstructors - Возвращает массив объектов типа ConstructorInfo, представляющих конструкторы данного типа
- GetMethods - Возвращает массив объектов типа MethodInfo, представляющие открытые методы данного типа
- GetNestedTypes - Возвращает массив объектов типа Type, представляющих вложенные типы данного типа
- IsAbstract - является абстрактным
- IsInterface - является интерфейсом
- InvokeMember - вызывает член данного типа
- IsPublic - является открытым
- IsSealed - является опечатаным
- IsValueType - является типом значения

Стандартные атрибуты:
- Obsolve - устаревший
- DllImport - импортировать из библиотеки .DLL
- ClsCompliant
- WebMethod
- Guid
- ProgID

Иерархия классов описания метаданных:
System.Object
  System.MemberInfo
    System.FieldInfo
      System.FieldBuilder
    System.MethodBase
      System.ConstructorInfo
        System.ConstructorBuilder
      System.MethodInfo
        System.MethodBuilder
    System.PropertyInfo
      System.PropertyBuilder
    System.Type
      System.EnumBuilder
      System.TypeBuilder
      System.TypeDelegator
}
// -----------------------------------------------------------------------------
{ Пример кода на языке ARL
<?arl version="0.1"?>
<arl>
  <namespace name="System">
    <class name="ValueType">
      <description>
        <about lang="ru">Базовый тип для любого элемента.</about>
      </description>
    </class>
    <class name="Boolean" type="ValueType" isValueType="true" />
    <class name="Int8" type="ValueType" isValueType="true" />
    <class name="Int16" type="ValueType" isValueType="true" />
    <class name="Int32" type="ValueType" isValueType="true" />
    <class name="Int64" type="ValueType" isValueType="true" />
    <class name="UInt8" type="ValueType" isValueType="true" />
    <class name="SByte" type="UInt8" />
    <class name="UInt16" type="ValueType" isValueType="true" />
    <class name="UInt32" type="ValueType" isValueType="true" />
    <class name="UInt64" type="ValueType" isValueType="true" />
    <class name="Float32" type="ValueType" isValueType="true" />
    <class name="Float64" type="ValueType" isValueType="true" />

    <class name="Object">
      <method name="Equals" description="возвращает true, если два объекта равны.">
        <params></params>
        <code></code>
      </method>
      <method name="Finalize" description="вызывается при сборке мусора">
        <params></params>
        <code></code>
      </method>
      <method name="GetHashCode" description="возвращает хэш-код">
        <params></params>
        <code></code>
      </method>
      <method name="GetType" description="Возвращает метаданные типа данных. Статический метод класса Type.">
        <params></params>
        <code></code>
      </method>
      <method name="MemberwiseClone" description="клонирует видимую часть объекта">
        <params></params>
        <code></code>
      </method>
      <method name="ReferenceEquals" description="возвращает true, если обе объектные ссылки, переданые методу относятся к одному объекту.">
        <params></params>
        <code></code>
      </method>
      <method name="ToString" description="возвращает строку, которая представляет этот объект">
        <params></params>
        <code></code>
      </method>
    </class>
    <class name="String" isSealed="true">
      <method name="Compare" description="производит сравнение с учетом и без учета регистра">
        <params></params>
        <code></code>
      </method>
      <method name="Concat" description="возвращает новую строку">
        <params></params>
        <code></code>
      </method>
      <method name="ToLower" />
      <method name="ToUpper" />
      <method name="Format" description="Заменяет символы подстановки и возвращает строковое представление каждого объекта.">
      </method>
      <method name="IndexOf" description="возвращает индекс местоположения первого искомого символа или подстроки.">
      </method>
      <method name="Insert" description="возвращает новую строку">
      </method>
      <method name="Lenght" description="возвращает длину строки">
      </method>
    </class>

    <class name="MemberInfo" type="Object">
    </class>
    <class name="FieldInfo" type="MemberInfo">
    </class>
    <class name="FieldBuilder" type="FieldInfo">
    </class>
    <class name="MethodBase" type="MemberInfo">
    </class>
    <class name="ConstructorInfo" type="MethodBase">
    </class>
    <class name="ConstructorBuilder" type="ConstructorInfo">
    </class>
    <class name="MethodInfo" type="MethodBase">
    </class>
    <class name="MethodBuilder" type="MethodInfo">
    </class>
    <class name="PropertyInfo" type="MemberInfo">
    </class>
    <class name="PropertyBuilder" type="PropertyInfo">
    </class>
    <class name="Type" type="MemberInfo">
    </class>
    <class name="EnumBuilder" type="Type">
    </class>
    <class name="TypeBuilder" type="Type">
    </class>
    <class name="TypeDelegator" type="Type">
    </class>
  </namespace>
  <namespace name="Org.AR">
    <class name="Agent" type="System.Object">
    </class>
  </namespace>
</arl>
}
// -----------------------------------------------------------------------------
{ Пример кода на языке ARL (версия 0.2):
<?arl version="0.2"?>
<arl>
  <Type Name="Agent" FullName="Org.AR.Agent" FullNameSP="Org_AR_Agent">
    <TypeSignature Language="ILAsm" Value=".class public serializable Agent extends System.Object"/>
    <TypeSignature Language="C#" Value="public class Agent : System.Object"/>
    <MemberOfLibrary>BCL</MemberOfLibrary>
    <AssemblyInfo>
      <AssemblyName>arcorlib</AssemblyName>
      <AssemblyPublicKey>[00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 ]</AssemblyPublicKey>
      <AssemblyVersion>0.0.x.x</AssemblyVersion>
      <AssemblyCulture>none</AssemblyCulture>
      <Attributes>
        <Attribute>
          <AttributeName>CLSCompliantAttribute(true)</AttributeName>
          <Excluded>0</Excluded>
        </Attribute>
      </Attributes>
    </AssemblyInfo>
    <Base>
      <BaseTypeName>System.Object</BaseTypeName>
    </Base>
    <Members>
      <Member MemberName=".ctor">
        <MemberSignature Language="ILAsm" Value="public rtspecialname specialname instance void .ctor()">
        <MemberSignature Language="C#" Value="public Agent();" />
        <MemberType>Constructor</MemberType>
        <ReturnValue />
        <Parameters />
        <Docs>
          <summary>
            <para>Constructs and initializes a new instance of the <see cref="T:Org.AR.Agent"/> class.</para>
          </summary>
          <remarks>
          </remarks>
        </Docs>
        <Excluded>0</Excluded>
      </Member>
      <Member MemberName=".ctor">
        <MemberSignature Language="ILAsm" Value="public rtspecialname specialname instance void .ctor(string message)">
        <MemberSignature Language="C#" Value="public Agent(string message);" />
        <MemberType>Constructor</MemberType>
        <ReturnValue />
        <Parameters>
          <Parameter Name="message" type="System.String" />
        </Parameters>
        <Docs>
          <summary>
            <para>Constructs and initializes a new instance of the <see cref="T:Org.AR.Agent"/> class.</para>
          </summary>
          <remarks>
          </remarks>
        </Docs>
        <Excluded>0</Excluded>
      </Member>
    </Members>
  </Type>
</arl>


<arl version="0.1">
  <code>
    <System.Out text="ExampleText" />
  </code>
</arl>
}

interface

uses
  Classes, SysUtils, Variants,
  ANodeIntf, ATypes,
  AiFrame, AiInterpretatorIntf, AiInterpretatorThread, AiObjectImpl;

type
  //** Тип нода
  TArlNodeType = Integer;
const
  ARL_NODE_TYPE_NONE     = $010000;
  ARL_NODE_TYPE_UNKNOWN  = $020000;
  ARL_NODE_TYPE_MEMBER   = $040000;
  ARL_NODE_TYPE_ELEMENT  = $080000; // Code Element
  ARL_NODE_TYPE_DESCRIPTION = $100000;
    //** Данные (ресурсный файл)
  ARL_NODE_TYPE_DATA     = $200000;
    //** Модуль (содержит в себе классы)
  ARL_NODE_TYPE_MODULE   = $400000;
    //** Сборка (содержит один или несколько модулей и файлов)
  ARL_NODE_TYPE_ASSEMBLY = $800000;
    //** Домен приложения (содержит одну или несколько версий сборок приложения)
  ARL_NODE_TYPE_DOMAIN   = $01000000; //ARL_NODE_TYPE_PROGRAMM (AppDomain [.NET])
    //** Процесс (содержит один или несколько доменов приложения)
  ARL_NODE_TYPE_PROCESS  = $02000000;
    //** Программа (содержит один или несколько процессов)
  ARL_NODE_TYPE_PROGRAMM = $03000000;
const
  STR_NODE_TYPE_NONE     = $010000;
  STR_NODE_TYPE_UNKNOWN  = $020000;
  STR_NODE_TYPE_MEMBER   = $040000;
  STR_NODE_TYPE_ELEMENT  = $080000; // Code Element
  STR_NODE_TYPE_DESCRIPTION = $100000;
  STR_NODE_TYPE_DATA     = $200000;
  STR_NODE_TYPE_MODULE   = $400000;
  STR_NODE_TYPE_ASSEMBLY = '';
  STR_NODE_TYPE_DOMAIN   = 'domain'; //ARL_NODE_TYPE_PROGRAMM
  STR_NODE_TYPE_PROCESS  = 'process';

type
  //** Тип кода
  TArlCodeType = Integer;
const
  //** Нет кода
  ARL_CODE_TYPE_NONE    = $01;
  //** Не известно
  ARL_CODE_TYPE_UNCNOWN = $02;
  //** Несколько действий { ... }
  ARL_CODE_TYPE_LIST    = $10;
  //** Выполнить любой из элементов
  ARL_CODE_TYPE_LIST_ANY     = $11;
  //** Выполнить обязательно все элементы по порядку
  ARL_CODE_TYPE_LIST_ALL_OL  = $12;
  //** Выполнить обязательно все элементы в произвольном порядке
  ARL_CODE_TYPE_LIST_ALL_UL  = $14;
  //** Выполнить действие (выполнить метод)
  ARL_CODE_TYPE_DO      = $20;
  //** Условие if-then-else
  ARL_CODE_TYPE_IF      = $30;
  //** Цикл for
  ARL_CODE_TYPE_FOR     = $40;
  //** Цикл while-do
  ARL_CODE_TYPE_WHILE   = $50;
  //** Цикл repeat-until
  ARL_CODE_TYPE_REPEAT  = $60;

type
  TArlMemberType = Integer;
const
  ARL_MEMBER_NONE      = $01;
  ARL_MEMBER_UNKNOWN   = $02;
  ARL_MEMBER_CLASS     = $03; // private классы не описываются
  ARL_MEMBER_METHOD    = $04; // private методы не описываются
  ARL_MEMBER_PROPERTY  = $05;
  ARL_MEMBER_FIELD     = $06; // Поле (для описания protected полей. public полей не допоскается. private поля не описываются)
  ARL_MEMBER_EVENT     = $07; // Delegate?
  ARL_MEMBER_OBJECT    = $08;
  ARL_MEMBER_INTERFACE = $09;
  //ARL_MEMBER_ATTRIBUTE = ARL_MEMBER_OBJECT
{const
  ARL_MEMBER_INFO          = $0101;
  ARL_MEMBER_INFO_UNKNOWN  = $0102;
  ARL_MEMBER_TYPE          = $0104;
  ARL_MEMBER_METHOD_INFO   = $0108;
  ARL_MEMBER_PROPERTY_INFO = $0110;
  ARL_MEMBER_EVENT_INFO    = $0120;}
const
  STR_MEMBER_CLASS     = 'Class';
  STR_MEMBER_METHOD    = 'Method';
  STR_MEMBER_PROPERTY  = 'Property';
  STR_MEMBER_EVENT     = 'Event'; // Delegate?
  STR_MEMBER_OBJECT    = 'Object';
  STR_MEMBER_INTERFACE = 'Interface';

type
  {**
    Уникальный идентификатор сущности (любого элемента)
    - artp://knowlegebase.ar.org/123456 - URI фрейма ID=123456 в БЗ knowlegebase.ar.org, протокол ARTP
    http://knowlegebase.ar.org/123456.xml - URI фрейма ID=123456 в БЗ knowlegebase.ar.org, протокол HTTP, формат XML
    http://knowlegebase.ar.org/ar/core/agent.xml - URI объекта ar.core.agent, формат XML
    ./ObjectName - URI объекта
    ./ObjectName/MethodName - URI метода
    ./ObjectName/SubObject1Name/SubObject2/PropertyName - URI свойства
  }
  TArlUri = WideString;

// =============================================================================

type
  IArlNode = interface
    //Attributes: IArlAttributes; //IArlNodeList;
    //ChieldNodes: IArlNodes; //IArlNodeList;
    //NodeName: WideString;
  end;

type
  TArlNode = class(TInterfacedObject, IArlNode)
  end;

// =============================================================================

type
  IArlDescription = interface(IArlNode)
    //Author
    //Copyrigth
    //Summer
    //Resume
  end;

// =============================================================================

type
  IArlEntityID = interface(IArlNode)
    function GetReferenceID(): IArlEntityID; safecall;
    function GetUri(): TArlUri; safecall;
    procedure SetReferenceID(Value: IArlEntityID); safecall;
    procedure SetUri(const Value: WideString); safecall;

    //property Description: IArlDescription;
    //** URI объекта (web ресурс или ссылка на БЗ)
    property Uri: TArlUri read GetUri write SetUri;
    //** ID аналогичного объекта в другой БЗ (используется, если объект не найден)
    property ReferenceID: IArlEntityID read GetReferenceID write SetReferenceID;
  end;

//type
//  IArlLocalEntityID = interface(IArlEntityID)
//    //** Имя объекта (локальное имя объекта)
//    //property Name: WideString;
//    //** ID объекта в локальной БЗ
//    //property Source_ID: Int64;
//  end;

type
  IArlMethodID = interface(IArlEntityID)
    //** Имя метода
    //property MethodName: WideString;
    //** ID объекта
    //property ObjectID: IArlEntityID;
  end;

{type
  IArlObjectID = interface(IArlID) //(IArlEntity)
        //** Источник знаний
        //property Source_Uri: WideString;
  end;}

// =============================================================================

type
  IArlEntity = interface(IArlNode)
    //** Получить идентификатор сущности (объекта)
    function GetEntityID(): IArlEntityID; safecall;
    //** Получить локальный идентификатор сущности (объекта)
    function GetLocalID(): Int64; safecall;
    //** Задать идентификатор сущности (объекта)
    procedure SetEntityID(Value: IArlEntityID); safecall;
    //** Задать локальный идентификатор сущности (объекта)
    procedure SetLocalID(Value: Int64); safecall;
  end;

type
  //** Сущность (объект)
  TArlEntity = class(TArlNode, IArlEntity)
  private
    //** Идентификатор сущности (объекта)
    FEntityID: IArlEntityID;
    //** Локальный идентификатор сущности (объекта)
    FLocalID: Int64;
  protected
    //** Получить идентификатор сущности (объекта)
    function GetEntityID(): IArlEntityID; safecall;
    //** Получить локальный идентификатор сущности (объекта)
    function GetLocalID(): Int64; safecall;
    //** Задать идентификатор сущности (объекта)
    procedure SetEntityID(Value: IArlEntityID); safecall;
    //** Задать локальный идентификатор сущности (объекта)
    procedure SetLocalID(Value: Int64); safecall;
  public
    //property Description: IArlDescription;
    //** Идентификатор сущности (объекта)
    property EntityID: IArlEntityID read FEntityID write FEntityID;
    //** Локальный идентификатор сущности (объекта)
    property LocalID: Int64 read FLocalID;
  end;

// -----------------------------------------------------------------------------

type
  //** Именованая сущность
  IArlNamedEntity = interface(IArlEntity)
    function GetName(): WideString; safecall;
    procedure SetName(const Value: WideString); safecall;
  end;

type
  //** Именованая сущность
  TArlNamedEntity = class(TArlEntity, IArlNamedEntity)
  private
    FName: WideString;
  protected
    function GetName(): WideString; safecall;
    procedure SetName(const Value: WideString); safecall;
  public
    property Name: WideString read FName;
  end;

// =============================================================================

type
  //** Параметр метода
  IArlParam = interface(IArlEntity)
    //** Значение параметра
    //Value: OleVariant;
//  private
//    FName: WideString;
//  protected
//    function GetName(): WideString; safecall;
//    procedure SetName(const Value: WideString); safecall;
//  public
//    property Name: WideString read FName;
  end;

type
  //** Параметры метода
  IArlParams = interface(IArlEntity)
    function GetParamByID(ID: Int64): IArlParam; safecall;
    function GetParamByIndex(Index: Integer): IArlParam; safecall;
    function GetParamByName(const Name: WideString): IArlParam; safecall;
    function GetParamCount(): Integer; safecall;
  end;

// =============================================================================

type
  {**
    @abstract(Элемент выполняемого кода)
    В зависимости от параметра CodeType может:
    1) вызывать метод определенного объекта
    2) являться структурой выполнения нескольких команд
  }
  IArlElement = interface(IArlEntity)
    //function GetCodeType(): TArlCodeType; safecall;
    //procedure SetCodeType(Value: TArlCodeType); safecall;
  end;

type
  IArlElements = interface(IArlEntity)
    function GetElementByIndex(Index: Integer): IArlElement; safecall;
    function GetElementCount(): Integer; safecall;
  end;

// -----------------------------------------------------------------------------

type
  IArlDo = interface(IArlElement)
    function GetLocalMethodID(): Int64; safecall;
    function GetMethodID(): IArlEntityID; safecall;
    function GetParams(): IArlParams; safecall;
    procedure SetLocalMethodID(Value: Int64); safecall;
    procedure SetMethodID(Value: IArlEntityID); safecall;
    procedure SetParams(Value: IArlParams); safecall;

        //** Идентификатор объекта метод которого нужно выполнить
        //ObjectID: IArlObjectID
    //** Идентификатор метода который нужно выполнить
    property MethodID: IArlEntityID read GetMethodID write SetMethodID; // IArlMethodID;
    //** Локальный идентификатор метода который нужно выполнить (указывается во время выполнения)
    property LocalMethodID: Int64 read GetLocalMethodID write SetLocalMethodID;
    //** Параметры для метода
    property Params: IArlParams read GetParams write SetParams;
  end;

type
  IArlIf = interface(IArlElement)
    //Condition
    //ThenCode
    //ElseCode
  end;

type
  IArlList = interface(IArlElement)
    //** Элементы выполняемого кода
    //property Elements: IArlElements read FArlElements;
  end;

type
  IArlRepeat = interface(IArlElement)
    //Condition
    //DoCode
  end;

type
  IArlWhile = interface(IArlElement)
    //Condition
    //DoCode
  end;

// -----------------------------------------------------------------------------

type
  //** Выполняемый код
  IArlCode = interface(IArlEntity)
    //function GetCodeType(): TArlCodeType; safecall;
    //procedure SetCodeType(Value: TArlCodeType); safecall;
  end;

type
  //** Выполняемый код
  TArlCode = class(TArlEntity, IArlCode)
  private
    FCodeType: TArlCodeType;
  protected
  public
    //** Тип кода
    property CodeType: TArlCodeType read FCodeType;
    //** Элементы выполняемого кода
    //property Elements: IArlElements read FArlElements;
  end;

// =============================================================================

type
  //** Именованая сущность
  IArlMember = interface(IArlNamedEntity)
    function GetName(): WideString; safecall;
    procedure SetName(const Value: WideString); safecall;
  end;

type
  //** Именованая сущность
  TArlMember = class(TArlNamedEntity, IArlMember)
  private
//    FName: WideString;
  protected
//    function GetName(): WideString; safecall;
//    procedure SetName(const Value: WideString); safecall;
  public
    //property MemberType;
//    property Name: WideString read FName;
  end;

// -----------------------------------------------------------------------------

type
  IArlMembers = interface(IArlEntity)
    //function GetMemberByID(ID: Integer): IArlMember; safecall;
    //function GetMemberByIndex(Index: Integer): IArlMember; safecall;
    //function GetMemberByName(const Name: WideString): IArlMember; safecall;
  end;

type
  TArlMembers = class(TArlEntity, IArlMembers)
  end;

// =============================================================================

type
  //** Свойство объекта
  IArlProperty = interface(IArlMember)
  end;

type
  //** Свойства объекта
  IArlProperties = interface(IArlMembers)
  end;

// =============================================================================

type
  //** Метод объекта
  IArlMethod = interface(IArlMember)
    //** Выполняемый код
    //property Code: IArlCode read GetCode;
  end;

type
  //** Методы объекта
  IArlMethods = interface(IArlMembers)
    function GetMethodByID(ID: Int64): IArlMethod; safecall;
    function GetMethodByIndex(Index: Integer): IArlMethod; safecall;
    function GetMethodByName(const Name: WideString): IArlMethod; safecall;
  end;

// =============================================================================

type
  //** Класс окружения
  IArlClass = interface(IArlMember)
  end;

type
  //** Класс окружения
  TArlClass = class(TArlMember, IArlClass)
  private
    //** Методы
    //FMethods: IArlMethods;
    //** Свойства
    //FProperties: IArlProperties;
    //** Родительский класс
    //FSuper: IArlClass;
  end;

// -----------------------------------------------------------------------------

type
  //** Классы окружения
  IArlClasses = interface(IArlMembers)
    //function GetClassByID(ID: Integer): IArlClass;
    //function GetClassByIndex(Index: Integer): IArlClass;
    //function GetClassByName(const Name: WideString): IArlClass;
  end;

type
  //** Классы окружения
  TArlClasses = class(TArlMembers, IArlClasses)
  private
    //FClasses: array of IArlClass;
  end;

// =============================================================================

{type
  IArlObject = IArlClass;
  IArlObjects = IArlClasses;}

type
  //** Объект окружения
  IArlObject = interface(IArlMember)
  end;

type
  //** Объект окружения
  TArlObject = class(TArlMember, IArlObject)
  private
    //** Методы
    //FMethods: IArlMethods;
    //** Свойства
    //FProperties: IArlProperties;
    //** Родительский класс
    //FSuper: IArlClass; // SubObjectOf
  end;

// -----------------------------------------------------------------------------

type
  //** Объекты окружения
  IArlObjects = interface(IArlMembers)
    //function GetObjectByID(ID: Integer): IArlObject; safecall;
    //function GetObjectByIndex(Index: Integer): IArlObject; safecall;
    //function GetObjectByName(const Name: WideString): IArlObject; safecall;
  end;

type
  //** Объекты окружения
  TArlObjects = class(TArlMembers, IArlObjects)
  private
    //FObjects: array of IArlObject;
  end;

// =============================================================================

type
  //** Окружение
  IArlEnviroment = interface(IArlEntity)
  end;

type
  //** Окружение
  TArlEnviroment = class(TArlEntity, IArlEnviroment)
  private
    ////** Классы окружения
    ////FClasses: IArlClasses;
    //** Объекты окружения
    //FObjects: IArlObjects;
    //** Члены окружения (классы и объекты)
    FMembers: IArlMembers;
  public
    //** Объекты окружения
    //property Objects: IArlObjects read FObjects write FObjects;
    //** Члены окружения (классы и объекты)
    property Members: IArlMembers read FMembers write FMembers;
  end;

// -----------------------------------------------------------------------------

{
type
  //** Выполняемый код
  IArlCode = interface(IArlEntity)
    function GetEnviroment(): IArlEnviroment; safecall;
    procedure SetEnviroment(Value: IArlEnviroment); safecall;
  end;

type
  //** Выполняемый код
  TArlCode = class(TArlEntity, IArlCode)
  private
    //** Окружение
    FEnviroment: IArlEnviroment;
  protected
    function GetEnviroment(): IArlEnviroment; safecall;
    procedure SetEnviroment(Value: IArlEnviroment); safecall;
  public
    //** Окружение
    property Enviroment: IArlEnviroment read FEnviroment write FEnviroment;
  end;
}

// =============================================================================

type // Интерпретатор кода на языке AR
  TAIInterpretator = class(TAIObject, IAIInterpretator)
  private
    FThread: TInterpretatorThread;
    function GetCode(): TStrings;
    procedure SetCode(Value: TStrings);
  protected
    procedure DoCreate(); override; safecall;
    procedure DoDestroy(); override; safecall;
  public
    property Code: TStrings read GetCode write SetCode;
    function Run(): Integer; safecall;
    function RunCode(ACode: IProfNode): Integer; virtual; safecall;
    function Start(): WordBool; virtual; safecall;
    function Stop(): WordBool; virtual; safecall;
  end;

const
  INT_RUN_OK     = 0;
  INT_RUN_NOCODE = -1;

type
  //** @abstract(Интерпретатор кода на языке AR)
  TAIInterpretator3 = class(TAIObject, IAiInterpretator)
  private
    //** Подпроцесс выполнения кода
    FThread: TInterpretatorThread3;
    function GetCode(): IArlCode;
    procedure SetCode(Value: IArlCode);
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
    //** Срабатывает при уничтожении
    procedure DoDestroy(); override; safecall;
  public
    //function Run(): Integer; safecall;
    //** Выполнить код
    function RunCode(ACode: IProfNode): Integer; virtual; safecall;
    //** Выполнить код
    function RunCodeA(ACode: IArlCode): Integer; virtual; safecall;
    //** Старт
    function Start(): WordBool; virtual; safecall;
    //** Стоп
    function Stop(): WordBool; virtual; safecall;
  public
    //** Выполняемый код
    property Code: IArlCode read GetCode write SetCode;
  end;

const
  ERR_RUN_OK     = 0;
  ERR_RUN_NOCODE = -1;

implementation

{ TAIInterpretator }

procedure TAIInterpretator.DoCreate();
begin
  inherited DoCreate();
  // ...
  FThread := TInterpretatorThread.Create();
  FThread.OnAddToLog := AddToLog;
end;

procedure TAIInterpretator.DoDestroy();
begin
  if Assigned(FThread) then
  try
    FThread.Stop();
    //FThread.Free();
    FThread := nil;
  except
    FThread := nil;
  end;
  // ...
  inherited DoDestroy();
end;

function TAIInterpretator.GetCode(): TStrings;
begin
  Result := nil;
//  if Assigned(FThread) then
//    Result := FThread.Code.Lines;
end;

function TAIInterpretator.Run(): Integer;
begin
  Result := 0;
//  if Assigned(FThread) then
//    Result := FThread.Run();
end;

function TAIInterpretator.RunCode(ACode: IProfNode): Integer;
var
  i: Integer;
begin
  Result := INT_RUN_NOCODE;
  if not(Assigned(ACode)) then Exit;
  for i := 0 to ACode.ChildNodes.Count - 1 do
    if ACode.ChildNodes.NodeByIndex[i].Name = 'write' then
      AddToLog(lgAgent, ltNone, ''{ACode.ChildNodes.NodeByIndex[i].AsString});
  Result := INT_RUN_OK;
end;

procedure TAIInterpretator.SetCode(Value: TStrings);
begin
//  if Assigned(FThread) then
//  begin
//    FThread.Code.Clear();
//    FThread.Code.Lines.AddStrings(Value);
//  end;
end;

function TAIInterpretator.Start(): WordBool;
//var
//  fm: TfmDialogMemo;
begin
//  Result := inherited Start();
//  if Assigned(FThread) then
//    FThread.Start();
//  // ...
//  fm := TfmDialogMemo.Create(nil);
//  fm.Show();
//  fm.AddMsg('Hello World!');
end;

function TAIInterpretator.Stop(): WordBool;
begin
  Result := True; //inherited Stop();
  if Assigned(FThread) then
    FThread.Stop();
  // ...
end;

{ TAIInterpretator3 }

procedure TAIInterpretator3.DoCreate();
begin
  inherited DoCreate();
  // ...
  FThread := TInterpretatorThread3.Create();
  FThread.OnAddToLog := AddToLog;
end;

procedure TAIInterpretator3.DoDestroy();
begin
  if Assigned(FThread) then
  try
    FThread.Stop();
    //FThread.Free();
    FThread := nil;
  except
    FThread := nil;
  end;
  // ...
  inherited DoDestroy();
end;

function TAIInterpretator3.GetCode(): IArlCode{IAICode};
begin
  Result := nil;
  // ...
end;

{function TAIInterpretator.Run(): Integer;
begin
  Result := 0;
//  if Assigned(FThread) then
//    Result := FThread.Run();
end;}

function TAIInterpretator3.RunCode(ACode: IProfNode): Integer;
var
  i: Integer;
begin
  Result := ERR_RUN_NOCODE;
  if not(Assigned(ACode)) then Exit;
  for i := 0 to ACode.ChildNodes.NodeCount - 1 do
    if ACode.ChildNodes.NodeByIndex[i].Name = 'write' then
      AddToLog(lgAgent, ltNone, ''{ACode.ChildNodes.NodeByIndex[i].AsString});
  Result := ERR_RUN_OK;
end;

function TAIInterpretator3.RunCodeA(ACode: IArlCode): Integer;
begin
  Result := ERR_RUN_NOCODE;
  // ...
end;

procedure TAIInterpretator3.SetCode(Value: IArlCode);
begin
  // ...
end;

function TAIInterpretator3.Start(): WordBool;
//var
//  fm: TfmDialogMemo;
begin
//  Result := inherited Start();
//  if Assigned(FThread) then
//    FThread.Start();
//  // ...
//  fm := TfmDialogMemo.Create(nil);
//  fm.Show();
//  fm.AddMsg('Hello World!');
end;

function TAIInterpretator3.Stop(): WordBool;
begin
  Result := True; //inherited Stop();
  if Assigned(FThread) then
    FThread.Stop();
  // ...
end;

{ TArlCode }

{function TArlCode.GetEnviroment(): IArlEnviroment;
begin
  Result := FEnviroment;
end;

procedure TArlCode.SetEnviroment(Value: IArlEnviroment);
begin
  FEnviroment := Value;
end;}

{ TArlEntity }

function TArlEntity.GetEntityID(): IArlEntityID;
begin
  Result := FEntityID;
end;

function TArlEntity.GetLocalID(): Int64;
begin
  Result := FLocalID;
end;

procedure TArlEntity.SetEntityID(Value: IArlEntityID);
begin
  FEntityID := Value;
end;

procedure TArlEntity.SetLocalID(Value: Int64);
begin
  FLocalID := Value;
end;

{ TArlNamedEntity }

function TArlNamedEntity.GetName(): WideString;
begin
  Result := FName;
end;

procedure TArlNamedEntity.SetName(const Value: WideString);
begin
  FName := Value;
end;

end.
