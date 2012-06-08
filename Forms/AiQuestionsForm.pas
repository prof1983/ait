{**
@Abstract(Окно работы со списком вопросов)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.05.2005)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiQuestionsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormQuestions = class(TForm)
    Panel1: TPanel;
    ButtonRefresh: TButton;
    ButtonAdd: TButton;
    ButtonInsert: TButton;
    ButtonDelete: TButton;
    ButtonInfo: TButton;
    ButtonShow: TButton;
    ButtonUp: TButton;
    ButtonDown: TButton;
    ListBox1: TListBox;
  end;

var
  FormQuestions: TFormQuestions;

implementation

{$R *.dfm}

end.
