{**
@Abstract Контрол для создания и редактирования фреймов, модулей, агентов и т.д.
@Author Prof1983 <prof1983@ya.ru>
@Created 06.04.2007
@LastMod 17.08.2012
}
unit ADeveloperControl;

interface

uses
  ComCtrls, Controls, SysUtils,
  ACodeControl, AControlImpl, AProgramImpl, ASystemData, ASystemUtils, ATypes,
  AiConsts;

type //** Контрол для создания и редактирования фреймов, модулей, агентов и т.д.
  TDeveloperControl = class(TProfControl)
  private
    FCodeControls: array of TArCodeControl;
    pcElements: TPageControl;
  protected
    function DoInitialize(): TProfError; override; safecall;
  public
      // Добавить вкладку редактирования кода
    function NewCodeControl(const AName: WideString): TArCodeControl;
  end;

implementation

{ TDeveloperControl }

function TDeveloperControl.DoInitialize(): TProfError;
var
  cc: TArCodeControl;
  S: string;
  DirectoryPath: string;
begin
  Result := inherited DoInitialize();

  pcElements := TPageControl.Create(FControl);
  pcElements.Parent := FControl;
  pcElements.Align := alClient;

  DirectoryPath := FExePath;

  // Создаем вкладку с кодом Example1
  cc := NewCodeControl('Example1');
  S := NormalizePath2(DirectoryPath + AiDataDir) + 'Example1.ar';
  S := ExpandFileName(S);
  if FileExists(S) then
    cc.LoadFromFile(S)
  else
  begin
    S := DirectoryPath + 'KnowlegeBase\Example1.ar';
    if FileExists(S) then
      cc.LoadFromFile(S);
  end;

  // Создаем вкладку с кодом Reason
  cc := NewCodeControl('Reason');
  S := DirectoryPath + '..\Data\Reason.ar';
  S := ExpandFileName(S);
  if FileExists(S) then
    cc.LoadFromFile(S)
  else
  begin
    S := DirectoryPath + 'KnowlegeBase\Reason.ar';
    if FileExists(S) then
      cc.LoadFromFile(S);
  end;
end;

function TDeveloperControl.NewCodeControl(const AName: WideString): TArCodeControl;
var
  ts: TTabSheet;
  i: Integer;
begin
  //ts := TTabSheet(DoTabMainAdd(tmMemo, AName));
  ts := TTabSheet.Create(FControl);
  ts.PageControl := pcElements;
  ts.Caption := AName;

  Result := TArCodeControl.Create();
  Result.Control := ts;
  Result.Initialize();

  i := Length(FCodeControls);
  SetLength(FCodeControls, i + 1);
  FCodeControls[i] := Result;
end;

end.
