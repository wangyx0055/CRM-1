using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 流失用户信息视图
    /// </summary>
     [KeyInfo("UserID")]
     public class View_CusLosInfo:ModelBase
       {
        /// <summary>
        /// 流失ID
        /// </summary>
         public System.Int32  ?CLID
             {get;set;}
        /// <summary>
        /// 用户姓名
        /// </summary>
         public System.String  UserName
             {get;set;}
        /// <summary>
        /// 客户名字
        /// </summary>
         public System.String  CusName
             {get;set;}
        /// <summary>
        /// 流失原因
        /// </summary>
         public System.String  CLReason
             {get;set;}
        /// <summary>
        /// 流失时间
        /// </summary>
         public System.DateTime  ?CLEnterDate
             {get;set;}
        /// <summary>
        /// 客户ID
        /// </summary>
         public System.String  CusID
             {get;set;}
        /// <summary>
        /// 客户经理ID
        /// </summary>
         public System.Int32  ?UserID
             {get;set;}
       }
}
