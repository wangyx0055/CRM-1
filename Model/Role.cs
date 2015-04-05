using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 角色表
    /// </summary>
     [KeyInfo("Role_id")]
     public class Role:ModelBase
       {
        /// <summary>
        /// 角色ID
        /// </summary>
         public System.Int32  ?Role_id
             {get;set;}
        /// <summary>
        /// 角色名字
        /// </summary>
         public System.String  Role_name
             {get;set;}
        /// <summary>
        /// 角色描述
        /// </summary>
         public System.String  Role_desc
             {get;set;}
        /// <summary>
        /// 是否可用
        /// </summary>
         public System.Int32  ?Role_flag
             {get;set;}
       }
}
