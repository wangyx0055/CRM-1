using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ���ۼƻ���
    /// </summary>
     [KeyInfo("ChanID")]
     public class Chances:ModelBase
       {
         /// <summary>
           /// ���ۻ���ID
         /// </summary>
         public System.Int32  ?ChanID
             {get;set;}
         /// <summary>
         /// �ͻ�����
         /// </summary>
         public System.String  ChanName
             {get;set;}
         /// <summary>
         /// �ɹ�����
         /// </summary>
         public System.Int32  ?ChanRate
             {get;set;}
         /// <summary>
         /// ��ϵ��
         /// </summary>
         public System.String  ChanLinkMan
             {get;set;}
         /// <summary>
         /// ��ϵ�绰
         /// </summary>
         public System.String  ChanLinkTel
             {get;set;}
         /// <summary>
         /// ��Ҫ
         /// </summary>
         public System.String  ChanTitle
             {get;set;}
         /// <summary>
         /// �ƻ�����
         /// </summary>
         public System.String  ChanDesc
             {get;set;}
         /// <summary>
         /// ������
         /// </summary>
         public System.Int32  ?ChanCreateMan
             {get;set;}
         /// <summary>
         /// ����ʱ��
         /// </summary>
         public System.DateTime  ?ChanCreateDate
             {get;set;}
         /// <summary>
         /// ָ����
         /// </summary>
         public System.Int32  ?ChanDueMan
             {get;set;}
         /// <summary>
         /// ָ��ʱ��
         /// </summary>
         public System.DateTime  ?ChanDueDate
             {get;set;}
         /// <summary>
         /// ���ۻ���״̬
         /// </summary>
         public System.Int32  ?ChanState
             {get;set;}
         /// <summary>
         /// ʧ��ԭ��
         /// </summary>
         public System.String  ChanError
             {get;set;}
       }
}
