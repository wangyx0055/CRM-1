using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// �û���
    /// </summary>
     [KeyInfo("UserID")]
     public class Users:ModelBase
       {
         /// <summary>
         /// �û�ID
         /// </summary>
         public System.Int32  ?UserID
             {get;set;}
         /// <summary>
         /// ��ɫID
         /// </summary>
         public System.Int32  ?RoleID
             {get;set;}
         /// <summary>
         /// ��½��
         /// </summary>
         public System.String  UserLName
             {get;set;}
         /// <summary>
         /// ��½����
         /// </summary>
         public System.String  UserLPWD
             {get;set;}
         /// <summary>
         /// ��ʵ����
         /// </summary>
         public System.String  UserName
             {get;set;}
         /// <summary>
         /// �Ƿ����
         /// </summary>
         public System.Int32? UserFlag { get; set; }
       }
}
