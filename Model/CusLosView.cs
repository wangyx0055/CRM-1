using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// �ͻ���ʧ��ͼ
    /// </summary>
     [KeyInfo("CusID")]
     public class CusLosView:ModelBase
       {
        /// <summary>
        /// ��ʧID
        /// </summary>
         public System.Int32  ?CLID
             {get;set;}
        /// <summary>
        /// �ͻ�ID
        /// </summary>
         public System.String  CusID
             {get;set;}
        /// <summary>
        /// �ͻ���󶩵�ʱ��
        /// </summary>
         public System.DateTime  ?CLOrderDate
             {get;set;}
        /// <summary>
        /// ����ʱ��
        /// </summary>
         public System.DateTime  ?CLDate
             {get;set;}
        /// <summary>
        /// �����ʩ
        /// </summary>
         public System.String  CLMeasures
             {get;set;}
        /// <summary>
        /// �ͻ���ʧʱ��
        /// </summary>
         public System.DateTime  ?CLEnterDate
             {get;set;}
        /// <summary>
        /// ��ʧԭ��
        /// </summary>
         public System.String  CLReason
             {get;set;}
        /// <summary>
        /// ��ʧ״̬
        /// </summary>
         public System.Int32  ?CLState
             {get;set;}
        /// <summary>
        /// �ͻ�����
        /// </summary>
         public System.String  CusName
             {get;set;}
       }
}
