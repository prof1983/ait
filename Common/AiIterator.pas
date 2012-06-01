{**
@Abstract(AiIterator)
@Author(Prof1983 prof1983@ya.ru)
@Created(10.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: java.util.Iterator.java 1.24 04/01/17
}
unit JavaIterator;

interface

type
  {**
  An iterator over a collection.
  Iterator takes the place of Enumeration in the Java collections framework.
  Iterators differ from enumerations in two ways: <ul>
  <li> Iterators allow the caller to remove elements from the underlying
  collection during the iteration with well-defined semantics.
  <li> Method names have been improved.
  </ul><p>

  This interface is a member of the
  <a href="{@docRoot/../guide/collections/index.html">
  Java Collections Framework</a>.

  @author  Josh Bloch
  @version 1.24, 01/17/04
  @see Collection
  @see ListIterator
  @see Enumeration
  @since 1.2
  }
  IJavaIterator = interface //<E>
    {**
     * Returns <tt>true</tt> if the iteration has more elements. (In other
     * words, returns <tt>true</tt> if <tt>next</tt> would return an element
     * rather than throwing an exception.)
     *
     * @return <tt>true</tt> if the iterator has more elements.
    }
    function HasNext(): WordBool;
    //boolean hasNext();

    {**
     * Returns the next element in the iteration.  Calling this method
     * repeatedly until the {@link #hasNext() method returns false will
     * return each element in the underlying collection exactly once.
     *
     * @return the next element in the iteration.
     * @exception NoSuchElementException iteration has no more elements.
    }
    function Next(): IUnknown; //TObject;
    //E next();

    {**
     * Removes from the underlying collection the last element returned by the
     * iterator (optional operation).  This method can be called only once per
     * call to <tt>next</tt>.  The behavior of an iterator is unspecified if
     * the underlying collection is modified while the iteration is in
     * progress in any way other than by calling this method.
     *
     * @exception UnsupportedOperationException if the <tt>remove</tt>
     *		  operation is not supported by this Iterator.

     * @exception IllegalStateException if the <tt>next</tt> method has not
     *		  yet been called, or the <tt>remove</tt> method has already
     *		  been called after the last call to the <tt>next</tt>
     *		  method.
    }
    procedure Remove();
    //void remove();
  end;

implementation

end.
