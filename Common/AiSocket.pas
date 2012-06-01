{**
@Abstract(Команды обмена информацией между ядрами AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.12.2005)
@LastMod(24.02.2012)
@version(0.5)

Все сообщения (команды, события, ответы) передаются в формате XML в виде
одной строки без пробелов, табуляторов и знаков переноса между тегами.
Формат сообщения: <Message><Id>AAA</Id><Name1>BBB</Name1><NameN>ZZZ</NameN></Message>
Первый тег указывает тип сообщения:
  Comand - команда
  Event - событие
  Receive - результат выполнения команды (ответ)
Пример (Поиск плугинов):
<Comand>
  <Name>Plugins_Search</Name>
  <Path>C:\</Path>
</Comand>
Эта команда посылается ядру. Параметр Path указывает по какому пути производить поиск.
Результат обработки команды посылается вызвавшему его соккету или оболочке в следующем виде:
<Receive>
  <Ident>123456</Ident>
  <Comand>Plugins_Search</Comand>
  <Result>Ok</Result>
</Receive>
Здесь: Ident - номер команды, который присваевается ей во время постаноски в
список выполнения. Этот номер так же сразу возвращается вызавающему соккету в
виде резутьтата.
}
unit AiSocket;

interface

{const // Команды клиент-сервера -----------------------------------------------
  ARComGetCountFreims = $00000001;

  ARComAgentAdd         = $00000002;
  ARComAgentClose       = $00000003;
  ARComAgentDelete      = $00000004;
  ARComAgentGet         = $00000005;
  ARComAgentGetCount    = $00000006;
  ARComAgentOpen        = $00000007;

  ARComConnectAdd       = $00000008;
  ARComConnectDelete    = $00000009;
  ARComConnectGet       = $0000000A;
  ARComConnectGetCount  = $0000000B;

  ARComEventConnect     = $0000000C;
  ARComEventDisconect   = $0000000D;
  ARComEventGet         = $0000000E;
  ARComEventGetCount    = $0000000F;

  ARComDataClear        = $00000010;
  ARComDataGetDataSize  = $00000011;
  ARComDataGetDataType  = $00000012;
  ARComDataReadBool     = $00000013;
  ARComDataReadFloat32  = $00000014;
  ARComDataReadFloat64  = $00000015;
  ARComDataReadInt08    = $00000016;
  ARComDataReadInt16    = $00000017;
  ARComDataReadInt32    = $00000018;
  ARComDataReadInt64    = $00000019;
  ARComDataReadUInt08   = $0000001A;
  ARComDataReadUInt16   = $0000001B;
  ARComDataReadUInt32   = $0000001C;
  ARComDataReadUInt64   = $0000001D;
  ARComDataWriteBool    = $0000001E;
  ARComDataWriteFloat32 = $0000001F;
  ARComDataWriteFloat64 = $00000020;
  ARComDataWriteInt08   = $00000021;
  ARComDataWriteInt16   = $00000022;
  ARComDataWriteInt32   = $00000023;
  ARComDataWriteInt64   = $00000024;
  ARComDataWriteUInt08  = $00000025;
  ARComDataWriteUInt16  = $00000026;
  ARComDataWriteUInt32  = $00000027;
  ARComDataWriteUInt64  = $00000028;

  ARComFreimGetCountConnects = $00000029;
  ARComFreimGetDataSize = $0000002A;
  ARComFreimGetDateTimeCreate = $0000002B;
  ARComFreimGetSource   = $0000002C;
  ARComFreimGetType     = $0000002D;
  ARComFreimSetType     = $0000002E;

  ARComSourceAdd        = $0000002F;
  ARComSourceClose      = $00000030;
  ARComSourceDelete     = $00000031;
  ARComSourceGet        = $00000032;
  ARComSourceGetCount   = $00000033;
  ARComSourceOpen       = $00000034;}

const // Имена нодов в передаваемой команде ------------------------------------
  cMsgNodeID            = 'ID';
  cMsgNodeIdent         = 'Ident';
  cMsgNodeName          = 'Name';
  cMsgNodeOwner         = 'Owner';

const // Названия полей для передачи параметров в команде ----------------------
  cActive               = 'Active';
  cID                   = 'ID';
  cIdent                = 'Ident';
  cInfo                 = 'Info';
  cName                 = 'Name';
  cParams               = 'Params';
  cValue                = 'Value';

  cAgentActive          = cActive;
  cAgentID              = cID;
  cAgentInfo            = cInfo;
  cAgentName            = cName;
  cAgentVisible         = 'Visible';

  cEventID              = cID;
  cEventName            = cName;
  cEventParams          = cParams;

  cSourceActive         = cActive;
  cSourceInfo           = cInfo;
  cSourceName           = cName;

const // Команды ядру и плугинам - значение поля Name --------------------------
  cAgent_GetActive      = 'Agent_GetActive';
  cAgent_GetInfo        = 'Agent_GetInfo';
  cAgent_GetVisible     = 'Agent_GetVisible';
  cAgent_Finalize       = 'Agent_Finalize';
  cAgent_Initialize     = 'Agent_Initialize';
  cAgent_Registration   = 'Agent_Registration';
  cAgent_SetActive      = 'Agent_SetActive';
  cAgent_SetVisible     = 'Agent_SetVisible';
  cAgent_UnRegistration = 'Agent_UnRegistration';

  cAgents_AddAgent      = 'Agents_AddAgent';
  cAgents_Clear         = 'Agents_Clear';
  cAgents_Count         = 'Agents_Count';
  cAgents_DeleteAgent     = 'Agents_DeleteAgent';
  cAgents_FinalizeAgent   = 'Agents_FinalizeAgent';
  cAgents_GetAgentInfo    = 'Agents_GetAgentInfo<';
  cAgents_InitializeAgent = 'Agents_InitializeAgent';
  cAgents_Search        = 'Agents_Search';

  cConnects_AddConnect    = 'Connects_AddConnect';
  cConnects_DeleteConnect = 'Connects_DeleteConnect';
  cConnects_GetConnect    = 'Connects_GetConnect';

  cData_Clear             = 'Data_Clear';
  cData_GetDataSize       = 'Data_GetDataSize';
  cData_GetDataType       = 'Data_GetDataType';
  cData_ReadBool          = 'Data_ReadBool';
  cData_ReadFloat32       = 'Data_ReadFloat32';
  cData_ReadFloat64       = 'Data_ReadFloat64';
  cData_ReadInt08         = 'Data_ReadInt08';
  cData_ReadInt16         = 'Data_ReadInt16';
  cData_ReadInt32         = 'Data_ReadInt32';
  cData_ReadInt64         = 'Data_ReadInt64';
  cData_ReadString        = 'Data_ReadString';
  cData_ReadUInt08        = 'Data_ReadUInt08';
  cData_ReadUInt16        = 'Data_ReadUInt16';
  cData_ReadUInt32        = 'Data_ReadUInt32';
  cData_ReadUInt64        = 'Data_ReadUInt64';
  cData_WriteBool         = 'Data_ReadBool';
  cData_WriteFloat32      = 'Data_WriteFloat32';
  cData_WriteFloat64      = 'Data_WriteFloat64';
  cData_WriteInt08        = 'Data_WriteInt08';
  cData_WriteInt16        = 'Data_WriteInt16';
  cData_WriteInt32        = 'Data_WriteInt32';
  cData_WriteInt64        = 'Data_WriteInt64';
  cData_WriteString       = 'Data_WriteString';
  cData_WriteUInt08       = 'Data_WriteUInt08';
  cData_WriteUInt16       = 'Data_WriteUInt16';
  cData_WriteUInt32       = 'Data_WriteUInt32';
  cData_WriteUInt64       = 'Data_WriteUInt64';

  cEvents_Clear           = 'Events_Clear';
  cEvents_Connect         = 'Events_Connect';
  cEvents_Count           = 'Events_Count';
  cEvents_CreateEvent     = 'Events_CreateEvent';
  cEvents_Disconect       = 'Events_Disconnect';
  cEvents_FreeEvent       = 'Events_FreeEvent';
  cEvents_GetEventInfo    = 'Events_GetEventInfo';
  cEvents_OnEvent         = 'Events_OnEvent';
  cEvents_Search          = 'Events_Search';

  cFreim_GetCountConnects = 'Freim_GetCountConnects';
  cFreim_GetDataSize      = 'Freim_GetDataSize';
  cFreim_GetDateTimeCreate = 'Freim_GetDateTimeCreate';
  cFreim_GetSource        = 'Freim_GetSource';
  cFreim_GetType          = 'Freim_GetType';
  cFreim_SetSource        = 'Freim_SetSource';
  cFreim_SetType          = 'Freim_SetType';

  cPlugin_GetCountAgents  = 'Plugin_GetCountAgents';
  cPlugin_GetCountSources = 'Plugin_GetCountSources';

  cPlugins_Clear          = 'Plugins_Clear';
  cPlugins_Count          = 'Plugins_Count';
  cPlugins_GetPluginInfo  = 'Plugins_GetPluginInfo';
  cPlugins_Search         = 'Plugins_Search';

  cSources_AddSource      = 'Sources_AddSource';
  cSources_Clear          = 'Sources_Clear';
  cSources_Count          = 'Sources_Count';
  cSources_DeleteSource   = 'Sources_DeleteSource';
  cSources_FinalizeSource = 'Sources_FinalizeSource';
  cSources_GetSourceInfo  = 'Sources_GetSourceInfo';
  cSources_InitializeSource = 'Sources_InitializeSource';
  cSources_Search         = 'Sources_Search';

const // События от ядра и плугинов - значение поля Name -----------------------
  Event_AgentAdd         = 'AgentAdd';
  Event_AgentClose       = 'AgentClose';
  Event_AgentDelete      = 'AgentDelete';
  Event_AgentOpen        = 'AgentOpen';

  Event_ClearAgents      = 'ClearAgents';
  Event_ClearEvents      = 'ClearEvents';
  Event_ClearPlugins     = 'ClearPlugins';
  Event_ClearSources     = 'ClearSources';

  Event_ConnectAdd       = 'ConnectAdd';
  Event_ConnectDelete    = 'ConnectDelete';
  Event_ConnectGet       = 'ConnectGet';

  Event_DataClear        = 'DataClear';
  Event_DataGetDataSize  = 'DataGetDataSize';
  Event_DataGetDataType  = 'DataGetDataType';
  Event_DataReadBool     = 'DataReadBool';
  Event_DataReadFloat32  = 'DataReadFloat32';
  Event_DataReadFloat64  = 'DataReadFloat64';
  Event_DataReadInt08    = 'DataReadInt08';
  Event_DataReadInt16    = 'DataReadInt16';
  Event_DataReadInt32    = 'DataReadInt32';
  Event_DataReadInt64    = 'DataReadInt64';
  Event_DataReadUInt08   = 'DataReadUInt08';
  Event_DataReadUInt16   = 'DataReadUInt16';
  Event_DataReadUInt32   = 'DataReadUInt32';
  Event_DataReadUInt64   = 'DataReadUInt64';
  Event_DataWriteBool    = 'DataWriteBool';
  Event_DataWriteFloat32 = 'DataWriteFloat32';
  Event_DataWriteFloat64 = 'DataWriteFloat64';
  Event_DataWriteInt08   = 'DataWriteInt08';
  Event_DataWriteInt16   = 'DataWriteInt16';
  Event_DataWriteInt32   = 'DataWriteInt32';
  Event_DataWriteInt64   = 'DataWriteInt64';
  Event_DataWriteUInt08  = 'DataWriteUInt08';
  Event_DataWriteUInt16  = 'DataWriteUInt16';
  Event_DataWriteUInt32  = 'DataWriteUInt32';
  Event_DataWriteUInt64  = 'DataWriteUInt64';

  Event_EventConnect     = 'EventConnect';
  Event_EventDisconect   = 'EventDisconect';

  Event_FreimGetCountConnects  = 'FreimGetCountConnects';
  Event_FreimGetDataSize       = 'FreimGetDataSize';
  Event_FreimGetDateTimeCreate = 'FreimGetDateTimeCreate';
  Event_FreimGetSource         = 'FreimGetSource';
  Event_FreimGetType           = 'FreimGetType';
  Event_FreimSetSource         = 'FreimSetSource';
  Event_FreimSetType           = 'FreimSetType';

  Event_GetAgentInfo     = 'GetAgentInfo';
  Event_GetCountAgents   = 'GetCountAgents';
  Event_GetCountEvents   = 'GetCountEvents';
  Event_GetCountPlugins  = 'GetCountPlugins';
  Event_GetCountSources  = 'GetCountSources';
  Event_GetEventInfo     = 'GetEventInfo';
  Event_GetPluginInfo    = 'GetPluginInfo';
  Event_GetSourceInfo    = 'GetSourceInfo';

  Event_SearchAgents     = 'SearchAgents';
  Event_SearchEvents     = 'SearchEvents';
  Event_SearchPlugins    = 'SearchPlugins';
  Event_SearchSources    = 'SearchSources';

  Event_SourceAdd        = 'SourceAdd';
  Event_SourceClose      = 'SourceClose';
  Event_SourceDelete     = 'SourceDelete';
  Event_SourceOpen       = 'SourceOpen';

const // Receive Value - Значения поля Value в ответе на команду ---------------
  cAnswerOK               = 'OK';
  cAnswerError            = 'Error';
  cAnswerWarning          = 'Warning';

const // Сообщения об ошибках --------------------------------------------------
  cAnswerError_Comand_Uncnown = 'Error_Comand_Uncnown';
  cAnswerError_Source_Main    = 'Error_Source_Main';

const // Сообщения об ошибках --------------------------------------------------
  sER_Comand_Uncnown     = 'Не известная команда';
  sER_Source_Main        = 'Источник берет данные из ядра. Читать из ядра этот источник нельзя.';

implementation

end.
