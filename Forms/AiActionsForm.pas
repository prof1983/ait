{**
@Abstract(AiActionsForm)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.10.2005)
@LastMod(11.07.2012)
@Version(0.5)
}
unit AiActionsForm;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Graphics, Forms, Messages, StdCtrls, SysUtils,
  Windows,
  ABase, AFormObj,
  AiAction, AiActionForm;

type
  TFormActions = class(TAFormObject)
  private
    FListBox: TListBox;
    FStatusBar: TStatusBar;
    FPanel: TPanel;
  private
    tvActions: TTreeView;
    tbMain: TToolBar;
  private
    FActions: TAiActions;
    procedure tbNewActionClick(Sender: TObject);
  public
    {**
      Initializing form
      @param Typ - 0: ListBox; 1: TreeView
    }
    procedure Init(Typ: AInt);
    procedure Free; override;
  public
    property Actions: TAiActions read FActions write FActions;
  end;

implementation

{$R *.dfm}

{ Functions }

function AiActions_CreateNewAction(): ABoolean;
var
  f: TfmAction;
begin
  f := TfmAction.Create(nil);
  f.Edit1.Text := '<action name="Action1"></action>';
  Result := (f.ShowModal = mrOK);
  f.Free();
end;

{ TFormActions }

procedure TFormActions.Free();
begin
  FreeAndNil(FStatusBar);
  FreeAndNil(FPanel);
  FreeAndNil(FListBox);
  inherited Free;
end;

procedure TFormActions.Init(Typ: AInt);
var
  tbNewAction: TToolButton;
begin
  tbMain := TToolBar.Create(Self);
  tbMain.Parent := Self;
  tbMain.Left := 0;
  tbMain.Top := 0;
  tbMain.Width := 220;
  tbMain.Height := 29;
  tbMain.ShowCaptions := True;
  tbMain.TabOrder := 2;

  tbNewAction := TToolButton.Create(tbMain);
  tbNewAction.Parent := tbMain;
  tbNewAction.Caption := 'New';
  tbNewAction.OnClick := tbNewActionClick;

  FStatusBar := TStatusBar.Create(Self);
  FStatusBar.Parent := Self;

  FPanel := TPanel.Create(Self);
  FPanel.Align := alRight;

  if (Typ = 0) then
  begin
    FListBox := TListBox.Create(Self);
    FListBox.Parent := Self;
    FListBox.Align := alClient;
  end
  else
  begin
    tvActions := TTreeView.Create(Self);
    tvActions.Parent := Self;
    tvActions.Left := 0;
    tvActions.Top := 29;
    tvActions.Width := 220;
    tvActions.Height := 281;
    tvActions.Align := alClient;
    tvActions.Indent := 19;
    tvActions.TabOrder := 0;
  end;
end;

procedure TFormActions.tbNewActionClick(Sender: TObject);
begin
  if AiActions_CreateNewAction() then
    Self.tvActions.Items.Add(nil, 'Action1');
end;

end.
