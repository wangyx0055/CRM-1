using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model
{
    /// <summary>
    /// 自定义的特性类，标示这个类的主键名
    /// </summary>
   public class KeyInfoAttribute:Attribute
    {
       public string KeyName
       { get; set; }
       public KeyInfoAttribute(string name)
       {
           this.KeyName = name;
       }
    }
}
