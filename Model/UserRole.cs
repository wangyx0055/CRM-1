using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 

    /// <summary>
    /// 用户角色
    /// </summary>
     [KeyInfo("Role_id")]
     public class UserRole:ModelBase
       {
        /// <summary>
        /// 用户ID
        /// </summary>
         public System.Int32  ?UserID
             {get;set;}
        /// <summary>
        /// 角色ID
        /// </summary>
         public System.Int32  ?RoleID
             {get;set;}
        /// <summary>
        /// 登录名字
        /// </summary>
         public System.String  UserLName
             {get;set;}
        /// <summary>
        /// 登录密码
        /// </summary>
         public System.String  UserLPWD
             {get;set;}
         public System.String  UserName
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
         public System.Int32  ?Role_flag
             {get;set;}
        /// <summary>
        /// 角色ID
        /// </summary>
         public System.Int32  ?Role_id
             {get;set;}
        /// <summary>
        /// 角色是否可用
        /// </summary>
         public System.Int32? UserFlag
         { get; set; }
       }
}
