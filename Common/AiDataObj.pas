{**
@Abstract(Базовый тип данных для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2005)
@LastMod(09.06.2012)
@Version(0.5)

02.05.2012 - Added from Prof_AI_Base.pas
}
unit AiDataObj;

interface

uses
  Classes,
  ABase, AStreamObj, ATypes, AXml20060314, AXmlObj,
  AiBase, AiTypes;

type
  TMyXml20050819 = AXml20060314.TProfXmlNode2;

type //** @abstract(Базовый тип данных для AI)
  TAiDataObject = class
  protected
      //** Фрейм, к которому принадлежат данные
    FFreim: TAId; //FFreimParent: TAI_Id; //FFreim: IAIFreim;
      //** Данные открыты
    FOpened: Boolean;
      //** Поток данных
    FStream: TProfStream; //FStream: IProfStream;
      //** Тескстовая строка
    FText: WideString;
      //** Тип даных
    FDataType: TAiDataType;
      //** Данные в виде XML
    FXml: TProfXml; //FXml: IProfNode;
      // В виде параметров. Id=0 Source=nil
    FXml2006: AXml20060314.TProfXmlNode2{TMyXml20050819};
  protected
    //FType: TAIDataType; - Use FDataType {Тип даных}
  protected
    function Get_DataType(): TAiDataType;
    function Get_Opened(): WordBool;
    //function Get_Stream(): IProfStream;
    function Get_Text(): WideString;
    //function Get_Xml(): IProfNode;
    procedure Set_DataType(Value: TAiDataType);
    procedure Set_Opened(Value: WordBool);
    procedure Set_Text(const Value: WideString);
    //procedure Set_Xml(Value: IProfNode);
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
    function GetXml(): TProfXml;
    function GetXml1(): AXml20060314.TProfXmlNode2;
    function LoadFromFileN(const FileName: WideString): AError; virtual;
    function LoadFromXml(Xml: TProfXml): TError;
    function Read(var A: TArrayByte; Count: UInt64): UInt64; virtual;
    function ReadId(var Value: TAId): AError; virtual;
    function ReadInt08(var Value: Int08): TError; virtual;
    function ReadInt16(var Value: Int16): TError; virtual;
    function ReadInt32(var Value: Int32): TError; virtual;
    function ReadInt64(var Value: Int64): TError; virtual;
    function ReadUInt08(var Value: UInt08): TError; virtual;
    function ReadUInt16(var Value: UInt16): TError; virtual;
    function ReadUInt32(var Value: UInt32): TError; virtual;
    function ReadUInt64(var Value: UInt64): TError; virtual;
    function SaveToFile(F: AStreamObj.TProfFile): TError;
    function SaveToFileN(const FileName: WideString): AError; virtual;
    function SaveToXml(Xml: TProfXml): TError; virtual;
    //function SaveToXml(Xml: IProfNode): WordBool; virtual;
    function SetOpened(Value: Boolean): TError;
    function SetStream(Value: AStreamObj.TProfStream): TError;
    function SetType(Value: TAiDataType): TError;
    function SetXml(Value: AXml20060314.TProfXmlNode2{TMyXml20050819}): TError;
    function Write(A: TArrayByte; Count: UInt64): UInt64; virtual;
    function WriteId(Value: TAId): AError; virtual;
    function WriteInt08(Value: Int08): TError; virtual;
    function WriteInt16(Value: Int16): TError; virtual;
    function WriteInt32(Value: Int32): TError; virtual;
    function WriteInt64(Value: Int64): TError; virtual;
    function WriteUInt08(Value: UInt08): TError; virtual;
    function WriteUInt16(Value: UInt16): TError; virtual;
    function WriteUInt32(Value: UInt32): TError; virtual;
    function WriteUInt64(Value: UInt64): TError; virtual;
  public
    property DataType: TAiDataType read Get_DataType write Set_DataType;
    //property DataTypeEnum: AIDataTypeEnum read Get_DataType write Set_DataType;
    property Opened: WordBool read Get_Opened write Set_Opened;
    property Text: WideString read Get_Text write Set_Text;
    //property Xml: IProfNode read Get_Xml write Set_Xml;
  end;

  TAiData = TAiDataObject;
  TAI_Data = TAiDataObject;
  TAI_DataFile = TAiDataObject;
  TAI_DataFileCashe = TAI_DataFile;
  TAI_DataNet = TAiDataObject;

  TAI_DataMemory = TAiDataObject;
  TAiDataMemoryObject20050819 = class(TAiDataObject)
  public
    function GetStreamMy(): AStreamObj.TProfStream; override;
  end;

  (*TAI_DataStream = class(TAiDataObject)
  private
    FStream: TMyStream;        // В виде потока байтов
  public
    function Clear: TError; override;
    function GetSize: UInt64;
    function GetStream: TMyStream;
    function LoadFromFileN(FileName: String): TError;
    function Read(var A: TArrayByte; Count: UInt64): UInt64; virtual;
    function ReadId(var Value: TAI_Id): TError; virtual;
    function ReadInt08(var Value: Int08): TError; virtual;
    function ReadInt16(var Value: Int16): TError; virtual;
    function ReadInt32(var Value: Int32): TError; virtual;
    function ReadInt64(var Value: Int64): TError; virtual;
    function ReadStr(var S: String): TError;
    function ReadUInt08(var Value: UInt08): TError; virtual;
    function ReadUInt16(var Value: UInt16): TError; virtual;
    function ReadUInt32(var Value: UInt32): TError; virtual;
    function ReadUInt64(var Value: UInt64): TError; virtual;
    function SaveToFile(F: TMyFile): TError; virtual;
    function SaveToFileN(FileName: String): TError; virtual;
    function SetStream(Value: TMyStream): TError;
    function Write(A: TArrayByte; Count: UInt64): UInt64; virtual;
    function WriteId(Value: TAI_Id): TError; virtual;
    function WriteInt08(Value: Int08): TError; virtual;
    function WriteInt16(Value: Int16): TError; virtual;
    function WriteInt32(Value: Int32): TError; virtual;
    function WriteInt64(Value: Int64): TError; virtual;
    function WriteStr(S: String): TError;
    function WriteUInt08(Value: UInt08): TError; virtual;
    function WriteUInt16(Value: UInt16): TError; virtual;
    function WriteUInt32(Value: UInt32): TError; virtual;
    function WriteUInt64(Value: UInt64): TError; virtual;
  end;*)

  (*TAI_DataStream = class(TAiDataObject)
  private
    FStream: TMyStream;        {В виде потока байтов}
  public
    function Clear: TError; override;
    function GetSize: UInt64;
    function GetStream: TMyStream;
    function LoadFromFileN(FileName: String): TError;
    function Read(var A: TArrayByte; Count: UInt64): UInt64; virtual;
    function ReadId(var Value: TAI_Id): TError; virtual;
    function ReadInt08(var Value: Int08): TError; virtual;
    function ReadInt16(var Value: Int16): TError; virtual;
    function ReadInt32(var Value: Int32): TError; virtual;
    function ReadInt64(var Value: Int64): TError; virtual;
    function ReadStr(var S: String): TError;
    function ReadUInt08(var Value: UInt08): TError; virtual;
    function ReadUInt16(var Value: UInt16): TError; virtual;
    function ReadUInt32(var Value: UInt32): TError; virtual;
    function ReadUInt64(var Value: UInt64): TError; virtual;
    function SaveToFile(F: TMyFile): TError; virtual;
    function SaveToFileN(FileName: String): TError; virtual;
    function SetStream(Value: TMyStream): TError;
    function Write(A: TArrayByte; Count: UInt64): UInt64; virtual;
    function WriteId(Value: TAI_Id): TError; virtual;
    function WriteInt08(Value: Int08): TError; virtual;
    function WriteInt16(Value: Int16): TError; virtual;
    function WriteInt32(Value: Int32): TError; virtual;
    function WriteInt64(Value: Int64): TError; virtual;
    function WriteStr(S: String): TError;
    function WriteUInt08(Value: UInt08): TError; virtual;
    function WriteUInt16(Value: UInt16): TError; virtual;
    function WriteUInt32(Value: UInt32): TError; virtual;
    function WriteUInt64(Value: UInt64): TError; virtual;
  end;*)

  (*TAI_DataStreamFile = class(TAI_DataStream)
  end;*)

  (*TAI_DataStreamMemory = class(TAI_DataStream)
  private
    {FStream: TMyStreamMemory;}
  public
    function GetStream: TMyStreamMemory;
    function SetStream(Value: TMyStreamMemory): TError;
  end;*)

  (*TAI_DataXml = class(TAiDataObject)
  private
    FXml: TProfXml;              {В виде параметров. Id=0 Source=nil}
  public
    function Clear: TError; override;
    constructor Create(Freim: TAI_Freim);
    function GetXml: TProfXml;
    function LoadFromXml(Xml: TProfXml): TError;
    function ReadId(Name: String; var Value: TAI_Id): TError;
    function ReadStr(Name: String; var S: String): TError;
    function ReadUInt08(Name: String; var Value: UInt08): TError;
    function SaveToXml(Xml: TProfXml): TError; override;
    function SetXml(Value: TProfXml): TError;
    function WriteId(Name: String; Value: TAI_Id): TError;
    function WriteStr(Name, S: String): TError;
    function WriteUInt08(Name: String; Value: UInt08): TError;
  end;*)

implementation

{ TAiDataMemoryObject20050819 }

function TAiDataMemoryObject20050819.GetStreamMy(): AStreamObj.TProfStream;
begin
  Result := nil;
  if (FDataType <> dtStream) then Exit;
  if not(Assigned(FStream)) then
    FStream := AStreamObj.TProfMemoryStream.Create;
  Result := FStream;
end;

{ TAiDataObject }

function TAiDataObject.Clear(): AError;
begin
  FOpened := False;
  FStream := nil;
  FXml := nil;
  FDataType := dtNone;
  Result := 0;
end;

constructor TAiDataObject.Create(Freim: TAId; Typ: TAiDataType = dtNone);
begin
  inherited Create();
  FFreim := Freim;
  FOpened := False;
  FDataType := Typ;
  FStream := nil;
  FXml := nil;
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
    Result := TProfStreamAdapter(FStream).Stream;
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

function TAiDataObject.GetXml(): TProfXml;
begin
  Result := FXml;
end;

function TAiDataObject.GetXml1(): AXml20060314.TProfXmlNode2;
begin
  {if not(Assigned(FXml)) then
    FXml := TMyXml.Create();}
  Result := FXml2006;
end;

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

{function TAIData.Get_Xml(): IProfNode;
begin
  Result := FXml;
end;}

{function TAIData.Get_XmlDocument(): IXmlDocument;
begin
  Result := FXmlDocument;
end;}

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

function TAiDataObject.LoadFromXml(Xml: TProfXml): TError;
begin
  if not(Assigned(FXml)) then
    FXml := TProfXml.Create;
  Result := FXml.LoadFromXml(Xml);
end;
(*function TAiDataObject.LoadFromXml(Xml: TMyXml20050819): TError;
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

function TAiDataObject.ReadInt08(var Value: Int08): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt08(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadInt16(var Value: Int16): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt16(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadInt32(var Value: Int32): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt32(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadInt64(var Value: Int64): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadInt64(Value)
  else
    Result := 1;
end;

function TAiDataObject.ReadUInt08(var Value: UInt08): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt08(Value)
  else
    Result := -1;
end;

function TAiDataObject.ReadUInt16(var Value: UInt16): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt16(Value)
  else
    Result := -1;
end;

function TAiDataObject.ReadUInt32(var Value: UInt32): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt32(Value)
  else
    Result := -1;
end;

function TAiDataObject.ReadUInt64(var Value: UInt64): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.ReadUInt64(Value)
  else
    Result := -1;
end;

function TAiDataObject.SaveToFile(F: AStreamObj.TProfFile): TError;
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

function TAiDataObject.SaveToXml(Xml: TProfXml): TError;
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

function TAiDataObject.SetOpened(Value: Boolean): TError;
begin
  Result := -1;
  if (FDataType = dtNone) then Exit;
  FOpened := Value;
  Result := 0;
end;

function TAiDataObject.SetStream(Value: AStreamObj.TProfStream): TError;
begin
  FStream := Value;
  FDataType := dtStream;
  Result := 0;
end;

function TAiDataObject.SetType(Value: TAiDataType): TError;
begin
  FDataType := Value;
  Result := 0;
end;

function TAiDataObject.SetXml(Value: AXml20060314.TProfXmlNode2{TMyXml20050819}): TError;
begin
  FXml2006 := Value;
  FDataType := dtXml;
  Result := 0;
end;

procedure TAIDataObject.Set_DataType(Value: TAiDataType);
{var
  DataType: TAIDataType;}
begin
  {for DataType := Low(TAIDataType) to High(TAIDataType) do
    if OLE_DATA_TYPE[DataType] = Value then
    begin
      FType := DataType;
      Exit;
    end;}
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

{procedure TAiDataObject.Set_Xml(Value: IProfNode);
begin
  FXml := Value;
  FDataType := dtXml;
end;}

{procedure TAiDataObject.Set_XmlDocument(Value: IXmlDocument);
begin
  FXmlDocument := Value;
end;}

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

function TAiDataObject.WriteInt08(Value: Int08): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt08(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteInt16(Value: Int16): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt16(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteInt32(Value: Int32): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt32(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteInt64(Value: Int64): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteInt64(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteUInt08(Value: UInt08): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt08(Value)
  else
    Result := -1;
end;

function TAiDataObject.WriteUInt16(Value: UInt16): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt16(Value)
  else
    Result := -1;
end;

function TAiDataObject.WriteUInt32(Value: UInt32): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt32(Value)
  else
    Result := 1;
end;

function TAiDataObject.WriteUInt64(Value: UInt64): TError;
begin
  if Assigned(FStream) and (FDataType = dtStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := -1;
end;

{ TAIDataStream }

(*function TAI_DataStream.Clear: TError;
begin
  FStream := nil;
  Result := inherited Clear;
end;

function TAI_DataStream.GetSize: UInt64;
begin
  if (FType = dtStream) and Assigned(FStream) then
    Result := FStream.GetSize
  else
    Result := 0;
end;

function TAI_DataStream.GetStream: TMyStream;
begin
  Result := FStream;
end;

function TAI_DataStream.LoadFromFileN(FileName: String): TError;
begin
  SetType(dtStream);
  GetStream.Clear;
  Result := GetStream.LoadFromFileN(FileName);
end;

function TAI_DataStream.Read(var A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
  if (Count = 0) or (Length(A) = 0) or not(Assigned(FStream)) then Exit;
  if FType <> dtStream then Exit;
  if Length(A) < Count then Count := Length(A);
  Result := FStream.Read(A, Count);
end;

function TAI_DataStream.ReadId(var Value: TAI_Id): TError;
var
  V: UInt64;
begin
  if Assigned(FStream) and (FType = dtStream) then begin
    Result := FStream.ReadUInt64(V);
    Value := V;
  end else
    Result := 1;
end;

function TAI_DataStream.ReadInt08(var Value: Int08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadInt16(var Value: Int16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadInt32(var Value: Int32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadInt64(var Value: Int64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadStr(var S: String): TError;
var
  C: UInt16;
  Count: UInt32;
  I: Int32;
begin
  Result := 1;
  if not(Assigned(FStream)) or (FType <> dtStream) then Exit;
  ReadUInt32(Count);
  SetLength(S, Count);
  for I := 1 to Count do begin
    ReadUInt16(C);
    S[I] := Chr(C);
  end;
end;

function TAI_DataStream.ReadUInt08(var Value: UInt08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadUInt16(var Value: UInt16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadUInt32(var Value: UInt32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadUInt64(var Value: UInt64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.SaveToFile(F: TMyFile): TError;
begin
  if Assigned(FStream) then
    Result := FStream.SaveToFile(F)
  else
    Result := 1;
end;

function TAI_DataStream.SaveToFileN(FileName: String): TError;
begin
  Result := 1;
end;

function TAI_DataStream.SetStream(Value: TMyStream): TError;
begin
  FStream := Value;
  Result := 0;
end;

function TAI_DataStream.Write(A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
  if (Count = 0) or (Length(A) = 0) or not(Assigned(FStream)) then Exit;
  if FType <> dtStream then Exit;
  if Length(A) < Count then Count := Length(A);
  Result := FStream.Write(A, Count);
end;

function TAI_DataStream.WriteId(Value: TAI_Id): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt08(Value: Int08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt16(Value: Int16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt32(Value: Int32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt64(Value: Int64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteStr(S: String): TError;
var
  A: TArrayByte;
  Count: UInt32;
begin
  WriteUInt32(Count);
  A := cStrToArrayByte(S);
  Write(A, Count);
end;

function TAI_DataStream.WriteUInt08(Value: UInt08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteUInt16(Value: UInt16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteUInt32(Value: UInt32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteUInt64(Value: UInt64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := 1;
end;*)

{ TAI_DataStream }

(*function TAI_DataStream.Clear: TError;
begin
  FStream := nil;
  Result := inherited Clear;
end;

function TAI_DataStream.GetSize: UInt64;
begin
  if (FType = dtStream) and Assigned(FStream) then
    Result := FStream.GetSize
  else
    Result := 0;
end;

function TAI_DataStream.GetStream: TMyStream;
begin
  Result := FStream;
end;

function TAI_DataStream.LoadFromFileN(FileName: String): TError;
begin
  SetType(dtStream);
  GetStream.Clear;
  Result := GetStream.LoadFromFileN(FileName);
end;

function TAI_DataStream.Read(var A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
  if (Count = 0) or (Length(A) = 0) or not(Assigned(FStream)) then Exit;
  if FType <> dtStream then Exit;
  if Length(A) < Count then Count := Length(A);
  Result := FStream.Read(A, Count);
end;

function TAI_DataStream.ReadId(var Value: TAI_Id): TError;
var
  V: UInt64;
begin
  if Assigned(FStream) and (FType = dtStream) then begin
    Result := FStream.ReadUInt64(V);
    Value := V;
  end else
    Result := 1;
end;

function TAI_DataStream.ReadInt08(var Value: Int08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadInt16(var Value: Int16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadInt32(var Value: Int32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadInt64(var Value: Int64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadStr(var S: String): TError;
var
  C: UInt16;
  Count: UInt32;
  I: Int32;
begin
  Result := 1;
  if not(Assigned(FStream)) or (FType <> dtStream) then Exit;
  ReadUInt32(Count);
  SetLength(S, Count);
  for I := 1 to Count do begin
    ReadUInt16(C);
    S[I] := Chr(C);
  end;
end;

function TAI_DataStream.ReadUInt08(var Value: UInt08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadUInt16(var Value: UInt16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadUInt32(var Value: UInt32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.ReadUInt64(var Value: UInt64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.ReadUInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.SaveToFile(F: TMyFile): TError;
begin
  if Assigned(FStream) then
    Result := FStream.SaveToFile(F)
  else
    Result := 1;
end;

function TAI_DataStream.SaveToFileN(FileName: String): TError;
begin
  Result := 1;
end;

function TAI_DataStream.SetStream(Value: TMyStream): TError;
begin
  FStream := Value;
  Result := 0;
end;

function TAI_DataStream.Write(A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
  if (Count = 0) or (Length(A) = 0) or not(Assigned(FStream)) then Exit;
  if FType <> dtStream then Exit;
  if Length(A) < Count then Count := Length(A);
  Result := FStream.Write(A, Count);
end;

function TAI_DataStream.WriteId(Value: TAI_Id): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt08(Value: Int08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt16(Value: Int16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt32(Value: Int32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteInt64(Value: Int64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteInt64(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteStr(S: String): TError;
var
  A: TArrayByte;
  Count: UInt32;
begin
  WriteUInt32(Count);
  A := cStrToArrayByte(S);
  Write(A, Count);
end;

function TAI_DataStream.WriteUInt08(Value: UInt08): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt08(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteUInt16(Value: UInt16): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt16(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteUInt32(Value: UInt32): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt32(Value)
  else
    Result := 1;
end;

function TAI_DataStream.WriteUInt64(Value: UInt64): TError;
begin
  if Assigned(FStream) and (FType = dtStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := 1;
end;*)

{ TAI_DataStreamMemory }

(*function TAI_DataStreamMemory.GetStream: TMyStreamMemory;
begin
  Result := nil;
  if FType <> dtStream then Exit;
  if not(Assigned(FStream)) then FStream := TMyStreamMemory.Create;
  Result := TMyStreamMemory(FStream);
end;

function TAI_DataStreamMemory.SetStream(Value: TMyStreamMemory): TError;
begin
  FStream := Value;
  Result := 0;
end;*)

{ TAI_DataStreamMemory }

(*function TAI_DataStreamMemory.GetStream: TMyStreamMemory;
begin
  Result := nil;
  if FType <> dtStream then Exit;
  if not(Assigned(FStream)) then FStream := TMyStreamMemory.Create;
  Result := TMyStreamMemory(FStream);
end;

function TAI_DataStreamMemory.SetStream(Value: TMyStreamMemory): TError;
begin
  FStream := Value;
  Result := 0;
end;*)

{ TAI_DataXml }

(*function TAI_DataXml.Clear: TError;
begin
  FXml := nil;
  Result := inherited Clear;
end;

constructor TAI_DataXml.Create(Freim: TAI_Freim);
begin
  inherited Create(Freim, dtXml);
  FXml := nil;
end;

function TAI_DataXml.GetXml: TProfXml;
begin
  if not(Assigned(FXml)) then FXml := TProfXml.Create;
  Result := FXml;
end;

function TAI_DataXml.LoadFromXml(Xml: TProfXml): TError;
{var
  Count: UInt32;
  I: Int32;}
begin
  {Clear;}
  SetType(dtXml);
  {Count := Xml.GetCountParams;
  for I := 0 to Count - 1 do begin
    Xml
  end;}
  if not(Assigned(FXml)) then FXml := TProfXml.Create;
  FXml.AddFromXml(Xml);
  Result := 0;
end;

function TAI_DataXml.ReadId(Name: String; var Value: TAI_Id): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.ReadStr(Name: String; var S: String): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.ReadUInt08(Name: String; var Value: UInt08): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.SaveToXml(Xml: TProfXml): TError;
begin
  Result := 1;
  if not(Assigned(Xml)) then Exit;
  if not(Assigned(FXml)) or (FType <> dtXml) then Exit;
  Result := Xml.AddFromXml(Xml);
end;

function TAI_DataXml.SetXml(Value: TProfXml): TError;
begin
  FXml := Value;
  FType := dtXml;
  Result := 0;
end;

function TAI_DataXml.WriteId(Name: String; Value: TAI_Id): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.WriteStr(Name, S: String): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.WriteUInt08(Name: String; Value: UInt08): TError;
begin
  Result := 1;
  {}
end;*)

{ TAI_DataXml }

(*function TAI_DataXml.Clear: TError;
begin
  FXml := nil;
  Result := inherited Clear;
end;

constructor TAI_DataXml.Create(Freim: TAI_Freim);
begin
  inherited Create(Freim, dtXml);
  FXml := nil;
end;

function TAI_DataXml.GetXml: TProfXml;
begin
  if not(Assigned(FXml)) then FXml := TProfXml.Create;
  Result := FXml;
end;

function TAI_DataXml.LoadFromXml(Xml: TProfXml): TError;
{var
  Count: UInt32;
  I: Int32;}
begin
  {Clear;}
  SetType(dtXml);
  {Count := Xml.GetCountParams;
  for I := 0 to Count - 1 do begin
    Xml
  end;}
  if not(Assigned(FXml)) then FXml := TProfXml.Create;
  FXml.AddFromXml(Xml);
  Result := 0;
end;

function TAI_DataXml.ReadId(Name: String; var Value: TAI_Id): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.ReadStr(Name: String; var S: String): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.ReadUInt08(Name: String; var Value: UInt08): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.SaveToXml(Xml: TProfXml): TError;
begin
  Result := 1;
  if not(Assigned(Xml)) then Exit;
  if not(Assigned(FXml)) or (FType <> dtXml) then Exit;
  Result := Xml.AddFromXml(Xml);
end;

function TAI_DataXml.SetXml(Value: TProfXml): TError;
begin
  FXml := Value;
  FType := dtXml;
  Result := 0;
end;

function TAI_DataXml.WriteId(Name: String; Value: TAI_Id): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.WriteStr(Name, S: String): TError;
begin
  Result := 1;
  {}
end;

function TAI_DataXml.WriteUInt08(Name: String; Value: UInt08): TError;
begin
  Result := 1;
  {}
end;*)

end.
 