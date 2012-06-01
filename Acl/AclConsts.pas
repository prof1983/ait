{**
@Abstract(ACL Consts)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.03.2007)
@LastMod(13.03.2012)
@Version(0.5)

Все константы менять крайне не рекомендуется.

История версий:
0.1.0.1 - 29.07.2007 - Переименован AIAclConsts -> AclConsts
0.1.0.0 - 21.06.2007 -
  Добавил ACL_SELECT, ACL_CONVERSATION_ID, ACL_REPLY_WITH, ACL_REPLY_TO, ACL_REPLY_BY
}
unit AclConsts;

interface

const
  //** Тип сообщения
  ACL_PERFORMATIVE = 'Performative';
  //** Отправитель сообщения
  ACL_SENDER = 'Sender';
  //** Получатель сообщения
  ACL_RECEIVER = 'Receiver';
  //** Адреса агентов, которым отправлять ответ
  ACL_REPLY_TO = 'ReplyTo'; //'Reply-to';
  //** Содержание сообщения
  ACL_CONTENT = 'Content';
  //** Язык кодирования сообщения
  ACL_LANGUAGE = 'Language';
  //** Кодировка содержания сообщения
  ACL_ENCODING = 'Encoding';
  //** Онтология, используемая для интерпретации сообщения
  ACL_ONTOLOGY = 'Ontology';
  //** Протокол взаимодействия агентов
  ACL_PROTOCOL = 'Protocol';
  //** Идентификатор сообщений
  ACL_CONVERSATION_ID = 'ConversationID';  //Conversation-id -
  //** Строка, идентифицирующая сообщение
  ACL_REPLY_WITH = 'ReplyWith';  //Reply-with
  //** Строка, идентифицирующая сообщение соответствует параметру reply-with при ответе на сообщение
  ACL_IN_REPLY_TO = 'InReplyTo'; //In-reply-to
  //** Время, к которому необходимо получить ответ
  ACL_REPLY_BY = 'ReplyBy';  //Reply-by

type
  TAclPerformative = Integer;
const
    //** Принять предложение (constant identifying the FIPA performative)
  ACL_ACCEPT_PROPOSAL = 0;
    //** Согласится (constant identifying the FIPA performative)
  ACL_AGREE = 1;
    //** Отмена (constant identifying the FIPA performative)
  ACL_CANCEL = 2;
    //** constant identifying the FIPA performative
  ACL_CFP = 3;
    //** Подтвердить (constant identifying the FIPA performative)
  ACL_CONFIRM = 4;
    //** Не подтвердить (constant identifying the FIPA performative)
  ACL_DISCONFIRM = 5;
    //** Неудача (constant identifying the FIPA performative)
  ACL_FAILURE = 6;
    //** Информируйте (constant identifying the FIPA performative)
  ACL_INFORM = 7;
    //** Информируйте, если (constant identifying the FIPA performative)
  ACL_INFORM_IF = 8;
    //** Информируйте (constant identifying the FIPA performative)
  ACL_INFORM_REF = 9;
    //** Не понятно (constant identifying the FIPA performative)
  ACL_NOT_UNDERSTOOD = 10;
    //** Предложите (constant identifying the FIPA performative)
  ACL_PROPOSE = 11;
    //** Запрос, если (constant identifying the FIPA performative)
  ACL_QUERY_IF = 12;
    //** Запрос (constant identifying the FIPA performative)
  ACL_QUERY_REF = 13;
    //** Мусор (constant identifying the FIPA performative)
  ACL_REFUSE = 14;
    //** Предложите брак (constant identifying the FIPA performative)
  ACL_REJECT_PROPOSAL = 15;
    //** Запрос (constant identifying the FIPA performative)
  ACL_REQUEST = 16;
    //** Запрос, когда (constant identifying the FIPA performative)
  ACL_REQUEST_WHEN = 17;
    //** Запрос каждый раз, когда (constant identifying the FIPA performative)
  ACL_REQUEST_WHENEVER = 18;
    //** Подписаться (constant identifying the FIPA performative)
  ACL_SUBSCRIBE = 19;
    //** Proxy (constant identifying the FIPA performative)
  ACL_PROXY = 20;
    //** Распространяйте (constant identifying the FIPA performative)
  ACL_PROPAGATE = 21;
    //** Не известно (constant identifying an unknown performative)
  ACL_UNKNOWN = -1;

const // [Prof]
    //** Запрос
  ACL_SELECT = $1000;

{ Здесь можно было реализовать так:
type
  TPerformative = (
    ACL_ACCEPT_PROPOSAL,
    ACL_AGREE,
    ...
    );
и затем создать константный массив строк:
performatives: array[TPerformative] of WideString = (
  'ACCEPT-PROPOSAL',
  'AGREE', ...
  );
Я нарочно этого не сделал, т.к. работа с константами лучше!
}

// This array of Strings keeps the names of the performatives
const
  STR_ACCEPT_PROPOSAL = 'ACCEPT-PROPOSAL';
  STR_AGREE           = 'AGREE';
  STR_CANCEL          = 'CANCEL';
  STR_CFP             = 'CFP';
  STR_CONFIRM         = 'CONFIRM';
  STR_DISCONFIRM      = 'DISCONFIRM';
  STR_FAILURE         = 'FAILURE';
  STR_INFORM          = 'INFORM';
  STR_INFORM_IF       = 'INFORM-IF';
  STR_INFORM_REF      = 'INFORM-REF';
  STR_NOT_UNDERSTOOD  = 'NOT-UNDERSTOOD';
  STR_PROPOSE         = 'PROPOSE';
  STR_QUERY_IF        = 'QUERY-IF';
  STR_QUERY_REF       = 'QUERY-REF';
  STR_REFUSE          = 'REFUSE';
  STR_REJECT_PROPOSAL = 'REJECT-PROPOSAL';
  STR_REQUEST         = 'REQUEST';
  STR_REQUEST_WHEN    = 'REQUEST-WHEN';
  STR_REQUEST_WHENEVER = 'REQUEST-WHENEVER';
  STR_SUBSCRIBE       = 'SUBSCRIBE';
  STR_PROXY           = 'PROXY';
  STR_PROPAGATE       = 'PROPAGATE';

const
  RU_ACCEPT_PROPOSAL = 'Принять предложение'; //'ACCEPT-PROPOSAL';
  RU_AGREE           = 'согласиться'; //'AGREE';
  RU_CANCEL          = 'отмена'; //'CANCEL';
  RU_CFP             = 'CFP';
  RU_CONFIRM         = 'Подтвердить'; //'CONFIRM';
  RU_DISCONFIRM      = 'Не подтвердить'; //'DISCONFIRM';
  RU_FAILURE         = 'Неудача'; //'FAILURE';
  RU_INFORM          = 'Информируйте'; //'INFORM';
  RU_INFORM_IF       = 'Информируйте, если'; //'INFORM-IF';
  RU_INFORM_REF      = 'INFORM-REF';
  RU_NOT_UNDERSTOOD  = 'NOT-UNDERSTOOD';
  RU_PROPOSE         = 'PROPOSE';
  RU_QUERY_IF        = 'Запрос, если'; //'QUERY-IF';
  RU_QUERY_REF       = 'Запрос'; //'QUERY-REF';
  RU_REFUSE          = 'Мусор'; //'REFUSE';
  RU_REJECT_PROPOSAL = 'REJECT-PROPOSAL';
  RU_REQUEST         = 'требуется'; //'REQUEST';
  RU_REQUEST_WHEN    = 'Требуется, когда'; //'REQUEST-WHEN';
  RU_REQUEST_WHENEVER = 'REQUEST-WHENEVER';
  RU_SUBSCRIBE       = 'подписаться'; //'SUBSCRIBE';
  RU_PROXY           = 'PROXY';
  RU_PROPAGATE       = 'PROPAGATE';

const
  performatives: array[0..21] of WideString = (
    STR_ACCEPT_PROPOSAL,
    STR_AGREE,
    STR_CANCEL,
    STR_CFP,
    STR_CONFIRM,
    STR_DISCONFIRM,
    STR_FAILURE,
    STR_INFORM,
    STR_INFORM_IF,
    STR_INFORM_REF,
    STR_NOT_UNDERSTOOD,
    STR_PROPOSE,
    STR_QUERY_IF,
    STR_QUERY_REF,
    STR_REFUSE,
    STR_REJECT_PROPOSAL,
    STR_REQUEST,
    STR_REQUEST_WHEN,
    STR_REQUEST_WHENEVER,
    STR_SUBSCRIBE,
    STR_PROXY,
    STR_PROPAGATE
    );

const
  {**
  User defined parameter key specifying, when set to "true", that if the delivery of a
  message fails, no FAILURE notification has to be sent back to the sender.
  }
  STR_IGNORE_FAILURE = 'JADE-ignore-failure';
  {**
  User defined parameter key specifying that the corresponding value must be
  replaced by the JADE runtime by an ISO8601 encoded time-stamp at posting time.
  }
  STR_POST_TIME_STAMP = 'JADE-post-ts';
  {**
  User defined parameter key specifying that the JADE tracing mechanism should be
  activated for this message.
  }
  STR_TRACE = 'JADE-trace';

implementation

end.
