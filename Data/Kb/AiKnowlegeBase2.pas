{**
@Abstract(База Знаний. Работает с фреймами в виде отдельных файлов N.xml)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.02.2006)
@LastMod(05.07.2012)
@Version(0.5)

Может работать с несколькими источниками знаний. (пока не реализовано)
Обмен даными осуществляется сообщениями на языке AQL.
}
unit AiKnowlegeBase2;

interface

uses
  SysUtils,
  ATypes,
  AiBase, AiIntf, AiSourceImpl;

type //** @abstract(База Знаний. Работает с фреймами в виде отдельных файлов N.xml)
  TAIKnowlegeBase = class(TAISource)
  private
    //FSources: TAISourceList;

    //FF: TFileProfKB;
    // Путь для расположения файлов N.xml
    FFilePath: WideString;
    function GetFreimStringById(Id: TAiId): WideString;
  protected
    //function GetCountFreims(): Integer; override; safecall;
    //procedure SetFreimType(ID, Typ: TAIID); override; safecall;
  public
    procedure Close(); override; safecall;
    //function GetFreimDTCreate(ID: TAIID): TDateTime;
    //function GetFreimType(Id: TAIID): TAIID; override;
    function NewFrame(Typ: TAIID; ID: TAIID = 0): TAIID; override; safecall;
    function Open(): TProfError; virtual; safecall;
    ///function OpenCreate: Boolean;
  public
    property FilePath: WideString read FFilePath write FFilePath;
    property FreimStringByID[ID: TAIID]: WideString read GetFreimStringByID;
  end;

implementation

{ TAIKnowlegeBase }

procedure TAIKnowlegeBase.Close();
begin
  {if Assigned(FF) then FF.Free;
  FF := nil;
  Result := inherited Close;}
end;

{function TAIKnowlegeBase.GetCountFreims(): Integer;
begin
  Result := 0;
//  if not(Assigned(FF)) then Exit;
//  Result := FF.GetHeaderKB.CountF;
end;}

function TAIKnowlegeBase.GetFreimStringByID(ID: TAIID): WideString;
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
end;

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

function TAIKnowlegeBase.NewFrame(Typ: TAIID; ID: TAIID = 0): TAIID;
begin
  Result := 0;
//  if not(Assigned(FF)) then Exit;
//  Result := FF.FreimNew(Typ);
end;

function TAIKnowlegeBase.Open(): TProfError;
begin
  Result := -1;
//  Close;
//  Result := False;
//  if (FFileName = '') or (FFilePath = '') then Exit;
//  FF := TFileProfKB.Create;
//  Result := FF.Open(FFileName);
//  Result := inherited Open;
end;

//function TAIKnowlegeBase.OpenCreate: Boolean;
//begin
//  Close;
//  Result := SaveSourceToFileN(Self, FFileName, FFilePath);
//  if not(Result) then Exit;
//  Result := Open;
//end;

(*procedure TAIKnowlegeBase.SetFreimType(Id, Typ: TAIID);
//var
//  Rec: TAIFreimRecF64;
begin
//  Result := False;
//  if not(Assigned(FF)) then Exit;
//  {Result := FF.TypeSet(Id, Typ);}
//  if Id >= GetCountFreims then Exit;
//  if FF.FreimRead(Id, Rec) <> 0 then Exit;
//  Rec.Typ := Typ;
//  Result := FF.FreimWrite(Id, Rec);
end;*)

end.
