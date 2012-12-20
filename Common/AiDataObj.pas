{**
@Abstract Базовый тип данных для AI
@Author Prof1983 <prof1983@ya.ru>
@Created 26.04.2005
@LastMod 20.12.2012
}
unit AiDataObj;

{$ifndef NoAiDataXml}
  {$define UseXml}
{$endif}

interface

uses
  Classes,
  ABase, AStreamObj, ATypes,
  {$ifdef UseXml}AXmlNodeImpl, AXmlObj,{$endif}
  AiBase, AiTypes;

type //** @abstract(Базовый тип данных для AI)
  TAiDataObject = class
  protected
      //** Фрейм, к которому принадлежат данные
    FFreim: TAId;
      //** Данные открыты
    FOpened: Boolean;
      //** Поток данных
    FStream: TProfStream;
      //** Тескстовая строка
    FText: WideString;
      //** Тип даных
    FDataType: TAiDataType;
    {$ifdef UseXml}
      //** Данные в виде XML
    FXml: TProfXml;
      // В виде параметров. Id=0 Source=nil
    FXml2006: TProfXmlNode2;
    {$endif}
  protected
    function Get_DataType(): TAiDataType;
    function Get_Opened(): WordBool;
    function Get_Text(): WideString;
    procedure Set_DataType(Value: TAiDataType);
    procedure Set_Opened(Value: WordBool);
    procedure Set_Text(const Value: WideString);
  public
    constructor Create(Freim: TAId; Typ: TAiDataType = dtNone);
  public
    //** Очистить фрейм
    function Clear(): AError; virtual;
    function GetOpened(): Boolean;
    function GetSize(): UInt64; virtual;
    function GetStream(): TStream; virtual;
    function GetStreamMy(): AStreamObj.TProfStream; virtual;
    function GetType(): TAiDataType;
    {$ifdef UseXml}
    function GetXml(): TProfXml;
    function GetXml1(): TProfXmlNode2;
    {$endif}
    function LoadFromFileN(const FileName: WideString): AError; virtual;
    {$ifdef UseXml}
    function LoadFromXml(Xml: TProfXml): AError;
    {$endif}
    function Read(var A: TArrayByte; Count: UInt64): UInt64; virtual;
    function ReadId(var Value: TAId): AError; virtual;
    function ReadInt08(var Value: AInt08): AError; virtual;
    function ReadInt16(var Value: Int16): AError; virtual;
    function ReadInt32(var Value: Int32): AError; virtual;
    function ReadInt64(var Value: Int64): AError; virtual;
    function ReadUInt08(var Value: AUInt08): AError; virtual;
    function ReadUInt16(var Value: UInt16): AError; virtual;
    function ReadUInt32(var Value: UInt32): AError; virtual;
    function ReadUInt64(var Value: UInt64): AError; virtual;
    function SaveToFile(F: AStreamObj.TProfFile): AError;
    function SaveToFileN(const FileName: WideString): AError; virtual;
    {$ifdef UseXml}
    function SaveToXml(Xml: TProfXml): AError; virtual;
    //function SaveToXml(Xml: IProfNode): WordBool; virtual;
    {$endif}
    function SetOpened(Value: Boolean): AError;
    function SetStream(Value: AStreamObj.TProfStream): AError;
    function SetType(Value: TAiDataType): AError;
    {$ifdef UseXml}
    function SetXml(Value: TProfXmlNode2): AError;
    {$endif}
    function Write(A: TArrayByte; Count: UInt64): UInt64; virtual;
    function WriteId(Value: TAId): AError; virtual;
    function WriteInt08(Value: AInt08): AError; virtual;
    function WriteInt16(Value: Int16): AError; virtual;
    function WriteInt32(Value: Int32): AError; virtual;
    function WriteInt64(Value: Int64): AError; virtual;
    function WriteUInt08(Value: AUInt08): AError; virtual;
    function WriteUInt16(Value: UInt16): AError; virtual;
    function WriteUInt32(Value: UInt32): AError; virtual;
    function WriteUInt64(Value: UInt64): AError; virtual;
  public
    property DataType: TAiDataType read Get_DataType write Set_DataType;
    property Opened: WordBool read Get_Opened write Set_Opened;
    property Text: WideString read Get_Text write Set_Text;
  end;

  TAiData = TAiDataObject;

implementation

{ TAiDataObject }

function TAiDataObject.Clear(): AError;
begin
  FDataType := dtNone;
  FOpened := False;
  FStream := nil;
  {$ifdef UseXml}
  FXml := nil;
  {$endif}
  Result := 0;
end;

constructor TAiDataObject.Create(Freim: TAId; Typ: TAiDataType = dtNone);
begin
  inherited Create();
  FFreim := Freim;
  FOpened := False;
  FDataType := Typ;
  FStream := nil;
  {$ifdef UseXml}
  FXml := nil;
  {$endif}
end;

function TAiDataObject.GetOpened(): Boolean;
begin
  Result := FOpened;
end;

function TAiDataObject.GetSize(): UInt64;
begin
  if (FDataType = dtStream) and Assigned(FStream) then
    Result := FStream.GetSize
  else
    Result := 0;
end;

function TAiDataObject.GetStream(): TStream;
begin
  if not(Assigned(FStream)) then
    FStream := TProfStreamAdapter.Create(TMemoryStream.Create());
  if (FStream is TProfStreamAdapter) then
    Result := TProfStreamAdapter(FStream).Stream
  else
    Result := nil;
end;

function TAiDataObject.GetStreamMy(): AStreamObj.TProfStream;
begin
  if not(Assigned(FStream)) then
    FStream := TProfStreamAdapter.Create(TMemoryStream.Create());
  Result := FStream;
end;

function TAiDataObject.GetType(): TAiDataType;
begin
  Result := FDataType;
end;

{$ifdef UseXml}
function TAiDataObject.GetXml(): TProfXml;
begin
  Result := FXml;
end;
{$endif}

{$ifdef UseXml}
function TAiDataObject.GetXml1(): TProfXmlNode2;
begin
  {if not(Assigned(FXml)) then
    FXml := TMyXml.Create();}
  Result := FXml2006;
end;
{$endif}

function TAiDataObject.Get_DataType(): TAiDataType;
begin
  Result := FDataType;
end;

function TAiDataObject.Get_Opened(): WordBool;
begin
  Result := FOpened;
end;

{function TAIData.Get_Stream(): IProfStream;
begin
  Result := FStream;
end;}

function TAiDataObject.Get_Text(): WideString;
begin
  Result := '';
  {case FDataType of
    dtNone: Result := '';
    dtStream: Result := '';
    dtText: Result := FText;
    dtXml: Result := FXml.XML;
  else
    Result := '';
  end;}
end;

function TAiDataObject.LoadFromFileN(const FileName: WideString): AError;
var
  Stream: TProfStream;
begin
  SetType(dtStream);
  Stream := GetStreamMy();
  Stream.Position := 0;
  Stream.Size := 0;
  Result := ProfStreamMemory_LoadFromFileN(FileName);
end;

{$ifdef UseXml}
function TAiDataObject.LoadFromXml(Xml: TProfXml): AError;
begin
  if not(Assigned(FXml)) then
    FXml := TProfXml.Create;
  Result := FXml.LoadFromXml(Xml);
end;
(*function TAiDataObject.LoadFromXml(Xml: TProfXmlNode2): TError;
var
  Count: UInt32;
  I: Int32;
begin
  Result := 1;
  SetType(dtXml);
  if not(Assigned(FXml)) then
    FXml := TMyXml.Create(Xml);
  FXml.AddFromXml(Xml);
  Result := 0;
end;*)
{function TAiDataObject.LoadFromXml(Xml: IProfNode): Boolean;
begin
  //if not(Assigned(FXml)) then FXml := TProfXmlDocument.Create();
  //Result := FXml.LoadFromXml(Xml);
  Result := False;
end;}
{$endif}

function TAiDataObject.Read(var A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
  if (Count = 0) or (Length(A) = 0) or not(Assigned(FStream)) then Exit;
  if (FDataType <> dtStream) then Exit;
  if (Length(A) < Count) then
    Count := Length(A);
  Result := FStream.ReadArray(A, Count);
end;

function TAiDataObject.ReadId(var Value: TAId): AError;
var
  V: UInt64;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
  begin
    Result := FStream.ReadUInt64(V);
    Value := V;
  end
  else
    Result := -1;
end;

function TAiDataObject.ReadInt08(var Value: AInt08): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt08(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadInt16(var Value: Int16): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt16(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadInt32(var Value: Int32): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt32(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadInt64(var Value: Int64): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt64(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadUInt08(var Value: AUInt08): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt08(Value)
  else
    Result := -1;
end;

function TAiDataObject.ReadUInt16(var Value: UInt16): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt16(Value)
  else
    Result := -1;
end;

function TAiDataObject.ReadUInt32(var Value: UInt32): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt32(Value)
  else
    Result := -1;
end;

function TAiDataObject.ReadUInt64(var Value: UInt64): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt64(Value)
  else
    Result := -1;
end;

function TAiDataObject.SaveToFile(F: AStreamObj.TProfFile): AError;
begin
  if Assigned(FStream) then
    Result := AStream_SaveToFile(FStream, F)
  else
    Result := 1;
end;

function TAiDataObject.SaveToFileN(const FileName: WideString): AError;
begin
  Result := -1;
end;

{$ifdef UseXml}
function TAiDataObject.SaveToXml(Xml: TProfXml): AError;
begin
  Result := -1;
end;
{function TAiDataObject.SaveToXml(Xml: TMyXml): TError;
begin
  Result := 1;
  if not(Assigned(Xml)) then Exit;
  if not(Assigned(FXml)) or (FType <> dtXml) then Exit;
  Result := Xml.AddFromXml(FXml);
end;}
{$endif}

function TAiDataObject.SetOpened(Value: Boolean): AError;
begin
  Result := -1;
  if (FDataType = dtNone) then Exit;
  FOpened := Value;
  Result := 0;
end;

function TAiDataObject.SetStream(Value: AStreamObj.TProfStream): AError;
begin
  FStream := Value;
  FDataType := dtStream;
  Result := 0;
end;

function TAiDataObject.SetType(Value: TAiDataType): AError;
begin
  FDataType := Value;
  Result := 0;
end;

{$ifdef UseXml}
function TAiDataObject.SetXml(Value: TProfXmlNode2): AError;
begin
  FXml2006 := Value;
  FDataType := dtXml;
  Result := 0;
end;
{$endif}

procedure TAIDataObject.Set_DataType(Value: TAiDataType);
begin
  Self.FDataType := Value;
end;

procedure TAiDataObject.Set_Opened(Value: WordBool);
begin
  if FDataType = dtNone then Exit;
  FOpened := Value;
end;

procedure TAiDataObject.Set_Text(const Value: WideString);
begin
  FText := Value;
  {if Assigned(FXmlDocument) then
  try
    FXmlDocument.Active := False;
    FXmlDocument.XML.Clear();
    FXmlDocument.XML.Add(Value);
    FXmlDocument.Active := True;
  except
  end;}
end;

function TAiDataObject.Write(A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
  if (Count = 0) or (Length(A) = 0) or not(Assigned(FStream)) then Exit;
  if (FDataType <> dtStream) then Exit;
  if (Length(A) < Count) then
    Count := Length(A);
  Result := AStream_Write(FStream, A, Count); //Result := FStream.WriteArray(A, Count);
end;

function TAiDataObject.WriteId(Value: TAId): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := -1;
end;

function TAiDataObject.WriteInt08(Value: AInt08): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt08(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteInt16(Value: Int16): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt16(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteInt32(Value: Int32): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt32(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteInt64(Value: Int64): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt64(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteUInt08(Value: AUInt08): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt08(Value)
  else
    Result := -1;
end;

function TAiDataObject.WriteUInt16(Value: UInt16): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt16(Value)
  else
    Result := -1;
end;

function TAiDataObject.WriteUInt32(Value: UInt32): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt32(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteUInt64(Value: UInt64): AError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := -1;
end;

end.
