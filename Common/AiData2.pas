{**
@Abstract(Базовый тип данных для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2005)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AiData2;

// TODO: Use AiDataImpl.pas

interface

uses
  ActiveX, XmlIntf,
  {AiGlobals,} AiFrameIntf, AiIntf, AiTypes;

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
    function Get_DataType(): TAiDataType; safecall;
    function Get_DataTypeEnum(): AiDataTypeEnum; safecall;
    function Get_Opened(): WordBool; safecall;
    function Get_Stream(): IStream; safecall;
    function Get_Text(): WideString; safecall;
    //function Get_Xml(): IProfXmlDocument; safecall;
    function Get_XmlNode(): IXmlNode; safecall;
    function Get_XmlDocument(): IXmlDocument; safecall;
    procedure SetType(Value: TAIDataType);
    procedure Set_DataType(Value: TAiDataType); safecall;
    procedure Set_DataTypeEnum(Value: AIDataTypeEnum); safecall;
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
    property DataTypeEnum: AiDataTypeEnum read Get_DataTypeEnum write Set_DataTypeEnum;
    property Opened: WordBool read Get_Opened write Set_Opened;
    property Text: WideString read Get_Text write Set_Text;
    property XmlNode: IXmlNode read Get_XmlNode write Set_XmlNode;
    property XmlDocument: IXmlDocument read Get_XmlDocument write Set_XmlDocument;
  end;

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

function TAIData.Get_DataType(): TAiDataType;
begin
  Result := FType;
end;

function TAIData.Get_DataTypeEnum(): AiDataTypeEnum;
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

procedure TAIData.Set_DataType(Value: TAiDataType);
begin
  FType := Value;
end;

procedure TAIData.Set_DataTypeEnum(Value: AIDataTypeEnum);
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

end.
