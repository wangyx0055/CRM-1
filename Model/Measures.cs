using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 流失措施表
    /// </summary>
     [KeyInfo("MeID")]
     public class Measures:ModelBase
       {
         /// <summary>
         /// 编号
         /// </summary>
         public System.Int32  ?MeID
             {get;set;}
         /// <summary>
         /// 客户流失ID
         /// </summary>
         public System.Int32  ?CLID
             {get;set;}
         /// <summary>
         /// 创建时间
         /// </summary>
         public System.DateTime  ?MeDate
             {get;set;}
         /// <summary>
         /// 措施细节
         /// </summary>
         public System.String  MeDesc
             {get;set;}
       }
}
