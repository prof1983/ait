{**
@Abstract(Решение заданий)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.03.2006)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AiTaskImpl;

interface

uses
  SysUtils, XmlIntf,
  AiBaseTypes, AiListImpl, AiNamedFrameImpl;

type //** Задание
  TAITask = class(TAINamedFrame)
  private
    FDTStart: TDateTime;
    FDTEnd: TDateTime;
    //FMethods: TAIMethods;
    FName: WideString;
      //** Приоритет
    FPriority: Integer;
    FText: WideString;
    FTimeImplementation: UInt64;
  protected
    function GetDateTimeEnd: TDateTime;
    function GetDateTimeStart: TDateTime;
    //function GetMethods: TAIMethods;
    function GetPriority: Integer;
    function GetText: String;
    function GetTimeImplementation: UInt64;
      //** Перевести в вид XML
    function GetXml: WideString; override;
  public
    //function Initialize: WordBool; override;
    function LoadFromXml(Xml: IXmlNode): WordBool; //override;
      //** Сохранить изменения в БЗ
    function Save(): TAIError; override; safecall;
  public
      //** Дата окончания
    property DateTimeEnd: TDateTime read FDTEnd write FDTEnd;
      //** Дата начала
    property DateTimeStart: TDateTime read FDTStart write FDTStart;
      //** Текст задания
    property Text: WideString read FText write FText;
      //** Время на выполнение в мс
    property TimeImplementation: UInt64 read FTimeImplementation write FTimeImplementation;
  end;

type //** Для TAITasksTree
  TAITaskNode = class(TAITask)
  private
      //** Родительская задача - задача для выполнения которой требуется выполнить данную
    FParentTask: TAITaskNode;
  public
    function GetParentTask: TAITaskNode;
    procedure SetParentTask(Value: TAITaskNode);
  end;

implementation

// TODO: Use ABaseUtils3.pas
function Tag(Name, Value: WideString): WideString;
begin
  Result := '<'+Name+'>'+Value+'</'+Name+'>';
end;

{ TAITask3 }

function TAITask.GetDateTimeEnd(): TDateTime;
begin
  Result := FDTEnd;
end;

function TAITask.GetDateTimeStart(): TDateTime;
begin
  Result := FDTStart;
end;

{function TAITask.GetMethods: TAIMethods;
begin
  Result := FMethods;
end;}

function TAITask.GetPriority(): Integer;
begin
  Result := FPriority;
end;

function TAITask.GetText(): String;
begin
  Result := FText;
end;

function TAITask.GetTimeImplementation(): UInt64;
begin
  Result := FTimeImplementation;
end;

function TAITask.GetXml(): WideString;
begin
  Result := Tag('Name', FName)
    + Tag('Title', Title)
    + Tag('Description', Description)
    + Tag('DateTimeStart', FormatDateTime('dd.mm.yyyy hh.nn.ss', FDTStart))
    + Tag('DateTimeEnd', FormatDateTime('dd.mm.yyyy hh.nn.ss', FDTEnd))
end;

{function TAITask.Initialize: WordBool;
var
  Source: TAISource;
begin
  Result := inherited Initialize;
  if not(Assigned(FMethods)) then begin
    Source := TAISource(GetSource);
    FMethods := TAIMethods.Create(nil, nil, Source, 0);
    if Assigned(Source) then
      //Source.NewFreim(FMethods);
      Source.NewFreim(0);
  end;
  FMethods.Initialize;
end;}

function TAITask.LoadFromXml(Xml: IXmlNode): WordBool;
begin
  Result := False;
//  Result := inherited LoadFromXml(Xml);
//  TProfXmlNode.ReadDateTimeA(Xml, 'DateTimeEnd', FDTEnd);
//  TProfXmlNode.ReadDateTimeA(Xml, 'DateTimeStart', FDTStart);
  // FMethods
  // ...
end;

function TAITask.Save(): TAIError;
begin
  Result := inherited Save();
end;

{ TAITaskNode }

function TAITaskNode.GetParentTask(): TAITaskNode;
begin
  Result := FParentTask;
end;

procedure TAITaskNode.SetParentTask(Value: TAITaskNode);
begin
  FParentTask := Value;
end;

end.
