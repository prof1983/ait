{**
@Abstract(Job types)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AJobTypes;

interface

type
  TJobType = (
    AlwaysJobType,   // Работа, которую нужно выполнять всегда
    PeriodicJobType, // Работа, которую нужно выполнять постоянно с заданной периодичностью
    ManyJobType,     // Работа, которую нужно выполнить несколько раз
    OneJobType       // Работа, которую нужно выполнить один раз
    );

implementation

end.
