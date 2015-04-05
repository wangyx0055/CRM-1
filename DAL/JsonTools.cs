using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;
using Model;
namespace DAL
{
   public class JsonTools
    {
       public static string ToJson(object obj)
       {
           JavaScriptSerializer js = new JavaScriptSerializer();
           return js.Serialize(obj);
        
       }

       public static T ToObject<T>(string json) where T : ModelBase
       {
           JavaScriptSerializer js = new JavaScriptSerializer();
           T t = js.Deserialize<T>(json);
           return t;
       }
    }
}
