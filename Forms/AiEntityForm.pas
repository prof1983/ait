{**
@Abstract(Форма редактирования сущности)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.05.2007)
@LastMod(26.03.2012)
@Version(0.5)

История версий:
0.0.0.3 - 10.06.2007 - Добавил fmEntity.TypeEnabled
}
unit AiEntityForm;

interface

uses
  Classes, Controls, Dialogs, ExtCtrls, Graphics, Grids, Forms, Messages,
  StdCtrls, SysUtils, ValEdit, Variants, Windows, Buttons;

type //** @abctract(Форма редактирования сущности)
  TEntityForm = class(TForm)
    Panel1: TPanel;
    lblID: TLabel;
    lblType: TLabel;
    edID: TEdit;
    btType: TButton;
    pnButtons: TPanel;
    btOK: TButton;
    btCancel: TButton;
    btApply: TButton;
    ValueListEditor: TValueListEditor;
    cbType: TComboBox;
    sbAdd: TSpeedButton;
    sbDelete: TSpeedButton;
    procedure sbDeleteClick(Sender: TObject);
    procedure sbAddClick(Sender: TObject);
  private
    function GetTypeEnabled(): Boolean;
    procedure SetTypeEnabled(Value: Boolean);
  public
    property TypeEnabled: Boolean read GetTypeEnabled write SetTypeEnabled;
  end;

implementation

{$R *.dfm}

{ TfmEntity }

function TEntityForm.GetTypeEnabled(): Boolean;
begin
  Result := cbType.Enabled;
end;

procedure TEntityForm.sbAddClick(Sender: TObject);
begin
  ValueListEditor.InsertRow('', '', True);
  // ...
end;

procedure TEntityForm.sbDeleteClick(Sender: TObject);
begin
  // ...
end;

procedure TEntityForm.SetTypeEnabled(Value: Boolean);
begin
  cbType.Enabled := Value;
  btType.Enabled := Value;
end;

end.
