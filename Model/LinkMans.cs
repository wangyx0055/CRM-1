using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 联系人
    /// </summary>
     [KeyInfo("LMID")]
     public class LinkMans:ModelBase
       {
         /// <summary>
         /// 联系人编号
         /// </summary>
         public System.Int32  ?LMID
             {get;set;}
         /// <summary>
         /// 客户编号
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// 姓名
         /// </summary>
         public System.String  LMName
             {get;set;}
         /// <summary>
         /// 性别
         /// </summary>
         public System.String  LMSex
             {get;set;}
         /// <summary>
         /// 职位
         /// </summary>
         public System.String  LMDuty
             {get;set;}
         /// <summary>
         /// 手机号码
         /// </summary>
         public System.String  LMMobileNo
             {get;set;}
         /// <summary>
         /// 办公室电话
         /// </summary>
         public System.String  LMOfficeNo
             {get;set;}
         /// <summary>
         /// ；备注
         /// </summary>
         public System.String  LMMemo
             {get;set;}
       }
}
