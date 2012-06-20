{**
@Abstract(Сущность - базовый интерфейс для представления знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.05.2007)
@LastMod(20.06.2012)
@Version(0.5)

Эта сущность для хранения в ОЗУ в виде объекта.
Создается для использования. После использования удаляется.

Прототипы:
  ru.narod.profsoft.common.ProfEntity
  ru.narod.profsorf.ai.common.aiFrame
  aterm.ATerm
  aterm.ATermAppl
  org.framerd.FDType
  javax.swing.text.html.parser.Entity
  org.semanticweb.owl.model.OwlEntity

История версий:
0.0.2.1 - 04.07.2007
0.0.2.0 - 24.05.2007 - Полностью переделал из прототипа AiEntity
}
unit AiEntityIntf;

interface

uses
  ABase, AEntityIntf;

type
    //** Сущность - базовый интерфейс для представления знаний
  //IAiEntity = IAEntity;

    // Прототип: org.framed.OID
  IAIWSFrame = interface
    //ID: TAId;
    //Value: TAiEntity;
  end;

  // TODO: Use IAiCollection
  {**
    Список сущностей, интерфейс доступа к вложенным сущностям.
    Аналоги:
      aterm.ATermAppl.GetArgument()
      org.framerd.FDType.Enumerate
      org.framerd.FDType.Get()
      ru.narod.profsoft.ai.common.aiFrame.Slots
      java.util.Set
  }
  IAiEntities = interface
    {**
    Возвращает сущность по идентификатору.
    Если сущность является слотом (вложеной сущностью),
    то идентификатор можно не указывать.
    }
    function GetById(Id: AId): IAEntity;
    {**
    Возвращает сущность по индексу.
    Индекс сужности указывается от нуля до Count-1 по порядку.
    }
    function GetByIndex(Index: AInt): IAEntity;
    {**
    Возвращает сущность по имени.
    }
    function GetByName(const Name: WideString): IAEntity;
    {**
    Возвращает сущность по номеру.
    Номер вложеной сущности задается от 1 и
    увеличивается для каждой новой вложеной сущности.
    При удалении какой-либо сущности из списка присвоеные номера не меняются.
    Является локальным для коллекции идентификатором.
    }
//    function GetByNumber(Number: Integer): IAIWSEntity;
    //** Возвращает колличество сущностей
    function GetCount(): Integer;

    {**
    Добавить сущность (в списке может находится только один экземпляр)
    Если сущность уже присутствует в списке возвращает False,
    если добавлено успешно возвращает True.
    }
    function Add(Id: AId): Boolean; overload;
    {**
    Добавить сущность (в списке может находится только один экземпляр)
    Если сущность уже присутствует в списке возвращает False,
    если добавлено успешно возвращает True.
    }
    function Add(Entity: IAEntity): Boolean; overload;

    {** Удаляет сущность из списка }
    function Remove(Entity: IAEntity): ABoolean; overload;
    {** Удаляет сущность из списка }
    function RemoveById(Entity: AId): ABoolean; overload;

    {**
    Сущности по идентификатору
    Если сущность является слотом (вложеной сущностью),
    то идентификатор можно не указывать.
    }
    property ByID[ID: TAId]: IAEntity read GetByID;
    {**
    Сущности по индексу
    Индекс сужности указывается от нуля до Count-1 по порядку.
    }
    property ByIndex[Index: AInt]: IAEntity read GetByIndex;
    {**
    Сущности по имени
    }
    property ByName[const Name: WideString]: IAEntity read GetByName;
    {**
    Сущности по номеру
    Номер вложеной сущности задается от 1 и
    увеличивается для каждой новой вложеной сущности.
    При удалении какой-либо сущности из списка присвоеные номера не меняются.
    Является локальным для коллекции идентификатором.
    }
//    property ByNumber[Number: Integer]: IAIWSEntity read GetByNumber;
    //** Колличество сущностей
    property Count: Integer read GetCount;
  end;

  // TODO: IAIWSEntity -> IAIWSFrame
  //** @abstract(Сущность - базовый интерфейс для представления знаний)
  IAIWSEntity = interface(IANamedEntity)
    // Protected методы
    // ----------------

    {**
    Возвращает объект работы с вложеными сущностями
    }
    function GetEntities(): IAiEntities;

    // Properties
    // ----------

    {**
      Объект доступа к вложенным сущностям.
      Может отсутствовать.
      Аналоги:
        aterm.ATermAppl.GetArgument
        org.framerd.FDType.Enumerate
        org.framerd.FDType.Get
        ru.narod.profsoft.ai.common.aiFrame.Slots
    }
    property Entities: IAiEntities read GetEntities;
  end;

// -----------------------------------------------------------------------------

type
  //** @abstract(Сущность - базовый интерфейс для представления знаний с дополнительными функциями)
  IAIWSEntityEx = interface(IAIWSEntity)
    // Protected методы
    // ----------------

    {**
    Возвращает номер сущности.
    Номер задается только для вложеных сущностей.
    }
    function GetNumber(): Integer;

    // Public методы
    // -------------

    {**
      Добавить сущность к этой сущности.
      Возвращает True, если добавлено успешно.
    }
    function AddEntity(ID: TAId): WordBool; overload;
    {**
      Добавить сущность к этой сущности.
      Возвращает True, если добавлено успешно.
    }
    function AddEntity(Entity: IAIWSEntity): WordBool; overload;
    {**
      Создать новую сущность.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(): TAId; overload;
    {**
      Создать новую сущность с указанием имени сущности.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(Name: WideString): TAId; overload;
    {**
      Создать новую сущность с указанием типа сущности.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(AType: TAId): TAId; overload;
    {**
      Создать новую сущность с указанием имени и типа сущности.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(Name: WideString; AType: TAId): TAId; overload;
    {**
      Создать новую сущность.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(): IAIWSEntity; overload;
    {**
      Создать новую сущность с указанием имени сущности.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(Name: WideString): IAIWSEntity; overload;
    {**
      Создать новую сущность с указанием типа сущности.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(AType: TAId): IAIWSEntity; overload;
    {**
      Создать новую сущность с указанием имени и типа сущности.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(Name: WideString; AType: TAId): IAIWSEntity; overload;

    // Properties
    // ----------

    //** Номер сущности
    property Number: Integer read GetNumber;
  end;

implementation

end.
