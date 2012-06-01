{**
@Abstract(База Знаний. Работает с фреймами в виде отдельных файлов N.xml)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.02.2006)
@LastMod(25.05.2012)
@Version(0.5)

Может работать с несколькими источниками знаний. (пока не реализовано)
Обмен даными осуществляется сообщениями на языке AQL.
}
unit AiKnowlegeBase3;

interface

uses
  SysUtils,
  ABase,
  AiBase, AiFrameImpl, AiIntf, AiSourceImpl, AiSourceListImpl;

type //** База Знаний. Работает с фреймами в виде отдельных файлов N.xml
  TAIKnowlegeBase3 = class(TAiSource)
  private
    FSources: TAISourceList3;
      //** Путь для расположения файлов N.xml
    //FFilePath: WideString;
//    function GetFreimStringByID(ID: TAIID): WideString;
  protected
    function Get_FrameCount(): Integer; override; safecall;
//    function Get_FrameData(ID: TAIID): IAIData; override; safecall;
//    procedure Set_FrameType(ID, Typ: TAIID); override; safecall;
  public
    procedure Close(); override; safecall;
    //function GetFreimDTCreate(ID: TAIID): TDateTime;
    //function GetFreimType(Id: TAIID): TAIID; override;
    function NewFrame(Typ: TAIID; ID: TAIID = 0): TAIID; override; safecall;
    function Open(): AError; override; safecall;
  public
    //property FilePath: WideString read FFilePath write FFilePath;
//    property FreimStringByID[ID: TAIID]: WideString read GetFreimStringByID;
    property Sources: TAISourceList3 read FSources;
  end;

implementation

{ TAIKnowlegeBase3 }

procedure TAIKnowlegeBase3.Close();
var
  i: Integer;
begin
  for i := 0 to FSources.Count - 1 do
    FSources.SourceByIndex[i].Close();
  inherited Close();
end;

function TAIKnowlegeBase3.Get_FrameCount(): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FSources.Count - 1 do
    Result := Result + FSources.SourceByIndex[i].FrameCount;
end;

{function TAIKnowlegeBase.Get_FrameData(ID: TAIID): IAIData;
begin
//  Result := inherited FreimDataGet(Id);
  Result := nil;
//  if Id >= FreimCount then Exit;
//  Result := nil;
end;}

(*function TAIKnowlegeBase3.GetFreimStringByID(ID: TAIID): WideString;
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

//function TAIKnowlegeBase.GetFreimDTCreate(Id: TAIID): TDateTime;
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

//function TAIKnowlegeBase.GetFreimType(Id: TAI_Id): TAI_Id;
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

function TAIKnowlegeBase3.NewFrame(Typ: TAIID; ID: TAIID = 0): TAIID;
begin
  Result := 0;
//  if not(Assigned(FF)) then Exit;
//  Result := FF.FreimNew(Typ);
end;

function TAIKnowlegeBase3.Open(): AError;
var
  i: Integer;
  r: Integer;
begin
  Result := inherited Open();
  for i := 0 to FSources.Count - 1 do
  begin
    r := FSources.SourceByIndex[i].Open();
    if r < 0 then
      Result := -1;
  end;
end;

{procedure TAIKnowlegeBase.Set_FrameType(Id, Typ: TAIID);
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
