using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ��ʧ�û���Ϣ��ͼ
    /// </summary>
     [KeyInfo("UserID")]
     public class View_CusLosInfo:ModelBase
       {
        /// <summary>
        /// ��ʧID
        /// </summary>
         public System.Int32  ?CLID
             {get;set;}
        /// <summary>
        /// �û�����
        /// </summary>
         public System.String  UserName
             {get;set;}
        /// <summary>
        /// �ͻ�����
        /// </summary>
         public System.String  CusName
             {get;set;}
        /// <summary>
        /// ��ʧԭ��
        /// </summary>
         public System.String  CLReason
             {get;set;}
        /// <summary>
        /// ��ʧʱ��
        /// </summary>
         public System.DateTime  ?CLEnterDate
             {get;set;}
        /// <summary>
        /// �ͻ�ID
        /// </summary>
         public System.String  CusID
             {get;set;}
        /// <summary>
        /// �ͻ�����ID
        /// </summary>
         public System.Int32  ?UserID
             {get;set;}
       }
}
