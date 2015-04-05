using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 销售机会视图
    /// </summary>
     [KeyInfo("UserID")]
     public class ChanUNameView:ModelBase
       {
        /// <summary>
        /// 销售机会ID
        /// </summary>
         public System.Int32  ?ChanID
             {get;set;}
        /// <summary>
        /// 客户名字
        /// </summary>
         public System.String  ChanName
             {get;set;}
        /// <summary>
        /// 成功率
        /// </summary>
         public System.Int32  ?ChanRate
             {get;set;}
        /// <summary>
        /// 联系人
        /// </summary>
         public System.String  ChanLinkMan
             {get;set;}
        /// <summary>
        /// 联系电话
        /// </summary>
         public System.String  ChanLinkTel
             {get;set;}
        /// <summary>
        /// 概要
        /// </summary>
         public System.String  ChanTitle
             {get;set;}
        /// <summary>
        /// 详细信息
        /// </summary>
         public System.String  ChanDesc
             {get;set;}
        /// <summary>
        /// 创建人
        /// </summary>
         public System.Int32  ?ChanCreateMan
             {get;set;}
        /// <summary>
        /// 创建时间
        /// </summary>
         public System.DateTime  ?ChanCreateDate
             {get;set;}
        /// <summary>
        /// 指派人
        /// </summary>
         public System.Int32  ?ChanDueMan
             {get;set;}
        /// <summary>
        /// 指派时间
        /// </summary>
         public System.DateTime  ?ChanDueDate
             {get;set;}
        /// <summary>
        /// 开发状态
        /// </summary>
         public System.Int32  ?ChanState
             {get;set;}
        /// <summary>
        /// 失败原因
        /// </summary>
         public System.String  ChanError
             {get;set;}
        /// <summary>
        /// 客户经理名字
        /// </summary>
         public System.String  UserName
             {get;set;}
        /// <summary>
        /// 指派人名字
        /// </summary>
         public System.String  UserName2
             {get;set;}
        /// <summary>
        /// 客户经理ID
        /// </summary>
         public System.Int32  ?UserID
             {get;set;}
       }
}
