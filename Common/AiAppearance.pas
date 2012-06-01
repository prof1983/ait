{**
@Abstract(Распознавание образов)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.03.2005)
@LastMod(27.03.2012)
@Version(0.5)

Appearance - Образ
}
unit AiAppearance;

interface

uses
  AiBaseObj; 

type
  // Образ, класс — классификационная группировка в системе классификации,
  // объединяющая (выделяющая) определенную группу объектов по некоторому
  // признаку. http://www.codenet.ru/progr/alg/ai/htm/gl3_1.php
  TAiAppearance = class(TAiFrame)
  private
    //FGroupList: TAI_ID; //Список групп, в которые входит данный образ
  end;

  // Группа объектов, объединенная по какому-то признаку
  TAiAppearanceGroup = class(TAiFrame)
  end;

  // Список групп
  TAiAppearanceGroupList = class //(TAIList)
  end;

  // Признак объекта, по которому оъекты объединяются в группы
  TAiAppearanceSign = class(TAiFrame)
  end;

implementation

end.
