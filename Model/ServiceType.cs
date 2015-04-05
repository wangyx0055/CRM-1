using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 服务类型
    /// </summary>
     [KeyInfo("STID")]
     public class ServiceType:ModelBase
       {
         /// <summary>
         /// 服务类型ID
         /// </summary>
         public System.Int32  ?STID
             {get;set;}
         /// <summary>
         /// 服务类型名称
         /// </summary>
         public System.String  STName
             {get;set;}
       }
}
