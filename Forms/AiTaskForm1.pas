{**
@Abstract(Форма редактирования задания)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.07.2007)
@LastMod(16.03.2012)
@Version(0.5)
}
unit AiTaskForm1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  AiTask;

type //** @abstract(Форма редактирования задания)
  TTaskForm = class(TForm)
    TitleLabel: TLabel;
    TitleEdit: TEdit;
    CommentLabel: TLabel;
    CommentMemo: TMemo;
    OKBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    procedure OKBitBtnClick(Sender: TObject);
  private
    FTask: TTask;
    procedure SetTask(Value: TTask);
  public
    //** Задание
    property Task: TTask read FTask write SetTask;
  end;

implementation

{$R *.dfm}

{ TTaskForm }

procedure TTaskForm.OKBitBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
  begin
    FTask.Title := TitleEdit.Text;
    FTask.Comment := CommentMemo.Text;
  end;
end;

procedure TTaskForm.SetTask(Value: TTask);
begin
  FTask := Value;
  TitleEdit.Text := FTask.Title;
  CommentMemo.Text := FTask.Comment;
end;

end.
