using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ��ɫ��
    /// </summary>
     [KeyInfo("Role_id")]
     public class Role:ModelBase
       {
        /// <summary>
        /// ��ɫID
        /// </summary>
         public System.Int32  ?Role_id
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
        /// <summary>
        /// �Ƿ����
        /// </summary>
         public System.Int32  ?Role_flag
             {get;set;}
       }
}
