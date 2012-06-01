{**
@Abstract(AiInterpretator)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.06.2007)
@LastMod(25.04.2012)
@Version(0.5)
}
unit AiInterpretatorBaseTypes;

interface

type
  TAiValueType = (vtVoid);

type
  TProcMsg = function(Msg: WideString): Integer of object;

implementation

end.
