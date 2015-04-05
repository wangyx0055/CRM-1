using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 

     [KeyInfo("Id")]
     public class ListType:ModelBase
       {
         public System.Int32  ?Id
             {get;set;}
         public System.String  Typename
             {get;set;}
       }
}
