using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 客户流失表
    /// </summary>
     [KeyInfo("CLID")]
     public class CustomLosts:ModelBase
       {
         /// <summary>
         /// 客户流失ID
         /// </summary>
         public System.Int32  ?CLID
             {get;set;}
         /// <summary>
         /// 客户编号
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// 最后下单时间
         /// </summary>
         public System.DateTime  ?CLOrderDate
             {get;set;}
         /// <summary>
         /// 流失报警时间
         /// </summary>
         public System.DateTime  ?CLDate
             {get;set;}
         /// <summary>
         /// 流失措施
         /// </summary>
         public System.String  CLMeasures
             {get;set;}
         /// <summary>
         /// 确定流失时间
         /// </summary>
         public System.DateTime  ?CLEnterDate
             {get;set;}
         /// <summary>
         /// 流失原因
         /// </summary>
         public System.String  CLReason
             {get;set;}
         /// <summary>
         /// 状态
         /// </summary>
         public System.Int32  ?CLState
             {get;set;}
       }
}
