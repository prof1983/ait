{**
@Abstract(AI Агент чат-бот)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.09.2005)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AiAgentChat;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase, ALogNodeImpl, ALogNodeIntf, ATypes, AXmlNodeIntf,
  AiAgentObj, AiBase, AiChatForm, AiDataObj, AiSelectObj, AiSourceObj, AiSourceAdoObj;

type
  {** Выделяет новые слова и пр. }
  TAiAgentWord = TAiAgent2006;

  TAiAgentChat = class(TAiAgent2006{TAIAgent})
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
    function Finalize(): TProfError; override;
    procedure Free(); override;
    function GetAgentWordId(): TAId;
    function GetForm(): TFormChat;
    function GetModuleTextId(): TAId;
    function Hide(): WordBool; virtual;
    function Initialize(): TProfError; override;
    //function Load(): Boolean; override;
    function Save(): AError; override;
    function Show(): AError; virtual;
  public
    constructor Create(Source: AiSourceObject2005; Id: AId);
  public
    property Form: TFormChat read FForm write SetFormChat;
  end;

  {Агент чат-бот}
  TAiAgentChat20050525 = class(TAiAgentChat)
  private
    FAgentWord: TAIAgentWord; {Агент. Выделяет ф-слова из ф-предложений.}
    FAgentWordId: AId;
    FForm: TAiFormChat;     {Форма ввода/вывода}
    FFormId: AId;
    FModuleTextId: AId;  {Модуль работы с текстом}
    FProcess: TThread;
  public
    constructor Create(Source: AiSourceObject2005; Id: AId = 0);
    procedure Free; override;
    function GetAgentWordId(): AId;
    function GetForm: TAIFormChat;
    function GetModuleTextId(): AId;
    function Initialize: TError; override;
    function Load: TError; override;
    function Pause: TError; override;
    function Run: TError; override;
    function Save: TError; override;
    function Show: TError; override;
    function Stop: TError; override;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stNotAssignedForm = '"%s" Форма не задана';

implementation

{ TAIAgentChat }

function TAiAgentChat.AssignedForm: Boolean;
begin
  Result := Assigned(FForm);
  if not(Result) then
    AddToLog(lgGeneral, ltError, Format(stNotAssignedForm, [ClassName]));
end;

constructor TAiAgentChat.Create(Source: AiSourceObject2005; Id: AId);
begin
  inherited Create(Source, Id);
  Self.Name := 'Chat';
  Self.Title := 'AgentChat';
end;

function TAiAgentChat.Finalize(): TProfError;
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

function TAiAgentChat.FormNewText(Sender: TObject; Params: WideString): WordBool;
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

procedure TAiAgentChat.Free;
begin
  FreeAndNil(FProcess);
  inherited Free;
end;

function TAiAgentChat.GetAgentWordId: TAId;
begin
  Result := FAgentWordId;
end;

function TAiAgentChat.GetForm: TFormChat;
begin
  if not(Assigned(FForm)) then
  begin
    FForm := TFormChat.Create({FFormMain});
  end;
  Result := FForm;
end;

function TAiAgentChat.GetModuleTextId: TAId;
begin
  Result := FModuleTextId;
end;

function TAiAgentChat.Hide(): WordBool;
begin
  Result := AssignedForm;
  if not(Result) then Exit;
  FForm.Hide;
end;

function TAiAgentChat.Initialize(): TProfError;
var
  ConfigForm: IProfXmlNode;
  ConfigSource: IProfXmlNode;
  Count: Int32;
  I: Int32;
  LogSource: TALogNode;   // Log источника
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

function TAiAgentChat.Save(): AError;
(*var
  Data: TAI_Data;
  Stream: TProfStream;
  Xml: TProfXmlNode;*)
begin
  Result := inherited Save();
  (*if not(Result) then Exit;
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

procedure TAiAgentChat.SetFormChat(Value: TFormChat);
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

function TAiAgentChat.Show(): AError;
begin
  Result := inherited Show();
  GetForm.Show;
end;

{ TAiAgentChat20050525 }

constructor TAiAgentChat20050525.Create(Source: AiSourceObject2005; Id: AId = 0);
{var
  Typ: TAIType;}
begin
  inherited Create(Source, Id);
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

procedure TAiAgentChat20050525.Free;
begin
  FProcess.Free;
  inherited Free;
end;

function TAiAgentChat20050525.GetAgentWordId(): AId;
begin
  Result := FAgentWordId;
end;

function TAiAgentChat20050525.GetForm: TAIFormChat;
var
  Source: TAiSource2005;
begin
  if not(Assigned(FForm)) then
  begin
    Source := TObject(GetSource) as TAiSource;
    FForm := TAIFormChat.Create(AiSource2005(Source), FFormId);
    if (FFormId = 0) and (Assigned(Source)) then
      FFormId := Source.NewFreim(0);
  end;
  Result := FForm;
end;

function TAiAgentChat20050525.GetModuleTextId(): AId;
begin
  Result := FModuleTextId;
end;

function TAiAgentChat20050525.Initialize: TError;
begin
  {if GetInitialized then Exit;
  Result := inherited Initialize;
  SetTitle('AgentChat');

  if not(Assigned(FForm)) then begin
    FForm := TAIFormChat1.Create(nil, 0);
    GetSource.NewFreim(FForm);
  end;
  FForm.Initialize;}
  Result := 0;
end;

function TAiAgentChat20050525.Load: TError;
var
  Id: AId;
  Data: TAiDataObject;
begin
  Result := inherited Load;
  if Result <> 0 then Exit;
  Data := GetData;
  Data.ReadId(Id);
  FAgentWordId := Id;
  Data.ReadId(Id);
  FFormId := Id;
  Data.ReadId(Id);
  FModuleTextId := Id;
end;

function TAiAgentChat20050525.Pause: TError;
begin
  Result := inherited Pause;
end;

function TAiAgentChat20050525.Run: TError;
begin
  Result := inherited Run;
end;

function TAiAgentChat20050525.Save: TError;
var
  Id: AId;
  Data: TAiDataObject;
begin
  Result := inherited Save;
  if Result <> 0 then Exit;
  Data := GetData;
  Id := FAgentWordId;
  Data.WriteId(Id);
  Id := FFormId;
  Data.WriteId(Id);
  Id := FModuleTextId;
  Data.WriteId(Id);
end;

function TAiAgentChat20050525.Show: TError;
begin
  Result := inherited Show;
  GetForm.Show;
end;

function TAiAgentChat20050525.Stop: TError;
begin
  Result := inherited Stop;
end;

end.
