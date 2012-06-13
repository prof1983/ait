{**
@Abstract(Терм - Интерфейс для класса базы знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.04.2007)
@LastMod(13.06.2012)
@Version(0.5)
}
unit AiTermIntf;

interface

uses
  AiBaseTypes, AiFrameIntf;

type // Интерфейс описания терма
  IAiTerm = interface(IAiFrame)
    //function Get_Connects(): IAIConnects; safecall;
    // Связи с другими фреймами
    //property Connects: IAIConnects read Get_Connects;

    function GetVersion(): TAiVersion; safecall;
    procedure SetVersion(Value: TAiVersion); safecall;

    property Version: TAiVersion read GetVersion write SetVersion;
  end;

implementation

end.
