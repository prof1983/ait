﻿{**
@Abstract(Выполняемый код на языке AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.10.2006)
@LastMod(28.04.2012)
@Version(0.5)
}
unit AiCode2;

interface

uses
  Classes, XmlIntf,
  ATypes, AXml3,
  AiBaseObj2006, AiData2, AiGlobals, AiIntf, AiTypes;

type //** @abstract(Выполняемый код на языке AR)
  TAICode = class(TAIFreim)
  private
    FDataEx1: IAIDataEx1;
    FLines: TStringList;
  private
    function GetDataEx1(): IAIDataEx1;
  protected
    function Get_Data(): IAIData; override; safecall;
  protected
    procedure DoCreate(); override; safecall;
    procedure DoDestroy(); override; safecall;
  public
    property DataEx1: IAIDataEx1 read GetDataEx1;
    property Lines: TStringList read FLines;
    //** Разобрать код
    procedure Parse();
  end;

implementation

{ TAICode }

procedure TAICode.DoCreate();
begin
  inherited DoCreate();
  FLines := TStringList.Create();
end;

procedure TAICode.DoDestroy();
begin
  if Assigned(FLines) then
  begin
    FLines.Free();
    FLines := nil;
  end;
  inherited DoDestroy();
end;

function TAICode.GetDataEx1: IAIDataEx1;
begin
  Result := FDataEx1;
end;

function TAICode.Get_Data(): IAIData;
var
  xd: TProfXmlDocument;
  SelfFreim: IAIFreim;
  Data: IAIDataEx1;
begin
  Result := inherited Get_Data();
  if not(Assigned(Result)) then
  try
    SelfFreim := IAIFreim(Self);
    Data := TAIData.Create(SelfFreim, dtXml);
    xd := TProfXmlDocument.Create('', 'frame'); //('arcode.xml', 'frame');
    xd.Initialize();
    Data.XmlDocument := xd.Controller;
    Data.XmlNode := xd.Controller.DocumentElement;
    FData := Data;
    FDataEx1 := Data;
    Result := Data;
  except
    Result := nil;
  end;
end;

procedure TAICode.Parse();
var
  xframe: IXmlNode;
  xclass: IXmlNode;
  xdata: IXmlNode;
  i: Integer;
  iclass: Integer;
  d: TProfXmlDocument;
begin
  if Assigned(FData) then
    FDataEx1.Clear();
  //Lines.SaveToFile('tmp.xml');
  //Data.XmlDocument.LoadFromFile('tmp.xml');

  FDataEx1.Text := FLines.Text;
  FDataEx1.XmlNode := FDataEx1.XmlDocument.DocumentElement;

  xframe := FDataEx1.XmlNode;
  if (xframe.NodeName = 'frame') and Assigned(xframe.ChildNodes) then
  begin
    for i := 0 to xframe.ChildNodes.Count - 1 do
    begin
      xdata := xframe.ChildNodes.Nodes[i];
      if xdata.NodeName = 'data' then
      begin
        for iclass := 0 to xdata.ChildNodes.Count - 1 do
        begin
          xclass := xdata.ChildNodes.Nodes[iclass];
          if xclass.NodeName = 'class' then
          begin
            Self.AddToLog(lgGeneral, ltInformation, '--- Class "' + xclass.NodeName + '" ---');
          end;
        end;
      end;
    end;
  end;
end;

end.