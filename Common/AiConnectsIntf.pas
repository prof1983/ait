{**
@Abstract AiConnects interface
@Author Prof1983 <prof1983@ya.ru>
@Created 08.06.2012
@LastMod 23.11.2012
}
unit AiConnectsIntf;

interface

uses
  XmlIntf,
  ABase, AiBase;

type
  {** Интерфейс для работы со связями фрейма }
  IAiConnects = interface
      {** Получить Id связаного фрейма }
    function GetConnect(AIndex: Integer): TAId;
      {** Получить колличество связей }
    function GetCountConnects(): Integer;
      {** Получить Id фрейма-владельца }
    function GetFreimId(): TAId;
      {** Задать Id связанного фрейма }
    procedure SetConnect(AIndex: Integer; Value: TAId);
      {** Задать Id связанного фрейма }
    function SetConnectA(Index: Integer; Value: TAId): AError;
      {** Задать Id фрейма-владельца }
    procedure SetFreimId(Id: TAId);

      {** Добавить связь }
    function AddConnect(Connect: TAId): Integer;
      {** Очистить список связей }
    function Clear(): AError;
      {** Удалить связь по Id }
    function DeleteConnect(Id: TAId): AError;
      {** Удалить связь по индексу }
    function DeleteConnectByIndex(Index: Integer): AError;
      {** Получить индекс связи по Id }
    function GetConnectIndex(Id: TAId): Integer;
      {** Загрузить список связей из файла }
    function LoadFromFile(const FileName: WideString): AError;
      {** Загрузить список связей из XML }
    function LoadFromXml(const AXml: IXmlNode): WordBool;
      {** Сохранить список связей в файл }
    function SaveToFile(const FileName: WideString): WordBool;
      {** Сохранить список связей в XML }
    function SaveToXml(const AXml: IXmlNode): WordBool;

    property Connects[AIndex: Integer]: TAId read GetConnect write SetConnect;
    property FreimId: TAId read GetFreimId write SetFreimId;
  end;

implementation

end.
