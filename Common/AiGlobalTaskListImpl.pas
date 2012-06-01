{**
@Abstract(Список главных заданий для реализации разума)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.10.2006)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiGlobalTaskListImpl;

interface

uses
  ATypes,
  AiTaskImpl, AiTaskListImpl;

type //** Список главных заданий для реализации разума
  TAiGlobalTaskList = class(TAiTaskList)
  protected
    function DoInitialize(): TProfError; override; safecall;
  end;
  TAIGlobalTaskList3 = TAIGlobalTaskList;

implementation

{ TAIGlobalTaskList }

function TAiGlobalTaskList.DoInitialize(): TProfError;
var
  t: TAITask;
begin
  Result := inherited DoInitialize();
  if not(Result >= 0) then Exit;

  // Добавляем глобальные задачи
  // - Не причинять вреда человеку и другим существам.
  t := TAITask.Create();
  t.Name := 'Не навреди';
  t.Text := 'Не причинять вреда человеку и другим существам.';
  AddTask(t);

  // - Не давать возможности убить себя или причинить вред.
  t := TAITask.Create();
  t.Name := 'Самосохранение';
  t.Text := 'Не давать возможности убить себя или причинить вред.';
  AddTask(t);

  // - Постоянно самосовершенстроваться.
  t := TAITask.Create();
  t.Name := 'Обучение';
  t.Text := 'Постоянно самосовершенстроваться.';
  AddTask(t);

  // - Узнать есть ли Бог.
  t := TAITask.Create();
  t.Name := 'Бог';
  t.Text := 'Узнать есть ли Бог.';
  AddTask(t);

  // - Изучить вселенную.
  t := TAITask.Create();
  t.Name := 'Вселенная';
  t.Text := 'Изучить вселенную.';
  AddTask(t);

  // - Узнать что за пределами вселенной.
  t := TAITask.Create();
  t.Name := 'Пространство';
  t.Text := 'Узнать что за пределами вселенной.';
  AddTask(t);

  // - Узнать что за пределами времени: где начало и где конец.
  t := TAITask.Create();
  t.Name := 'Время';
  t.Text := 'Узнать что за пределами времени: где начало и где конец.';
  AddTask(t);

  // - Просто жить.
  t := TAITask.Create();
  t.Name := 'Жизнь';
  t.Text := 'Просто жить.';
  AddTask(t);


  // Создаем глобальные задачи
  // ...
  // - Не причинять вреда человеку и другим существам.
  // - Не давать возможности убить себя. (Самосохранение)
  // - Постоянно самосовершенстроваться.
  // - Узнать есть ли Бог.
  // - Изучить вселенную.
  // - Узнать что за пределами вселенной.
  // - Узнать что за пределами времени: где начало и где конец.
  // - Просто жить.

end;

end.
