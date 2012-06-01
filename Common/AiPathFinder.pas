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
unit AiPathFinder;

interface

type
  TPoint = record
    X: longint;
    Y: longint;
  end;

  TTile = record
    TerrType: byte;
    Status: byte;
    value: real;
    gval: real;
    hval: real;
    fval: real;
    Prev: TPoint;
  end;

const
  ttWall   = 0; // препятствие
  ttType1  = 1; // тип территории 1 - самый плохо проходимый тип территории
  ttType2  = 2; // тип территории 2
  ttType3  = 3; // тип территории 3
  ttType4  = 4; // тип территории 4
  ttType5  = 5; // тип территории 5
  ttClear  = 6; // проходимая клетка - самый хорошо проходимый тип территории

  tsPath       = 1; // путь
  tsUnvisited  = 2; // непосещенная точка
  tsBound      = 3; // граничная точка
  tsPassed     = 4; // проверенная точка
  tsStart      = 5; // точка старта
  tsFinish     = 6; // точка финиша


  MaxX   = 56;
  MaxY   = 56;

 Courses : array [1..8] of TPoint=((X:0;Y:-1),(X:1;Y:-1),(X:1;Y:0),(X:1;Y:1),
                                   (X:0;Y:1),(X:-1;Y:1),(X:-1;Y:0),(X:-1;Y:-1));
 Marks   : Set of byte = [tsPath, tsBound, tsPassed];

 MaxBoundSize = 500;

type
 TMap     = array[0..101,0..101] of TTile;
 TBound   = array[1..MaxBoundSize] of TPoint;

 function FindPath(Src,Dst: TPoint;var Map: TMap): boolean;
 function EqualPoints(a,b:TPoint):boolean ;

implementation

function EqualPoints(a,b:TPoint):boolean ;
begin
 Result:=(A.X=B.X) and (A.Y=B.Y);
end;
function Point(AX , AY : integer): TPoint;
begin
 Result.X:=AX;
 Result.Y:=AY;
end;

function Max(x,y: real):real;
begin
 if x>y then Result:=x else Result:=y;
end;

function Min(x,y: real):real;
begin
 if x>y then Result:=y else Result:=x;
end;

function HEst(A,B: TPoint; dx2,dy2:real): real;
var dx,dy,cross : real;
begin
 dx:= A.X - B.X;
 dy:= A.Y - B.Y;
// dx2:= Src.X - Dst.X;
// dy2:= Src.Y - Dst.Y;
 cross:= dx*dy2 - dx2*dy;
 if( cross<0 ) then cross:=-cross;
 Result:= max(abs(dx), abs(dy))+cross*0.001;

// Result:=sqrt(sqr(A.x-B.x)+sqr(A.y-B.y));
end;


function FindPath(Src,Dst: TPoint;var Map: TMap): boolean;
var
         A : TPoint;
     i,j,k : byte;
     dx,dy : real;
     Bound : TBound;
     BSize : integer;

const kk   : array[0..1] of real=(1.42,1);

function FindMin: integer;
var i,n: integer;
begin
  n:=1;
  for i:=1 to BSize do
    if Map[bound[n].X,bound[n].Y].fval>Map[bound[i].X,bound[i].Y].fval
      then n:=i;
  result:=n;
end;

procedure AddToBound(Point:TPoint);
begin
 if BSize>=MaxBoundSize then exit;
 BSize:=BSize+1;
 Bound[BSize]:=Point;
end;

begin // FindPath
 dx:=Src.X-Dst.X;
 dy:=Src.Y-Dst.Y;
 Map[Src.X,Src.Y].Status:=tsBound;
 Map[Dst.X,Dst.Y].Status:=tsFinish;
 BSize:=1;
 Map[Src.x,Src.y].gval:=0;
 Map[Src.x,Src.y].hval:=HEst(Src,Dst,dx,dy);
 Map[Src.x,Src.y].fval:=Map[Src.x,Src.y].gval+Map[Src.x,Src.y].hval;
 Bound[1]:=Src;
 Result:=False;
 while BSize>0 do
  begin
      k:=FindMin; //BSize;
      i:=Bound[k].x;
      j:=Bound[k].y;
      Map[bound[k].X,bound[k].Y].Status:=tsPassed;
      bound[k]:=bound[BSize];
      BSize:=BSize-1;
        for k:=1 to 8 do
         begin
          A.X:=i+Courses[k].X;
          A.Y:=j+Courses[k].Y;
          if Map[A.x,A.y].TerrType<>ttWall then
           case Map[A.x,A.y].Status of
            tsUnvisited:
                       begin
                        Map[A.X,A.Y].gval:=Map[i,j].gval+Map[A.X,A.Y].value*kk[k mod 2];
                        Map[A.X,A.Y].fval:=Map[A.X,A.Y].gval+HEst(A,Dst,dx,dy);
                        Map[A.X,A.Y].Prev:=Point(i,j);
                        Map[A.X,A.Y].Status:=tsBound;
                        AddToBound(A);
                       end;
            tsFinish :
                       begin
                        Map[A.X,A.Y].Prev:=Point(i,j);
                        Map[Src.X,Src.Y].Status:=tsStart;
                        Result:=True;
                        exit;
                       end;
 {           tsBound  :
                       begin
                        _gval:=Map[i,j].gval+Map[A.X,A.Y].value*kk[k mod 2];
                        if _gval<Map[A.X,A.Y].gval then
                         begin
                           Map[A.X,A.Y].gval:=_gval;
                           Map[A.X,A.Y].fval:=Map[A.X,A.Y].gval+HEst(A,Dst);
                           Map[A.X,A.Y].Prev:=Point(i,j);
                           AddToBound(A);
                         end;
                       end;}
           end;
         end;
  end;
 Map[Src.X,Src.Y].Status:=tSStart;
end;

end.
