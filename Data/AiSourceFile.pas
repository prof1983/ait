{**
@Abstract(Источник)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.02.2006)
@LastMod(18.05.2012)
@Version(0.5)

0.0.0.1 - 14.02.2006 - From Prof_AI_Class
}
unit AiSourceFile;

// TODO: Rename AiSourceFile.pas -> AiSourceFileObj.pas
// TODO: Rename TAiSource -> TAiSourceObject

interface

uses
  ATypes,
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
    function GetFreimConnects(Id: TAI_Id): TAiConnectsObject; override;
    function GetFreimData(Id: TAI_Id): TAiData; override; //function GetFreimData(Id: TAI_Id): TAI_Data; override;
    function GetFreimDTCreate(Id: TAI_Id): TDateTime;
    function GetFreimType(Id: TAI_Id): TAI_Id; override;
    function NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id; override;
    function Open: Boolean; override;
    function OpenCreate: Boolean;
    function SetFileName(const Value: string): Boolean;
    function SetFilePath(const Value: string): Boolean;
    function SetFreimType(Id, Typ: TAI_Id): Boolean; override;
  public
    constructor Create(const FileName, Path: string);
  end;

  TAiSourceFile2004 = class(TAiSource2004)
  end;

  {259}
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

function TAISourceFile.GetFreimConnects(Id: TAI_Id): TAiConnectsObject;
begin
  Result := nil;
end;

function TAISourceFile.GetFreimData(Id: TAI_Id): TAiData;
begin
  {Result := inherited FreimDataGet(Id);
  Result := nil;
  {if Id >= FreimCount then Exit;}
  Result := nil;
end;

function TAISourceFile.GetFreimDTCreate(Id: TAI_Id): TDateTime;
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

function TAISourceFile.GetFreimType(Id: TAI_Id): TAI_Id;
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

function TAISourceFile.NewFreim(Typ: TAI_Id; Id: TAI_Id = 0): TAI_Id;
begin
  Result := 0;
  if not(Assigned(FF)) then Exit;
  Result := FF.FreimNew(Typ);
end;

function TAISourceFile.Open(): Boolean;
begin
  Close();
  if (FFileName = '') or (FFilePath = '') then
  begin
    Result := False;
    Exit;
  end;
  FF := TFileProfKB.Create();
  Result := FF.Open(FFileName);
end;

function TAISourceFile.OpenCreate: Boolean;
begin
  Close();
  Result := SaveSourceToFileN(Self, FFileName, FFilePath);
  if not(Result) then Exit;
  Result := Open();
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

function TAISourceFile.SetFreimType(Id, Typ: TAI_Id): Boolean;
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

end.
