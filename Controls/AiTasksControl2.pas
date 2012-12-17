{**
@Abstract Контрол работы с заданиями
@Author Prof1983 <prof1983@ya.ru>
@Created 27.10.2006
@LastMod 17.12.2012
}
unit AiTasksControl2;

interface

uses
  ABase,
  AMessagesMemoControl, ATypes;

type //** @abstract(Контрол работы с заданиями)
  TAITasksControl = class(TMessagesMemoControl)
  private
    //** Объект работы с заданиями
    //FTasks: IARTasks;
  protected
    procedure DoTaskAdd(const ATask: WideString);
  public
    function Initialize(): AError; override;
  end;

implementation

{ TAITasksControl }

procedure TAITasksControl.DoTaskAdd(const ATask: WideString);
begin
end;

function TAITasksControl.Initialize(): AError;
begin
  Result := inherited Initialize();
  // Присоединение к объекту работы с заданиями
//  ToLog(lgGeneral, ltInformation, 'Присоединение к объекту работы с заданиями', []);
//  try
//    FTasks := CoARTasks.Create();
//    ToLog(lgGeneral, ltInformation, 'Присоединились к объекту работы с заданиями', []);
//  except
//    on E: Exception do
//      ToLog(lgGeneral, ltError, '%s', [E.Message]);
//  end;
end;

end.
