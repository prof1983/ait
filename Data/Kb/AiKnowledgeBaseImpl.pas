{**
@Abstract(База Знаний. Работает с фреймами в виде отдельных файлов N.xml)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.02.2006)
@LastMod(18.05.2012)
@Version(0.5)

Может работать с несколькими источниками знаний. (пока не реализовано)
Обмен даными осуществляется сообщениями на языке AQL.

История версий:
0.0.0.4 - 05.07.2007
0.0.0.3 - 04.07.2007
0.0.0.2 - 11.06.2007 - AIWSOwlClass -> AIOwlClass, AIWSOwlPool -> AIOwlPool, AIWSSet -> AICollection
}
unit AiKnowledgeBaseImpl;

{DEFINE KnowledgeBaseOld}

interface

uses
  ABase,
  {IFDEF KnowledgeBaseOld}
  SysUtils,
  AiBaseTypes, AiFrame, AiPoolImpl_20070511, AiPoolListImpl, AiTermIntf,
  {ELSE}
  AiOwlPoolIntf,
  {ENDIF KnowledgeBaseOld}
  AiBase, AiCollection, AiKnowledgeBaseIntf, AiOwlClassIntf;

type // База Знаний. Работает с фреймами в виде отдельных файлов N.xml
  TAiKnowledgeBase1 = class(TAiFramePool, IAiKnowledgeBase)
  private
    FPools: TAIFramePoolList; // Pools
    // Путь для расположения файлов N.xml
    //FFilePath: WideString;
//    function GetFreimStringByID(ID: TAIID): WideString;
  protected
    function GetTerm(ID: TAIID): IAITerm; safecall;
    function GetTermV(ID: TAIID; Version: TAIVersion): IAITerm; safecall;
    function Get_FrameCount(): Integer; override; safecall;
//    function Get_FrameData(ID: TAIID): IAIData; override; safecall;
//    procedure Set_FrameType(ID, Typ: TAIID); override; safecall;
  protected
    procedure DoCreate(); override; safecall;
  public // IAiKnowledgeBase
      // Возвращает список онтологических классов
    function GetClasses(): IAiCollection;
  public
    //** Закрываем все пулы
    procedure Close(); override; safecall;
    //function GetFreimDTCreate(ID: TAIID): TDateTime;
    //function GetFreimType(Id: TAIID): TAIID; override;
    // Создать новый класс
    function NewClass(Name: WideString): IAiOwlClass;
    //** Создать новый фрейм
    function NewFrame(): TAIID; override; safecall;
    //** Создать новый фрейм
    function NewFrameA(): IAIFrame; override; safecall;
    //** Новый фрейм
    function NewFrameB(Typ: TAIID; ID: TAIID = 0): TAIID; override; safecall;
    //** Открываем все пулы
    function Open(): AError; override; safecall;
    function ToString(): WideString; override; safecall;
  public
    //property FilePath: WideString read FFilePath write FFilePath;
//    property FreimStringByID[ID: TAIID]: WideString read GetFreimStringByID;
    // Pools
    property Pools: TAIFramePoolList read FPools;
  end;

type
  TAiKnowledgeBaseOwl = class(TInterfacedObject, IAiKnowledgeBase1)
  private
    // Пул для чтения и записи онтологических (OWL) сущностей
    FPool: IAiOwlPool;
  public // IAiKnowledgeBase
      // Возвращает список онтологических классов
    function GetClasses(): IAiCollection;
  public
    // Создать новый класс
    function NewClass(Name: WideString): IAiOwlClass;
  public
    // Пул для чтения и записи онтологических (OWL) сущностей
    property Pool: IAiOwlPool read FPool write FPool;
  end;

type
  {$IFDEF KnowledgeBaseOld}
  TAiKnowledgeBase = TAiKnowledgeBase1;
  {$ELSE}
  TAiKnowledgeBase = TAiKnowledgeBaseOwl; // deprecated
  {$ENDIF KnowledgeBaseOld}

implementation

{ TAiKnowledgeBase1 }

procedure TAiKnowledgeBase1.Close();
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

procedure TAiKnowledgeBase1.DoCreate();
begin
  inherited DoCreate();
  FName := 'KnowlegeBase';
  FPools := TAIFramePoolList.Create();
  Self.FBase := 1;
  Self.FCapacity := 100000;
end;

function TAiKnowledgeBase1.GetClasses(): IAiCollection;
begin
  Result := nil;
end;

function TAiKnowledgeBase1.GetTerm(ID: TAIID): IAITerm;
begin
  Result := nil;
  // ...
end;

function TAiKnowledgeBase1.GetTermV(ID: TAIID; Version: TAIVersion): IAITerm;
begin
  Result := nil;
  // ...
end;

function TAiKnowledgeBase1.Get_FrameCount(): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FPools.Count - 1 do
    Result := Result + FPools.PoolByIndex[i].Frames.Count;
end;

{function TAiKnowlegeBase1.Get_FrameData(ID: TAIID): IAIData;
begin
//  Result := inherited FreimDataGet(Id);
  Result := nil;
//  if Id >= FreimCount then Exit;
//  Result := nil;
end;}

(*function TAiKnowlegeBase1.GetFreimStringByID(ID: TAIID): WideString;
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

//function TAiKnowlegeBase1.GetFreimDTCreate(Id: TAIID): TDateTime;
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

//function TAiKnowlegeBase1.GetFreimType(Id: TAI_Id): TAI_Id;
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

function TAiKnowledgeBase1.NewClass(Name: WideString): IAiOwlClass;
begin
  Result := nil;
end;

function TAiKnowledgeBase1.NewFrame(): TAIID;
begin
  Result := 0;
  if FPools.Count > 0 then
  try
    Result := FPools.PoolByIndex[0].NewFrame();
  except
  end;
end;

function TAiKnowledgeBase1.NewFrameA(): IAIFrame;
begin
  Result := nil;
  if FPools.Count > 0 then
  try
    Result := FPools.PoolByIndex[0].NewFrameA();
  except
  end;
end;

function TAiKnowledgeBase1.NewFrameB(Typ: TAIID; ID: TAIID = 0): TAIID;
begin
  Result := 0;
  if FPools.Count > 0 then
  try
    //Result := FPools.PoolByIndex[0].NewFrameB(Typ, ID);
  except
  end;
end;

function TAiKnowledgeBase1.Open(): AError;
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

function TAiKnowledgeBase1.ToString(): WideString;
var
  i: Integer;
begin
  Result := inherited ToString() + #13#10 + 'PoolList ('+IntToStr(FPools.Count)+'): ';
  for i := 0 to FPools.Count - 1 do
  Result := #13#10 + FPools.PoolByIndex[i].Name;
end;

{procedure TAiKnowlegeBase1.Set_FrameType(Id, Typ: TAIID);
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

{ TAiKnowledgeBaseOwl }

function TAiKnowledgeBaseOwl.GetClasses(): IAiCollection;
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

function TAiKnowledgeBaseOwl.NewClass(Name: WideString): IAiOwlClass;
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

end.
