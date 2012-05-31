/* AKernel
Author(Prof1983 prof1983@ya.ru)
Created(05.04.2012)
LastMod(05.04.2012)
Version(0.5)
*/

#include "AKernel.h"

AKernel_Type AKernel;

/* Public functions */

func AKernel_AddAgent(AAgentInfo AgentInfo) {
	return -1;
}

func AKernel_DeleteAgentById(AInteger AgentId) {
	return -1;
}

func AKernel_DeleteAgentByName(AString AgentName) {
	return -1;
}

func AKernel_GetAgentInfoById(AInteger AgentId, AAgentInfo AgentInfo) {
	return -1;
}

func AKernel_GetAgentKarma(AInteger AgentId) {
	return -1;
}

func AKernel_Init() {
	AKernel.AddAgent = AKernel_AddAgent;
	AKernel.DeleteAgentById = AKernel_DeleteAgentById;
	AKernel.DeleteAgentByName = AKernel_DeleteAgentByName;
	AKernel.GetAgentInfoById = AKernel_GetAgentInfoById;
	AKernel.GetAgentKarma = AKernel_GetAgentKarma;
	return 0;
}
