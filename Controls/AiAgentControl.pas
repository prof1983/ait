{**
@Abstract(Контрол формы для агента)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.04.2007)
@LastMod(01.06.2012)
@Version(0.5)

01.06.2012 - Renamed AgentControl.pas -> AiAgentControl.pas
}
unit AiAgentControl;

interface

uses
  Classes, ComCtrls, Controls, ExtCtrls, Menus, StdCtrls,
  AControlEx, ALogRichEditControl, ATypes,
  AclConsts, AclMessageImpl; //AclStringCodec4;

type
  TAgentControl = class(TProfControlEx)
  private
    btSend: TButton;
    lblLanguage: TLabel;
    lblPerformative: TLabel;
    lblReceiver: TLabel;
    //** Тип сообщения
    cbPerformative: TComboBox;
    //** Получатель
    cbReceiver: TComboBox;
    //** Язык сообщения
    cbLanguage: TComboBox;
    //** Поле ввода команд и других сообщений
    memInput: TMemo;
    //** Панель кнопок быстрого вызова
    //pnButtons: TPanel;
    //** Панель с элементами для ввода сообщения
    pnInput: TPanel;
    //** Панель с дополнительными элементами для ввода сообщения
    pnInputTool: TPanel;
    //** Поле вывода информации
    reOut: TRichEdit;
  private
    //** Контрол вывода лог-сообщений в RichEdit
    FLogControl: TProfLogRichEditControl3;
    procedure memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSendClick(Sender: TObject);
  protected
    function DoInitialize(): TProfError; override; safecall;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    //** Контрол вывода лог-сообщений в RichEdit
    property LogControl: TProfLogRichEditControl3 read FLogControl;
  end;

implementation

{ TAgentControl }

function TAgentControl.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := inherited AddToLog(AGroup, AType, AStrMsg);

  if Assigned(FLogControl) then
    Result := FLogControl.AddToLog(AGroup, AType, AStrMsg);
end;

procedure TAgentControl.btSendClick(Sender: TObject);
var
  msg: TAclMessage;
begin
  msg := TAclMessage.Create();
  msg.SenderName := 'AssistantForm';
  msg.ReceiverName := cbReceiver.Text; //'Core';
  msg.Content := memInput.Text;
  msg.Language := cbLanguage.Text;
  msg.Performative := 0;
  //msg.OntologyStr

//  Self.SendMessageA(msg);

  reOut.Lines.Add('-->' + msg.Content);
  //reOut.Lines.Add(msg.ToString());
  //reOut.Lines.Add(TAclStringCodec.Encode(msg));
  memInput.Clear();
end;

function TAgentControl.DoInitialize(): TProfError;
begin
  Result := inherited DoInitialize();

  pnInput := TPanel.Create(FControl);
  pnInput.Parent := FControl;
  pnInput.Align := alBottom;
  pnInput.Height := 150;

  pnInputTool := TPanel.Create(FControl);
  pnInputTool.Parent := pnInput;
  pnInputTool.Align := alRight;
  pnInputTool.Width := 200;

  lblPerformative := TLabel.Create(FControl);
  lblPerformative.Parent := pnInputTool;
  lblPerformative.Align := alTop;
  lblPerformative.Caption := 'Performative';

  cbPerformative := TComboBox.Create(FControl);
  cbPerformative.Parent := pnInputTool;
  cbPerformative.Align := alTop;

  lblReceiver := TLabel.Create(FControl);
  lblReceiver.Parent := pnInputTool;
  lblReceiver.Top := 90;
  lblReceiver.Align := alTop;
  lblReceiver.Caption := 'Receiver';

  cbReceiver := TComboBox.Create(FControl);
  cbReceiver.Parent := pnInputTool;
  cbReceiver.Top := 100;
  cbReceiver.Align := alTop;

  lblLanguage := TLabel.Create(FControl);
  lblLanguage.Parent := pnInputTool;
  lblLanguage.Top := 150;
  lblLanguage.Align := alTop;
  lblLanguage.Caption := 'Language';

  cbLanguage := TComboBox.Create(FControl);
  cbLanguage.Parent := pnInputTool;
  cbLanguage.Top := 160;
  cbLanguage.Align := alTop;

  btSend := TButton.Create(FControl);
  btSend.Parent := pnInputTool;
  btSend.Top := 200;
  btSend.Align := alTop;
  btSend.Caption := 'Send';
  btSend.OnClick := btSendClick;

  //cbLanguage

  memInput := TMemo.Create(FControl);
  memInput.Parent := pnInput; //FControl;
  memInput.Align := alClient; //alBottom;
  //memInput.Height := 50;
  memInput.OnKeyUp := memInputKeyUp;

  reOut := TRichEdit.Create(FControl);
  reOut.Parent := FControl;
  reOut.Align := alClient;
  reOut.ReadOnly := True;

  // Создаем контрол вывода лог-сообщений в RichEdit
  FLogControl := TProfLogRichEditControl3.Create();
  FLogControl.Controller := reOut;
//  TProfForm(FControl).Log := FLogControl;

  // Создаем панель кнопок быстрого вызова
  {pnButtons := TPanel.Create(Self);
  pnButtons.Parent := Self;
  pnButtons.Height := 17;
  pnButtons.Align := alTop;}

//  // Создаем список текущих действий
//  FActions := TStringList.Create();
//  // Заполняем список текущих действий
//  //FActions.Add('Открыть Базу Знаний');
//  FActions.Add(AR_CMD_TASK_NEW);
//  FActions.Add(AR_CMD_AGENT_NEW);

  {DoMessage('-');

  DoMessage('Assistant: Hello.');

  DoMessage('Assistant: Выберете что мне делать');
  // Отобразить варианты действий
  WriteActionList();

  //DoMessage('1 - Открыть Базу Знаний');
  // ... }

  cbLanguage.Items.Add('ARL-0.1');
  cbLanguage.ItemIndex := 0;

  cbPerformative.Items.Add(RU_AGREE);
  cbPerformative.Items.Add(RU_CANCEL);
  cbPerformative.Items.Add(RU_CONFIRM);
  cbPerformative.Items.Add(RU_DISCONFIRM);
  cbPerformative.Items.Add(RU_FAILURE);
  cbPerformative.Items.Add(RU_INFORM);
  cbPerformative.Items.Add(RU_REQUEST);
  cbPerformative.Items.Add(RU_SUBSCRIBE);

  cbReceiver.Items.Add('Core');
end;

procedure TAgentControl.memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  msg: WideString;      // Текущее введеное сообщение
  //i: Integer;
begin
  if (Key <> 13) or (ssShift in Shift) then Exit;

  memInput.SetFocus();

  msg := memInput.Text;
  // Если пустое сообщение, то выходим
  if msg = '' then Exit;
  if msg[Length(msg)] = #10 then msg := Copy(msg, 1, Length(msg) - 1);
  if msg = '' then Exit;
  if msg[Length(msg)] = #13 then msg := Copy(msg, 1, Length(msg) - 1);
  if msg = '' then Exit;

  reOut.Lines.Add('You: ' + msg);
  memInput.Clear();

  SendMessage(msg);

//  if TryStrToInt(msg, i) then
//    DoAction(i);
end;

end.
