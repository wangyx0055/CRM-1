using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
    /// <summary>
    ///  �ͻ�������ͼ
    /// </summary>
    [KeyInfo("UserID")]
     public class CS_View:ModelBase
       {
        /// <summary>
        /// ����������
        /// </summary>
         public System.String  UserName2
             {get;set;}
        /// <summary>
        /// �ͻ�����
        /// </summary>
         public System.String  CusName
             {get;set;}
        /// <summary>
        /// ����ID
        /// </summary>
         public System.Int32  ?CSID
             {get;set;}
        /// <summary>
        /// ��������ID
        /// </summary>
         public System.Int32  ?STID
             {get;set;}
        /// <summary>
        /// �ͻ�iD
        /// </summary>
         public System.String  CusID
             {get;set;}
        /// <summary>
        /// �������
        /// </summary>
         public System.String  CSTitle
             {get;set;}
        /// <summary>
        /// ����״̬
        /// </summary>
         public System.Int32  ?CSState
             {get;set;}
        /// <summary>
        /// ������ϸ��Ϣ
        /// </summary>
         public System.String  CSDesc
             {get;set;}
        /// <summary>
        /// ����������ID
        /// </summary>
         public System.Int32  ?CSCreateID
             {get;set;}
        /// <summary>
        /// ��������ʱ��
        /// </summary>
         public System.DateTime  ?CSCreateDate
             {get;set;}
        /// <summary>
        /// ����ָ����ID
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
        /// ������ʱ��
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
        /// <summary>
        /// ������������
        /// </summary>
         public System.String  STName
             {get;set;}
        /// <summary>
        /// ����������
        /// </summary>
         public System.String  UserName
             {get;set;}
      /// <summary>
      /// ������ID
      /// </summary>
         public System.Int32  ?UserID
             {get;set;}
     
       }
}
