using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
  /// <summary>
  /// ������¼
  /// </summary>
     [KeyInfo("ActID")]
     public class Activitys:ModelBase
       {
         /// <summary>
         /// ����ID
         /// </summary>
         public System.Int32 ? ActID
             {get;set;}
         /// <summary>
         /// �ͻ����
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// ����ʱ��
         /// </summary>
         public System.DateTime  ?ActDate
             {get;set;}
         /// <summary>
         /// �����ص�
         /// </summary>
         public System.String  ActAdd
             {get;set;}
         /// <summary>
         /// ��Ҫ
         /// </summary>
         public System.String  ActTitle
             {get;set;}
         /// <summary>
         /// ��ע
         /// </summary>
         public System.String  ActMemo
             {get;set;}
         /// <summary>
         /// ��ϸ��Ϣ
         /// </summary>
         public System.String  ActDesc
             {get;set;}
       }
}
