{**
@Abstract(Константы работы с языком AQL)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.03.2007)
@LastMod(03.05.2012)
@Version(0.5)
}
unit AqlConsts;

interface

// Структура сообщений для обмена информацией между агентами:
// <?xml version="1.0" encoding="E1"?>
// <aql sender="X1" recepient="X2" lang="L1">
// </aql>
// Здесь:
// E1 - Указывает в какой кодировке создано сообщение
// X1 - Имя или ID объекта который отправил сообщение
// X2 - Имя или ID объекта которому отправлено сообщения
// L1 - Язык на котором составлено сообщение
const
  AQL           = 'aql';
  AQL_SENDER    = 'sender';
  AQL_RECEPIENT = 'recepient';
  AQL_LANG      = 'lang';

// Названия языков обмена информацией между агентами:
const
  AQL_LANG_UML    = 'uml';   // [Prof]
  AQL_LANG_AR     = 'ar';    // [Prof]
  AQL_LANG_XVRML  = 'xvrml'; // [Prof]
  AQL_LANG_XFORM  = 'xform'; // [Prof]

// -----------------------------------------------------------------------------
// Константы для обмена сообщениями по fipa.org
{
http://fipa.org/specs/fipa00071/SC00071E.html
FIPA ACL Message Representation in XML Specification
}
const
  // Possible FIPA Communicative Acts. See [FIPA00037] for a full list of valid performatives.
  communicative_acts = 'communicative-acts';
    //accept-proposal
    //agree
    //cancel
    //cfp
    //confirm
    //disconfirm
    //failure
    //inform
    //not-understood
    //propose
    //query-if
    //query-ref
    //refuse
    //reject-proposal
    //request
    //request-when
    //request-whenever
    //subscribe
    //inform-if
    //inform-ref
    //proxy
    //propagate

const
  {The FIPA message root element, the communicative act is 
     an attribute - see below and the message itself is a list
     of parameters. The list is unordered. None of the elements
     should occur more than once except receiver.}
  msg_param = 'msg-param';
    //receiver
    //sender
    //content
    //language
    //encoding
    //ontology
    //protocol
    //reply-with
    //in-reply-to
    //reply-by
    //reply-to
    //conversation-id
    //user-defined

// -----------------------------------------------------------------------------
// Пример:
{
<fipa-message act="%act">
  <sender>...agent-identifier...</sender>
  <receiver>...agent-identifier...</receiver>
  <content href="url">...</content>
  <language href="url"></language>
  <encoding href="url"></encoding>
  <ontology href="url"></ontology>
  <protocol href="url"></protocol>
  <reply-with href="url"></reply-with>
  <in-reply-to href="url"></in-reply-to>
  <reply-by time="..." href="..."></reply-by>
  <reply-to>AgentTo</reply-to>
  <conversation-id href="url"></conversation-id>
</fipa-message>

<agent-identifier>
  <name id="..." refid="...">agentName</name>
  <addresses>
    <url>...</url>
    <url>...</url>
  </addresses>
  <resolvers>
    <agent-identifier>
      <name id="..." refid="...">agentName</name>
      <addresses>
        <url>...</url>
        <url>...</url>
      </addresses>
      <resolvers>
      </resolvers>
      <user-defined>
        <url>...</url>
        <url>...</url>
      </user-defined>
    </agent-identifier>
  </resolvers>
  <user-defined>
    <url>...</url>
    <url>...</url>
  </user-defined>
</agent-identifier>


name - An id can be used to uniquely identify the name of the agent.
     The refid attribute can be used to refer to an already defined
     agent name, avoiding unnecessary repetition. Either the id
     OR refid should be specified, (both should not be present at the
     same time).
}

// -----------------------------------------------------------------------------
// http://fipa.org/specs/fipa00085/SC00085J.html
{
<!--
Document Type: XML DTD
Document Purpose: Encoding of FIPA ACL message envelopes (as in [FIPA0067]).
See http://www.fipa.org
Last Revised: 2000-08-16
-->
<!ELEMENT     envelope               ( params+ )>
<!ELEMENT     params                 ( to?,
                                      from?,
                                      comments?,
                                      acl-representation?,
                                      payload-length?,
                                      payload-encoding?,
                                      date?,
                                      encrypted?,
                                      intended-receiver?,
                                      received?,
                                      user-defined* )>
<!ATTLIST     params                  index CDATA #REQUIRED>
<!ELEMENT     to                     ( agent-identifier+ )>
<!ELEMENT     from                   ( agent-identifier )>
<!ELEMENT     acl-representation     ( #PCDATA )>
<!ELEMENT     comments               ( #PCDATA )>
<!ELEMENT     payload-length         ( #PCDATA )>
<!ELEMENT     payload-encoding       ( #PCDATA )>
<!ELEMENT     date                   ( #PCDATA )>
<!ELEMENT     intended-receiver      ( agent-identifier+ )>
<!ELEMENT     agent-identifier       ( name,
                                      addresses?,
                                      resolvers?,
                                      user-defined* )>
<!ELEMENT     name                   ( #PCDATA )>
<!ELEMENT     addresses              ( url+ )>
<!ELEMENT     url                    ( #PCDATA )>
<!ELEMENT     resolvers              ( agent-identifier+ )>
<!ELEMENT     received               ( received-by,
                                      received-from?,
                                      received-date,
                                      received-id?,
                                      received-via?,
                                      user-defined* )>
<!ELEMENT     received-by            ( url )>
<!ELEMENT     received-from          ( url )>
<!ELEMENT     received-date           EMPTY>
<!ATTLIST     received-date           value CDATA #IMPLIED>
<!ELEMENT     received-id             EMPTY>
<!ATTLIST     received-id             value CDATA #IMPLIED>
<!ELEMENT     received-via            EMPTY>
<!ATTLIST     received-via            value CDATA #IMPLIED>
<!ELEMENT     user-defined           ( #PCDATA )>
<!ATTLIST     user-defined            href CDATA #IMPLIED>
}
implementation

end.
