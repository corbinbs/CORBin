package Syrup;


/**
* Syrup/_SyrupManagerImplBase.java
* Generated by the IDL-to-Java compiler (portable), version "3.0"
* from Syrup.idl
* Thursday, March 8, 2001 2:19:45 AM EST
*/

public abstract class _SyrupManagerImplBase extends org.omg.CORBA.portable.ObjectImpl
                implements Syrup.SyrupManager, org.omg.CORBA.portable.InvokeHandler
{

  // Constructors
  public _SyrupManagerImplBase ()
  {
  }

  private static java.util.Hashtable _methods = new java.util.Hashtable ();
  static
  {
    _methods.put ("Login", new java.lang.Integer (0));
    _methods.put ("Logout", new java.lang.Integer (1));
    _methods.put ("PostMessage", new java.lang.Integer (2));
    _methods.put ("SendMessage", new java.lang.Integer (3));
  }

  public org.omg.CORBA.portable.OutputStream _invoke (String method,
                                org.omg.CORBA.portable.InputStream in,
                                org.omg.CORBA.portable.ResponseHandler rh)
  {
    org.omg.CORBA.portable.OutputStream out = null;
    java.lang.Integer __method = (java.lang.Integer)_methods.get (method);
    if (__method == null)
      throw new org.omg.CORBA.BAD_OPERATION (0, org.omg.CORBA.CompletionStatus.COMPLETED_MAYBE);

    switch (__method.intValue ())
    {
       case 0:  // Syrup/SyrupManager/Login
       {
         String userid = in.read_string ();
         Syrup.SyrupClient client = Syrup.SyrupClientHelper.read (in);
         this.Login (userid, client);
         out = rh.createReply();
         break;
       }

       case 1:  // Syrup/SyrupManager/Logout
       {
         String userid = in.read_string ();
         this.Logout (userid);
         out = rh.createReply();
         break;
       }

       case 2:  // Syrup/SyrupManager/PostMessage
       {
         String userid = in.read_string ();
         String msg = in.read_string ();
         this.PostMessage (userid, msg);
         out = rh.createReply();
         break;
       }

       case 3:  // Syrup/SyrupManager/SendMessage
       {
         String from = in.read_string ();
         String to = in.read_string ();
         String msg = in.read_string ();
         this.SendMessage (from, to, msg);
         out = rh.createReply();
         break;
       }

       default:
         throw new org.omg.CORBA.BAD_OPERATION (0, org.omg.CORBA.CompletionStatus.COMPLETED_MAYBE);
    }

    return out;
  } // _invoke

  // Type-specific CORBA::Object operations
  private static String[] __ids = {
    "IDL:Syrup/SyrupManager:1.0"};

  public String[] _ids ()
  {
    return __ids;
  }


} // class _SyrupManagerImplBase
