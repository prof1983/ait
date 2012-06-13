{**
@Abstract(База Знаний. Работает с фреймами в виде отдельных файлов N.xml)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.02.2006)
@LastMod(13.06.2012)
@Version(0.5)

Может работать с несколькими источниками знаний. (пока не реализовано)
Обмен даными осуществляется сообщениями на языке AQL.

История версий:
0.0.0.4 - 05.07.2007
0.0.0.3 - 04.07.2007
0.0.0.2 - 11.06.2007 - AIWSOwlClass -> AIOwlClass, AIWSOwlPool -> AIOwlPool, AIWSSet -> AICollection
}
unit AiKnowledgeBaseImpl;

interface

uses
  SysUtils,
  ABase, ACollectionIntf, AOwlClassIntf, AOwlPoolIntf,
  AiFrameIntf, AiKnowledgeBaseIntf, AiPoolImpl_20070511, AiPoolListImpl, AiTermIntf;

type // База Знаний. Работает с фреймами в виде отдельных файлов N.xml
  TAiKnowledgeBase = class(TAiFramePool, IAiKnowledgeBaseOld, IAiKnowledgeBaseOwl)
  protected
      //** Пул для чтения и записи онтологических (OWL) сущностей
    FPool: IAiOwlPool;
      //** Pools
    FPools: TAIFramePoolList;
    // Путь для расположения файлов N.xml
    //FFilePath: WideString;
//    function GetFreimStringByID(ID: TAIID): WideString;
  protected
    function GetTerm(ID: TAId): IAITerm; safecall;
    function GetTermV(ID: TAId; Version: AVersion): IAITerm; safecall;
    function Get_FrameCount(): Integer; override; safecall;
//    function Get_FrameData(ID: TAIID): IAIData; override; safecall;
//    procedure Set_FrameType(ID, Typ: TAIID); override; safecall;
  protected
    procedure DoCreate(); override; safecall;
  public // IAiKnowledgeBase
      // Возвращает список онтологических классов
    function GetClasses(): IACollection;
  public
    //** Закрываем все пулы
    procedure Close(); override; safecall;
    //function GetFreimDTCreate(ID: TAIID): TDateTime;
    //function GetFreimType(Id: TAIID): TAIID; override;
    // Создать новый класс
    function NewClass(Name: WideString): IAiOwlClass;
    //** Создать новый фрейм
    function NewFrame(): TAId; override; safecall;
    //** Создать новый фрейм
    function NewFrameA(): IAIFrame; override; safecall;
    //** Новый фрейм
    function NewFrameB(Typ: TAId; ID: TAId = 0): TAId; override; safecall;
    //** Открываем все пулы
    function Open(): AError; override; safecall;
    function ToString(): WideString; override; safecall;
  public
    //property FilePath: WideString read FFilePath write FFilePath;
//    property FreimStringByID[ID: TAIID]: WideString read GetFreimStringByID;
      //** Пул для чтения и записи онтологических (OWL) сущностей
    property Pool: IAiOwlPool read FPool write FPool;
      //** Pools
    property Pools: TAIFramePoolList read FPools;
  end;

  //TAiKnowledgeBase1 = TAiKnowledgeBase;
  //TAiKnowledgeBaseOwl = TAiKnowledgeBase;

implementation

{ TAiKnowledgeBase }

procedure TAiKnowledgeBase.Close();
var
  i: Integer;
begin
  for i := 0 to FPools.Count - 1 do
  try
    FPools.PoolByIndex[i].Close();
  except
  end;
  inherited Close();
end;

procedure TAiKnowledgeBase.DoCreate();
begin
  inherited DoCreate();
  FName := 'KnowlegeBase';
  FPools := TAIFramePoolList.Create();
  Self.FBase := 1;
  Self.FCapacity := 100000;
end;

function TAiKnowledgeBase.GetClasses(): IACollection;
begin
  if not(Assigned(FPool)) then
  begin
    Result := nil;
    Exit;
  end;
  try
    Result := FPool.GetClasses();
  except
    Result := nil;
  end;
end;

function TAiKnowledgeBase.GetTerm(ID: TAId): IAITerm;
begin
  Result := nil;
  // ...
end;

function TAiKnowledgeBase.GetTermV(ID: TAId; Version: AVersion): IAITerm;
begin
  Result := nil;
  // ...
end;

function TAiKnowledgeBase.Get_FrameCount(): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FPools.Count - 1 do
    Result := Result + FPools.PoolByIndex[i].Frames.Count;
end;

{function TAiKnowlegeBase.Get_FrameData(ID: TAIID): IAIData;
begin
//  Result := inherited FreimDataGet(Id);
  Result := nil;
//  if Id >= FreimCount then Exit;
//  Result := nil;
end;}

(*function TAiKnowlegeBase.GetFreimStringByID(ID: TAIID): WideString;
var
  f: file;
  r: Integer;
  s: ShortString;
  ws: WideString;
  i: Integer;
  p: PChar;
begin
  Result := '';
  ws := '';
  {$I-}
  GetMem(p, 200);
  AssignFile(f, FFilePath + IntToStr(ID) + '.ar');
  Reset(f, 1);
  while not(Eof(f)) do
  begin
    //BlockRead(f, s[1], 100, r);
    BlockRead(f, p^, 100, r);
    s := string(p);
    ws := ws + Copy(s, 1, r);
  end;
  CloseFile(f);
  FreeMem(p);
  {$I+}

  // Избавляемся от символов #10 #13
  for i := 1 to Length(ws) do
    if (ws[i] <> #10) and (ws[i] <> #13) then
      Result := Result + ws[i];
end;*)

//function TAiKnowlegeBase.GetFreimDTCreate(Id: TAIID): TDateTime;
//var
//  Rec: TAIFreimRecF64;
//begin
//  Result := 0;
//  if not(Assigned(FF)) then Exit;
//  {Result := FF.DTCreate(Id);}
//  if Id >= GetCountFreims then Exit;
//  if FF.FreimRead(Id, Rec) <> 0 then Exit;
//  Result := Rec.DTCreate;
//end;

//function TAiKnowlegeBase.GetFreimType(Id: TAI_Id): TAI_Id;
//var
//  Rec: TAIFreimRecF64;
//begin
//  Result := 0;
//  if not(Assigned(FF)) then Exit;
//  {Result := FF.TypeGet(Id);}
//  if Id >= GetCountFreims then Exit;
//  if FF.FreimRead(Id, Rec) <> 0 then Exit;
//  Result := Rec.Typ;
//end;

function TAiKnowledgeBase.NewClass(Name: WideString): IAiOwlClass;
begin
  if not(Assigned(FPool)) then
  begin
    Result := nil;
    Exit;
  end;
  try
    Result := FPool.NewClass(Name);
  except
    Result := nil;
  end;
end;

function TAiKnowledgeBase.NewFrame(): TAId;
begin
  Result := 0;
  if FPools.Count > 0 then
  try
    Result := FPools.PoolByIndex[0].NewFrame();
  except
  end;
end;

function TAiKnowledgeBase.NewFrameA(): IAIFrame;
begin
  Result := nil;
  if FPools.Count > 0 then
  try
    Result := FPools.PoolByIndex[0].NewFrameA();
  except
  end;
end;

function TAiKnowledgeBase.NewFrameB(Typ: TAId; ID: TAId = 0): TAId;
begin
  Result := 0;
  if FPools.Count > 0 then
  try
    //Result := FPools.PoolByIndex[0].NewFrameB(Typ, ID);
  except
  end;
end;

function TAiKnowledgeBase.Open(): AError;
var
  i: Integer;
  r: Integer;
begin
  Result := inherited Open();
  for i := 0 to FPools.Count - 1 do
  try
    r := FPools.PoolByIndex[i].Open();
    if r < 0 then
      Result := -1;
  except
  end;
end;

function TAiKnowledgeBase.ToString(): WideString;
var
  i: Integer;
begin
  Result := inherited ToString() + #13#10 + 'PoolList ('+IntToStr(FPools.Count)+'): ';
  for i := 0 to FPools.Count - 1 do
  Result := #13#10 + FPools.PoolByIndex[i].Name;
end;

{procedure TAiKnowlegeBase.Set_FrameType(Id, Typ: TAIID);
//var
//  Rec: TAIFreimRecF64;
begin
//  Result := False;
//  if not(Assigned(FF)) then Exit;
//  Result := FF.TypeSet(Id, Typ);
//  if Id >= GetCountFreims then Exit;
//  if FF.FreimRead(Id, Rec) <> 0 then Exit;
//  Rec.Typ := Typ;
//  Result := FF.FreimWrite(Id, Rec);
end;}

end.
