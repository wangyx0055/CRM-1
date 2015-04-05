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
            throw new NotImplementedException();
        }

        public void Init(HttpApplication context)
        {
            context.AcquireRequestState += context_AcquireRequestState;
            context.AcquireRequestState += Context_AcquireRequestState;
        }

        private void Context_AcquireRequestState(object sender, EventArgs e)
        {
            HttpApplication app = (HttpApplication)sender;
            if (app.Context.Request.RawUrl.Contains(".htm"))
            {
                if (!app.Context.Request.RawUrl.Contains("login.htm"))
                {
                    if (app.Context.Session == null || app.Context.Session["name"] == null)
                    {
                        app.Context.Response.Redirect("~/login.aspx");
                    }
                }
            }
        }

        /// <summary>
        /// 登录过滤器
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void context_AcquireRequestState(object sender, EventArgs e)
        {
            
        }

     

        
      
    }
}