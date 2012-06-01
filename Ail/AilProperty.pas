{**
@Abstract(Ai lang property)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AilProperty;

interface

type
  TAilProperty = class
  public
    Name: WideString; // ID
    //SubPropertyOf: TAssistantObjectProperty;
    //Domain - сущность которой принадлежит это свойство
    //Range - Тип значений / Диапазон значений
  end;

type //** Свойство какого-то класса или индивида
  TAilObjectProperty = class(TAilProperty)
  public
    //Domain: TAssistantClass; // Класс которому принадлежит это свойство
    //Domain: TAssistantIndividual; // Индивид которому принадлежит это свойство
    //Range: TAssistantClass; // Диапазон значений
  end;

type
  TAilDatatypeProperty = class(TAilProperty)
  public
    //Domain: TAssistantClass; // Класс которому принадлежит это свойство
    //Domain: TAssistantIndividual; // Индивид которому принадлежит это свойство
    //Range: TAssistantDatatype; // Тип значений (Диапазон значений)
  end;

implementation

end.
