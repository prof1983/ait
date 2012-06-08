{**
@Abstract(Источник)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.02.2006)
@LastMod(04.06.2012)
@Version(0.5)

0.0.0.1 - 14.02.2006 - From Prof_AI_Class
}
unit AiSourceFile;

// TODO: Rename AiSourceFile.pas -> AiSourceFileObj.pas
// TODO: Rename TAiSource -> TAiSourceObject

interface

uses
  ABase, ATypes,
  AiConnectsObj, AiDataObj, AiIoFileKb, AiTypes, AiSourceObj;

type {258}
  TAISourceFile = class(TAiSourceObject)
  private
    FF: TFileProfKB;
    FFileName: String;
    FFilePath: String;          // Путь для расположения дополнительных файлов
  public
    function Close(): TError; override;
    function GetCountFreims: UInt64; override;
    function GetFile: TFileProfKB;
    function GetFileName(): String;
    function GetFilePath(): String;
    function GetFreimConnects(Id: TAId): TAiConnectsObject; override;
    function GetFreimData(Id: TAId): TAiDataObject; override;
    function GetFreimDTCreate(Id: TAId): TDateTime;
    function GetFreimType(Id: TAId): TAId; override;
    function NewFreim(Typ: TAId; Id: TAId = 0): TAId; override;
    function Open(): AError; override;
    function OpenCreate: Boolean;
    function SetFileName(const Value: string): Boolean;
    function SetFilePath(const Value: string): Boolean;
    function SetFreimType(Id, Typ: TAId): Boolean; override;
  public
    constructor Create(const FileName, Path: string);
  end;

  TAiSourceFile2004 = class(TAiSource2004)
  private
    FSource: TAiSourceFile;
  public
    constructor Create(const FileName, Path: string);
  end;

  TAiSourceFile20050915 = class(TAiSourceObject2005)
  private
    FF: TFileProfKB;
    FFileName: String;
    FFilePath: String;          {Путь для расположения дополнительных файлов}
  public
    function Close(): TError; override;
    function GetCountFreims(): UInt64; override;
    function GetFile(): TFileProfKB;
    function GetFileName(): String;
    function GetFilePath(): String;
    function GetFreimDTCreate(Id: TAId): TDateTime;
    function GetFreimType(Id: TAId): TAId; override;
    function NewFreim(Typ: TAId; Id: TAId = 0): TAId; override;
    function Open(): TError; override;
    function OpenCreate(): AError;
    function SetFileName(Value: String): AError;
    function SetFilePath(Value: String): AError;
    function SetFreimType(Id, Typ: TAId): AError; override;
  end;

  TAISourceFileCashe = TAISourceFile;

implementation

{ TAISourceFile }

function TAISourceFile.Close(): TError;
begin
  if Assigned(FF) then
    FF.Free();
  FF := nil;
  Result := inherited Close();
end;

constructor TAISourceFile.Create(const FileName, Path: string);
begin
  inherited Create();
  Self.FFileName := FileName;
  Self.FFilePath := Path;
end;

function TAISourceFile.GetCountFreims: UInt64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.GetHeaderKB.CountF;
end;

function TAISourceFile.GetFile: TFileProfKB;
begin
  Result := FF;
end;

function TAISourceFile.GetFileName(): String;
begin
  Result := FFileName;
end;

function TAISourceFile.GetFilePath(): String;
begin
  Result := FFilePath;
end;

function TAISourceFile.GetFreimConnects(Id: TAId): TAiConnectsObject;
begin
  Result := nil;
end;

function TAISourceFile.GetFreimData(Id: TAId): TAiDataObject;
begin
  {Result := inherited FreimDataGet(Id);
  Result := nil;
  {if Id >= FreimCount then Exit;}
  Result := nil;
end;

function TAISourceFile.GetFreimDTCreate(Id: TAId): TDateTime;
var
  Rec: TAIFreimRecF64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.DTCreate(Id);}
  if Id >= GetCountFreims then Exit;
  if FF.FreimRead64(Id, Rec) <> 0 then Exit;
  Result := Rec.DTCreate;
end;

function TAISourceFile.GetFreimType(Id: TAId): TAId;
var
  Rec: TAIFreimRecF64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.TypeGet(Id);}
  if Id >= GetCountFreims then Exit;
  if FF.FreimRead64(Id, Rec) <> 0 then Exit;
  Result := Rec.Typ;
end;

function TAISourceFile.NewFreim(Typ: TAId; Id: TAId = 0): TAId;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.FreimNew(Typ);
end;

function TAISourceFile.Open(): AError;
begin
  Close();
  if (FFileName = '') or (FFilePath = '') then
  begin
    Result := -2;
    Exit;
  end;
  FF := TFileProfKB.Create();
  if FF.Open(FFileName) then
    Result := 0
  else
    Result := -1;
end;

function TAISourceFile.OpenCreate: Boolean;
begin
  Close();
  Result := SaveSourceToFileN(Self, FFileName, FFilePath);
  if not(Result) then Exit;
  Result := (Open() >= 0);
end;

function TAISourceFile.SetFileName(const Value: string): Boolean;
begin
  if Assigned(FF) then
  begin
    Result := False;
    Exit;
  end;
  FFileName := Value;
  Result := True;
end;

function TAISourceFile.SetFilePath(const Value: string): Boolean;
begin
  if Assigned(FF) then
  begin
    Result := False;
    Exit;
  end;
  FFilePath := Value;
  Result := True;
end;

function TAISourceFile.SetFreimType(Id, Typ: TAId): Boolean;
var
  Rec: TAIFreimRecF64;
begin
  Result := False;
  if not(Assigned(FF)) then Exit;
  {Result := FF.TypeSet(Id, Typ);}
  if Id >= GetCountFreims then Exit;
  if FF.FreimRead64(Id, Rec) <> 0 then Exit;
  Rec.Typ := Typ;
  Result := FF.FreimWrite64(Id, Rec);
end;

{ TAiSourceFile2004 }

constructor TAiSourceFile2004.Create(const FileName, Path: string);
begin
  inherited Create();
  FSource := TAiSourceFile.Create(FileName, Path);
end;

{ TAiSourceFile20050915 }

function TAiSourceFile20050915.Close(): AError;
begin
  if Assigned(FF) then FF.Free;
  FF := nil;
  Result := inherited Close;
end;

function TAiSourceFile20050915.GetCountFreims(): UInt64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.GetHeaderKB.CountF;
end;

function TAiSourceFile20050915.GetFile(): TFileProfKB;
begin
  Result := FF;
end;

function TAiSourceFile20050915.GetFileName(): String;
begin

end;

function TAiSourceFile20050915.GetFilePath(): String;
begin
  Result := FFilePath;
end;

function TAiSourceFile20050915.GetFreimDTCreate(Id: TAId): TDateTime;
var
  Rec: TAiFreimRecF64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.DTCreate(Id);}
  if Id >= GetCountFreims then Exit;
  if FF.FreimRead64(Id, Rec) <> 0 then Exit;
  Result := Rec.DTCreate;
end;

function TAiSourceFile20050915.GetFreimType(Id: TAId): TAId;
var
  Rec: TAIFreimRecF64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  {Result := FF.TypeGet(Id);}
  if Id >= GetCountFreims then Exit;
  if FF.FreimRead64(Id, Rec) <> 0 then Exit;
  Result := Rec.Typ;
end;

function TAiSourceFile20050915.NewFreim(Typ: TAId; Id: TAId = 0): TAId;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.FreimNew(Typ);
end;

function TAiSourceFile20050915.Open(): AError;
begin
  Close;
  if (FFileName = '') or (FFilePath = '') then
  begin
    Result := -1;
    Exit;
  end;
  FF := TFileProfKB.Create;
  Result := FF.Open2(FFileName, '');
end;

function TAiSourceFile20050915.OpenCreate(): AError;
begin
  Close;
  if SaveSourceToFileN(Self, FFileName, FFilePath) then
    Result := 0
  else
    Result := -1;
  if Result <> 0 then Exit;
  Result := Open;
end;

function TAiSourceFile20050915.SetFileName(Value: String): AError;
begin
  Result := 1;
end;

function TAiSourceFile20050915.SetFilePath(Value: String): AError;
begin
  Result := 1;
end;

function TAiSourceFile20050915.SetFreimType(Id, Typ: TAId): AError;
var
  Rec: TAIFreimRecF64;
begin
  Result := 1;
  if not(Assigned(FF)) then Exit;
  {Result := FF.TypeSet(Id, Typ);}
  if Id >= GetCountFreims then Exit;
  if FF.FreimRead64(Id, Rec) <> 0 then Exit;
  Rec.Typ := Typ;
  Result := FF.FreimWrite64_2(Id, Rec);
end;

end.
