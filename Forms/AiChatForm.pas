{**
@Abstract(Главная форма для агента чат-бот)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(24.03.2005)
@LastMod(13.07.2012)
}
unit AiChatForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  ABase, ABaseUtils2, AEventObj, AFormObj, ATypes,
  AiBase, AiForm2006;

type
  TAiFormChat = class(TAiForm)
  protected
    FDialog: TArrayString;
    FInput: String;
    FListIn: TArrayString;
    FListOut: TArrayString;
    FOutput: String;
  public
    procedure DialogAdd(Value: String); virtual;
    procedure DialogAddIn(Value: String); virtual;
    procedure DialogAddOut(Value: String); virtual;
    procedure ListInAdd(Value: String); virtual;
    function GetDialog: TArrayString;
    function GetInput: String;
    function GetListIn: TArrayString;
    function GetListOut: TArrayString;
    function GetOutput: String;
    function SetInput(Value: String): TError;
  public
    constructor Create(Source: AiSourceObject2005; Id: AId = 0);
    procedure Free; override;
  end;

  TFormChat = class(TAFormObject)
    ButtonInfo: TButton;
    ButtonOk: TButton;
    EditIn: TEdit;
    MemoDialog: TMemo;
    Panel1: TPanel;
    ProgressBar: TProgressBar;
    procedure ButtonOkClick(Sender: TObject);
    procedure EditInKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    FEventNewText: TEvent;
  public
    //AIForm: TAIFormChat;
    constructor Create(AOwner: TComponent = nil); override;
    property EventNewText: TEvent read FEventNewText;
    procedure Free; override;
  end;

implementation

{$R *.dfm}

{ TFormChat }

procedure TFormChat.ButtonOkClick(Sender: TObject);
begin
  {if not(Assigned(AIForm)) then Exit;
  if EditIn.Text = '' then Exit;
  AIForm.Input := EditIn.Text;
  EditIn.Text := '';}

  if EditIn.Text = '' then Exit;

  MemoDialog.Lines.Add('You: '+EditIn.Text);
  FEventNewText.Run(Self, '<Text>'+EditIn.Text+'</Text>');
  AddToLog(lgGeneral, ltInformation, Format('Добавлено новое сообщение "%s"', [EditIn.Text]));
  EditIn.Text := '';
end;

procedure TFormChat.EditInKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then ButtonOk.Click;
end;

procedure TFormChat.FormResize(Sender: TObject);
begin
  ButtonInfo.Left := Width - 48;
  ButtonOk.Left := Width - 88;
  EditIn.Width := Width - 95;
end;

constructor TFormChat.Create(AOwner: TComponent = nil);
begin
  inherited Create(AOwner);
  FEventNewText := TEvent.Create('NewText');
end;

procedure TFormChat.Free;
begin
  FreeAndNil(FEventNewText);
  inherited Free;
end;

{ TAiFormChat }

constructor TAiFormChat.Create(Source: AiSourceObject2005; Id: AId = 0);
begin
  inherited Create(Source, Id);
  {FDialog := TListString.Create;
  FListIn := TListString.Create;
  FListOut := TListString.Create;}
end;

procedure TAiFormChat.DialogAdd(Value: String);
var
  I: Int32;
begin
  {Dialog.Add(Value);}
  I := Length(FDialog);
  SetLength(FDialog, I + 1);
  FDialog[I] := Value;
end;

procedure TAiFormChat.DialogAddIn(Value: String);
begin
  DialogAdd('<You>:' + Value);
end;

procedure TAiFormChat.DialogAddOut(Value: String);
begin
  DialogAdd('<AI>:' + Value);
end;

procedure TAiFormChat.Free;
begin
  {FDialog.Free;
  FListIn.Free;
  FListOut.Free;}
  inherited Free;
end;

function TAiFormChat.GetDialog: TArrayString;
begin
  Result := FDialog;
end;

function TAiFormChat.GetInput: String;
begin
  Result := FInput;
end;

function TAiFormChat.GetListIn: TArrayString;
begin
  Result := FListIn;
end;

function TAiFormChat.GetListOut: TArrayString;
begin
  Result := FListOut;
end;

function TAiFormChat.GetOutput: String;
begin
  Result := FOutput;
end;

procedure TAiFormChat.ListInAdd(Value: String);
begin
  {FListIn.Add(Value);}
  ArrayStringAdd(FListIn, Value);
end;

function TAiFormChat.SetInput(Value: String): TError;
begin
  FInput := Value;
  ListInAdd(FInput);
  DialogAddIn(FInput);
  Result := 0;
end;

end.
