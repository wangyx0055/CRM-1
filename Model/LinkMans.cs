using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ��ϵ��
    /// </summary>
     [KeyInfo("LMID")]
     public class LinkMans:ModelBase
       {
         /// <summary>
         /// ��ϵ�˱��
         /// </summary>
         public System.Int32  ?LMID
             {get;set;}
         /// <summary>
         /// �ͻ����
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// ����
         /// </summary>
         public System.String  LMName
             {get;set;}
         /// <summary>
         /// �Ա�
         /// </summary>
         public System.String  LMSex
             {get;set;}
         /// <summary>
         /// ְλ
         /// </summary>
         public System.String  LMDuty
             {get;set;}
         /// <summary>
         /// �ֻ�����
         /// </summary>
         public System.String  LMMobileNo
             {get;set;}
         /// <summary>
         /// �칫�ҵ绰
         /// </summary>
         public System.String  LMOfficeNo
             {get;set;}
         /// <summary>
         /// ����ע
         /// </summary>
         public System.String  LMMemo
             {get;set;}
       }
}
