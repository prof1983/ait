{**
@Abstract(Главное окно органайзера)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.05.2007)
@LastMod(25.06.2012)
@Version(0.5)

История версий:
0.0.1.1 - 20.06.2007 - Сделал MDIChild форму.
0.0.5.10 - 20.04.2012 - Remove FReasoner (TAIWSReasoner)
}
unit AiOrganizerForm;

interface

uses
  ActnList, ActnCtrls, ActnMan, ActnMenus, Classes, ComCtrls, Controls, Dialogs, ExtCtrls,
  Graphics, Forms, Messages, SysUtils, ToolWin, Variants, Windows,
  XPStyleActnCtrls, StdCtrls, Menus, ImgList,
  {AiReasonerImpl,}
  AiEntityForm;

type
  TTabItem = class
  public
    Node: TTreeNode;
  end;

type
  TMode = (
    mNone,
    mNewEntity,
    mNewClass,
    mNewIndividual,
    mNewOntology
    );

type //** Главное окно органайзера
  TfmOrganizer = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    tcObjects: TTabControl;
    tvObjects: TTreeView;
    PageControl1: TPageControl;
    pnTool: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    actNewEntity: TAction;
    actNewClass: TAction;
    actNewIndividual: TAction;
    actNewOntology: TAction;
    Action5: TAction;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    reOut: TRichEdit;
    Panel3: TPanel;
    btSend: TButton;
    Splitter3: TSplitter;
    memInput: TMemo;
    PopupMenu1: TPopupMenu;
    Exit1: TMenuItem;
    ImageList1: TImageList;
    procedure actNewOntologyExecute(Sender: TObject);
    procedure actNewIndividualExecute(Sender: TObject);
    procedure actNewClassExecute(Sender: TObject);
    procedure actNewEntityExecute(Sender: TObject);
    procedure memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure memInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure memInputKeyPress(Sender: TObject; var Key: Char);
    procedure btSendClick(Sender: TObject);
    procedure tcObjectsChange(Sender: TObject);
  private
    // Список элементов вкладок
    //FTabItems: array of TTabItem;
    //** Пул хранения сущностей в памяти
//    FPool: TAIWSMemoryPool;
    //** Машина логического вывода
    //FReasoner: TAIWSReasoner;
    FMode: TMode;
    //** Инициализируем пул в памяти
    procedure InitPool();
  protected
    //** Срабатывает при создании окна
    procedure DoCreate(); override;
    //** Срабатывает при уничтожении окна
    procedure DoDestroy(); override;
  end;

implementation

{$R *.dfm}

{ TfmOrganizer }

procedure TfmOrganizer.actNewClassExecute(Sender: TObject);
var
  f: TEntityForm;
begin
  f := TEntityForm.Create(Self);
  f.Caption := 'Класс';
  f.ShowModal();
  f.Free();
end;

procedure TfmOrganizer.actNewEntityExecute(Sender: TObject);
var
  f: TEntityForm;
begin
  f := TEntityForm.Create(Self);
  f.Caption := 'Сущность';
  f.ShowModal();
  f.Free();
end;

procedure TfmOrganizer.actNewIndividualExecute(Sender: TObject);
var
  f: TEntityForm;
begin
  f := TEntityForm.Create(Self);
  f.Caption := 'Индивид';
  f.ShowModal();
  f.Free();
end;

procedure TfmOrganizer.actNewOntologyExecute(Sender: TObject);
var
  f: TEntityForm;
begin
  f := TEntityForm.Create(Self);
  f.Caption := 'Онтология';
  f.ShowModal();
  f.Free();
end;

procedure TfmOrganizer.btSendClick(Sender: TObject);
var
  sIn: WideString;
begin
  sIn := memInput.Text;
  memInput.Clear();

  reOut.Lines.Add('<-- ' + sIn);

  case FMode of
    mNewEntity:
      begin
        if sIn = 'cancel' then
        begin
          reOut.Lines.Add('Операция отменена');
          FMode := mNone;
        end;
        // ...
        reOut.Lines.Add('Создана новая сущность');
        FMode := mNone;
      end;
    mNewClass:
      begin
        if sIn = 'cancel' then
        begin
          reOut.Lines.Add('Операция отменена');
          FMode := mNone;
        end;
        // ...
        reOut.Lines.Add('Создан новый класс');
        FMode := mNone;
      end;
    mNewIndividual:
      begin
        if sIn = 'cancel' then
        begin
          reOut.Lines.Add('Операция отменена');
          FMode := mNone;
        end;
        // ...
        reOut.Lines.Add('Создан новый индивид');
        FMode := mNone;
      end;
    mNewOntology:
      begin
        if sIn = 'cancel' then
        begin
          reOut.Lines.Add('Операция отменена');
          FMode := mNone;
        end;
        // ...
        reOut.Lines.Add('Создана новая онтология');
        FMode := mNone;
      end;
  else
    if sIn = 'new entity' then
    begin
      reOut.Lines.Add('Создаем новую сущность');
      FMode := mNewEntity;
      reOut.Lines.Add('Введите тип сущности или введите "cancel" для отмены операции.');
    end
    else if sIn = 'new class' then
    begin
      reOut.Lines.Add('Создаем новый класс');
      FMode := mNewClass;
      reOut.Lines.Add('Введите имя класса или введите "cancel" для отмены операции.');
    end
    else if sIn = 'new individual' then
    begin
      reOut.Lines.Add('Создаем новый индивид');
      FMode := mNewIndividual;
      reOut.Lines.Add('Введите имя индивида или введите "cancel" для отмены операции.');
    end
    else if sIn = 'new ontology' then
    begin
      reOut.Lines.Add('Создаем новую онтологию');
      FMode := mNewOntology;
      reOut.Lines.Add('Введите имя онтологии или введите "cancel" для отмены операции.');
    end;
  end;
end;

procedure TfmOrganizer.DoCreate();
begin
  inherited DoCreate();

  FMode := mNone;

  // Инициализируем пул в памяти
  InitPool();

  // Инициализируем машину логического вывода
  //FReasoner := TAIWSReasoner.Create();

  tcObjects.Tabs.Clear();
  tcObjects.Tabs.Add('Задания');
  tcObjects.Tabs.Add('Заметки');
  tcObjects.Tabs.Add('Напоминания');

//  SetLength(FTabItems, 3);
//  FTabItems[1] := TTabItem.Create();
//  FTabItems[1].Node := Self.

  tcObjectsChange(nil);

  reOut.Lines.Add('Введите "new entity", "new class", "new individual", "new ontology" для создания новой сущности, класса, индивида, онтологии.');
end;

procedure TfmOrganizer.DoDestroy();
begin
  // TODO: Сделать сохранение сущностей в файл
  // ...
  inherited DoDestroy();
end;

procedure TfmOrganizer.InitPool();
//var
//  loader: TAIWSPoolLoader;
begin
//  FPool := TAIWSMemoryPool.Create();
  // TODO: Сделать загрузку сущностей из файла
  // ...
//  FPool.Open();
end;

procedure TfmOrganizer.memInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    btSendClick(nil);
end;

procedure TfmOrganizer.memInputKeyPress(Sender: TObject; var Key: Char);
begin
  //memInput.Clear();
end;

procedure TfmOrganizer.memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    memInput.Clear();
end;

procedure TfmOrganizer.tcObjectsChange(Sender: TObject);
begin
  tvObjects.Items.Clear();

  case tcObjects.TabIndex of
    0:
      begin
        tvObjects.Items.Add(nil, 'Все задания');
        tvObjects.Items.Add(nil, 'Работа');
        tvObjects.Items.Add(nil, 'Дом');
      end;
    1:
      begin
        tvObjects.Items.Add(nil, 'Все заметки');
        tvObjects.Items.Add(nil, 'Работа');
        tvObjects.Items.Add(nil, 'Дом');
      end;
    2:
      begin
        tvObjects.Items.Add(nil, 'Все напоминания');
        tvObjects.Items.Add(nil, 'Работа');
        tvObjects.Items.Add(nil, 'Дом');
      end;
  end;
end;

end.
