{**
@Abstract(Форма управления действиями)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.10.2005)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AiActionsForm;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Graphics, Forms, Messages, StdCtrls, SysUtils,
  {$IFDEF VER150}Variants,{$ENDIF} Windows,
  AiAction, AForm2007;

type
  TFormActions = class(TProfForm)
  private
    FListBox: TListBox;
    FStatusBar: TStatusBar;
    FPanel: TPanel;
  private
    FActions: TAIActions;
  public
    property Actions: TAIActions read FActions write FActions;
    constructor Create({AConfig: IProfXmlNode = nil; ALog: ILogNode = nil;} AOwner: TComponent = nil);
    procedure Free; override;
  end;

implementation

{$R *.dfm}

{ TFormActions }

constructor TFormActions.Create({AConfig: IProfXmlNode = nil; ALog: ILogNode = nil;} AOwner: TComponent = nil);
begin
  inherited Create(AOwner);

  FStatusBar := TStatusBar.Create(Self);
  FStatusBar.Parent := Self;

  FPanel := TPanel.Create(Self);
  FPanel.Align := alRight;

  FListBox := TListBox.Create(Self);
  FListBox.Parent := Self;
  FListBox.Align := alClient;
end;

procedure TFormActions.Free();
begin
  FreeAndNil(FStatusBar);
  FreeAndNil(FPanel);
  FreeAndNil(FListBox);

  inherited Free;
end;

end.
