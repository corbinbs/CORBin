package Syrup;

/**
* Syrup/SyrupManagerHolder.java
* Generated by the IDL-to-Java compiler (portable), version "3.0"
* from Syrup.idl
* Thursday, March 8, 2001 2:19:45 AM EST
*/

public final class SyrupManagerHolder implements org.omg.CORBA.portable.Streamable
{
  public Syrup.SyrupManager value = null;

  public SyrupManagerHolder ()
  {
  }

  public SyrupManagerHolder (Syrup.SyrupManager initialValue)
  {
    value = initialValue;
  }

  public void _read (org.omg.CORBA.portable.InputStream i)
  {
    value = Syrup.SyrupManagerHelper.read (i);
  }

  public void _write (org.omg.CORBA.portable.OutputStream o)
  {
    Syrup.SyrupManagerHelper.write (o, value);
  }

  public org.omg.CORBA.TypeCode _type ()
  {
    return Syrup.SyrupManagerHelper.type ();
  }

}
