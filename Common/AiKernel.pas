{**
@Abstract(AiKernel lib client)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.06.2012)
@LastMod(19.06.2012)
@Version(0.0)
}
unit AiKernel;

interface

uses
  ABase;

{** Initializes AiKernel
 *  @return AError value
 *}
function AiKernel_Init(): AError; cdecl;

implementation

const
  AiKernelLib = 'AiKernel.dll';

function AiKernel_Init(): AError; cdecl; external AiKernelLib;

end.
