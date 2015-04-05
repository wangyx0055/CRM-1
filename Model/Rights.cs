using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// 权利表
    /// </summary>
     [KeyInfo("Right_code")]
     public class Rights:ModelBase
       {
        /// <summary>
        /// 权利编号
        /// </summary>
         public System.String  Right_code
             {get;set;}
        /// <summary>
        /// 权利路径
        /// </summary>
         public System.String  Right_url
             {get;set;}
        /// <summary>
        /// 权利描述
        /// </summary>
         public System.String  Right_tip
             {get;set;}
        /// <summary>
        /// 权利类别ID
        /// </summary>
        public System.Int32? Typeid
        { get; set; }
    }
}
