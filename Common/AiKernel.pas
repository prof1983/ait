{**
@Abstract AiKernel lib client
@Author Prof1983 <prof1983@ya.ru>
@Created 19.06.2012
@LastMod 09.08.2012
}
unit AiKernel;

interface

uses
  ABase, ALibraries;

{** Boot AiKernel functions from library }
function AiKernel_Boot(): AError;

{** Initializes AiKernel
    @return AError value }
function AiKernel_Init(): AError; cdecl;

implementation

const
  AiKernelLib = 'AiKernel.dll';

type
  AiKernel_Init_Proc = function(): AError; cdecl;

var
  IsBooted: Boolean;
  _AiKernel_Init: AiKernel_Init_Proc;

// --- External ---

//function AiKernel_Init(): AError; cdecl; external AiKernelLib;

// --- AiKernel ---

function AiKernel_Boot(): AError;
var
  Lib: ALibrary;
begin
  Lib := Library_Open(AiKernelLib, 0);
  if (Lib = 0) then
  begin
    Result := -1;
    Exit;
  end;
  _AiKernel_Init := Library_GetProcAddress(Lib, 'AiKernel_Init');
end;

function AiKernel_Init(): AError;
begin
  if not(IsBooted) then
    AiKernel_Boot();
  if not(Assigned(_AiKernel_Init)) then
  begin
    Result := -1;
    Exit;
  end;
  try
    Result := _AiKernel_Init()
  except
    Result := -1;
  end;
end;

end.
