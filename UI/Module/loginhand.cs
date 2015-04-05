using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace UI.Module
{
    public class loginhand:IHttpHandler,IRequiresSessionState
    {
        public bool IsReusable
        {
            get { throw new NotImplementedException(); }
        }

        public void ProcessRequest(HttpContext context)
        {
            //if (context.Request.RawUrl.Contains(".htm"))
            //{
            //    if (!context.Request.RawUrl.Contains("login.htm"))
            //    {
            //        if (context.Session == null || context.Session["name"] == null)
            //        {
            //            context.Response.Redirect("~/login.htm");
            //        }
            //    }
            //}
        }
    }
}