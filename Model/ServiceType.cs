using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ��������
    /// </summary>
     [KeyInfo("STID")]
     public class ServiceType:ModelBase
       {
         /// <summary>
         /// ��������ID
         /// </summary>
         public System.Int32  ?STID
             {get;set;}
         /// <summary>
         /// ������������
         /// </summary>
         public System.String  STName
             {get;set;}
       }
}
