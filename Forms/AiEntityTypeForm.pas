{**
@Abstract(EntityType form)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.10.2011)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AiEntityTypeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, ComCtrls;

type
  TEntityTypeForm = class(TForm)
    InfoMemo: TMemo;
    EntityTreeView: TTreeView;
    EntityStringGrid: TStringGrid;
    ButtonPanel: TPanel;
    OKBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    Splitter1: TSplitter;
  end;

implementation

{$R *.dfm}

end.
