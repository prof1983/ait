{**
@Abstract(Базовые константы и типы для ИР)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.03.2008)
@LastMod(09.06.2012)
@Version(0.5)
}
unit AiBase;

interface

uses
  ABase;

const
  AMajorVersion = 0;
  AMinorVersion = 0;
  AReleaseVersion = 5;
  AVersionStr = '0.0.5';

type
  {**
    Идентификатор. Глобальный тип для использования во всех модулях.
    Номер 0 может использоваться для хранения глобальных параметров AI системы.
    Номера от 0 до 1023 заререзвированы.
    Номер 1024 используется для хранения настроек AI программы.
    Номера от 1025 до 2047 используются для определения внутренних типов AI программы.
    Номера от 2028 до 65535 зарезервированы.
    Номера от 65535 до 2^31 используются свободно для локального приложения.
    Использование номеров от 2^32 до 2^63 выделяются сервером AI системы.
    Сущности с номерами от 2^32 хранятся на сервере
    (локальные копии могут хранится на локальном компьютере).
    Аналог:
      org.framerd.OID.OID
  }
  TAId = ABase.AId;
  // Идентификатор
  TAiId = AId;
  TAiId32 = AUInt32;

type
  AiPool = type AInt;
  AiSource1 = type AInt; // IAiSource1
  AiSource2 = type AInt; // IAiSource2
  AiSourceObject = type Integer; // TAiSourceObject
  // TODO: Delete
  AiSourceObject2005 = type Integer; // TAiSource2005
  AiSource2005 = AiSourceObject2005;
  AiSource20050819 = type Integer; // TAiSource20050819

const
  AOntologyEntityType = $10;

implementation

end.
 