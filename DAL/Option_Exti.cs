using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAL
{
   public class Option_Exti
    {
       /// <summary>
       /// 解密
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>
       public static string SetStr(string str) {
           byte[] bs = Convert.FromBase64String(str);
           string newPwd = System.Text.Encoding.ASCII.GetString(bs);
           return newPwd;
       }

       /// <summary>
       /// 加密
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>
       public static string GetStr(string str) {
           byte[] bs = System.Text.Encoding.ASCII.GetBytes(str);
           string newPwd = Convert.ToBase64String(bs);
           return newPwd;
       }

    }
}
