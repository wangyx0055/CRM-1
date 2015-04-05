using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 客户流失视图
    /// </summary>
     [KeyInfo("CusID")]
     public class CusLosView:ModelBase
       {
        /// <summary>
        /// 流失ID
        /// </summary>
         public System.Int32  ?CLID
             {get;set;}
        /// <summary>
        /// 客户ID
        /// </summary>
         public System.String  CusID
             {get;set;}
        /// <summary>
        /// 客户最后订单时间
        /// </summary>
         public System.DateTime  ?CLOrderDate
             {get;set;}
        /// <summary>
        /// 报警时间
        /// </summary>
         public System.DateTime  ?CLDate
             {get;set;}
        /// <summary>
        /// 缓存措施
        /// </summary>
         public System.String  CLMeasures
             {get;set;}
        /// <summary>
        /// 客户流失时间
        /// </summary>
         public System.DateTime  ?CLEnterDate
             {get;set;}
        /// <summary>
        /// 流失原因
        /// </summary>
         public System.String  CLReason
             {get;set;}
        /// <summary>
        /// 流失状态
        /// </summary>
         public System.Int32  ?CLState
             {get;set;}
        /// <summary>
        /// 客户姓名
        /// </summary>
         public System.String  CusName
             {get;set;}
       }
}
