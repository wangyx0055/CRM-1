using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 订单表
    /// </summary>
     [KeyInfo("OrderID")]
     public class Orders:ModelBase
       {
         /// <summary>
         /// 订单编号
         /// </summary>
         public System.Int32  ?OrderID
             {get;set;}
         /// <summary>
         /// 客户编号
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// 订单时间
         /// </summary>
         public System.DateTime  ?OrderDate
             {get;set;}
       }
}
