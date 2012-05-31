/* AKernel
Author(Prof1983 prof1983@yandex.ru)
Created(05.04.2012)
LastMod(05.04.2012)
Version(0.5)
*/

#ifndef AKernelH
#define AKernelH

#include "ABase2.h"

typedef struct {
	AString Name;
} AAgentInfo_Type;
typedef AAgentInfo_Type* AAgentInfo;

typedef struct {
	/* Local agent identificator. */
	AInteger AgentId;
	/* Agent information. */
	AAgentInfo AgentInfo;
	/* Agent karma. */
	AInteger Karma;
} AAgent_Type;
typedef AAgent_Type AAgent;

/* --- Functions --- */

/* Initialize AKernel. */
func AKernel_Init();

/* Add agent. */
func AKernel_AddAgent(AAgentInfo AgentInfo);

/* Delete agent. */
func AKernel_DeleteAgentById(AInteger AgentId);

/* Delete agent by name. */
func AKernel_DeleteAgentByName(AString AgentName);

/* Return agent information. */
func AKernel_GetAgentInfoById(AInteger AgentId, AAgentInfo AgentInfo);

/* Add agent karma. */
func AKernel_GetAgentKarma(AInteger AgentId);

/* --- AKernel procs --- */

/* Add agent. */
typedef func (*AKernel_AddAgent_Proc)(AAgentInfo AgentInfo);

/* Delete agent. */
typedef func (*AKernel_DeleteAgentById_Proc)(AInteger AgentId);

/* Delete agent by name. */
typedef func (*AKernel_DeleteAgentByName_Proc)(AString AgentName);

/* Return agent information. */
typedef func (*AKernel_GetAgentInfoById_Proc)(AInteger AgentId, AAgentInfo AgentInfo);

/* Add agent karma. */
typedef func (*AKernel_GetAgentKarma_Proc)(AInteger AgentId);

typedef struct {
	AKernel_AddAgent_Proc AddAgent;
	AKernel_DeleteAgentById_Proc DeleteAgentById;
	AKernel_DeleteAgentByName_Proc DeleteAgentByName;
	AKernel_GetAgentInfoById_Proc GetAgentInfoById;
	AKernel_GetAgentKarma_Proc GetAgentKarma;
} AKernel_Type;

extern AKernel_Type AKernel;

#endif