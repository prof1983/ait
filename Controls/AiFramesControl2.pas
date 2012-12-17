{**
@Abstract Контрол фреймов
@Author Prof1983 <prof1983@ya.ru>
@Created 06.11.2006
@LastMod 17.12.2012
}
unit AiFramesControl2;

interface

uses
  Classes, ComCtrls, Controls, StdCtrls,
  AControlImpl,
  AiKbCode, AiKbFrame;

type //** @abstract(Контрол фреймов)
  TAIFramesControl = class(TAControl)
  private
    FTreeView: TTreeView;
    FMemo: TMemo;
    procedure TreeViewClick(Sender: TObject);
  protected
    procedure DoSelect(const AName: WideString);
  public
    function Initialize(): WordBool;
    procedure Refresh();
  end;

implementation

{ TAIFramesControl }

procedure TAIFramesControl.DoSelect(const AName: WideString);
begin
  FMemo.Clear();
  if AName = 'Frame' then
    FMemo.Lines.Add(AIFrameSchema)
  else if AName = 'Code' then
    FMemo.Lines.Add(AiCodeSchema)
  else if AName = 'Reason' then
    //FMemo.Lines.Add(kbReason);
end;

function TAIFramesControl.Initialize(): WordBool;
begin
  Result := True;
  FTreeView := TTreeView.Create(FControl);
  FTreeView.Parent := FControl;
  FTreeView.Align := alLeft;
  FTreeView.Width := 200;
  FTreeView.OnClick := TreeViewClick;

  FMemo := TMemo.Create(FControl);
  FMemo.Parent := FControl;
  FMemo.Align := alClient;
  FMemo.ScrollBars := ssBoth;
  Refresh()
end;

procedure TAIFramesControl.Refresh();
begin
  FTreeView.Items.AddChild(nil, 'Frame');
  FTreeView.Items.AddChild(nil, 'Code');
  FTreeView.Items.AddChild(nil, 'Reason');
end;

procedure TAIFramesControl.TreeViewClick(Sender: TObject);
begin
  if Assigned(FTreeView.Selected) then
    DoSelect(FTreeView.Selected.Text);
end;

end.
