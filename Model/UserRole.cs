using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 

    /// <summary>
    /// �û���ɫ
    /// </summary>
     [KeyInfo("Role_id")]
     public class UserRole:ModelBase
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
        /// ��¼����
        /// </summary>
         public System.String  UserLName
             {get;set;}
        /// <summary>
        /// ��¼����
        /// </summary>
         public System.String  UserLPWD
             {get;set;}
         public System.String  UserName
             {get;set;}
        /// <summary>
        /// ��ɫ����
        /// </summary>
         public System.String  Role_name
             {get;set;}
        /// <summary>
        /// ��ɫ����
        /// </summary>
         public System.String  Role_desc
             {get;set;}
         public System.Int32  ?Role_flag
             {get;set;}
        /// <summary>
        /// ��ɫID
        /// </summary>
         public System.Int32  ?Role_id
             {get;set;}
        /// <summary>
        /// ��ɫ�Ƿ����
        /// </summary>
         public System.Int32? UserFlag
         { get; set; }
       }
}
