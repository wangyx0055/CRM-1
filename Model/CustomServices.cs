using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 客户服务处理
    /// </summary>
     [KeyInfo("CSID")]
     public class CustomServices:ModelBase
       {
         /// <summary>
         /// 客户处理ID
         /// </summary>
         public System.Int32  ?CSID
             {get;set;}
         /// <summary>
         /// 服务类型ID
         /// </summary>
         public System.Int32  ?STID
             {get;set;}
         /// <summary>
         /// 客户编号
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// 概要
         /// </summary>
         public System.String  CSTitle
             {get;set;}
         /// <summary>
         /// 服务状态
         /// </summary>
         public System.Int32  ?CSState
             {get;set;}
         /// <summary>
         /// 服务请求
         /// </summary>
         public System.String  CSDesc
             {get;set;}
         /// <summary>
         /// 创建人ID
         /// </summary>
         public System.Int32  ?CSCreateID
             {get;set;}
         /// <summary>
         /// 创建时间
         /// </summary>
         public System.DateTime  ?CSCreateDate
             {get;set;}
         /// <summary>
         /// 指派人ID
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
         /// 处理时间
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
       }
}
