using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
    /// <summary>
    ///  客户服务视图
    /// </summary>
    [KeyInfo("UserID")]
     public class CS_View:ModelBase
       {
        /// <summary>
        /// 处理人名字
        /// </summary>
         public System.String  UserName2
             {get;set;}
        /// <summary>
        /// 客户名字
        /// </summary>
         public System.String  CusName
             {get;set;}
        /// <summary>
        /// 服务ID
        /// </summary>
         public System.Int32  ?CSID
             {get;set;}
        /// <summary>
        /// 服务类型ID
        /// </summary>
         public System.Int32  ?STID
             {get;set;}
        /// <summary>
        /// 客户iD
        /// </summary>
         public System.String  CusID
             {get;set;}
        /// <summary>
        /// 服务概述
        /// </summary>
         public System.String  CSTitle
             {get;set;}
        /// <summary>
        /// 服务状态
        /// </summary>
         public System.Int32  ?CSState
             {get;set;}
        /// <summary>
        /// 服务详细信息
        /// </summary>
         public System.String  CSDesc
             {get;set;}
        /// <summary>
        /// 创建服务人ID
        /// </summary>
         public System.Int32  ?CSCreateID
             {get;set;}
        /// <summary>
        /// 创建服务时间
        /// </summary>
         public System.DateTime  ?CSCreateDate
             {get;set;}
        /// <summary>
        /// 服务指派人ID
        /// </summary>
         public System.Int32  ?CSDueID
             {get;set;}
        /// <summary>
        /// 指派时间
        /// </summary>
         public System.DateTime  ?CSDueDate
             {get;set;}
        /// <summary>
        /// 服务处理
        /// </summary>
         public System.String  CSDeal
             {get;set;}
        /// <summary>
        /// 服务处理时间
        /// </summary>
         public System.DateTime  ?CSDealDate
             {get;set;}
        /// <summary>
        /// 处理结果
        /// </summary>
         public System.String  CSResult
             {get;set;}
        /// <summary>
        /// 满意度
        /// </summary>
         public System.Int32  ?CSSatisfy
             {get;set;}
        /// <summary>
        /// 服务类型名字
        /// </summary>
         public System.String  STName
             {get;set;}
        /// <summary>
        /// 创建人名字
        /// </summary>
         public System.String  UserName
             {get;set;}
      /// <summary>
      /// 创建人ID
      /// </summary>
         public System.Int32  ?UserID
             {get;set;}
     
       }
}
