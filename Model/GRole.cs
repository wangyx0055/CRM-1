using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ����Ȩ�ޱ�
    /// </summary>
     [KeyInfo("Id")]
     public class GRole:ModelBase
       {
        /// <summary>
        /// ����Ȩ��ID
        /// </summary>
         public System.Int32  ?Id
             {get;set;}
        /// <summary>
        /// ����Ȩ��·��
        /// </summary>
         public System.String  Url
             {get;set;}
       }
}
