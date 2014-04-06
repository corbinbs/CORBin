
/**
* _AccountImplBase.java
* Generated by the IDL-to-Java compiler (portable), version "3.0"
* from account.idl
* Tuesday, February 27, 2001 5:40:15 PM EST
*/

public abstract class _AccountImplBase extends org.omg.CORBA.portable.ObjectImpl
                implements Account, org.omg.CORBA.portable.InvokeHandler
{

  // Constructors
  public _AccountImplBase ()
  {
  }

  private static java.util.Hashtable _methods = new java.util.Hashtable ();
  static
  {
    _methods.put ("deposit", new java.lang.Integer (0));
    _methods.put ("withdraw", new java.lang.Integer (1));
    _methods.put ("_get_balance", new java.lang.Integer (2));
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
       case 0:  // Account/deposit
       {
         int amount = in.read_ulong ();
         this.deposit (amount);
         out = rh.createReply();
         break;
       }

       case 1:  // Account/withdraw
       {
         int amount = in.read_ulong ();
         this.withdraw (amount);
         out = rh.createReply();
         break;
       }

       case 2:  // Account/_get_balance
       {
         int __result = (int)0;
         __result = this.balance ();
         out = rh.createReply();
         out.write_long (__result);
         break;
       }

       default:
         throw new org.omg.CORBA.BAD_OPERATION (0, org.omg.CORBA.CompletionStatus.COMPLETED_MAYBE);
    }

    return out;
  } // _invoke

  // Type-specific CORBA::Object operations
  private static String[] __ids = {
    "IDL:Account:1.0"};

  public String[] _ids ()
  {
    return __ids;
  }


} // class _AccountImplBase
