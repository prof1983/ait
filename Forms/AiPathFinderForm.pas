{**
@Abstract(Алгоритм обхода препятствий)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.10.2005)
@LastMod(04.05.2012)
@Version(0.5)

Предлагаемый алгоритм обхода препятствий - это, так называемый, обобщенный алгоритм Дейкстры. В англоязычной литературе он называется алгоритмом A*.

1. Карта разбита на квадратные части, назовем их клетками.
2. Каждая клетка имеет несколько показателей:
1) стоимость прохождения по этой клетке,
2) предыдущая клетка - клетка из которой пришли в эту клетку,
3) статус клетки (непосещенная, граничная, отброшенная),
4) оценка пройденного пути,
5) оценка оставшегося пути.
3. Имеется две клетки - начальная и конечная.
4. Сосед клетки - клетка в которую можно попасть из рассматриваемой за 1 шаг.
Общий принцип: на каждой итерации из всех граничных точек выбирается та, для которой сумма уже пройденного пути и пути до конца по прямой является минимальной, и от нее осуществляется дальнейшее продвижение.
Алгоритм этот проще реализовать, чем описать:

Start - начальная клетка
Finish - конечная клетка.
Алгоритм итерационный
1 шаг: Помечаем Start как граничную точку.
2 шаг: Среди всех граничных точек находим Клетку1 - клетку с минимальной суммой оценки пройденного пути g и оценки оставшегося пути h.
3 шаг: Для Клетки 1 рассматриваем соседей. Если сосед имеет статус непосещенного, то мы обозначаеми его как граничную клетку, и указываем Клетку1 как предыдущую для него. Оценку g1 для соседа принимаем равной g+p, где p-стоимость прохождения по клетке сосед, а g - оценка пройденного пути для Клетки1 . Оценка h для любой клетки равна длине кратчайшего пути (по прямой от рассматриваемой клетки до клетки Finish) Рассматриваемую Клетку1 помечаем как отброшенную.
4 шаг: Если на предыдущем шаге один из соседей оказался равен клетке Finish, то путь найден. Если ни одного нового соседа не существует, то нет и пути.
5 шаг: Переход на шаг 2.

http://www.delphikingdom.com/asp/viewitem.asp?catalogid=166
}
unit AiPathFinderForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  AiPathFinder;

type
  TFormPath = class(TForm)
    Image1: TImage;
    StartButton: TSpeedButton;
    FinishButton: TSpeedButton;
    WallButton: TSpeedButton;
    OpenButton: TSpeedButton;
    SaveButton: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    NewButton: TSpeedButton;
    FindButton: TSpeedButton;
    EraseButton: TSpeedButton;
    ClearButton: TSpeedButton;
    Memo1: TMemo;
    Label2: TLabel;
    ClStatButton: TSpeedButton;
    SvStatButton: TSpeedButton;
    SaveDialog2: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure FinishButtonClick(Sender: TObject);
    procedure WallButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EraseButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ClStatButtonClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SvStatButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
  public
    procedure DoAction(MapX,MapY: integer);
    procedure ReDrawMapXY(I, J: Integer);
    procedure DrawMap;
  end;

implementation

{$R *.DFM}

const
  Start  = 1;
  Finish = 2;
  Wall   = 3;
  Erase  = 4;

  Type1  = 5;
  Type2  = 6;
  Type3  = 7;
  Type4  = 8;
  Type5  = 9;

  mPlace = 1;
  mNone  = 2;

  NullPoint : TPoint = (X:0;Y:0);

  TerrColors : array [0..6] of TColor = ($555555,$999999,$AAAAAA,$BBBBBB,$CCCCCC,$DDDDDD,clWhite);
  StatusColors : array [1..6] of TColor = ($FF0000,clWhite,$00DDDD,$00BB00,clGreen,clRed);

var
  Map: TMap;
  TypeAction: byte;
  Src: TPoint;
  Dst: TPoint;
  Mode: byte;
  Modify: boolean;

procedure TFormPath.FormCreate(Sender: TObject);
var i,j : byte;
begin
 Modify:=False;
 Src:=NullPoint;
 Dst:=NullPoint;
 for i:=1 to MaxX do
  for j:=1 to MaxY do
  begin
    Map[i,j].TerrType:=ttClear;
    Map[i,j].Value:=1;
    Map[i,j].Status:=tsUnvisited;
  end;
 for i:=0 to MaxX+1 do
  begin
   Map[i,0].TerrType:=ttWall;
   Map[0,i].TerrType:=ttWall;
   Map[i,MaxY+1].TerrType:=ttWall;
   Map[MaxX+1,i].TerrType:=ttWall;
  end;
 DrawMap;
end;

procedure TFormPath.StartButtonClick(Sender: TObject);
begin
 TypeAction:=Start;
end;

procedure TFormPath.FinishButtonClick(Sender: TObject);
begin
 TypeAction:=Finish;
end;

procedure TFormPath.WallButtonClick(Sender: TObject);
begin
 TypeAction:=Wall;
end;

procedure TFormPath.NewButtonClick(Sender: TObject);
var i,j : byte;
begin
 for i:=1 to MaxX do
  for j:=1 to MaxY do
   begin
    Map[i,j].TerrType:=ttClear;
    Map[i,j].Status:=tsUnvisited;
   end;
 DrawMap;
end;

procedure TFormPath.EraseButtonClick(Sender: TObject);
begin
 TypeAction:=Erase;
end;

procedure TFormPath.FindButtonClick(Sender: TObject);
var C     : TPoint;
    i,j   : byte;
    len   : word;
    t1,t2 : TDateTime;
    found : boolean;
    hour,min,sec,msec : word;
    sh,sm,ss,sms : string;
begin
 if EqualPoints(Dst,NullPoint) or EqualPoints(Src,NullPoint) then
  exit;
 for i:=1 to MaxX do
  for j:=1 to MaxY do
   begin
    Map[i,j].Status:=tsUnvisited;
    Map[i,j].Prev:=NullPoint;
   end;
 t1:=Time;
 Found:=FindPath(Src,Dst,Map);
 t2:=Time;
 t1:=t2-t1;
 DecodeTime(t1,hour,min,sec,msec);
 if found then
  begin
   len:=1;
   c:=Map[Dst.X,Dst.Y].Prev;
   Map[c.x,c.y].Status:=tsPassed;
   While not EqualPoints(c,Src) do
    begin
     inc(len);
     if Map[c.X,c.y].Status<>tsBound then
      Map[c.X,c.y].Status:=tsPath;
     c:=Map[c.x,c.y].Prev;
    end;
   Memo1.Lines.Add('Длина найденного пути: '+IntToStr(len));
  end
  else Memo1.Lines.Add('Пути не существует!');
  sh:=IntToStr(hour);
  sm:=IntToStr(Min);
  ss:=IntToStr(Sec);
  sms:=IntToStr(MSec);
  sh:=copy('00',1,2-length(sh))+sh;
  sm:=copy('00',1,2-length(sm))+sm;
  ss:=copy('00',1,2-length(ss))+ss;
  sms:=copy('000',1,3-length(sms))+sms;

  Memo1.Lines.Add('Затрачено времени: '+sh+':'+sm+':'+ss+'.'+sms+' сек.');
  Memo1.Lines.Add('------------------------------');
 DrawMap;
end;

procedure TFormPath.SaveButtonClick(Sender: TObject);
var f   : file of byte;
    i,j : byte;
begin
 for i:=1 to MaxX do
  for j:=1 to MaxY do
   begin
    if Map[i,j].Status in Marks then Map[i,j].Status:=tsUnvisited;
   end;
 SaveDialog1.FileName:='*.map';
 if SaveDialog1.Execute then
 begin
  AssignFile(f,SaveDialog1.FileName);
  Memo1.Lines.Add('Сохранена карта: '+SaveDialog1.FileName);
  Modify:=False;
  ReWrite(f);
  for i:=1 to MaxX do
   for j:=1 to MaxY do
    begin
     Write(f,Map[i,j].TerrType);
     Write(f,Map[i,j].Status);
    end;
  CloseFile(f);
 end;
end;

procedure TFormPath.OpenButtonClick(Sender: TObject);
var f   : file of byte;
    i,j : byte;
begin
 OpenDialog1.FileName:='*.map';
 if OpenDialog1.Execute then
 begin
  AssignFile(f,OpenDialog1.FileName);
  Memo1.Lines.Add('Открыта карта: '+OpenDialog1.FileName);
  Modify:=False;
  ReSet(f);
  for i:=1 to MaxX do
   for j:=1 to MaxY do
    begin
     Read(f,Map[i,j].TerrType);
     Read(f,Map[i,j].Status);
     Case Map[i,j].Status of
      tsStart  : begin
                 Src.X:=i;
                 Src.Y:=j;
                end;
      tsFinish : begin
                  Dst.X:=i;
                  Dst.Y:=j;
                 end;
     end;
    end;
  CloseFile(f);
 end;
 DrawMap;
end;

procedure TFormPath.ClearButtonClick(Sender: TObject);
var i,j : byte;
begin
 for i:=1 to MaxX do
  for j:=1 to MaxY do
   begin
    if Map[i,j].Status in Marks then Map[i,j].Status:=tsUnvisited;
   end;
 DrawMap;
end;

procedure TFormPath.ClStatButtonClick(Sender: TObject);
begin
 Memo1.Lines.Clear;
end;

procedure TFormPath.DoAction(MapX,MapY: integer);
begin
    case TypeAction of
     Wall   : begin
               if (MapX<>Src.x) or (MapY<>Src.y) or
                  (MapX<>Dst.x) or (MapY<>Dst.y)
                then
                 begin
                  Map[MapX,MapY].TerrType:=ttWall;
                  Map[MapX,MapY].Value:=100000;
                 end;
               ReDrawMapXY(MapX,MapY);
              end;
     Erase  : begin
               if (MapX<>Src.x) or (MapY<>Src.y) or
                  (MapX<>Dst.x) or (MapY<>Dst.y)
                then
                 Map[MapX,MapY].TerrType:=ttClear;
               Map[MapX,MapY].value:=1;
               ReDrawMapXY(MapX,MapY);
              end;
     Start  : begin
               Map[Src.x,Src.y].Status:=tsUnvisited;
               Map[MapX,MapY].Status:=tsStart;
               ReDrawMapXY(Src.x,Src.y);
               Src.x:=MapX;
               Src.y:=MapY;
              end;
     Finish : begin
               Map[MapX,MapY].Status:=tsFinish;
               Map[Dst.x,Dst.y].Status:=tsUnvisited;
               ReDrawMapXY(Dst.x,Dst.y);
               Dst.x:=MapX;
               Dst.y:=MapY;
              end;
     Type1:   //- самый плохо проходимый тип территории
              begin
                Map[MapX,MapY].TerrType:=ttType1;
                Map[MapX,MapY].value:=20;
                Modify:=True;
              end;
     Type2:
              begin
                Map[MapX,MapY].TerrType:=ttType2;
                Map[MapX,MapY].value:=15;
                Modify:=True;
              end;
     Type3:
              begin
                Map[MapX,MapY].TerrType:=ttType3;
                Map[MapX,MapY].value:=10;
                Modify:=True;
              end;
     Type4:
              begin
                Map[MapX,MapY].TerrType:=ttType4;
                Map[MapX,MapY].value:=5;
                Modify:=True;
              end;
     Type5:  //- самый хорошо проходимый тип территории (кроме ttClear)
              begin
                Map[MapX,MapY].TerrType:=ttType5;
                Map[MapX,MapY].value:=2;
                Modify:=True;
              end;

    end;
    ReDrawMapXY(MapX,MapY);
end;

procedure TFormPath.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  MapX, MapY: integer;
begin
  MapX:=X div 10 +1;
  MapY:=Y div 10 +1;
  if (MapX>0) and (MapY>0) and (MapX<=MaxX) and (MapY<=MaxY) then
   if Button = mbLeft then
    begin
      // Начать рисование
      Mode:=mPlace;
      DoAction(MapX,MapY);
  end;
end;

procedure TFormPath.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  MapX, MapY: integer;
begin
  MapX:=X div 10 + 1;
  MapY:=Y div 10 + 1;
  if (MapX>0) and (MapY>0) and (MapX<=MaxX) and (MapY<=MaxY) then
   if ssLeft in Shift then
    begin
    // Начать рисование
      Mode:=mPlace;
      DoAction(MapX,MapY);
    end;
end;

procedure TFormPath.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Mode:=mNone;
end;

procedure TFormPath.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Memo1.Lines.Add('Выход и автосохранение статистики');
 Memo1.Lines.SaveToFile('Autosave.sts');
end;

procedure TFormPath.SvStatButtonClick(Sender: TObject);
begin
 if SaveDialog2.Execute then
  begin
   Memo1.Lines.Add('Статистика сохранена в файле :'+SaveDialog2.FileName);
   Memo1.Lines.SaveToFile(SaveDialog2.FileName);
  end;
end;

procedure TFormPath.SpeedButton1Click(Sender: TObject);
begin
  TypeAction:=Type1;
end;

procedure TFormPath.SpeedButton2Click(Sender: TObject);
begin
  TypeAction:=Type2;
end;

procedure TFormPath.SpeedButton3Click(Sender: TObject);
begin
  TypeAction:=Type3;
end;

procedure TFormPath.SpeedButton4Click(Sender: TObject);
begin
  TypeAction:=Type4;
end;

procedure TFormPath.SpeedButton5Click(Sender: TObject);
begin
  TypeAction:=Type5;
end;

procedure TFormPath.ReDrawMapXY(I, J: Integer);
var
  A: TRect;
begin
  A.Left:=(i-1)*10+1;
  A.Top:=(j-1)*10+1;
  A.Right:=i*10;
  A.Bottom:=j*10;
  Image1.Canvas.Brush.Color:=TerrColors[Map[i,j].TerrType];
  Image1.Canvas.Brush.Style:=bsSolid;
  Image1.Canvas.FillRect(A);
  if Map[i,j].Status<>tsUnvisited then begin
    Image1.Canvas.Pen.Width:=2;
    Image1.Canvas.Pen.Color:=StatusColors[Map[i,j].Status];
    Image1.Canvas.Brush.Color:=StatusColors[Map[i,j].Status];
    Image1.Canvas.Ellipse(A.Left+2,A.Top+2,A.Right-2,A.Bottom-2);
  end;
end;

procedure TFormPath.DrawMap;
var i,j : byte;
begin
 for i:=1 to MaxX do
  for j:=1 to MaxY do ReDrawMapXY(i,j);
 Image1.Canvas.Pen.Width:=1;
 Image1.Canvas.Pen.Color:=clBlack;
 for i:=0 to MaxX+1 do
  begin
   Image1.Canvas.MoveTo(0,i*10);
   Image1.Canvas.LineTo(560,i*10);
   Image1.Canvas.MoveTo(i*10,0);
   Image1.Canvas.LineTo(i*10,560);
  end;
end;

end.
