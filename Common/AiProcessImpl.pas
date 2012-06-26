{**
@Abstract(Процесс выполнения команд для агентов)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.01.2006)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AiProcessImpl;

interface

uses
  Classes, SysUtils,
  ATypes,
  AiFrameImpl, AiInterpretatorIntf, AiInterpretatorThread, AiProcessIntf;

type //** Процесс выполнения какого-либо метода(процедуры или функции). Используется в TAIAgent
  TAiProcess = class(TAIFrame, IAiProcess)
  private
    function GetOnProgress: TProcProgress;
    procedure SetOnProgress(const Value: TProcProgress);
  protected
    //** CallBack функция отсылки сообщения ядру
    //FOnSendMessageToCore: TProcMessage;
    //** Подпроцесс выполнения команд
    FThread: TInterpretatorThread3;
  protected
    function GetCodeString(): WideString;
    function GetInterpretator(): IAiInterpretator;
    function GetThread: TInterpretatorThread3;
    procedure SetCodeString(const Value: WideString);
    procedure SetInterpretator(Value: IAiInterpretator);
    procedure SetThread(Value: TInterpretatorThread3);
  protected
      //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
      //** Срабатывает при поступлении сообщения
    //function SendMessage(const Msg: WideString): Integer; override; safecall;
  public
      //** Приостановить выполнение процесса
    function Pause(ATimeOut: Integer = 1000): WordBool; virtual; safecall;
      //** Начать/продолжить выполнение процесса
    function Start(): WordBool; virtual; safecall;
      //** Остановить выполнение процесса
    function Stop(): WordBool; virtual; safecall;
  public
      //** Код для выполнения в виде строки
    property CodeString: WideString read GetCodeString write SetCodeString;
      //** Интерпретатор кода
    property Interpretator: IAiInterpretator read GetInterpretator write SetInterpretator;
      //** CallBack функция progress
    property OnProgress: TProcProgress read GetOnProgress write SetOnProgress;
      //** CallBack функция отсылки сообщения ядру
    //property OnSendMessageToCore: TProcMessage read FOnSendMessageToCore write FOnSendMessageToCore;
      //** Подпроцесс выполнения команд
    property Thread: TInterpretatorThread3 read GetThread write SetThread;
  end;

implementation

const
  //** Задержка (мсек) между проверками сметы статуса подпроцесса (старт/остановка/приостановка)
  TIC_TIME    = 16;
  //** Максимальное время ожидания (мсек) завершения процесса смены статуса подпроцесса
  MAX_TIMEOUT = 10000;

{ TAIProcess }

procedure TAiProcess.DoCreate();
begin
  inherited DoCreate();
  if not(Assigned(FThread)) then
    FThread := TInterpretatorThread3.Create();
end;

function TAiProcess.GetCodeString(): WideString;
begin
  if Assigned(FThread) then
    Result := FThread.CodeString;
end;

function TAiProcess.GetInterpretator(): IAiInterpretator;
begin
  Result := FThread.Interpretator;
end;

function TAiProcess.GetOnProgress(): TProcProgress;
begin
  Result := nil;
  if Assigned(FThread) then
    Result := FThread.OnProgress;
end;

function TAiProcess.GetThread(): TInterpretatorThread3;
begin
  Result := FThread;
end;

function TAiProcess.Pause(ATimeOut: Integer): WordBool;
var
  i: Integer;
begin
  Result := False;
  if Assigned(FThread) then
  try
    FThread.Pause();

    if ATimeOut > MAX_TIMEOUT then
      ATimeOut := MAX_TIMEOUT;

    i := 0;
    while (ATimeOut < i * TIC_TIME) do
    begin
      if (FThread.State = tsTerminated) or
         (FThread.State = tsTerminating) or
         (FThread.State = tsPaused) then
      begin
        Result := True;
        Exit;
      end;
      Inc(i);
      Sleep(TIC_TIME);
    end;
  except
  end;
end;

{function TAIProcess.SendMessage(const Msg: WideString): Integer;
begin
  if Assigned(FOnSendMessageToCore) then
  try
    Result := FOnSendMessageToCore(Msg);
  except
  end;
end;}

procedure TAiProcess.SetCodeString(const Value: WideString);
begin
  if Assigned(FThread) then
    FThread.CodeString := Value;
end;

procedure TAiProcess.SetInterpretator(Value: IAiInterpretator);
begin
  if Assigned(FThread) then
    FThread.Interpretator := Value;
end;

procedure TAiProcess.SetOnProgress(const Value: TProcProgress);
begin
  if Assigned(FThread) then
    FThread.OnProgress := Value;
end;

procedure TAiProcess.SetThread(Value: TInterpretatorThread3);
begin
  if Assigned(FThread) then
  begin
    FThread.Terminate();
  end;
  FThread := Value;
end;

function TAiProcess.Start(): WordBool;
begin
  Result := False;
  if Assigned(FThread) then
  try
    FThread.Start();

    // ...

    Result := True;
  except
  end;
end;

function TAiProcess.Stop(): WordBool;
begin
  Result := False;
  if Assigned(FThread) then
  try
    FThread.Stop();

    // ...

    Result := True;
  except
  end;
end;

end.
