using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 基本权限表
    /// </summary>
     [KeyInfo("Id")]
     public class GRole:ModelBase
       {
        /// <summary>
        /// 基本权限ID
        /// </summary>
         public System.Int32  ?Id
             {get;set;}
        /// <summary>
        /// 基本权限路径
        /// </summary>
         public System.String  Url
             {get;set;}
       }
}
