{**
@Abstract(Внутренний мир агента. Содержит объекты, их текущие свойства)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.10.2006)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AiWorld;

interface

uses
  AObjectImpl; {ArObjectList;}

type //** Внутренний мир агента. Содержит объекты, их текущие свойства.
  TArWorld = class(TProfObject2)
  private
    //FObjects: TARObjectList;
  protected
      // Срабатывает при создании
    procedure DoCreate(); override; safecall;
      // Срабатывает при уничтожении
    procedure DoDestroy(); override; safecall;
  public
      // Объекты
    //property Objects: TARObjectList read FObjects;
  end;

implementation

{ TArWorld }

procedure TArWorld.DoCreate();
begin
  inherited DoCreate();
  //FObjects := TARObjectList.Create();
end;

procedure TArWorld.DoDestroy();
begin
//  try
//    FObjects.Free();
//  finally
//    FObjects := nil;
//  end;
  inherited DoDestroy();
end;

end.
