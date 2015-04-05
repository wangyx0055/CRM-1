using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace UI
{
    public class LoginFilter:IHttpModule,IRequiresSessionState
    {

        public void Dispose()
        {
            Console.WriteLine("Session出现异常了");
        }

        public void Init(HttpApplication context)
        {
            context.AcquireRequestState += Context_AcquireRequestState;
        }
        /// <summary>
        /// 登录过滤器
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Context_AcquireRequestState(object sender, EventArgs e)
        {
            //HttpApplication app = (HttpApplication)sender;
            //if (app.Context.Request.RawUrl.Contains(".aspx"))
            //{
            //    if (!app.Context.Request.RawUrl.Contains("login.aspx"))
            //    {
            //        if (app.Context.Session == null || app.Context.Session["name"] == null)
            //        {
            //            app.Context.Response.Redirect("~/login.aspx");
            //        }
            //    }
            //}
        }
      
    }
}