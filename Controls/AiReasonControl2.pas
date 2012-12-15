{**
@Abstract Контрол для наблюдения за заданиями ИР
@Author Prof1983 <prof1983@ya.ru>
@Created 31.10.2006
@LastMod 15.12.2012
}
unit AiReasonControl2;

// TODO: Объединить с AiReasonControl.pas

interface

uses
  Classes, ComCtrls, Controls, ExtCtrls, StdCtrls,
  AMessagesControl, ATypes,
  AiReasonAgentImpl, AiTaskImpl, AiTaskListImpl;

type //** Контрол для наблюдения за заданиями ИР
  TReasonControl2 = class(TMessagesControl)
  private
    FReason: TAIReasonAgent;
    procedure SetReason(Value: TAiReasonAgent);
  protected
    ReasonTasks: TTreeView;
    ReasonTaskLog: TMemo;
    Panel: TPanel;
    Splitter: TSplitter;
    Progress1: TProgressBar;
    Progress2: TProgressBar;
    Progress3: TProgressBar;
  protected
      //** Срабатывает при инициализации
    function DoInitialize(): AError; override; safecall;
      //** Срабатывает при получении сообщения
    function DoMessage(const Msg: WideString): Integer; //override; safecall;
      //** Срабатывает при необходимости изменении ProgressBar
    function DoProgress(AID, AProgress: Integer; const Msg: WideString): Integer; safecall;
      //** Срабатывает при добавлении задания
    function DoTaskAdd(const AMessage: WideString): Integer; safecall;
  public
    property Reason: TAiReasonAgent read FReason write SetReason;
  end;

type
  TReasonControl = TReasonControl2;

implementation

{ TReasonControl2 }

function TReasonControl2.DoInitialize(): AError;
begin
  Result := inherited DoInitialize();
  if not(Assigned(FControl)) then Exit;

  ReasonTasks := TTreeView.Create(FControl);
  ReasonTasks.Parent := FControl;
  ReasonTasks.Width := 150;
  ReasonTasks.Align := alLeft;

  Splitter := TSplitter.Create(FControl);
  Splitter.Parent := FControl;
  Splitter.Left := ReasonTasks.Width + 10;
  Splitter.Align := alLeft;

  Panel := TPanel.Create(FControl);
  Panel.Parent := FControl;
  Panel.Align := alClient;

  Progress1 := TProgressBar.Create(FControl);
  Progress1.Parent := Panel;
  Progress1.Align := alTop;
  Progress1.Height := 6;
  Progress1.Smooth := True;

  Progress2 := TProgressBar.Create(FControl);
  Progress2.Parent := Panel;
  Progress2.Align := alTop;
  Progress2.Height := 6;
  Progress2.Smooth := True;

  Progress3 := TProgressBar.Create(FControl);
  Progress3.Parent := Panel;
  Progress3.Align := alTop;
  Progress3.Height := 6;
  Progress3.Smooth := True;

  ReasonTaskLog := TMemo.Create(FControl);
  ReasonTaskLog.Parent := Panel;
  ReasonTaskLog.Align := alClient;
end;

function TReasonControl2.DoMessage(const Msg: WideString): Integer;
begin
  Result := ReasonTaskLog.Lines.Add(Msg);
end;

function TReasonControl2.DoProgress(AID, AProgress: Integer; const Msg: WideString): Integer;
begin
  Result := 0;
  Progress3.Position := Progress3.Position + 1;
  if Progress3.Position >= Progress3.Max then
  begin
    Progress3.Position := 0;
    Progress2.Position := Progress2.Position + 1;
    if Progress2.Position >= Progress2.Max then
    begin
      Progress2.Position := 0;
      Progress1.Position := Progress1.Position + 1;
      if Progress1.Position >= Progress1.Max then
      begin
        Progress1.Position := 0;
        ReasonTaskLog.Lines.Add('===');
      end;
    end;
  end;
end;

function TReasonControl2.DoTaskAdd(const AMessage: WideString): Integer;
var
  i: Integer;
  gt: TAITaskList;
  t: TAITask;
begin
  //ReasonTasks.Items.AddChild(nil, '---');

  ReasonTasks.Items.Clear();

  gt := FReason.GlobalTasks;
  for i := 0 to gt.TaskCount - 1 do
  begin
    t := gt.TaskByIndex[i];
    ReasonTasks.Items.AddChild(nil, t.Name);
  end;
end;

procedure TReasonControl2.SetReason(Value: TAiReasonAgent);
begin
  FReason := Value;

  // Присоединяемся к событиям программы
  FReason.OnProgress := DoProgress;
//  FReason.Thread.OnProgress := DoProgress;
//  FReason.Thread.OnTaskAdd := DoTaskAdd;
end;

end.
