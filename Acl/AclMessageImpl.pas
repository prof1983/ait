{**
@Abstract(ACL Message)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.03.2007)
@LastMod(26.04.2012)
@Version(0.5)

Структура ACL сообщения (http://grouper.ieee.org/groups/ifets/russian/depository/v7_i2/pdf/3.pdf)
Performative - Тип сообщения
Sender       - Отправитель сообщения
Receiver     - Получатель сообщения
Reply-to     - Адреса агентов, которым отправлять ответ
Content      - Содержание сообщения
Language     - Язык кодирования сообщения
Encoding     - Кодировка содержания сообщения
Ontology     - Онтология, используемая для интерпретации сообщения
Protocol     - Протокол взаимодействия агентов
Conversation-id - Идентификатор сообщений
Reply-with   - Строка, идентифицирующая сообщение
In-reply-to  - Строка, идентифицирующая сообщение соответствует параметру
               reply-with при ответе на сообщение
Reply-by     - Время, к которому необходимо получить ответ

История версий:
0.0.1.0 - 21.06.2007 - Избавился от зависимости с ProfMessage
}
unit AclMessageImpl;

interface

uses
  SysUtils,
  AclAgentIdIntf, AclConsts, AclMessageIntf, AclTypes;

//import java.io.IOException;
//import java.io.ByteArrayOutputStream;
//import java.io.ByteArrayInputStream;
//import java.io.ObjectOutputStream;
//import java.io.ObjectInputStream;
//import java.lang.ClassNotFoundException;
//import java.util.Date;

//import jade.util.leap.Serializable;
//import jade.util.leap.ArrayList;
//import jade.util.leap.Iterator;
//import jade.util.leap.Properties;
//import jade.util.leap.EmptyIterator;
//import jade.util.leap.EnumIterator;
//import java.util.Vector;
//
//import jade.domain.FIPAAgentManagement.Envelope;

type
  {**
    The class ACLMessage implements an ACL message compliant to the <b>FIPA 2000</b> "FIPA ACL Message Structure Specification" (fipa000061) specifications.
    All parameters are couples <em>keyword: value</em>.
    All keywords are <code>private final String</code>.
    All values can be set by using the methods <em>set</em> and can be read by using
    the methods <em>get</em>.
    <p> <b>Warning: </b> since JADE 3.1  an exception might be thrown
    during the serialization of the ACLMessage parameters (with
    exception of the content of the ACLMessage) because of a limitation
    to 65535 in the total number of bytes needed to represent all the
    characters of a String (see also java.io.DataOutput#writeUTF(String)).
    <p> The methods <code> setByteSequenceContent() </code> and
    <code> getByteSequenceContent() </code> allow to send arbitrary
    sequence of bytes
    over the content of an ACLMessage.
    <p> The couple of methods
    <code> setContentObject() </code> and
    <code> getContentObject() </code> allow to send
    serialized Java objects over the content of an ACLMessage.
    These method are not strictly
    FIPA compliant so their usage is not encouraged.
    @author Fabio Bellifemine - CSELT
    @version $Date: 2006-03-27 12:57:34 +0200 (lun, 27 mar 2006) $ $Revision: 5875 $
    @see <a href=http://www.fipa.org/specs/fipa00061/XC00061D.html>FIPA Spec</a>
  }
  TAclMessage = class(TInterfacedObject, IAclMessage) //(TProfMessage3, IAclMessage) //(Cloneable, Serializable
  private
    // Explicitly set for compatibility between standard and micro version
    //private static final long serialVersionUID=3945353187608998130L;
    //serialVersionUID: Int64; // ?
    FDests: array of IAclAgentID;

    {**
      At a given time or content or byteSequenceContent are != null,
      it is not allowed that both are != null
    }
    FByteSequenceContent: string;
    //** Кодировка содержания сообщения
    FEncoding: WideString;
    //** Язык кодирования сообщения
    FLanguage: WideString;
    //** Онтология, используемая для интерпретации сообщения
    FOntology: WideString;

    //userDefProps: Properties;
    //messageEnvelope: Envelope;
    //** For persistence service
    FPersistentID: Int64;
    //** Тип сообщения
    FPerformative: TAclPerformative;
    //** Протокол взаимодействия агентов
    FProtocol: WideString;
    //** Получатель сообщения [Prof]
    FReceiver: IAclAgentID;
    //** Время, к которому необходимо получить ответ
    //FReplyByInMillisec: Int64; // TODO: Удалить
    //** Адреса агентов, которым отправлять ответ
    FReplyTo: array of IAclAgentID;
    //** Отправитель сообщения
    FSender: IAclAgentID;
    FContent: string;
    FConversationID: string;
    FInReplyTo: string;
    FReceiverName: string;
    FReplyBy: TDateTime;
    FReplyWith: string;
    FSenderName: string;
  protected
    //** Returns the list of the communicative acts as an array of <code>String</code>.
    //public static String[] getAllPerformativeNames()
    {
      return performatives;
    }

    {**
      Reads <code>:content</code> slot. <p>
      <p>Notice that, in general, setting a String content and getting
      back a byte sequence content - or viceversa - does not return
      the same value, i.e. the following relation does not hold
      <code>
      getByteSequenceContent(setByteSequenceContent(getContent().getBytes()))
      is equal to getByteSequenceContent()
      </code>
      @return The value of <code>:content</code> slot.
      @see jade.lang.acl.ACLMessage#setContent(String)
      @see jade.lang.acl.ACLMessage#getContent()
      @see jade.lang.acl.ACLMessage#getContentObject()
      @see java.io.ObjectInputStream
    }
    function GetByteSequenceContent(): string;
    {**
     Reads <code>:conversation-id</code> slot.
     @return The value of <code>:conversation-id</code>slot.
     @see jade.lang.acl.ACLMessage#setConversationId(String).
    }
    function GetConversationID(): WideString;
    {**
      Reads <code>:content</code> slot. <p>
      <p>Notice that, in general, setting a String content and getting
      back a byte sequence content - or viceversa - does not return
      the same value, i.e. the following relation does not hold
      <code>
      getByteSequenceContent(setByteSequenceContent(getContent().getBytes()))
      is equal to getByteSequenceContent()
      </code>
      @return The value of <code>:content</code> slot.
      @see jade.lang.acl.ACLMessage#setContent(String)
      @see jade.lang.acl.ACLMessage#getByteSequenceContent()
      @see jade.lang.acl.ACLMessage#getContentObject()
      @see java.io.ObjectInputStream
    }
    function GetContent(): WideString;
    {**
     Reads <code>:encoding</code> slot.
     @return The value of <code>:encoding</code>slot.
     @see jade.lang.acl.ACLMessage#setEncoding(String).
    }
    function GetEncoding(): WideString;
    {**
     Reads <code>:reply-to</code> slot.
     @return The value of <code>:reply-to</code>slot.
     @see jade.lang.acl.ACLMessage#setInReplyTo(String).
    }
    function GetInReplyTo(): WideString;
    {**
     Reads <code>:language</code> slot.
     @return The value of <code>:language</code>slot.
     @see jade.lang.acl.ACLMessage#setLanguage(String).
    }
    function GetLanguage(): WideString;
    {**
     Reads <code>:ontology</code> slot.
     @return The value of <code>:ontology</code>slot.
     @see jade.lang.acl.ACLMessage#setOntology(String).
    }
    function GetOntologyStr(): WideString;
    {**
      return the integer representing the performative of this object
      @return an integer representing the performative of this object
    }
    function GetPerformative(): TAclPerformative;
  	//** For persistence service
    function GetPersistentID(): Int64;
    {**
     Reads <code>:protocol</code> slot.
     @return The value of <code>:protocol</code>slot.
     @see jade.lang.acl.ACLMessage#setProtocol(String).
    }
    function GetProtocol(): WideString;
    //** Получатель
    function GetReceiver(): IAclAgentID;
    {**
     Reads <code>:receiver</code> slot.
     @return An <code>Iterator</code> containing the Agent IDs of the
     receiver agents for this message.
     [Prof]
    }
    function GetReceiverA(Index: Integer): IAclAgentID;
    //** Колличество получателей [Prof]
    function GetReceiverCount(): Integer;
    function GetReceiverName(): WideString;
    {**
     Reads <code>:reply-by</code> slot.
     @return The value of <code>:reply-by</code>slot, as a string.
     @see jade.lang.acl.ACLMessage#getReplyByDate().
     @deprecated Since the value of this slot is a Date by definition, then
     the <code>getReplyByDate</code> should be used that returns a Date
    }
    function GetReplyBy(): WideString;
    {**
     Reads <code>:reply-by</code> slot.
     @return The value of <code>:reply-by</code>slot, as a
     <code>Date</code> object.
     @see jade.lang.acl.ACLMessage#setReplyByDate(Date).
    }
    function GetReplyByDate(): TDateTime;
    {**
     Reads <code>:reply-with</code> slot.
     @return The value of <code>:reply-with</code>slot.
     @see jade.lang.acl.ACLMessage#setReplyWith(String).
    }
    function GetReplyWith(): WideString;
    function GetReplyTo(Index: Integer): IAclAgentID;
    function GetReplyToCount(): Integer;
    {**
     Reads <code>:sender</code> slot.
     @return The value of <code>:sender</code>slot.
     @see jade.lang.acl.ACLMessage#setSender(AID).
    }
    function GetSender(): IAclAgentID;
    //** Имя отправителя
    function GetSenderName(): WideString;


    {**
      Writes the <code>:content</code> slot. <em><b>Warning:</b> no
      checks are made to validate the slot value.</em> <p>
      <p>Notice that, in general, setting a String content and getting
      back a byte sequence content - or viceversa - does not return
      the same value, i.e. the following relation does not hold
      <code>
      getByteSequenceContent(setByteSequenceContent(getContent().getBytes()))
      is equal to getByteSequenceContent()
      </code>
      @param content The new value for the slot.
      @see jade.lang.acl.ACLMessage#setContent(String s)
      @see jade.lang.acl.ACLMessage#getByteSequenceContent()
      @see jade.lang.acl.ACLMessage#setContentObject(Serializable s)
    }
    procedure SetByteSequenceContent(content: string);
    {**
      Writes the <code>:content</code> slot. <em><b>Warning:</b> no
      checks are made to validate the slot value.</em> <p>
      <p>Notice that, in general, setting a String content and getting
      back a byte sequence content - or viceversa - does not return
      the same value, i.e. the following relation does not hold
      <code>
      getByteSequenceContent(setByteSequenceContent(getContent().getBytes()))
      is equal to getByteSequenceContent()
      </code>
      @param content The new value for the slot.
      @see jade.lang.acl.ACLMessage#getContent()
      @see jade.lang.acl.ACLMessage#setByteSequenceContent(byte[])
      @see jade.lang.acl.ACLMessage#setContentObject(Serializable s)
    }
    procedure SetContent(const Content: WideString);
    {**
     Writes the <code>:conversation-id</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param str The new value for the slot.
     @see jade.lang.acl.ACLMessage#getConversationId()
    }
    procedure SetConversationID(const Str: WideString);
    {**
     Writes the <code>:encoding</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param str The new value for the slot.
     @see jade.lang.acl.ACLMessage#getEncoding()
    }
    procedure SetEncoding(const Str: WideString);
    {**
     Writes the <code>:in-reply-to</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param reply The new value for the slot.
     @see jade.lang.acl.ACLMessage#getInReplyTo()
    }
    procedure SetInReplyTo(const Reply: WideString);
    {**
     Writes the <code>:language</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param str The new value for the slot.
     @see jade.lang.acl.ACLMessage#getLanguage()
    }
    procedure SetLanguage(const Str: WideString);
    {**
     Writes the <code>:ontology</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param str The new value for the slot.
     @see jade.lang.acl.ACLMessage#getOntology()
    }
    procedure SetOntologyStr(const Str: WideString);
    {**
      set the performative of this ACL message object to the passed constant.
      Remind to
      use the set of constants (i.e. <code> INFORM, REQUEST, ... </code>)
      defined in this class
    }
    procedure SetPerformative(Value: TAclPerformative);
    //** For persistence service
    procedure SetPersistentID(Value: Int64);
    {**
     Writes the <code>:protocol</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param str The new value for the slot.
     @see jade.lang.acl.ACLMessage#getProtocol()
    }
    procedure SetProtocol(const Str: WideString);
    //** Имя отправителя [Prof]
    procedure SetReceiverName(const Value: WideString);
    {**
     Writes the <code>:reply-by</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param date The new value for the slot.
     @see jade.lang.acl.ACLMessage#getReplyByDate()
    }
    procedure SetReplyByDate(date: TDateTime);
    {**
     Writes the <code>:reply-with</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param reply The new value for the slot.
     @see jade.lang.acl.ACLMessage#getReplyWith()
    }
    procedure SetReplyWith(const Reply: WideString);
    {**
     Writes the <code>:sender</code> slot. <em><b>Warning:</b> no
     checks are made to validate the slot value.</em>
     @param source The new value for the slot.
     @see jade.lang.acl.ACLMessage#getSender()
    }
    procedure SetSender(Value: IAclAgentID);
    //** Имя отправителя [Prof]
    procedure SetSenderName(const Value: WideString);
  public
    {**
      @deprecated Since every ACL Message must have a message type, you
      should use the new constructor which gets a message type as a
      parameter.  To avoid problems, now this constructor silently sets
      the message type to <code>not-understood</code>.
      @see jade.lang.acl.ACLMessage#ACLMessage(int)
    }
    constructor Create();

    {**
     Adds a value to <code>:receiver</code> slot. <em><b>Warning:</b>
     no checks are made to validate the slot value.</em>
     @param r The value to add to the slot value set.
    }
    procedure AddReceiver(r: IAclAgentID);

    {**
     Removes a value from <code>:receiver</code>
     slot. <em><b>Warning:</b> no checks are made to validate the slot
     value.</em>
     @param r The value to remove from the slot value set.
     @return true if the AID has been found and removed, false otherwise
    }
    function RemoveReceiver(s: IAclAgentID): WordBool;

    {**
     Removes all values from <code>:receiver</code>
     slot. <em><b>Warning:</b> no checks are made to validate the slot
     value.</em>
    }
    procedure ClearAllReceiver();

    {**
     Adds a value to <code>:reply-to</code> slot. <em><b>Warning:</b>
     no checks are made to validate the slot value.</em>
     @param dest The value to add to the slot value set.
    }
    procedure AddReplyTo(dest: IAclAgentID);

    {**
     Removes a value from <code>:reply_to</code>
     slot. <em><b>Warning:</b> no checks are made to validate the slot
     value.</em>
     @param dest The value to remove from the slot value set.
     @return true if the AID has been found and removed, false otherwise
    }
    function RemoveReplyTo(dest: IAclAgentID): WordBool;

    {**
     Removes all values from <code>:reply_to</code>
     slot. <em><b>Warning:</b> no checks are made to validate the slot
     value.</em>
    }
    procedure ClearAllReplyTo();

	{
	 Reads <code>:reply_to</code> slot.
	 @return An <code>Iterator</code> containing the Agent IDs of the
	 reply_to agents for this message.
  }
	//public Iterator getAllReplyTo()
//  {
//		if (reply_to == null) {
//			return EmptyIterator.getInstance();
//		}
//		else
//    {
//			//#MIDP_EXCLUDE_BEGIN
//			return reply_to.iterator();
//			//#MIDP_EXCLUDE_END
//			/*#MIDP_INCLUDE_BEGIN
//			 return new EnumIterator(reply_to.elements());
//			 #MIDP_INCLUDE_END*/
//		}
//	}

    {**
    Returns the string corresponding to the integer for the performative
    @return the string corresponding to the integer for the performative;
    "NOT-UNDERSTOOD" if the integer is out of range.
    }
    class function GetPerformativeStr(perf: TAclPerformative): WideString;
    {**
     Returns the integer corresponding to the performative
     @returns the integer corresponding to the performative; -1 otherwise
    }
    class function PerfToInt(perf: WideString): Integer;

    {**
      This method allows to check if the content of this ACLMessage
      is a byteSequence or a String
      @return true if it is a byteSequence, false if it is a String
    }
    function HasByteSequenceContent(): WordBool;




    {**
      Add a new user defined parameter to this ACLMessage.
      Notice that according to the FIPA specifications, the keyword of a
      user-defined parameter must not contain space inside.
      Note that the user does not need to (and shall not) add the prefix "X-" to the keyword.
      This is automatically added by the StringACLCodec.
      @param key the property key.
      @param value the property value
    }
    procedure AddUserDefinedParameter(key, value: WideString);

    {**
      Searches for the user defined parameter with the specified key.
      The method returns
      <code>null</code> if the parameter is not found.

      @param   key   the parameter key.
      @return  the value in this ACLMessage with the specified key value.
    }
    function GetUserDefinedParameter(key: WideString): WideString;

	  //** get a clone of the data structure with all the user defined parameters
	//public Properties getAllUserDefinedParameters()
  {
		userDefProps = (userDefProps == null ? new Properties() : userDefProps);
		return userDefProps;
	}

    {**
      Removes the key and its corresponding value from the list of user
      defined parameters in this ACLMessage.
      @param key the key that needs to be removed
      @return true if the property has been found and removed, false otherwise
    }
    function RemoveUserDefinedParameter(key: WideString): WordBool;

//	#CUSTOM_EXCLUDE_BEGIN
	{
	 Attaches an envelope to this message. The envelope is used by the
	 <b><it>ACC</it></b> for inter-platform messaging.
	 @param e The <code>Envelope</code> object to attach to this
	 message.
	 @see jade.lang.acl#getEnvelope()
	 @see jade.lang.acl#setDefaultEnvelope()
  }
	//public void setEnvelope(Envelope e)
  {
		messageEnvelope = e;
	}


	{
	 Writes the message envelope for this message, using the
	 <code>:sender</code> and <code>:receiver</code> message slots to
	 fill in the envelope.
	 @see jade.lang.acl#setEnvelope(Envelope e)
	 @see jade.lang.acl#getEnvelope()
  }
	//public void setDefaultEnvelope()
  {
		messageEnvelope = new Envelope();
		messageEnvelope.setFrom(source);
		//#MIDP_EXCLUDE_BEGIN
		Iterator it = dests.iterator();
		//#MIDP_EXCLUDE_END
		/*#MIDP_INCLUDE_BEGIN
		 Iterator it = new EnumIterator(dests.elements());
		 #MIDP_INCLUDE_END*/
		while(it.hasNext())
			messageEnvelope.addTo((AID)it.next());
		//#MIDP_EXCLUDE_BEGIN
		messageEnvelope.setAclRepresentation(StringACLCodec.NAME);
		//#MIDP_EXCLUDE_END
		messageEnvelope.setDate(new Date());
	}

	{
	 Reads the envelope attached to this message, if any.
	 @return The envelope for this message.
	 @see jade.lang.acl#setEnvelope(Envelope e)
	 @see jade.lang.acl#setDefaultEnvelope()
  }
	//public Envelope getEnvelope()
  {
		return messageEnvelope;
	}
//	#CUSTOM_EXCLUDE_END


    {**
      #MIDP_EXCLUDE_BEGIN
      Convert an ACL message to its string representation. This method
      writes a representation of this <code>ACLMessage</code> into a
      character string.
      If the content is a bytesequence, then it is automatically converted
      into Base64 encoding.
      @return A <code>String</code> representing this message.
    }
    function ToString(): WideString;

    {**
     Clone an <code>ACLMessage</code> object.
     @return A copy of this <code>ACLMessage</code> object. The copy
     must be casted back to <code>ACLMessage</code> type before being
     used.
    }
	//#MIDP_EXCLUDE_BEGIN
	//public synchronized Object clone()
//  {
//
//		ACLMessage result;
//
//		try
//    {
//			result = (ACLMessage)super.clone();
//			result.persistentID = null;
//			if(source != null)
//      {
//				result.source = (AID)source.clone();
//			}
//
//			// Deep clone
//			if(dests != null)
//      {
//				result.dests = new ArrayList(dests.size());
//				Iterator it = dests.iterator();
//				while(it.hasNext()) {
//					AID id = (AID)it.next();
//					result.dests.add(id.clone());
//				}
//			}
//
//			// Deep clone
//			if(reply_to != null) {
//				result.reply_to = new ArrayList(reply_to.size());
//				Iterator it = reply_to.iterator();
//				while(it.hasNext()) {
//					AID id = (AID)it.next();
//					result.reply_to.add(id.clone());
//				}
//			}
//
//			if (userDefProps != null)
//				result.userDefProps = (Properties)userDefProps.clone();	//Deep copy
//			if(messageEnvelope != null)
//				result.messageEnvelope = (Envelope)messageEnvelope.clone();
//		}
//		catch(CloneNotSupportedException cnse) {
//			throw new InternalError(); // This should never happen
//		}
//
//		return result;
//	}
	// #MIDP_EXCLUDE_END
	 //public synchronized Object clone()
//   {
//	 ACLMessage result = new ACLMessage(NOT_UNDERSTOOD);
//	 result.performative = performative;
//	 result.source = source;
//	 result.content = content;
//	 result.byteSequenceContent = byteSequenceContent;
//	 result.reply_with = reply_with;
//	 result.in_reply_to = in_reply_to;
//	 result.encoding = encoding;
//	 result.language = language;
//	 result.ontology = ontology;
//	 result.reply_byInMillisec = reply_byInMillisec;
//	 result.protocol = protocol;
//	 result.conversation_id = conversation_id;
//	 result.userDefProps = userDefProps;
//	 //#CUSTOM_EXCLUDE_BEGIN
//	  if(messageEnvelope != null) {
//	  result.messageEnvelope = (Envelope)messageEnvelope.clone();
//	  }
//	  //#CUSTOM_EXCLUDE_END
//	   result.dests = new Vector(dests.size());
//	   for (int i=0; i<dests.size(); i++)
//	   result.dests.addElement(dests.elementAt(i));
//	   if (reply_to != null) {
//	   result.reply_to = new Vector(reply_to.size());
//	   for (int i=0; i<reply_to.size(); i++)
//	   result.reply_to.addElement(reply_to.elementAt(i));
//	   }
//	   return result;
//	   }

	{
	 * Resets all the message slots.
  }
	//public void reset()
//  {
//		source = null;
//		//#MIDP_EXCLUDE_BEGIN
//		dests.clear();
//		if (reply_to != null)
//			reply_to.clear();
//		//#MIDP_EXCLUDE_END
//		/*#MIDP_INCLUDE_BEGIN
//		 dests.removeAllElements();
//		 if (reply_to != null)
//		 reply_to.removeAllElements();
//		 #MIDP_INCLUDE_END*/
//		performative = NOT_UNDERSTOOD;
//		content = null;
//		byteSequenceContent = null;
//		reply_with = null;
//		in_reply_to = null;
//		encoding = null;
//		language = null;
//		ontology = null;
//		reply_byInMillisec = 0;
//		protocol = null;
//		conversation_id = null;
//		if (userDefProps != null) {
//			userDefProps.clear();
//		}
//	}

    {**
      create a new ACLMessage that is a reply to this message.
      In particular, it sets the following parameters of the new message:
      receiver, language, ontology, protocol, conversation-id,
      in-reply-to, reply-with.
      The programmer needs to set the communicative-act and the content.
      Of course, if he wishes to do that, he can reset any of the fields.
      @return the ACLMessage to send as a reply
    }
    function CreateReply(): TAclMessage;

    {**
     retrieve the whole list of intended receivers for this message.
     @return An Iterator over all the intended receivers of this
     message taking into account the Envelope ":intended-receiver"
     first, the Envelope ":to" second and the message ":receiver"
     last.
    }
	//public Iterator getAllIntendedReceiver()
//  {
//		Iterator it = null;
//		//#CUSTOM_EXCLUDE_BEGIN
//		Envelope env = getEnvelope();
//		if (env != null) {
//			it = env.getAllIntendedReceiver();
//			if (!it.hasNext()) {
//				// The ":intended-receiver" field is empty --> try with the ":to" field
//				it = env.getAllTo();
//			}
//		}
//		//#CUSTOM_EXCLUDE_END
//		if (it == null || !it.hasNext()) {
//			// Both the ":intended-receiver" and the ":to" fields are empty -->
//			// Use the ACLMessage receivers
//			it = getAllReceiver();
//		}
//		return it;
//	}


	//** For persistence service
	//private void setReceivers(ArrayList al)
  {
		dests = al;
	}

	// For persistence service
	//private ArrayList getReceivers()
  {
		return dests;
	}

	// For persistence service
	//private void setReplyTo(ArrayList al)
  {
		reply_to = al;
	}

	// For persistence service
	//private ArrayList getReplyTo()
  {
		return reply_to;
	}

	// For persistence service
	//private void setUserDefinedProperties(Serializable p)
  {
		userDefProps = (Properties)p;
	}

	// For persistence service
	//private Serializable getUserDefinedProperties()
  {
		return userDefProps;
	}
  public
    //** Сравнить с AMsg [Prof]
    function Compare(AMsg: TAclMessage): Integer;
  public
    {**
      At a given time or content or byteSequenceContent are != null,
      it is not allowed that both are != null
    }
    property ByteSequenceContent: string read GetByteSequenceContent write SetByteSequenceContent;
    //** Содержание сообщения (изначальный тип: StringBuffer)
    property Content: WideString read GetContent write SetContent;
    //** Идентификатор сообщений
    property ConversationID: WideString read GetConversationID write SetConversationID;
    //** Кодировка содержания сообщения
    property Encoding: WideString read GetEncoding write SetEncoding;
    //** Строка, идентифицирующая сообщение соответствует параметру reply-with при ответе на сообщение
    property InReplyTo: WideString read GetInReplyTo write SetInReplyTo;
    //** Язык кодирования сообщения
    property Language: WideString read GetLanguage write SetLanguage;
    //** Онтология, используемая для интерпретации сообщения
    property OntologyStr: WideString read GetOntologyStr write SetOntologyStr;
    //** Тип сообщения
    property Performative: Integer read GetPerformative write SetPerformative;
    //property Performatives: TAclStrings read GetPerformatives;
    property PersistentID: Int64 read GetPersistentID write SetPersistentID;
    //** Протокол взаимодействия агентов
    property Protocol: WideString read GetProtocol write SetProtocol;
    //** Получатель сообщения [Prof]
    property Receiver: IAclAgentID read FReceiver write FReceiver;
    //** Получатели сообщения [Prof]
    property ReceiverByIndex[Index: Integer]: IAclAgentID read GetReceiverA;
    //** Колличество получателей сообщения [Prof]
    property ReceiverCount: Integer read GetReceiverCount;
    //** Имя получателя [Prof]
    property ReceiverName: WideString read GetReceiverName write SetReceiverName;
    //** Время, к которому необходимо получить ответ
    property ReplyBy: WideString{Int64} read GetReplyBy; //write SetReplyBy;
    //** Адреса агентов, которым отправлять ответ
    //property ReplyTo: ArrayList read GetReplyTo write ReplyTo;
    //** Адреса агентов, которым отправлять ответ [Prof]
    property ReplyTo[Index: Integer]: IAclAgentID read GetReplyTo;
    //** Колличество адресов агентов, которым отправлять ответ [Prof]
    property ReplyToCount: Integer read GetReplyToCount;
    //** Строка, идентифицирующая сообщение
    property ReplyWith: WideString read GetReplyWith write SetReplyWith;
    //** Отправитель сообщения
    property Sender: IAclAgentID read GetSender write SetSender;
    //** Имя отправителя [Prof]
    property SenderName: WideString read GetSenderName write SetSenderName;
  end;

implementation

const
	{** These constants represent the expected size of the 2 array lists
	  used by this class }
	ACL_RECEIVERS_EXPECTED_SIZE = 1;
	ACL_REPLYTO_EXPECTED_SIZE = 1;

  // #MIDP_EXCLUDE_BEGIN
  {
   * This method sets the content of this ACLMessage to a Java object.
   * It is not FIPA compliant so its usage is not encouraged.
   * For example:<br>
   * <PRE>
   * ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
   * Date d = new Date();
   * try
   *  msg.setContentObject(d);
   * catch(IOException e)
   * </PRE>
   *
   * @param s the object that will be used to set the content of the ACLMessage.
   * @exception IOException if an I/O error occurs.
  }
  //public void setContentObject(java.io.Serializable s) throws IOException
  {
    ByteArrayOutputStream c = new ByteArrayOutputStream();
    ObjectOutputStream oos = new ObjectOutputStream(c);
    oos.writeObject(s);
    oos.flush();
    setByteSequenceContent(c.toByteArray());
  }


	{
	 * This method returns the content of this ACLMessage when they have
	 * been written via the method <code>setContentObject</code>.
	 * It is not FIPA compliant so its usage is not encouraged.
	 * For example to read Java objects from the content
	 * <PRE>
	 * ACLMessage msg = blockingReceive();
	 * try
	 *  Date d = (Date)msg.getContentObject();
	 * catch(UnreadableException e)
	 * </PRE>
	 *
	 * @return the object read from the content of this ACLMessage
	 * @exception UnreadableException when an error occurs during the decoding.
  }
	//public java.io.Serializable getContentObject() throws UnreadableException
//	{
//		try
//    {
//			byte[] data = getByteSequenceContent();
//			if (data == null)
//				return null;
//			ObjectInputStream oin = new ObjectInputStream(new ByteArrayInputStream(data));
//			java.io.Serializable s = (java.io.Serializable)oin.readObject();
//			return s;
//		}
//		catch (java.lang.Error e)
//    {
//			throw new UnreadableException(e.getMessage());
//		}
//		catch (IOException e1)
//    {
//			throw new UnreadableException(e1.getMessage());
//		}
//		catch(ClassNotFoundException e2)
//    {
//			throw new UnreadableException(e2.getMessage());
//		}
//
//	}
	//#MIDP_EXCLUDE_END

{ TAclMessage }

procedure TAclMessage.AddReceiver(r: IAclAgentID);
begin
  if (r <> nil) then
  begin
    //dests.add(r); (or) dests.addElement(r);
  end;
end;

procedure TAclMessage.AddReplyTo(dest: IAclAgentID);
begin
	//public void addReplyTo(AID dest)
//  {
//		if (dest != null) {
//			reply_to = (reply_to == null ? new ArrayList(REPLYTO_EXPECTED_SIZE) : reply_to);
//			reply_to.add(dest);
//		}
//	}
end;

procedure TAclMessage.AddUserDefinedParameter(key, value: WideString);
begin
	//public void addUserDefinedParameter(String key, String value)
  {
		userDefProps = (userDefProps == null ? new Properties() : userDefProps);
		userDefProps.setProperty(key,value);
	}
end;

procedure TAclMessage.ClearAllReceiver();
begin
	//public void clearAllReceiver()
  {
		dests.clear();
	}
end;

procedure TAclMessage.ClearAllReplyTo();
begin
	//public void clearAllReplyTo()
//  {
//		if (reply_to != null)
//    {
//			//#MIDP_EXCLUDE_BEGIN
//			reply_to.clear();
//			//#MIDP_EXCLUDE_END
//			/*#MIDP_INCLUDE_BEGIN
//			 reply_to.removeAllElements();
//			 #MIDP_INCLUDE_END*/
//		}
//	}
end;

function TAclMessage.Compare(AMsg: TAclMessage): Integer;
begin
  Result := -1;
  // ...
end;

constructor TAclMessage.Create();
begin
  inherited Create();
  performative := ACL_NOT_UNDERSTOOD;

	//public ACLMessage()
  { // Used by persistence service: do not remove it, but make it private
		performative = NOT_UNDERSTOOD;
	}
	{
	 * This constructor creates an ACL message object with the specified
	 * performative. If the passed integer does not correspond to any of
	 * the known performatives, it silently initializes the message to
	 * <code>not-understood</code>.
  }
	//public ACLMessage(int perf)
  {
		performative = perf;
	}
end;

function TAclMessage.CreateReply(): TAclMessage;
begin
  Result := nil;
	//public ACLMessage createReply()
//  {
//		ACLMessage m = (ACLMessage)clone();
//		m.clearAllReceiver();
//		Iterator it = getAllReplyTo();
//		while (it.hasNext())
//			m.addReceiver((AID)it.next());
//		if ((reply_to == null) || reply_to.isEmpty())
//			m.addReceiver(getSender());
//		m.clearAllReplyTo();
//		m.setLanguage(getLanguage());
//		m.setOntology(getOntology());
//		m.setProtocol(getProtocol());
//		m.setSender(null);
//		m.setInReplyTo(getReplyWith());
//		if (source != null)
//			m.setReplyWith(source.getName() + java.lang.System.currentTimeMillis());
//		else
//			m.setReplyWith("X"+java.lang.System.currentTimeMillis());
//		m.setConversationId(getConversationId());
//		m.setReplyByDate(null);
//		m.setContent(null);
//		m.setEncoding(null);
//		//#CUSTOM_EXCLUDE_BEGIN
//		//Set the Aclrepresentation of the reply message to the aclrepresentation of the sent message
//		if (messageEnvelope != null)
//		{
//			m.setDefaultEnvelope(); // reset the envelope after having been cloned
//			String aclCodec= messageEnvelope.getAclRepresentation();
//			if (aclCodec != null)
//				m.getEnvelope().setAclRepresentation(aclCodec);
//		}
//		else
//			m.setEnvelope(null);
//		//#CUSTOM_EXCLUDE_END
//		return m;
//	}
end;

function TAclMessage.GetByteSequenceContent(): string;
begin
	//public byte[] getByteSequenceContent()
  {
		if (content != null)
			return content.toString().getBytes();
		else if (byteSequenceContent != null)
			return byteSequenceContent;
		return null;
	}
end;

function TAclMessage.GetContent(): WideString;
begin
  Result := FContent;
	//public String getContent()
  {
		if(content != null)
			return new String(content);
		else if (byteSequenceContent != null)
			return new String(byteSequenceContent);
		return null;
	}
end;

function TAclMessage.GetConversationID(): WideString;
begin
  Result := FConversationID;
end;

function TAclMessage.GetEncoding(): WideString;
begin
  Result := FEncoding;
end;

function TAclMessage.GetInReplyTo(): WideString;
begin
  Result := FInReplyTo;
end;

function TAclMessage.GetLanguage(): WideString;
begin
  Result := FLanguage;
end;

function TAclMessage.GetOntologyStr(): WideString;
begin
  Result := FOntology;
end;

function TAclMessage.GetPerformative(): Integer;
begin
  Result := FPerformative;
end;

class function TAclMessage.GetPerformativeStr(perf: TAclPerformative): WideString;
begin
  case perf of
    ACL_ACCEPT_PROPOSAL: Result := STR_ACCEPT_PROPOSAL;
    ACL_AGREE: Result := STR_AGREE;
    ACL_CANCEL: Result := STR_CANCEL;
    ACL_CFP: Result := STR_CFP;
    ACL_CONFIRM: Result := STR_CONFIRM;
    ACL_DISCONFIRM: Result := STR_DISCONFIRM;
    ACL_FAILURE: Result := STR_FAILURE;
    ACL_INFORM: Result := STR_INFORM;
    ACL_INFORM_IF: Result := STR_INFORM_IF;
    ACL_INFORM_REF: Result := STR_INFORM_REF;
    ACL_NOT_UNDERSTOOD: Result := STR_NOT_UNDERSTOOD;
    ACL_PROPOSE: Result := STR_PROPOSE;
    ACL_QUERY_IF: Result := STR_QUERY_IF;
    ACL_QUERY_REF: Result := STR_QUERY_REF;
    ACL_REFUSE: Result := STR_REFUSE;
    ACL_REJECT_PROPOSAL: Result := STR_REJECT_PROPOSAL;
    ACL_REQUEST: Result := STR_REQUEST;
    ACL_REQUEST_WHEN: Result := STR_REQUEST_WHEN;
    ACL_REQUEST_WHENEVER: Result := STR_REQUEST_WHENEVER;
    ACL_SUBSCRIBE: Result := STR_SUBSCRIBE;
    ACL_PROXY: Result := STR_PROXY;
    ACL_PROPAGATE: Result := STR_PROPAGATE;
  end;
end;

function TAclMessage.GetPersistentID(): Int64;
begin
  Result := FPersistentID;
end;

function TAclMessage.GetProtocol(): WideString;
begin
  Result := FProtocol;
end;

function TAclMessage.GetReceiver(): IAclAgentID;
begin
  Result := Self.FReceiver;
end;

function TAclMessage.GetReceiverA(Index: Integer): IAclAgentID;
begin
  Result := FDests[Index];
end;

function TAclMessage.GetReceiverCount(): Integer;
begin
  Result := Length(FDests);
end;

function TAclMessage.GetReceiverName(): WideString;
begin
  Result := FReceiverName;
end;

function TAclMessage.GetReplyBy(): WideString;
begin
  Result := FormatDateTime('yyyymmddhhnnsszzzz', FReplyBy);
	//public String getReplyBy()
  {
		if(reply_byInMillisec != 0)
			return ISO8601.toString(new Date(reply_byInMillisec));
		else
			return null;
	}
	// #MIDP_EXCLUDE_END
end;

function TAclMessage.GetReplyByDate(): TDateTime;
begin
  Result := FReplyBy;
	//public Date getReplyByDate()
  {
		if(reply_byInMillisec != 0)
			return new Date(reply_byInMillisec);
		else
			return null;
	}
end;

function TAclMessage.GetReplyTo(Index: Integer): IAclAgentID;
begin
  Result := FReplyTo[Index];
end;

function TAclMessage.GetReplyToCount(): Integer;
begin
  Result := Length(FReplyTo);
end;

function TAclMessage.GetReplyWith(): WideString;
begin
  Result := FReplyWith;
end;

function TAclMessage.GetSender(): IAclAgentID;
begin
  Result := FSender;
end;

function TAclMessage.GetSenderName(): WideString;
begin
  Result := FSenderName;
end;

function TAclMessage.GetUserDefinedParameter(key: WideString): WideString;
begin
  Result := '';
	//public String getUserDefinedParameter(String key)
  {
		if (userDefProps == null)
			return null;
		else
			return userDefProps.getProperty(key);
	}
end;

function TAclMessage.HasByteSequenceContent(): WordBool;
begin
  Result := (FByteSequenceContent <> '');
end;

class function TAclMessage.PerfToInt(perf: WideString): Integer;
begin
  Result := 0;
	//public static int getInteger(String perf)
	{
		String tmp = perf.toUpperCase();
		for (int i=0; i<performatives.length; i++)
			if (performatives[i].equals(tmp))
				return i;
		return -1;
	}
end;

function TAclMessage.RemoveReceiver(s: IAclAgentID): WordBool;
begin
  Result := False;
//public boolean removeReceiver(AID r)
//  {
//		if (r != null)
//    {
//			//#MIDP_EXCLUDE_BEGIN
//			return dests.remove(r);
//			//#MIDP_EXCLUDE_END
//			/*#MIDP_INCLUDE_BEGIN
//			 return dests.removeElement(r);
//			 #MIDP_INCLUDE_END*/
//		}
//		else
//    {
//			return false;
//		}
//	}
end;

function TAclMessage.RemoveReplyTo(dest: IAclAgentID): WordBool;
begin
  Result := False;
	//public boolean removeReplyTo(AID dest)
//  {
//		if ((dest != null) && (reply_to != null) ) {
//			//#MIDP_EXCLUDE_BEGIN
//			return reply_to.remove(dest);
//			//#MIDP_EXCLUDE_END
//			/*#MIDP_INCLUDE_BEGIN
//			 return reply_to.removeElement(dest);
//			 #MIDP_INCLUDE_END*/
//		}
//		else
//    {
//			return false;
//		}
//	}
end;

function TAclMessage.RemoveUserDefinedParameter(key: WideString): WordBool;
begin
  Result := False;
	//public boolean removeUserDefinedParameter(String key)
  {
		if (userDefProps == null)
			return false;
		else
			return (userDefProps.remove(key) != null);
	}
end;

procedure TAclMessage.SetByteSequenceContent(content: string);
begin
	//public void setByteSequenceContent(byte[] content)
  {
		this.content = null; //make to null the other variable
		byteSequenceContent = content;
	}
end;

procedure TAclMessage.SetContent(const Content: WideString);
begin
  FContent := Content;
	//public void setContent(String content)
//  {
//		byteSequenceContent = null; //make to null the other variable
//		if (content != null)
//    {
//			this.content = new StringBuffer(content);
//		}
//		else
//    {
//			this.content = null;
//		}
//	}
end;

procedure TAclMessage.SetConversationID(const Str: WideString);
begin
  FConversationID := Str;
end;

procedure TAclMessage.SetEncoding(const Str: WideString);
begin
  FEncoding := Str;
end;

procedure TAclMessage.SetInReplyTo(const Reply: WideString);
begin
  FInReplyTo := Reply;
end;

procedure TAclMessage.SetLanguage(const Str: WideString);
begin
  FLanguage := Str;
end;

procedure TAclMessage.SetOntologyStr(const Str: WideString);
begin
  FOntology := Str;
end;

procedure TAclMessage.SetPerformative(Value: Integer);
begin
  FPerformative := Value;
end;

procedure TAclMessage.SetPersistentID(Value: Int64);
begin
  FPersistentID := Value;
end;

procedure TAclMessage.SetProtocol(const Str: WideString);
begin
  FProtocol := Str;
end;

procedure TAclMessage.SetReceiverName(const Value: WideString);
begin
  FReceiverName := Value;
end;

procedure TAclMessage.SetReplyByDate(date: TDateTime);
begin
  Self.FReplyBy := date;
end;

procedure TAclMessage.SetReplyWith(const Reply: WideString);
begin
  FReplyWith := Reply;
end;

procedure TAclMessage.SetSender(Value: IAclAgentID);
begin
  FSender := Value;
end;

procedure TAclMessage.SetSenderName(const Value: WideString);
begin
  FSenderName := Value;
end;

function TAclMessage.ToString(): WideString;
begin
	//public String toString()
  {
		return StringACLCodec.toString(this);
	}
end;

end.
