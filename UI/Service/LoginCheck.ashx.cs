using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;
using Model;
using System.Text;
using System.Web.SessionState;


namespace UI.Service
{
    /// <summary>
    /// LoginCheck 的摘要说明
    /// </summary>
    public class LoginCheck : IHttpHandler,IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string name = context.Request["UserLName"];
            string pwd = context.Request["UserLPWD"];
            Users u = new Users() { 
                UserLName=name,
                UserLPWD=pwd
            };
            byte[] nbt = Encoding.ASCII.GetBytes(u.UserLPWD);
            string newpwd = Convert.ToBase64String(nbt);
            string sql = string.Format("select  * from Users where UserLName ='{0}' and UserLPWD = '{1}'", u.UserLName, newpwd);
            int id = -1;
            List<Users> us = DALBase<Users>.SelectArg(sql);
            if (us.Count > 0)
            {
                id = Convert.ToInt32(us[0].UserID);
                //登陆名字
                context.Session["lname"] = u.UserLName;
                //用户真实名字
                context.Session["name"] = us[0].UserName;
                //用户ID
                context.Session["id"] = id;
            }
            context.Response.Write(id);
        }


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}