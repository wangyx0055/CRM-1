using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Model;
using DAL;
using System.Text;
using System.Web.Security;
namespace UI.Service
{
    /// <summary>
    /// UsersServices 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class UsersServices : System.Web.Services.WebService
    {
        /// <summary>
        /// 登陆
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        [WebMethod(EnableSession=true)]
        public int Login(string json){
            Users u = JsonTools.ToObject<Users>(json);
             u.UserLPWD = Option_Exti.GetStr(u.UserLPWD);
            string sql = string.Format("select  * from Users where UserLName ='{0}' and UserLPWD = '{1}'  and USERFLAG=1",u.UserLName,u.UserLPWD);
            int id = -1;
            List<Users> us=DALBase<Users>.SelectArg(sql);
            if (us.Count>0)
            {
                id = Convert.ToInt32(us[0].UserID);
                //登陆名字
                Session["lname"] = u.UserLName;
                //用户真实名字
                Session["name"] = us[0].UserName;
                //用户ID
                Session["id"] = id;
                //表单验证
                //FormsAuthentication.SetAuthCookie(u.UserLName, false);
                //FormsAuthentication.SignOut();
            }
            return id;
        }
        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession=true)]
        public string GetUsersInfo() {
            UserRole u = null;
            if (Session["id"]!=null)
            {
                u = new UserRole() { 
                    UserID=Convert.ToInt32(Session["id"]),
                    UserLName=Session["lname"].ToString(),
                    UserName=Session["name"].ToString(),
                    Role_name=Session["rolename"].ToString(),
                    RoleID=Convert.ToInt32(Session["roleid"])
                };
            }
            return JsonTools.ToJson(u);
        }
        [WebMethod(EnableSession=true,Description="注销登录")]
        public void EscLogin() {
            Session["lname"] = null;
            Session["name"] = null;
            Session["id"] = null;
        }
    }
}
