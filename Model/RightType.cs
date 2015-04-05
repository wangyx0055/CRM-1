using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 

     [KeyInfo("Typeid")]
     public class RightType:ModelBase
       {
         public System.Int32  ?Typeid
             {get;set;}
         public System.String  Right_type
             {get;set;}
       }
}
