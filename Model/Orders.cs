using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ������
    /// </summary>
     [KeyInfo("OrderID")]
     public class Orders:ModelBase
       {
         /// <summary>
         /// �������
         /// </summary>
         public System.Int32  ?OrderID
             {get;set;}
         /// <summary>
         /// �ͻ����
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// ����ʱ��
         /// </summary>
         public System.DateTime  ?OrderDate
             {get;set;}
       }
}
