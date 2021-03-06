{**
@Abstract(AiEnumeration)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: java.util.Enumeration (1.22 03/12/19)
}
unit AiEnumeration;

interface

type
  {**
  An object that implements the Enumeration interface generates a
  series of elements, one at a time. Successive calls to the
  <code>nextElement</code> method return successive elements of the
  series.
  <p>
  For example, to print all elements of a vector <i>v</i>:
  <blockquote><pre>
      for (Enumeration e = v.elements() ; e.hasMoreElements() ;)
       (
          System.out.println(e.nextElement());<br>
      )
  </pre></blockquote>
  <p>
  Methods are provided to enumerate through the elements of a
  vector, the keys of a hashtable, and the values in a hashtable.
  Enumerations are also used to specify the input streams to a
  <code>SequenceInputStream</code>.
  <p>
  NOTE: The functionality of this interface is duplicated by the Iterator
  interface.  In addition, Iterator adds an optional remove operation, and
  has shorter method names.  New implementations should consider using
  Iterator in preference to Enumeration.

  @see     java.util.Iterator
  @see     java.io.SequenceInputStream
  @see     java.util.Enumeration#nextElement()
  @see     java.util.Hashtable
  @see     java.util.Hashtable#elements()
  @see     java.util.Hashtable#keys()
  @see     java.util.Vector
  @see     java.util.Vector#elements()

  @author  Lee Boynton
  @version 1.22, 12/19/03
  @since   JDK1.0
  }
  IJavaEnumeration = interface //<E>
    {**
      Tests if this enumeration contains more elements.
      @return  <code>true</code> if and only if this enumeration object
               contains at least one more element to provide;
               <code>false</code> otherwise.
    }
    //boolean hasMoreElements();

    {**
      Returns the next element of this enumeration if this enumeration
      object has at least one more element to provide.
      @return     the next element of this enumeration.
      @exception  NoSuchElementException  if no more elements exist.
    }
    //E nextElement();
  end;

implementation

end.
