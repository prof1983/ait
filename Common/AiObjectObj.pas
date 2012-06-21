{**
@Abstract(Объект AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.09.2006)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AiObjectObj;

interface

uses
  AiNamedFrameObj;

type
  TAiObject = class(TAiNamedFrameObject)
  private
    FAuthor: WideString;
    FBuildVersion: Integer;
    FCopyright: WideString;
    //FDateCreate: TDateTime;
    FDateModify: TDateTime;
    FHomePage: WideString;
    FMajorVersion: Integer;
    FMinorVersion: Integer;
    FRevisionVersion: Integer;
  public
    property Author: WideString read FAuthor write FAuthor;
    property BuildVersion: Integer read FBuildVersion write FBuildVersion;
    property Copyright: WideString read FCopyright write FCopyright;
    //property DateCreate: TDateTime read FDateCreate write FDateCreate;
    property DateModify: TDateTime read FDateModify write FDateModify;
    property HomePage: WideString read FHomePage write FHomePage;
    property MajorVersion: Integer read FMajorVersion write FMajorVersion;
    property MinorVersion: Integer read FMinorVersion write FMinorVersion;
    property RevisionVersion: Integer read FRevisionVersion write FRevisionVersion;
  end;

implementation

end.
