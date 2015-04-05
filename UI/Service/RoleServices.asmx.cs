using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Model;
using DAL;
using System.Text;

namespace UI.Service
{
    /// <summary>
    /// RoleServices 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
     [System.Web.Script.Services.ScriptService]
    public class RoleServices : System.Web.Services.WebService
    {

        [WebMethod(EnableSession =true,Description="分页查询所有用户")]
        public string GetUserAll(string json)
        {
            int roleid = Convert.ToInt32(Session["roleid"]);
            UserRole u = JsonTools.ToObject<UserRole>(json);
            int index =Convert.ToInt32( u.UserID);
            int size = 10;
            StringBuilder sbwhere = new StringBuilder();//条件
            sbwhere.Append(u.Role_id!=0?" and Role_id="+u.Role_id+ "":"");//角色ID
            sbwhere.Append(u.UserFlag >=0 ? " and UserFlag=" + u.UserFlag + "" : "");//是否可用
            sbwhere.Append(u.UserName.Trim().Length>0 ? " and UserName like '%" + u.UserName + "%'" : "");//用户名字
            sbwhere.Append(roleid != 11 ? " and  Role_id !=11 and role_id!=1 " : "");//是否是超级管理员
            Dictionary<string, object> dic = new Dictionary<string, object>();
            StringBuilder sqlcount = new StringBuilder();
            sqlcount.Append("  SELECT  ");
            sqlcount.Append("  COUNT(*) ");
            sqlcount.Append("  FROM  ");
            sqlcount.Append("  USERROLE  where 1=1 ");
            sqlcount.Append(sbwhere.ToString());
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount.ToString(),null));
            dic.Add("count",count);
            count = count % size == 0 ? count / size : count / size + 1;
            dic.Add("page",count);
            StringBuilder sb = new StringBuilder();
            sb.Append(" SELECT  ");
            sb.Append("  TOP   ");
            sb.Append(size);
            sb.Append("   *  ");
            sb.Append("   FROM  ");
            sb.Append("   USERROLE  ");
            sb.Append("  WHERE   ");
            sb.Append("   USERID   ");
            sb.Append("   NOT  ");
            sb.Append("   IN  ");
            sb.Append("   (SELECT  ");
            sb.Append("   TOP  ");
            sb.Append((index-1)*size);
            sb.Append("   USERID  ");
            sb.Append("   FROM  ");
            sb.Append("    USERROLE  where 1=1 " + sbwhere.ToString() + "   ORDER BY USERID   ) " + sbwhere.ToString() + "  ORDER BY USERID ");
            List<UserRole> list = DALBase<UserRole>.SelectArg(sb.ToString());
            foreach (UserRole item in list)
            {
                string pwd = item.UserLPWD;
                item.UserLPWD = Option_Exti.SetStr(pwd);
            }
            dic.Add("list",list);
            return JsonTools.ToJson(dic);
        }

        [WebMethod(EnableSession =true,Description = "查询所有角色信息")]
        public string GetRoleAll() {
            int roleid = Convert.ToInt32(Session["roleid"]);
            string sql = roleid != 11 ? "select * from Role where Role_id !=11 and role_id!=1 " : "select * from Role  ";
            return JsonTools.ToJson(DALBase<Role>.SelectArg(sql));
        }

        [WebMethod(Description = "删除用户")]
        public int DeleeteUser(int id)
        {
            return DALBase<Users>.Delete(id);
        }

        [WebMethod(Description = "修改用户信息")]
        public int UpdateUser(string json)
        {
            Users u = JsonTools.ToObject<Users>(json);
            int id = -1;
            //加密操作
            u.UserLPWD = Option_Exti.GetStr(u.UserLPWD);
            if (u.UserID==null)
            {
                string sql = "select max(UserID) from Users";
                id= DALBase<Users>.Insert(u)>0?Convert.ToInt32(SQLHelper.SelectObject(sql,null)):id;
            }
            else
            {
                id= DALBase<Users>.Update(u);
            }
            return id;
        }
    }
}
