using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using DAL;
using System.Text;

namespace UI
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            string name = Request["textfield"];
            string pwd = Request["textfield2"];
            Users u = new Users()
            {
                UserLName = name,
                UserLPWD = pwd
            };
            byte[] nbt = Encoding.ASCII.GetBytes(u.UserLPWD);
            string newpwd = Convert.ToBase64String(nbt);
            string sql = string.Format("select  * from UserRole where UserLName ='{0}' and UserLPWD = '{1}'", u.UserLName, newpwd);
            int id = -1;
            List<UserRole> us = DALBase<UserRole>.SelectArg(sql);
            if (us.Count > 0)
            {
                if (us[0].UserFlag<1)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('该用户已被禁用，请联系系统管理员！');</script>");
                    return;
                }
                if (us[0].Role_flag < 1)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('该角色已被禁用，请联系系统管理员！');</script>");
                    return;
                }
                id = Convert.ToInt32(us[0].UserID);
                //登陆名字
                Session["lname"] = u.UserLName;
                //用户真实名字
                Session["name"] = us[0].UserName;
                //用户ID
                Session["id"] = id;
                //角色ID
                Session["roleid"] = us[0].RoleID;
                //角色名字
                Session["rolename"] = us[0].Role_name;
                Response.Redirect("~/Main.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(),"", "<script>alert('用户名或者密码错误，登录失败，请联系系统管理员！');</script>");
            }
        }
    }
}