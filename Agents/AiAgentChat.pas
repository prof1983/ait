{**
@Abstract(AI Агент чат-бот)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.09.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiAgentChat;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ALogNodeImpl, ALogNodeIntf, ATypes, AXmlNodeIntf,
  AiAgent, AiBase, AiBaseObj, AiGlobals, AiIntf, AiSelectObj, AiSourceObj, AiSourceAdoObj,
  aifChat;

type
  TAIAgentChat = class(TAIAgent)
  private
    //FAgentWord: TAIAgentWord;   // Агент. Выделяет ф-слова из ф-предложений.
    FAgentWordId: TAId;
    FForm: TFormChat;           // Форма ввода/вывода
    FFormCreated: Boolean;      // Форма создана при инициализации
    FModuleTextId: TAId;      // Модуль работы с текстом
    FProcess: TThread;
    FSource: TAiSource;
    FSourceCreated: Boolean;
    // Реакция на событие Form.EventNewText
    function FormNewText(Sender: TObject; Params: WideString): WordBool;
    procedure SetFormChat(Value: TFormChat);
  public
    function AssignedForm(): Boolean;
    constructor Create(AConfig: IXmlNode; ALog: ILogNode2; Source: TAISource = nil; Id: TAId = 0);
    function Finalize(): TProfError; override;
    property Form: TFormChat read FForm write SetFormChat;
    procedure Free(); override;
    function GetAgentWordId(): TAId;
    function GetForm(): TFormChat;
    function GetModuleTextId(): TAId;
    function Hide(): WordBool; override;
    function Initialize(): TProfError; override;
    //function Load(): Boolean; override;
    function Pause(): Boolean; override;
    function Run(): Boolean; override;
    function Save(): Boolean; //override;
    function Show(): WordBool; override;
    function Stop(): WordBool; override;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stNotAssignedForm = '"%s" Форма не задана';

implementation

{ TAIAgentChat }

function TAIAgentChat.AssignedForm: Boolean;
begin
  Result := Assigned(FForm);
  if not(Result) then
    AddToLog(lgGeneral, ltError, Format(stNotAssignedForm, [ClassName]));
end;

constructor TAIAgentChat.Create(AConfig: IXmlNode; ALog: ILogNode2; Source: TAISource = nil; Id: TAId = 0);
begin
  inherited Create(); //(AConfig, ALog, Source, Id);
  Self.Name := 'Chat';
  Self.Title := 'AgentChat';
end;

function TAIAgentChat.Finalize(): TProfError;
begin
  Result := inherited Finalize();

  if Assigned(FForm) and (FFormCreated) then
  begin
    FForm.ConfigureSave;
    FForm.Finalize;
    FreeAndNil(FForm);
  end;
  FFormCreated := False;
end;

function TAIAgentChat.FormNewText(Sender: TObject; Params: WideString): WordBool;
{var
  Text: WideString;
  Xml: TProfXmlNode;}
begin
  {AddToLog(lgGeneral, ltInformation, 'Произошло событие Form.EventNewText Params="%s"', [Params]);
  // Выделение параметра
  Xml := TProfXmlNode.Create;
  Xml.SetXmlA(Params);
  if not(Xml.ReadString('Text', Text)) then Text := '';
  FreeAndNil(Xml);

  // Добавление в БЗ
  if Text = '' then Exit;}
end;

procedure TAIAgentChat.Free;
begin
  FreeAndNil(FProcess);
  inherited Free;
end;

function TAIAgentChat.GetAgentWordId: TAId;
begin
  Result := FAgentWordId;
end;

function TAIAgentChat.GetForm: TFormChat;
begin
  if not(Assigned(FForm)) then
  begin
    FForm := TFormChat.Create({FFormMain});
  end;
  Result := FForm;
end;

function TAIAgentChat.GetModuleTextId: TAId;
begin
  Result := FModuleTextId;
end;

function TAIAgentChat.Hide(): WordBool;
begin
  Result := AssignedForm;
  if not(Result) then Exit;
  FForm.Hide;
end;

function TAIAgentChat.Initialize(): TProfError;
var
  ConfigForm: IProfXmlNode;
  ConfigSource: IProfXmlNode;
  Count: Int32;
  I: Int32;
  LogSource: TALogNode2;   // Log источника
  Name: WideString;      // Имя типа фреймов
  Select: TAI_Select;    // Выборка фреймов
begin
  Result := 0;
  if FInitialized then Exit;

  // Инициализация формы
  if not(Assigned(FForm)) then
  begin
    //if Assigned(Config) then ConfigForm := Config.GetNodeByName('Form') else ConfigForm := nil;
    FForm := TFormChat.Create({FFormMain});
    FForm.ConfigureLoad;
    FForm.Initialize;
    FFormCreated := True;
    FForm.EventNewText.Connect(FormNewText);
  end else FFormCreated := False;

  // Инициализация источника
  (* ---Уже инициализиравана ранее *)
  if not(Assigned(FSource)) then
  begin
    //if Assigned(Config) then ConfigSource := Config.GetNodeByName('Source') else ConfigSource := nil;
    //if Assigned(Log) then LogSource := Log.AddToLog2('Инициализация источника DB ADO') else LogSource := nil;
    FSource := TAISourceAdo.Create();
    TAISourceAdo(FSource).DBFileName := ExtractFilePath(Application.ExeName) + 'DB\ARAgentChat.mdb';
    //FSource.ConfigureLoad;
    //FSource.Initialize;
    //FSource.Log := Log;
    FSourceCreated := True;
  end else FSourceCreated := False;

  Result := inherited Initialize;

  // Проверка и регистрация необходимых типов фреймов
  AddToLog(lgGeneral, ltInformation, 'Проверка и регистрация необходимых типов фреймов');
  Select := nil; //FSource.Select(1);
  if not(Assigned(Select)) then Exit;
  Count := Select.Count;
  for I := 0 to Count - 1 do begin
    //if Select.Freims[I].Data.Xml.DocumentElement.ReadString('Name', Name) and (Name = 'String') then begin
    //end;
    {...}
  end;
  FreeAndNil(Select);
  AddToLog(lgGeneral, ltInformation, 'Проверка и регистрация необходимых типов фреймов выполнена');

  (*FAgentWordId := 0;
  FFormId := 0;
  FModuleTextId := 0;
  FProcess := TThreadAgentChat.Create(True);
  Title := 'AgentChat';
  if not(Assigned(Source)) then Exit;

  {Выделение идентификатора для типа и создание его}
  {if frAgentChat = 0 then begin
    frAgentChat := KB.FreimNew(1);
    Typ := TAIType(KB.FreimGet(frAgentChat));
    Typ.
  end;}
  {Выделение идентивикатора для объекта}*)
end;

(*function TAIAgentChat.Load: Boolean;
{var
  Data: TAI_Data;
  Stream: TProfStream;
  Xml: TProfXmlNode;}
begin
  (*Result := inherited Load;
  if not(Result) then Exit;
  Data := GetData;
  if not(Assigned(Data)) then Exit;
  if Data.GetType = dtStream then begin
    Stream := Data.GetStream;
    if not(Assigned(Stream)) then Exit;
    //Stream.ReadAIId(FAgentWordId);
    {Stream.ReadUInt64(FFormId);}
    //Stream.ReadAIId(FModuleTextId);
  end else begin
    Xml := Data.GetXml.DocumentElement;
    if not(Assigned(Xml)) then Exit;
    //Xml.ReadAIId('AgentWordId', FAgentWordId);
    {Xml.GetParamValueByNameAsUInt64('FormId', FFormId);}
    //Xml.ReadAIId('ModuleTextId', FModuleTextId);
  end;*
end;*)

function TAIAgentChat.Pause: Boolean;
begin
  Result := inherited Pause;
end;

function TAIAgentChat.Run: Boolean;
begin
  Result := inherited Run;
end;

function TAIAgentChat.Save: Boolean;
(*var
  Data: TAI_Data;
  Stream: TProfStream;
  Xml: TProfXmlNode;*)
begin
  (*Result := inherited Save;
  if not(Result) then Exit;
  Data := GetData;
  if Data.GetType = dtStream then begin
    Stream := Data.GetStream;
    if not(Assigned(Stream)) then Exit;
    Stream.WriteUInt64(FAgentWordId);
    {Stream.WriteUInt64(FFormId);}
    Stream.WriteUInt64(FModuleTextId);
  end else if Data.GetType = dtXml then begin
    Xml := Data.GetXml.DocumentElement;
    if not(Assigned(Xml)) then Exit;
    //Xml.ReadAIId('AgentWordId', FAgentWordId);
    {Xml.SetParamValueByNameAsUInt64('FormId', FFormId);}
    //Xml.ReadAIId('ModuleTextId', FModuleTextId);
  end;*)
end;

procedure TAIAgentChat.SetFormChat(Value: TFormChat);
begin
  // Удаление реакции на событие из предыдущей формы
  if Assigned(FForm) then begin
    FForm.EventNewText.Disconnect(FormNewText)
  end;

  // Задание новой формы
  FForm := Value;

  // Создание реакции на событие
  if Assigned(FForm) then begin
    FForm.EventNewText.Connect(FormNewText);
  end;
end;

function TAIAgentChat.Show(): WordBool;
begin
  Result := inherited Show();
  GetForm.Show;
end;

function TAIAgentChat.Stop(): WordBool;
begin
  Result := inherited Stop();
end;

end.
