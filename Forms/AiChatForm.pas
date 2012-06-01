{**
@Abstract(Главная форма для агента чат-бот)
@Author(Prof1983 prof1983@ya.ru)
@Created(24.03.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiChatForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  AEventObj, AForm2007, ATypes,
  AiBase, AiGlobals;

type
  TFormChat = class(TProfForm)
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
  AddToLog(lgGeneral, ltInformation, 'Добавлено новое сообщение "%s"', [EditIn.Text]);
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

end.
