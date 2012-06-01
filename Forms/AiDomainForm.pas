{**
@Abstract(Главная форма предметной области)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.11.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AiDomainForm;

interface

uses
  Classes, Controls, Dialogs, Graphics, Forms, Menus, Messages, StdCtrls, SysUtils,
  Variants, Windows,
  AiFrameImpl, AiDomain;

type
  TfmDomain = class(TForm)
    mmMain: TMainMenu;
    miFile: TMenuItem;
    miLoad: TMenuItem;
    miSave: TMenuItem;
    miDelimer1: TMenuItem;
    miExit: TMenuItem;
    miDemo: TMenuItem;
    ListBox1: TListBox;
    procedure miDemoClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miSaveClick(Sender: TObject);
    procedure miLoadClick(Sender: TObject);
  private
    FDomain: TAiDomain;
  protected
    procedure DoCreate(); override;
    procedure DoDestroy(); override;
    procedure RefreshList();
  end;

var
  fmDomain: TfmDomain;

implementation

{$R *.dfm}

{ TfmDomain }

procedure TfmDomain.DoCreate();
begin
  inherited DoCreate();
  FDomain := TAIDomain.Create();
  // ...
end;

procedure TfmDomain.DoDestroy();
begin
  // ...
  FDomain := nil;
  inherited DoCreate();
end;

procedure TfmDomain.miDemoClick(Sender: TObject);
var
  f: TAIFrame;
begin
  FDomain.Clear();

  f := TAIFrame.Create();
  f.Name := 'Frame1';
  FDomain.List.Add(f);

  f := TAIFrame.Create();
  f.Name := 'Frame2';
  FDomain.List.Add(f);

  RefreshList();
end;

procedure TfmDomain.miExitClick(Sender: TObject);
begin
  Close();
end;

procedure TfmDomain.miLoadClick(Sender: TObject);
begin
  // ...
end;

procedure TfmDomain.miSaveClick(Sender: TObject);
var
  d: TSaveDialog;
begin
  d := TSaveDialog.Create(Self);
  if d.Execute() then
    FDomain.SaveToFile(d.FileName);
  d.Free;
  // ...
end;

procedure TfmDomain.RefreshList();
var
  i: Integer;
begin
  Self.ListBox1.Clear();
  for i := 0 to FDomain.List.Count - 1 do
    Self.ListBox1.Items.Add(FDomain.List.ItemsByIndex[i].Name);
end;

end.
