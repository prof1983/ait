{**
@Abstract(Базовый тип данных для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2005)
@LastMod(09.06.2012)
@Version(0.5)
}
unit AiData2;

// TODO: Use AiDataImpl.pas

interface

uses
  ActiveX, XmlIntf,
  AiGlobals, AiIntf, AiTypes;

type //** Данные
  TAIData = class(TInterfacedObject, IAIDataEx1)
  private
    FFreim: IAIFreim;       // Фрейм, к которому принадлежат данные
    FOpened: Boolean;       // Данные открыты
    //FStream: TProfStream; // Поток данных
    FText: WideString;      // Тескстовая строка
    FType: TAIDataType;     // Тип даных
    FXml: IXmlNode;         // Данные в виде XML
    FXmlDocument: IXmlDocument; // XML документ
  protected
    function GetType(): TAIDataType;
    function Get_DataType(): AIDataTypeEnum; safecall;
    function Get_Opened(): WordBool; safecall;
    function Get_Stream(): IStream; safecall;
    function Get_Text(): WideString; safecall;
    //function Get_Xml(): IProfXmlDocument; safecall;
    function Get_XmlNode(): IXmlNode; safecall;
    function Get_XmlDocument(): IXmlDocument; safecall;
    procedure SetType(Value: TAIDataType);
    procedure Set_DataType(Value: AIDataTypeEnum); safecall;
    procedure Set_Opened(Value: WordBool); safecall;
    procedure Set_Text(const Value: WideString); safecall;
    procedure Set_XmlNode(Value: IXmlNode); safecall;
    procedure Set_XmlDocument(Value: IXmlDocument); safecall;
  public
    procedure Clear(); virtual; safecall;
    constructor Create(Freim: IAIFreim; Typ: TAIDataType);
    function LoadFromFileN(FileName: String): WordBool; virtual;
    function LoadFromXml(Xml: IXmlNode): Boolean;
    function SaveToFileN(FileName: String): WordBool; virtual;
    function SaveToXml(Xml: IXmlNode): WordBool; virtual;
  public
    property DataType: TAIDataType read GetType write SetType;
    property DataTypeEnum: AIDataTypeEnum read Get_DataType write Set_DataType;
    property Opened: WordBool read Get_Opened write Set_Opened;
    property Text: WideString read Get_Text write Set_Text;
    property XmlNode: IXmlNode read Get_XmlNode write Set_XmlNode;
    property XmlDocument: IXmlDocument read Get_XmlDocument write Set_XmlDocument;
  end;

  TAI_DataFile = TAiData;
  TAI_DataFileCashe = TAiData;
  TAI_DataMemory = TAiData;
  TAI_DataNet = TAiData;

  (*TAI_DataStream = class(TAI_Data)
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

  (*TAI_DataStreamFile = class(TAI_DataStream)
  private
  public
  end;*)

  (*TAI_DataStreamMemory = class(TAI_DataStream)
  private
    {FStream: TMyStreamMemory;}
  public
    function GetStream: TMyStreamMemory;
    function SetStream(Value: TMyStreamMemory): TError;
  end;*)

  (*TAI_DataXml = class(TAI_Data)
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

{ TAIData }

procedure TAIData.Clear();
begin
  FOpened := False;
  FType := dtNone;
  FXml := nil;
end;

constructor TAIData.Create(Freim: IAIFreim; Typ: TAIDataType);
begin
  inherited Create();
  FFreim := Freim;
  FOpened := False;
  FType := Typ;
end;

function TAIData.GetType(): TAIDataType;
begin
  Result := FType;
end;

function TAIData.Get_DataType(): AIDataTypeEnum;
begin
  Result := OLE_DATA_TYPE[FType];
end;

function TAIData.Get_Opened(): WordBool;
begin
  Result := FOpened;
end;

function TAIData.Get_Stream(): IStream;
begin
  Result := nil; //FStream;
end;

function TAIData.Get_Text(): WideString;
begin
  case FType of
    dtNone: Result := '';
    dtStream: Result := '';
    dtText: Result := FText;
    dtXml: Result := FXml.XML;
  else
    Result := '';
  end;
end;

{function TAIData.Get_Xml: IProfXmlDocument;
begin
  Result := nil;
end;}

function TAIData.Get_XmlNode(): IXmlNode;
begin
  Result := FXml;
end;

function TAIData.Get_XmlDocument(): IXmlDocument;
begin
  Result := FXmlDocument;
end;

function TAIData.LoadFromFileN(FileName: String): WordBool;
begin
  Result := False;
end;

function TAIData.LoadFromXml(Xml: IXmlNode): Boolean;
begin
  //if not(Assigned(FXml)) then FXml := TProfXmlDocument.Create();
  //Result := FXml.LoadFromXml(Xml);
  Result := False;
end;

function TAIData.SaveToFileN(FileName: String): WordBool;
begin
  Result := False;
end;

function TAIData.SaveToXml(Xml: IXmlNode): WordBool;
begin
  Result := False;
end;

procedure TAIData.SetType(Value: TAIDataType);
begin
  FType := Value;
end;

procedure TAIData.Set_DataType(Value: AIDataTypeEnum);
var
  DataType: TAIDataType;
begin
  for DataType := Low(TAIDataType) to High(TAIDataType) do
    if OLE_DATA_TYPE[DataType] = Value then
    begin
      FType := DataType;
      Exit;
    end;
end;

procedure TAIData.Set_Opened(Value: WordBool);
begin
  if FType = dtNone then Exit;
  FOpened := Value;
end;

procedure TAIData.Set_Text(const Value: WideString);
begin
  FText := Value;
  if Assigned(FXmlDocument) then
  try
    FXmlDocument.Active := False;
    FXmlDocument.XML.Clear();
    FXmlDocument.XML.Add(Value);
    FXmlDocument.Active := True;
  except
  end;
end;

procedure TAIData.Set_XmlNode(Value: IXmlNode);
begin
  FXml := Value;
  FType := dtXml;
end;

procedure TAIData.Set_XmlDocument(Value: IXmlDocument);
begin
  FXmlDocument := Value;
end;

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

{TAI_DataStreamMemory}

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

{TAI_DataXml}

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
 