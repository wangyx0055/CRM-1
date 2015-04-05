using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 服务个数
    /// </summary>
     [KeyInfo("")]
     public class View_sv_typecount:ModelBase
       {
        /// <summary>
        /// 服务名称
        /// </summary>
         public System.String  STName
             {get;set;}
        /// <summary>
        /// 个数
        /// </summary>
         public System.Int32  ?Count
             {get;set;}
       }
}
