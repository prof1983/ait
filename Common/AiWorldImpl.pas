{**
@Abstract(Внутренний мир агента. Содержит объекты, их текущие свойства)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.10.2006)
@LastMod(12.03.2012)
@Version(0.5)
}
unit AiWorldImpl;

interface

uses
  AiFrameImpl;

type //** Внутренний мир агента. Содержит объекты, их текущие свойства.
  TAIWorld = class(TAiFrame)
  private
    //FObjects: TARObjectList;
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
    //** Срабатывает при уничтожении
    procedure DoDestroy(); override; safecall;
  public
    //** Объекты AR
    //property Objects: TARObjectList read FObjects;
  end;
  TAIWorld3 = TAIWorld;

implementation

{ TAiWorld }

procedure TAIWorld.DoCreate();
begin
  inherited DoCreate();
  //FObjects := TARObjectList.Create();
end;

procedure TAIWorld.DoDestroy();
begin
//  try
//    FObjects.Free();
//  finally
//    FObjects := nil;
//  end;
  inherited DoDestroy();
end;

end.
