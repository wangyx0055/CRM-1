using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// �ͻ�������
    /// </summary>
     [KeyInfo("CSID")]
     public class CustomServices:ModelBase
       {
         /// <summary>
         /// �ͻ�����ID
         /// </summary>
         public System.Int32  ?CSID
             {get;set;}
         /// <summary>
         /// ��������ID
         /// </summary>
         public System.Int32  ?STID
             {get;set;}
         /// <summary>
         /// �ͻ����
         /// </summary>
         public System.String  CusID
             {get;set;}
         /// <summary>
         /// ��Ҫ
         /// </summary>
         public System.String  CSTitle
             {get;set;}
         /// <summary>
         /// ����״̬
         /// </summary>
         public System.Int32  ?CSState
             {get;set;}
         /// <summary>
         /// ��������
         /// </summary>
         public System.String  CSDesc
             {get;set;}
         /// <summary>
         /// ������ID
         /// </summary>
         public System.Int32  ?CSCreateID
             {get;set;}
         /// <summary>
         /// ����ʱ��
         /// </summary>
         public System.DateTime  ?CSCreateDate
             {get;set;}
         /// <summary>
         /// ָ����ID
         /// </summary>
         public System.Int32  ?CSDueID
             {get;set;}
         /// <summary>
         /// ָ��ʱ��
         /// </summary>
         public System.DateTime  ?CSDueDate
             {get;set;}
         /// <summary>
         /// ������
         /// </summary>
         public System.String  CSDeal
             {get;set;}
         /// <summary>
         /// ����ʱ��
         /// </summary>
         public System.DateTime  ?CSDealDate
             {get;set;}
         /// <summary>
         /// ������
         /// </summary>
         public System.String  CSResult
             {get;set;}
         /// <summary>
         /// �����
         /// </summary>
         public System.Int32  ?CSSatisfy
             {get;set;}
       }
}
