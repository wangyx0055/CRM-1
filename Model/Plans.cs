using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ���ۼƻ���
    /// </summary>
     [KeyInfo("PlanID")]
     public class Plans:ModelBase
       {
         /// <summary>
         /// �ƻ�ID
         /// </summary>
         public System.Int32 ? PlanID
             {get;set;}
         /// <summary>
         /// ���ۻ���ID
         /// </summary>
         public System.Int32  ?ChanID
             {get;set;}
         /// <summary>
         /// �ƻ�ʱ��
         /// </summary>
         public System.DateTime  ?PlanDate
             {get;set;}
         /// <summary>
         /// �ƻ�����
         /// </summary>
         public System.String  PlanContent
             {get;set;}
         /// <summary>
         /// ִ��ʱ��
         /// </summary>
         public System.DateTime  ?PlanResultDate
             {get;set;}
         /// <summary>
         /// ִ�н��
         /// </summary>
         public System.String  PlanResult
             {get;set;}
       }
}
