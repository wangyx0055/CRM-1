using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 客户信息
    /// </summary>
     [KeyInfo("CusID")]
     public class Customers:ModelBase
       {
         /// <summary>
         /// 客户编号
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// 客户经理编号
         /// </summary>
         public System.Int32  ?UserID
             {get;set;}
         /// <summary>
         /// 客户姓名
         /// </summary>
         public System.String  CusName
             {get;set;}
         /// <summary>
         /// 地址
         /// </summary>
         public System.String  CusAddress
             {get;set;}
         /// <summary>
         /// 邮编
         /// </summary>
         public System.String  CusZip
             {get;set;}
         /// <summary>
         /// 传真
         /// </summary>
         public System.String  CusFax
             {get;set;}
         /// <summary>
         /// 网址
         /// </summary>
         public System.String  CusWebsite
             {get;set;}
         /// <summary>
         /// 营业执照注册号
         /// </summary>
         public System.String  CusLicenceNo
             {get;set;}
         /// <summary>
         /// 法人
         /// </summary>
         public System.String  CusChieftain
             {get;set;}
         /// <summary>
         /// 注册资金
         /// </summary>
         public System.Int32  ?CusBankroll
             {get;set;}
         /// <summary>
         /// 年营业额
         /// </summary>
         public System.Int32  ?CusTurnover
             {get;set;}
         /// <summary>
         /// 开户银行
         /// </summary>
         public System.String  CusBank
             {get;set;}
         /// <summary>
         /// 银行账号
         /// </summary>
         public System.String  CusBankNo
             {get;set;}
         /// <summary>
         /// 地税登记号
         /// </summary>
         public System.String  CusLocalTaxNo
             {get;set;}
         /// <summary>
         /// 国税登记号
         /// </summary>
         public System.String  CusNationalTaxNo
             {get;set;}
         /// <summary>
         /// 建立时间
         /// </summary>
         public System.DateTime  ?CusDate
             {get;set;}
         /// <summary>
         /// 客户状态
         /// </summary>
         public System.Int32  ?CusState
             {get;set;}
       }
}
