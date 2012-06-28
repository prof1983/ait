{**
@Abstract(Главное окно просмотра XHTML кода)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2007)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AiBrowserForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  AHtmlConst, AHtmlControl;

type // Главное окно просмотра XHTML кода
  TfmBrowser = class(TForm)
    pnButtons: TPanel;
    sbRefresh: TSpeedButton;
    reHtml: TRichEdit;
    spDelimer1: TSplitter;
    pnHtml: TPanel;
    btClear: TButton;
    btDemo1: TButton;
    btDemo2: TButton;
    procedure btDemo2Click(Sender: TObject);
    procedure btDemo1Click(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure sbRefreshClick(Sender: TObject);
  private
      // Объект отрисовки элементов управления XHTML
    FHtmlControl: THtmlControl;
  protected
      // Срабатывает при создании
    procedure DoCreate(); override;
  public
  end;

implementation

{$R *.dfm}

{ TfmBrowser }

procedure TfmBrowser.btClearClick(Sender: TObject);
begin
  FHtmlControl.Clear();
end;

procedure TfmBrowser.btDemo1Click(Sender: TObject);
begin
  reHtml.Lines.Clear();
  reHtml.Lines.Add('<?xml version="1.0" encoding="Windows-1251"?>');
  reHtml.Lines.Add('<html>');
  reHtml.Lines.Add('<body>');
  reHtml.Lines.Add('<form name="exampleform" description="Атрибут name указывает имя возвращаемого тега">');
  reHtml.Lines.Add('<b>Текст</b>');
  reHtml.Lines.Add('<input type="text" />');
  reHtml.Lines.Add('<b>Текст2</b>');
  reHtml.Lines.Add('<input type="text" />');
  reHtml.Lines.Add('</form>');
  reHtml.Lines.Add('</body>');
  reHtml.Lines.Add('</html>');

  FHtmlControl.HtmlCode := reHtml.Lines.Text;
  FHtmlControl.Refresh();
end;

procedure TfmBrowser.btDemo2Click(Sender: TObject);
begin
  reHtml.Lines.Clear();
  reHtml.Lines.Add('<?xml version="1.0" encoding="Windows-1251"?>');
  reHtml.Lines.Add('<html>');
  reHtml.Lines.Add('<body>');
  reHtml.Lines.Add('<form name="exampleform" description="Атрибут name указывает имя возвращаемого тега">');
  reHtml.Lines.Add('<b>Текст</b>');
  reHtml.Lines.Add('<input type="text" />');
  reHtml.Lines.Add('<b>Текст2</b>');
  reHtml.Lines.Add('<input type="text" />');
  reHtml.Lines.Add('<b>Текст3</b>');
  reHtml.Lines.Add('<input type="text" />');
  reHtml.Lines.Add('</form>');
  reHtml.Lines.Add('</body>');
  reHtml.Lines.Add('</html>');

  FHtmlControl.HtmlCode := reHtml.Lines.Text;
  FHtmlControl.Refresh();
end;

procedure TfmBrowser.DoCreate();
begin
  inherited DoCreate();

  reHtml.Lines.Add('<?xml version="1.0" encoding="Windows-1251"?>');
  reHtml.Lines.Add('<html>');
  reHtml.Lines.Add('<body>');
  reHtml.Lines.Add('<form name="exampleform" description="Атрибут name указывает имя возвращаемого тега">');
  reHtml.Lines.Add('<input type="text" />');
  reHtml.Lines.Add('<b>Текст</b>');
  reHtml.Lines.Add('</form>');
  reHtml.Lines.Add('</body>');
  reHtml.Lines.Add('</html>');

  // Создаем объект отрисовки XHTML
  FHtmlControl := THtmlControl.Create();
  FHtmlControl.Controller := pnHtml;

  FHtmlControl.HtmlCode := reHtml.Lines.Text;
  FHtmlControl.Refresh();
end;

procedure TfmBrowser.sbRefreshClick(Sender: TObject);
begin
  FHtmlControl.HtmlCode := reHtml.Lines.Text;
  FHtmlControl.Refresh();
end;

end.
