﻿{**
@Abstract(Подпроцесс выполнения кода на языке AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.03.2007)
@LastMod(26.04.2012)
@Version(0.5)

Подпроцесс выполнения кода работает с TInterpretator.
Работа подпроцесса осуществляется следующим образом:
1. Создается объект CodeLine - линия выполняемых команд.

Линия выполняемых команд (CodeLine) служит для сохранения процесса выполнения с
дальнейшим восстановлением с того места где завершили работу программы.
}
unit AiInterpretatorThread;

interface

uses
  ActiveX,
  ANodeIntf, AThreadObj, AXmlDocumentImpl, 
  AiFrame, AiInterpretatorIntf;

type //** Подпроцесс выполнения кода на языке AR
  TInterpretatorThread3 = class(TProfThread)
  private
    //FClasses: TXmlNodeList;
    //FObjects: TXmlNodeList;
    //** Линия выполнения команд
    //FCodeLine: TObject;
    //** Выполняемый код в виде строки
    FCodeString: WideString;
    //** Выполняемый код в виде XML
    FCodeXml: IProfNode;
    //** Объект интерпретации и выполнения команд
    FInterpretator: IAiInterpretator;
    //FProgram: IProfNode;
  private
    //** Автоматический поиск решений
    FIsAuto: WordBool;
    //** Режим отладки - выводить все сообщения
    FIsDebug: WordBool;
    //** Выполнить нод
    procedure RunNode(ANode: IProfNode);
    //** Выполнить программу
    procedure RunProgram(ANode: IProfNode);
  private
    function GetCodeString(): WideString;
    procedure SetCodeString(const Value: WideString);
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
    //** Срабатывает при уничтожении
    procedure DoDestroy(); override; safecall;
    //** Главная выполняемая функция
    procedure Execute(); override;
  public
    function Run(): WordBool;
  public
    //** Выполняемый код в виде строки
    property CodeString: WideString read GetCodeString write SetCodeString;
    //** Выполняемый код в виде XML
    property CodeXml: IProfNode read FCodeXml write FCodeXml;
    //** Объект интерпретации и выполнения команд
    property Interpretator: IAiInterpretator read FInterpretator write FInterpretator;
    //** Автоматический режим принятия решений
    property IsAuto: WordBool read FIsAuto write FIsAuto;
    //** Режим отладки - подробные логи
    property IsDebug: WordBool read FIsDebug write FIsDebug;
  end;
  TInterpretatorThread = TInterpretatorThread3;

implementation

{ TInterpretatorThread }

procedure TInterpretatorThread3.DoCreate();
begin
  inherited DoCreate();
  //FCode := TAICode.Create();
end;

procedure TInterpretatorThread3.DoDestroy();
begin
//  try
//    FCode.Free();
//    FCode := nil;
//  except
//    FCode := nil;
//  end;
  inherited DoDestroy();
end;

procedure TInterpretatorThread3.Execute();
var
  xml: TProfXmlDocument3;
  nMethodMain: IProfNode;
  nMethodMainCode: IProfNode;
  nObject: IProfNode;
begin
  CoInitialize(nil);

  // Получаем список нодов - действий, которые нужно выполнить по порядку
  xml := TProfXmlDocument3.Create();
  try
    xml.Initialize();
//    FCodeXml := xml;
    if FCodeString <> '' then
    try
      xml.LoadFromString(FCodeString);
      nObject := xml.DocumentElement.ChildNodes.NodeByName['object'];
      if Assigned(nObject) then
      begin
        nMethodMain := nObject.ChildNodes.NodeByName['method'];
        if Assigned(nMethodMain) then
        begin
          nMethodMainCode := nMethodMain.ChildNodes.NodeByName['code'];
          if Assigned(nMethodMainCode) then
          begin
            // Выполнить код нода DocumentElement
            //RunNode(de);
            FInterpretator.RunCode(nMethodMainCode);
          end;
        end;
      end;
    finally
      FCodeXml := nil;
      xml.CloseDocument();
      xml.Free();
    end;
  except
  end;
end;

function TInterpretatorThread3.GetCodeString(): WideString;
begin
  Result := FCodeString;
end;

function TInterpretatorThread3.Run(): WordBool;
begin
  Execute();
  Result := True;
end;

procedure TInterpretatorThread3.RunNode(ANode: IProfNode);
//var
//  i: Integer;
//  s: string;
begin
//  if not(Assigned(ANode)) then Exit;
//
//  if ANode.NodeName = 'program' then
//    RunProgram(ANode)
//  else
//  begin
//    if ANode.IsTextElement then
//      s := cStrToHexA(VarToStr(ANode.NodeValue));
//    Self.ToLog(lgGeneral, ltInformation, 'Выполняем не известный элемент "%s" "%s"', [ANode.NodeName, s]);
//
//    // Выполняем элементы
//    for i := 0 to ANode.ChildNodes.Count - 1 do
//    begin
//      if ANode.ChildNodes[i].NodeName <> '#text' then
//        RunNode(ANode.ChildNodes[i]);
//
//
//      //ANode.ChildNodes.Nodes[i]
//
//  //    if Code.Strings[i] = '' then
//  //    begin
//  //      // ...
//  //    end;
//    end;
//  end;
end;

procedure TInterpretatorThread3.RunProgram(ANode: IProfNode);
//var
//  FProgramName: WideString;
//  i: Integer;
begin
//  FProgramName := ANode.Attributes['name'];
//
//  ToLog(lgGeneral, ltInformation, 'Выполняем программу "%s"', [FProgramName]);
//  // ...
//  // Выполняем элементы
//  for i := 0 to ANode.ChildNodes.Count - 1 do
//  begin
//    if ANode.ChildNodes[i].NodeName <> '#text' then
//      RunNode(ANode.ChildNodes[i]);
//  end;
end;

procedure TInterpretatorThread3.SetCodeString(const Value: WideString);
begin
  FCodeString := Value;
end;

end.