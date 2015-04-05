
/**
 *
 * ━━━━━━神兽出没━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */

/**
 * 　　　　　　　　┏┓　　　┏┓
 * 　　　　　　　┏┛┻━━━┛┻┓
 * 　　　　　　　┃　　　　　　　┃ 　
 * 　　　　　　　┃　　　━　　　┃
 * 　　　　　　　┃　＞　　　＜　┃
 * 　　　　　　　┃　　　　　　　┃
 * 　　　　　　　┃...　⌒　...　┃
 * 　　　　　　　┃　　　　　　　┃
 * 　　　　　　　┗━┓　　　┏━┛
 * 　　　　　　　　　┃　　　┃　Code is far away from bug with the animal protecting　　　　　　　　　　
 * 　　　　　　　　　┃　　　┃   神兽保佑,代码无bug
 * 　　　　　　　　　┃　　　┃　　　　　　　　　　　
 * 　　　　　　　　　┃　　　┃  　　　　　　
 * 　　　　　　　　　┃　　　┃
 * 　　　　　　　　　┃　　　┃　　　　　　　　　　　
 * 　　　　　　　　　┃　　　┗━━━┓
 * 　　　　　　　　　┃　　　　　　　┣┓
 * 　　　　　　　　　┃　　　　　　　┏┛
 * 　　　　　　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　　　　　　┃┫┫　┃┫┫
 * 　　　　　　　　　　┗┻┛　┗┻┛
 */

/**
 *　　　　　　　　┏┓　　　┏┓+ +
 *　　　　　　　┏┛┻━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　　┃ 　
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 ████━████ ┃+
 *　　　　　　　┃　　　　　　　┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　　┃ + +
 *　　　　　　　┗━┓　　　┏━┛
 *　　　　　　　　　┃　　　┃　　　　　　　　　　　
 *　　　　　　　　　┃　　　┃ + + + +
 *　　　　　　　　　┃　　　┃　　　　Code is far away from bug with the animal protecting　　　　　　　
 *　　　　　　　　　┃　　　┃ + 　　　　神兽保佑,代码无bug　　
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+　　　　　　　　　
 *　　　　　　　　　┃　 　　┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━┳┓┏┛ + + + +
 *　　　　　　　　　　┃┫┫　┃┫┫
 *　　　　　　　　　　┗┻┛　┗┻┛+ + + +
 */
/**
*
*   【CRM客户关系管理系统】
*前期做的时候是请求WebService
*后期做的时候是请求一般处理程序（通过反射调用方法）
*界面有使用EasyUI来做显示
*【数据库版本：SqlServer2008】
*【VS版本：2013/2015】
*
*
*
*
*/



using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Model;
using DAL;
using System.Text;
using System.Web.SessionState;

namespace UI.Service
{
    /// <summary>
    /// MyProcessRequst 的摘要说明
    /// 后期请求总控制台
    /// </summary>
    public class MyProcessRequst : IHttpHandler,IRequiresSessionState
    {
        /// <summary>
        /// 核心方法
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string method = context.Request["method"];
            MyProcessRequst mp = new MyProcessRequst();
            //反射得到一个对象
            Type t1 = mp.GetType();
            object [] objs={context};
            try
            {
                t1.InvokeMember(method,System.Reflection.BindingFlags.InvokeMethod, System.Type.DefaultBinder, mp, objs);
            }
            catch (Exception)
            {
                Console.WriteLine("参数或方法错误！");
                context.Response.Write("参数或方法错误");
            }
            
        }
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="context"></param>
        public void Login(HttpContext context)
        {
            string name = context.Request["UserLName"];
            string pwd = context.Request["UserLPWD"];
            Users u = new Users()
            {
                UserLName = name,
                UserLPWD = pwd
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
                //角色ID
                context.Session["roid"] = us[0].RoleID;
                context.Response.Write("yes");
            }
        }
        /// <summary>
        /// 去主页
        /// </summary>
        /// <param name="context"></param>
        public void InMain(HttpContext context) {
            context.Response.Write("<script>window.location.href='main.htm'</script>");
        }
        /// <summary>
        /// 注销登录
        /// </summary>
        /// <param name="context"></param>
        public void EscLogin(HttpContext context) {
            int id = -1;
            try {
                context.Session["lname"] = null;
                context.Session["name"] = null;
                context.Session["id"] = null;
                id = 1;
            }
            catch (Exception) {
                id = 0;
            }
            finally {
                context.Response.Write(id);
            }
        }
        /// <summary>
        /// 查询所有角色
        /// </summary>
        /// <param name="context"></param>
        public void GetRoleAll(HttpContext context) {
            int roleid = Convert.ToInt32(context.Session["roleid"]);
            string sql = roleid !=11? "select * from Role where Role_id !=11 and role_id!=1 " : "select * from Role  ";
            string json =JsonTools.ToJson( DALBase<Role>.SelectArg(sql));
            context.Response.Write(json );
        }
        /// <summary>
        /// 修改和添加Role表
        /// </summary>
        /// <param name="context"></param>
        public void UpOrAddRole(HttpContext context) { 
            string json=context.Request["json"];
            Role r = JsonTools.ToObject<Role>(json);
            int id = -1;
            if (r.Role_id != null)
            {
                id = DALBase<Role>.Update(r);
            }
            else {
                string maxsql = "SELECT MAX(ROLE_ID) FROM ROLE ";
                id = DALBase<Role>.Insert(r) > 0 ? Convert.ToInt32(SQLHelper.SelectObject(maxsql, null)) : id;
            }
            context.Response.Write(id);
        }
        /// <summary>
        /// 删除角色
        /// </summary>
        /// <param name="context"></param>
        public void DelRole(HttpContext context)
        {
            if (context.Request["id"]!=null)
            {
                int id = Convert.ToInt32(context.Request["id"]);
                context.Response.Write(DALBase<Role>.Delete(id));
            }
        }
        /// <summary>
        /// 查询所有服务个数
        /// </summary>
        /// <param name="context"></param>
        public void GetServerTypeCount(HttpContext context) {
           
           string y = context.Request["y"];
           string sql = y.Length != 0 ? string.Format("SELECT STNAME,COUNT(STNAME) 'COUNT'  FROM VIEW_SV_TYPECOUNT WHERE CSDATE ='{0}'  GROUP BY STNAME", y) : "SELECT STNAME,COUNT(STNAME) 'COUNT'  FROM VIEW_SV_TYPECOUNT  GROUP BY STNAME";
            List<View_sv_typecount> list = DALBase<View_sv_typecount>.SelectArg(sql);
            context.Response.Write(JsonTools.ToJson(list));
        }
        /// <summary>
        /// 查询客户流失的原因
        /// </summary>
        public void GetCusLosAll(HttpContext context)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string sqlcount = "select count(*) from  view_cuslosinfo where clstate=3";
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount,null));
            dic.Add("total",count);
            StringBuilder sb = new StringBuilder();
            string cusname = context.Request["CusName"];
            string username=context.Request["UserName"];
            sb.Append(cusname.Trim().Length!=0?" AND CUSNAME LIKE'%"+cusname+"%' ":"");
            sb.Append(username.Trim().Length != 0 ? " AND USERNAME LIKE'%" + username + "%' " : "");
            int index = Convert.ToInt32(context.Request["page"]);//页数
            int size = Convert.ToInt32(context.Request["rows"]);//页大小
            string sql = string.Format("select top {0} * from view_cuslosinfo where clid not in(select top {1} clid from view_cuslosinfo  where clstate=3 " + sb.ToString() + " )  and clstate=3  " + sb.ToString() + "", size, (index - 1) * size);
            List<View_CusLosInfo> list = DALBase<View_CusLosInfo>.SelectArg(sql);
            dic.Add("rows",list);
            context.Response.Write(JsonTools.ToJson(dic));
        }
        /// <summary>
        /// 查询所有权利信息
        /// </summary>
        /// <param name="context"></param>
        public void GetRightAll(HttpContext context)
        {
            int roleid = Convert.ToInt32(context.Session["roleid"]);
            string sql = "";
            if (roleid!=11)
            {
                sql = " select * from  Rights where typeid!=5";
            }
            else
            {
                sql = " select * from  Rights ";
            }
            context.Response.Write(JsonTools.ToJson(DALBase<Rights>.SelectArg(sql)));
        }
        /// <summary>
        /// 查询权利类别
        /// </summary>
        /// <param name="context"></param>
        public void GetRightTpye(HttpContext context)
        {
            int roleid = Convert.ToInt32(context.Session["roleid"]);
            string sql = "";
            if (roleid != 11)
            {
                sql = " select * from  RightType where typeid!=5";
            }
            else
            {
                sql = " select * from  RightType ";
            }
            context.Response.Write(JsonTools.ToJson(DALBase<RightType>.SelectArg(sql)));
        }
        /// <summary>
        /// 根据角色ID查询权利信息
        /// </summary>
        public void GetRightRoleByID(HttpContext context)
        {
            int id = Convert.ToInt32(context.Request["role_id"]);
            string sql = string.Format("SELECT * FROM ROLE_CENTER WHERE RF_ROLE_ID ={0}",id);
            List<Role_center> list = DALBase<Role_center>.SelectArg(sql);
            context.Response.Write(JsonTools.ToJson(list));
        }
        /// <summary>
        /// 根据角色ID清除角色权利
        /// </summary>
        /// <param name="context"></param>
        public void DelRightRoleByID(HttpContext context)
        {
            int id = Convert.ToInt32(context.Request["role_id"]);
            string sql = "DELETE Role_center WHERE rf_role_id ="+id;
            context.Response.Write(SQLHelper.CUD(sql,null));
        }
        /// <summary>
        /// 想角色添加权限
        /// </summary>
        /// <param name="context"></param>
        public void AddRightRole(HttpContext context)
        {
            try
            {
                int id = Convert.ToInt32(context.Request["role_id"]);
                string str = context.Request["right"];
                str = str.Substring(0,str.Length - 1);
                string[] code = str.Split('.');
                for (int i = 0; i < code.Length; i++)
                {
                    Role_center rc = new Role_center();
                    rc.Rf_role_id= id;
                    rc.Rf_right_code= code[i];
                    DALBase<Role_center>.Insert(rc);
                }
                context.Response.Write(1);
            }
            catch (Exception)
            {
                context.Response.Write(0);
            }
         
        }
        /// <summary>
        /// 验证是否有权限对销售机会操作
        /// </summary>
        /// <param name="context"></param>
        public void FGChanRole(HttpContext context) {
            if (context.Session != null || context.Session["id"] != null)
            {
                //验证登录用户是否拥有对销售机会的修改权限【权限代码：R_0005】
                int roleid = Convert.ToInt32(context.Session["roleid"]);
                if (roleid==11)//超级管理员
                {
                    context.Response.Write(1);
                    return;
                }
                string sqlflag = string.Format("select * from dbo.Role_center where rf_role_id={0} and rf_right_code='R_0005'", roleid);
                List<Role_center> listflag = DALBase<Role_center>.SelectArg(sqlflag);
                if (listflag.Count <1)
                {
                    context.Response.Write(0);
                    return;
                }
               //验证用户是否拥有这个销售机会
                int chanid = Convert.ToInt32(context.Request["ChanID"]);
                int chandueman = Convert.ToInt32(context.Session["id"]);
                string sql = string.Format("select * from Chances where chanid={0} and chandueman={1} ", chanid, chandueman);
                List<Chances> list = DALBase<Chances>.SelectArg(sql);
                context.Response.Write(list.Count);
            }
            else {
                context.Response.Write(0);
            }
          
        }
        /// <summary>
        /// 脚本权限验证
        /// </summary>
        /// <param name="context"></param>
        public void FGChanRoleAll(HttpContext context)
        {
            if (context.Session != null || context.Session["id"] != null)
            {
                //验证登录用户是否拥有对销售机会的修改权限【权限代码：R_0005】
                int roleid = Convert.ToInt32(context.Session["roleid"]);
                string rightcode = context.Request["rightcode"];
                string sqlflag = string.Format("select * from dbo.Role_center where rf_role_id={0} and rf_right_code='{1}'", roleid,rightcode);
                List<Role_center> listflag = DALBase<Role_center>.SelectArg(sqlflag);
                if (listflag.Count < 1)
                {
                    context.Response.Write(0);
                }
                else
                {
                    context.Response.Write(1);
                }
            }
            else
            {
                context.Response.Write(0);
            }

        }
        /// <summary>
        /// 验证是否有权限对服务操作
        /// </summary>
        /// <param name="context"></param>
        public void FGCusServiceRole(HttpContext context)
        {
            if (context.Session != null || context.Session["id"] != null)
            {
                //验证登录用户是否拥有对服务的修改权限【权限代码：R_0005】
                string rolecode = context.Request["rolecode"];
                int roleid = Convert.ToInt32(context.Session["roleid"]);
                if (roleid == 11)//超级管理员
                {
                    context.Response.Write(1);
                    return;
                }
                string sqlflag = string.Format("select * from dbo.Role_center where rf_role_id={0} and rf_right_code='{1}'", roleid,rolecode);
                List<Role_center> listflag = DALBase<Role_center>.SelectArg(sqlflag);
                if (listflag.Count < 1)
                {
                    context.Response.Write(0);
                    return;
                }
                int chanid = Convert.ToInt32(context.Request["CSID"]);
                int chandueman = Convert.ToInt32(context.Session["id"]);
                string sql = string.Format("select * from CustomServices where CSID={0} and CSDueID={1} ", chanid, chandueman);
                List<CustomServices> list = DALBase<CustomServices>.SelectArg(sql);
                context.Response.Write(list.Count);
            }
            else
            {
                context.Response.Write(0);
            }

        }
        /// <summary>
        /// 获取所有的页面访问路径菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetUserListToolsAll(HttpContext context)
        {
            int roleid = Convert.ToInt32(context.Session["roleid"]);
            string sql = "";
            string sql1 = "";
            if (roleid!=11)
            {
                 sql = "select * from listtools where listtype !=5";
                 sql1 = "select * from ListType where id !=5 ";
            }
            else
            {
                sql = "select * from listtools ";
                sql1 = "select * from ListType ";
            }
            Dictionary<string, object> dic = new Dictionary<string, object>();
            List<ListTools> llist = DALBase<ListTools>.SelectArg(sql);
            List<ListType> tlist = DALBase<ListType>.SelectArg(sql1);
            dic.Add("llist", llist);
            dic.Add("tlist", tlist);
            context.Response.Write(JsonTools.ToJson(dic));
        }
        /// <summary>
        /// 获取登录用户菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetUserListTools(HttpContext context) {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            int roleid = Convert.ToInt32(context.Session["roleid"]);
            string sql = "select * from listtools where listid in(select listid from Rolelistcenter where roleid = " + roleid+ ")";
            string sql1 = "select * from dbo.ListType where id in(select listtype from listtools where listid in(select listid from Rolelistcenter where roleid=" + roleid + "  ))";
            List<ListTools> llist = DALBase<ListTools>.SelectArg(sql);
            List<ListType> tlist = DALBase<ListType>.SelectArg(sql1);
            dic.Add("llist",llist);
            dic.Add("tlist",tlist);
            context.Response.Write(JsonTools.ToJson(dic));
        }
        /// <summary>
        /// 查看页面访问权限
        /// </summary>
        /// <param name="context"></param>
        public void GetUserListToolstoo(HttpContext context)
        {
            int roleid = Convert.ToInt32(context.Request["role_id"]);
            string sql = "select * from listtools where listid in(select listid from Rolelistcenter where roleid = " + roleid + ")";
            List<ListTools> list = DALBase<ListTools>.SelectArg(sql);
            context.Response.Write(JsonTools.ToJson(list));
        }
        /// <summary>
        /// 清除角色的访问路径
        /// </summary>
        /// <param name="context"></param>
        public void ClearRoleList(HttpContext context) {
            int roleid = Convert.ToInt32(context.Request["role_id"]);
            string sql = "delete  from  Rolelistcenter where roleid="+roleid;
            int index = 0;
            try
            {
                SQLHelper.CUD(sql, null);
                index = 1;
            }
            catch (Exception)
            {
                index = 0;
            }
           context.Response.Write(index );
        }
        /// <summary>
        /// 添加角色页面访问权限
        /// </summary>
        /// <param name="context"></param>
        public void AddRoleList(HttpContext context)
        {
            try
            {
                int id = Convert.ToInt32(context.Request["role_id"]);
                string str = context.Request["right"];
                str = str.Substring(0, str.Length - 1);
                string[] code = str.Split('.');
                for (int i = 0; i < code.Length; i++)
                {
                    Rolelistcenter rc = new Rolelistcenter();
                    rc.Roleid = id;
                    rc.Listid = Convert.ToInt32(code[i]);
                    DALBase<Rolelistcenter>.Insert(rc);
                }
                context.Response.Write(1);
            }
            catch (Exception)
            {
                context.Response.Write(0);
            }

        }
        /// <summary>
        /// 验证用户是否拥有分配权限
        /// </summary>
        /// <param name="context"></param>
        public void FGRoleAllot(HttpContext context) {
            if (context.Session != null || context.Session["id"] != null)
            {
                int roleid = Convert.ToInt32(context.Session["roleid"]);
                string sqlflag = string.Format("select * from dbo.Role_center where rf_role_id={0} and rf_right_code='R_0027'", roleid);
                List<Role_center> listflag = DALBase<Role_center>.SelectArg(sqlflag);
                context.Response.Write(listflag.Count);
            }
            else
            {
                context.Response.Write(0);
            }
        }

        /// <summary>
        /// 实例可再次使用，则为 true；否则为 false。
        /// </summary>
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}