using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 

     [KeyInfo("Listid")]
     public class ListTools:ModelBase
       {
         public System.Int32  ?Listid
             {get;set;}
         public System.String  Listname
             {get;set;}
         public System.String  Listurl
             {get;set;}
         public System.Int32  ?Listtype
             {get;set;}
       }
}
