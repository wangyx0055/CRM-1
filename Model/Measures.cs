using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// ��ʧ��ʩ��
    /// </summary>
     [KeyInfo("MeID")]
     public class Measures:ModelBase
       {
         /// <summary>
         /// ���
         /// </summary>
         public System.Int32  ?MeID
             {get;set;}
         /// <summary>
         /// �ͻ���ʧID
         /// </summary>
         public System.Int32  ?CLID
             {get;set;}
         /// <summary>
         /// ����ʱ��
         /// </summary>
         public System.DateTime  ?MeDate
             {get;set;}
         /// <summary>
         /// ��ʩϸ��
         /// </summary>
         public System.String  MeDesc
             {get;set;}
       }
}
