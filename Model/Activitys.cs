using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
  /// <summary>
  /// 交往记录
  /// </summary>
     [KeyInfo("ActID")]
     public class Activitys:ModelBase
       {
         /// <summary>
         /// 交往ID
         /// </summary>
         public System.Int32 ? ActID
             {get;set;}
         /// <summary>
         /// 客户编号
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// 交往时间
         /// </summary>
         public System.DateTime  ?ActDate
             {get;set;}
         /// <summary>
         /// 交往地点
         /// </summary>
         public System.String  ActAdd
             {get;set;}
         /// <summary>
         /// 概要
         /// </summary>
         public System.String  ActTitle
             {get;set;}
         /// <summary>
         /// 备注
         /// </summary>
         public System.String  ActMemo
             {get;set;}
         /// <summary>
         /// 详细信息
         /// </summary>
         public System.String  ActDesc
             {get;set;}
       }
}
