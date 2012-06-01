{**
@Abstract(AIterable)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: java.lang.Iterable.java 1.3 03/12/19
}
unit AiIterable;

interface

uses
  ABase;

//import java.util.Iterator;

type
  {**
  Implementing this interface allows an object to be the target of
  the "foreach" statement.
  }
  IJavaIterable = interface
    {**
    Returns an iterator over a set of elements of type T.
    @return an Iterator.
    }
    //Iterator<T> iterator();

    // [Prof]
    function ToString(): APascalString;
  end;

implementation

end.
