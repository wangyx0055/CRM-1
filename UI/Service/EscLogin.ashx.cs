using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace UI.Service
{
    /// <summary>
    /// EscLogin 的摘要说明
    /// </summary>
    public class EscLogin : IHttpHandler,IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            int state = 1;
            try
            {
                context.Response.ContentType = "text/plain";
                context.Session["lname"] = null;
                context.Session["name"] = null;
                context.Session["id"] = null;
                context.Response.Redirect("~/login.htm");
            }
            catch (Exception)
            {
                state = 0;
            }
            finally {
                context.Response.Write(state);
            }

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