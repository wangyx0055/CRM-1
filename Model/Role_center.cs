using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 权限中间表
    /// </summary>
     public class Role_center:ModelBase
       {
        /// <summary>
        /// 角色ID
        /// </summary>
         public System.Int64  ?Rf_role_id
             {get;set;}
        /// <summary>
        /// 权利编号
        /// </summary>
         public System.String  Rf_right_code
             {get;set;}
       }
}
