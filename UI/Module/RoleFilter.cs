using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Model;
using DAL;


namespace UI.Module
{

    /// <summary>
    /// 权限验证过滤器
    /// </summary>
    public class RoleFilter : IHttpModule
    {
        public void Dispose()
        {
            Console.WriteLine("未知错误");
        }
        /// <summary>
        /// 初始化方法
        /// </summary>
        /// <param name="context"></param>
        public void Init(HttpApplication context)
        {
            context.AcquireRequestState += Context_AcquireRequestState;
            context.Error += Context_Error;
        }

        private void Context_Error(object sender, EventArgs e)
        {
            //HttpApplication app = (HttpApplication)sender;
            //app.Response.Redirect("~/Error/500.aspx");
        }

        /// <summary>
        /// 权限拦截
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Context_AcquireRequestState(object sender, EventArgs e)
        {
            HttpApplication app = (HttpApplication)sender;
            string url = app.Context.Request.RawUrl.Trim();
            //如果不是页面请求，不执行权限验证
            if (!app.Context.Request.RawUrl.Contains(".aspx"))  {
                return;
            }
            if (app.Context.Session!=null)  {
                if (app.Context.Session["name"] != null)  {
                    int roleid = Convert.ToInt32(app.Context.Session["roleid"]);
                    if (!CheckRole(roleid,url)) {
                            //权限不足时，返回原来的页面
                     app.Response.Write("<script>alert('对不起，您没有该权限！确认返回原来页面。');history.go(-1);</script>");
                        //app.Response.Redirect("~/NoRole.aspx");
                    }
                }
            }

        }
        /// <summary>
        /// 权限验证
        /// </summary>
        /// <param name="roleid"></param>
        /// <returns></returns>
        private bool CheckRole(int roleid,string url) {
            bool flag = false;
            //基本权限验证
            List<GRole> gl = DALBase<GRole>.SelectArg();
            foreach (GRole item in gl) {
                if (url.ToUpper().Contains(item.Url.ToUpper()))  {
                    flag = true;
                    break;
                }
            }
            //权限验证
            if (!flag)  {
                string sql = string.Format(" select * from Rights where right_code in(select rf_right_code from dbo.Role_center where rf_role_id={0}) ", roleid);
                List<Rights> list = DALBase<Rights>.SelectArg(sql);
                foreach (Rights item in list)   {
                    if (url.ToUpper().Contains(item.Right_url.ToUpper())) {
                        flag = true;
                        break;
                    }
                }
            }
            return flag;
        }




    }

}