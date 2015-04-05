using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 销售计划表
    /// </summary>
     [KeyInfo("PlanID")]
     public class Plans:ModelBase
       {
         /// <summary>
         /// 计划ID
         /// </summary>
         public System.Int32 ? PlanID
             {get;set;}
         /// <summary>
         /// 销售机会ID
         /// </summary>
         public System.Int32  ?ChanID
             {get;set;}
         /// <summary>
         /// 计划时间
         /// </summary>
         public System.DateTime  ?PlanDate
             {get;set;}
         /// <summary>
         /// 计划内容
         /// </summary>
         public System.String  PlanContent
             {get;set;}
         /// <summary>
         /// 执行时间
         /// </summary>
         public System.DateTime  ?PlanResultDate
             {get;set;}
         /// <summary>
         /// 执行结果
         /// </summary>
         public System.String  PlanResult
             {get;set;}
       }
}
