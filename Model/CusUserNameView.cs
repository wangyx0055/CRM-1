using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Model
{
 
    /// <summary>
    /// �ͻ���Ϣ��ϸ��ͼ
    /// </summary>
     [KeyInfo("UserID")]
     public class CusUserNameView:ModelBase
       {
        /// <summary>
        /// �ͻ�ID
        /// </summary>
         public System.String  CusID
             {get;set;}
        /// <summary>
        /// ������ID
        /// </summary>
         public System.Int32  ?UserID
             {get;set;}
        /// <summary>
        /// �ͻ�����
        /// </summary>
         public System.String  CusName
             {get;set;}
        /// <summary>
        /// ��ַ
        /// </summary>
         public System.String  CusAddress
             {get;set;}

        /// <summary>
        /// �ʱ�
        /// </summary>
         public System.String  CusZip
             {get;set;}
        /// <summary>
        /// ����
        /// </summary>
         public System.String  CusFax
             {get;set;}
        /// <summary>
        /// ��ַ
        /// </summary>
         public System.String  CusWebsite
             {get;set;}
        /// <summary>
        ///Ӫҵִ��ע���
        /// </summary>
         public System.String  CusLicenceNo
             {get;set;}
        /// <summary>
        /// ����
        /// </summary>
        public System.String  CusChieftain
             {get;set;}
        /// <summary>
        /// ע���ʽ�
        /// </summary>
        public System.Int32  ?CusBankroll
             {get;set;}
        /// <summary>
        /// ��Ӫҵ��
        /// </summary>
        public System.Int32  ?CusTurnover
             {get;set;}
        /// <summary>
        /// ��������
        /// </summary>
        public System.String  CusBank
             {get;set;}
        /// <summary>
        /// �����˺�
        /// </summary>
        public System.String  CusBankNo
             {get;set;}
        /// <summary>
        /// ��˰�ǼǺ�
        /// </summary>
        public System.String  CusLocalTaxNo
             {get;set;}
        /// <summary>
        /// ��˰�ǼǺ�
        /// </summary>
        public System.String  CusNationalTaxNo
             {get;set;}
        /// <summary>
        /// ����ʱ��
        /// </summary>
        public System.DateTime  ?CusDate
             {get;set;}
        /// <summary>
        /// �ͻ�״̬
        /// </summary>
         public System.Int32  ?CusState
             {get;set;}
        /// <summary>
        /// �ͻ���������
        /// </summary>
         public System.String  UserName
             {get;set;}
       }
}
