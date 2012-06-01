{**
@Abstract(Базовые интерфейсы для работы с языком ACL)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.03.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AclAgentIdIntf;

// TODO: -oProf Переименовать IAclAgentIdIntf в IAclObjectIdIntf

interface

type // AID
  IAclAgentID = interface
    {**
      Returns the HAP of the agent or null if the GUID of this
      <code>AID</code> is not of the form <local-name>@<platform-name>
    }
    function GetHap(): WideString;
    {**
      Hash code. This method returns an hash code in such a way that two
      <code>AID</code> objects with equal names or with names differing
      only in case have the same hash code.
      @return The hash code for this <code>AID</code> object.
    }
    function GetHashCode(): Integer;
    {**
      Returns the local name of the agent (without the HAP).
      If the agent is not local, then the method returns its GUID.
    }
    function GetLocalName(): WideString;
    //** This method returns the name of the agent.
	  function GetName(): WideString;
    //** For persistence service
    function GetPersistentID(): Int64;
	  function GetPlatformID(): WideString;

    //** For persistence service
    procedure SetPersistentID(Value: Int64);
	  procedure SetPlatformID(id: WideString);
    {**
      This method permits to set the symbolic name of an agent.
      The passed parameter must be a local name.
    }
	  procedure SetLocalName(n: WideString);
    {**
      This method permits to set the symbolic name of an agent.
      The passed parameter must be a GUID and not a local name.
    }
	  procedure SetName(n: WideString);
  end;

implementation

end.
