using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// Ȩ����
    /// </summary>
     [KeyInfo("Right_code")]
     public class Rights:ModelBase
       {
        /// <summary>
        /// Ȩ�����
        /// </summary>
         public System.String  Right_code
             {get;set;}
        /// <summary>
        /// Ȩ��·��
        /// </summary>
         public System.String  Right_url
             {get;set;}
        /// <summary>
        /// Ȩ������
        /// </summary>
         public System.String  Right_tip
             {get;set;}
        /// <summary>
        /// Ȩ�����ID
        /// </summary>
        public System.Int32? Typeid
        { get; set; }
    }
}
