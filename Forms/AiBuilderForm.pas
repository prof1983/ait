{**
@Abstract(Агент для создания агнтов, источников и пр. для AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.11.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiBuilderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TFrameBuilder = class(TFrame)
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    RichEditCode: TRichEdit;
  end;

implementation

{$R *.dfm}

end.

