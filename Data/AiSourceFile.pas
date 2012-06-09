{**
@Abstract(Источник)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.02.2006)
@LastMod(09.06.2012)
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
  TAiSourceFileObject = class(TAiSourceObject)
  protected
    FF: TFileProfKB;
    FFileName: String;
    FFilePath: String;          // Путь для расположения дополнительных файлов
  public
    function Close(): AError; override;
    function GetCountFreims(): UInt64; override;
    function GetFile: TFileProfKB;
    function GetFileName(): String;
    function GetFilePath(): String;
    function GetFreimConnects(Id: TAId): TAiConnectsObject; override;
    function GetFreimData(Id: TAId): TAiDataObject; override;
    function GetFreimDTCreate(Id: TAId): TDateTime;
    function GetFreimType(Id: TAId): TAId; override;
    function NewFreim(Typ: TAId; Id: TAId = 0): TAId; override;
    function Open(): AError; override;
    function OpenCreate(): AError;
    function SetFileName(const Value: string): AError;
    function SetFilePath(const Value: string): AError;
    function SetFreimType(Id, Typ: TAId): AError; override;
  public
    constructor Create(const FileName, Path: string);
  end;

  TAiSourceFile2004 = class(TAiSource2004)
  private
    FSource: TAiSourceFileObject;
  public
    constructor Create(const FileName, Path: string);
  end;

  TAiSourceFile = TAiSourceFileObject;
  TAiSourceFile20050915 = TAiSourceFileObject;
  TAISourceFileCashe = TAiSourceFileObject;

implementation

{ TAISourceFile }

function TAiSourceFileObject.Close(): AError;
begin
  if Assigned(FF) then
    FF.Free();
  FF := nil;
  Result := inherited Close();
end;

constructor TAiSourceFileObject.Create(const FileName, Path: string);
begin
  inherited Create();
  Self.FFileName := FileName;
  Self.FFilePath := Path;
end;

function TAiSourceFileObject.GetCountFreims(): UInt64;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.GetHeaderKB.CountF;
end;

function TAiSourceFileObject.GetFile: TFileProfKB;
begin
  Result := FF;
end;

function TAiSourceFileObject.GetFileName(): String;
begin
  Result := FFileName;
end;

function TAiSourceFileObject.GetFilePath(): String;
begin
  Result := FFilePath;
end;

function TAiSourceFileObject.GetFreimConnects(Id: TAId): TAiConnectsObject;
begin
  Result := nil;
end;

function TAiSourceFileObject.GetFreimData(Id: TAId): TAiDataObject;
begin
  {Result := inherited FreimDataGet(Id);
  Result := nil;
  {if Id >= FreimCount then Exit;}
  Result := nil;
end;

function TAiSourceFileObject.GetFreimDTCreate(Id: TAId): TDateTime;
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

function TAiSourceFileObject.GetFreimType(Id: TAId): TAId;
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

function TAiSourceFileObject.NewFreim(Typ: TAId; Id: TAId = 0): TAId;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.FreimNew(Typ);
end;

function TAiSourceFileObject.Open(): AError;
begin
  Close();
  if (FFileName = '') or (FFilePath = '') then
  begin
    Result := -2;
    Exit;
  end;
  FF := TFileProfKB.Create();
  Result := FF.Open2(FFileName, FFilePath);
end;

function TAiSourceFileObject.OpenCreate(): AError;
begin
  Close();
  if not(SaveSourceToFileN(Self, FFileName, FFilePath)) then
  begin
    Result := -1;
    Exit;
  end;
  Result := Open();
end;

function TAiSourceFileObject.SetFileName(const Value: string): AError;
begin
  if Assigned(FF) then
  begin
    Result := -2;
    Exit;
  end;
  FFileName := Value;
  Result := 0;
end;

function TAiSourceFileObject.SetFilePath(const Value: string): AError;
begin
  if Assigned(FF) then
  begin
    Result := -2;
    Exit;
  end;
  FFilePath := Value;
  Result := 0;
end;

function TAiSourceFileObject.SetFreimType(Id, Typ: TAId): AError;
var
  Rec: TAIFreimRecF64;
begin
  Result := -1;
  if not(Assigned(FF)) then Exit;
  {Result := FF.TypeSet(Id, Typ);}
  if Id >= GetCountFreims then Exit;
  if FF.FreimRead64(Id, Rec) <> 0 then Exit;
  Rec.Typ := Typ;
  Result := FF.FreimWrite64_2(Id, Rec);
end;

{ TAiSourceFile2004 }

constructor TAiSourceFile2004.Create(const FileName, Path: string);
begin
  inherited Create();
  FSource := TAiSourceFile.Create(FileName, Path);
end;

end.
