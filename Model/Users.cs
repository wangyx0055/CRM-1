using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 用户表
    /// </summary>
     [KeyInfo("UserID")]
     public class Users:ModelBase
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
         /// 登陆名
         /// </summary>
         public System.String  UserLName
             {get;set;}
         /// <summary>
         /// 登陆密码
         /// </summary>
         public System.String  UserLPWD
             {get;set;}
         /// <summary>
         /// 真实姓名
         /// </summary>
         public System.String  UserName
             {get;set;}
         /// <summary>
         /// 是否可用
         /// </summary>
         public System.Int32? UserFlag { get; set; }
       }
}
