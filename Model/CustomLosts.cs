using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// �ͻ���ʧ��
    /// </summary>
     [KeyInfo("CLID")]
     public class CustomLosts:ModelBase
       {
         /// <summary>
         /// �ͻ���ʧID
         /// </summary>
         public System.Int32  ?CLID
             {get;set;}
         /// <summary>
         /// �ͻ����
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// ����µ�ʱ��
         /// </summary>
         public System.DateTime  ?CLOrderDate
             {get;set;}
         /// <summary>
         /// ��ʧ����ʱ��
         /// </summary>
         public System.DateTime  ?CLDate
             {get;set;}
         /// <summary>
         /// ��ʧ��ʩ
         /// </summary>
         public System.String  CLMeasures
             {get;set;}
         /// <summary>
         /// ȷ����ʧʱ��
         /// </summary>
         public System.DateTime  ?CLEnterDate
             {get;set;}
         /// <summary>
         /// ��ʧԭ��
         /// </summary>
         public System.String  CLReason
             {get;set;}
         /// <summary>
         /// ״̬
         /// </summary>
         public System.Int32  ?CLState
             {get;set;}
       }
}
