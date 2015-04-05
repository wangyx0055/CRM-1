using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Model;
using DAL;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace UI.Service
{
    /// <summary>
    /// CusServices 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
     [System.Web.Script.Services.ScriptService]
    public class CusServices : System.Web.Services.WebService
    {

        [WebMethod(Description="分页按条件查询客户表数据")]
        public string GetPageData(string json) {
            int size = 10;
            Dictionary<string, object> dic= new Dictionary<string, object>();
            CusUserNameView cv = JsonTools.ToObject<CusUserNameView>(json);
            StringBuilder sbcount = new StringBuilder();
            sbcount.Append("select  count( *) from CusUserNameView where  1=1 ");
            sbcount.Append(cv.CusID.Trim().Length != 0 ? " and CusID like '%" + cv.CusID + "%' " : "");
            sbcount.Append(cv.CusName.Trim().Length != 0 ? " and CusName like '%" + cv.CusName + "%' " : "");
            string sqlcount = sbcount.ToString();//查询数据个数的sql语句
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount,null));
            dic.Add("count",count);//总条数
            count=count% size == 0?count/ size : count/ size + 1;
            dic.Add("page",count);//总页数
            StringBuilder sb1 = new StringBuilder();
            StringBuilder sb2 = new StringBuilder();
            sb1.Append(" select top "+ size + " * from CusUserNameView where CusID not in(  ");
            int index=Convert.ToInt32( cv.CusState);//客户状态绑定的是分页查询的页数
            sb2.Append(" select top " + (index - 1) * size + " CusID from CusUserNameView where 1=1 ");
            sb2.Append(cv.CusID.Trim().Length != 0 ? " and CusID like '%" + cv.CusID + "%' " : "");
            sb2.Append(cv.CusName.Trim().Length != 0 ? " and CusName like '%" + cv.CusName + "%' " : "");
            sb1.Append(sb2.ToString() + " ) ");
            sb1.Append(cv.CusID.Trim().Length != 0 ? " and CusID like '%" + cv.CusID + "%' " : "");
            sb1.Append(cv.CusName.Trim().Length != 0 ? " and CusName like '%" + cv.CusName + "%' " : "");
            string sql = sb1.ToString();//模糊查询sql语句
            List<CusUserNameView> list = DALBase<CusUserNameView>.SelectArg(sql);
            dic.Add("list",list);//查询结果
            return JsonTools.ToJson(dic);
        }

        [WebMethod(Description = "根据客户ID查询用户信息")]
        public string GetCusByID(string id) {
            string sql = "select * from CusUserNameView where cusid='" + id+"'";
            CusUserNameView c = DALBase<CusUserNameView>.SelectArg(sql)[0];
            return JsonTools.ToJson(c);
        }

        [WebMethod(Description = "修改客户信息")]
        public int UpdateCusInfo(string json) {
            Customers c = JsonTools.ToObject<Customers>(json);
            return DALBase<Customers>.Update(c);
        }

        [WebMethod(Description = "根据客户ID查询联系人信息")]
        public string GetLinkManByCusID(string cusid) {
            string sql = "select * from LinkMans where CusID='"+cusid+"'";
            List<LinkMans> list = DALBase<LinkMans>.SelectArg(sql);
            return JsonTools.ToJson(list);
        }

        [WebMethod(Description = "添加修改联系人信息")]
        public int Add_UpdateLinkMan(string json)
        {
            LinkMans l = JsonTools.ToObject<LinkMans>(json);
            int id = -1;
            if (l.LMID==null)
            {
                id = DALBase<LinkMans>.Insert(l);
            }
            else
            {
                l.CusID = null;
                id = DALBase<LinkMans>.Update(l);
            }
            return id;
        }

        [WebMethod(Description = "删除联系人信息")]
        public int DelLinkMan(int id) {
            return DALBase<LinkMans>.Delete(id);
        }

        [WebMethod(Description = "根据客户ID查询交往记录")]
        public string GetActByCusID(string cusid) {
            string sql = "select * from Activitys where cusid ='"+cusid+"'";
            return JsonTools.ToJson(DALBase<Activitys>.SelectArg(sql));
        }

        [WebMethod(Description = "添加修改交往记录")]
        public int UpAddAct(string json) {
            int id = -1;
            Activitys act = JsonTools.ToObject<Activitys>(json);
            if (act.ActID==null)
            {
                id = DALBase<Activitys>.Insert(act);
            }
            else
            {
                id = DALBase<Activitys>.Update(act);
            }
            return id;
        }

        [WebMethod(Description = "删除客户交往记录")]
        public int DelAct(int id) {
            return DALBase<Activitys>.Delete(id);
        }

        [WebMethod(Description = "客户流失监控")]
        public void FilterCus() {
            SqlConnection conn = new SqlConnection("server=.;uid=sa;pwd=123;database=CRM;");
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            //设置命令对象不去执行SQL语句，去执行存储过程
            cmd.CommandType = CommandType.StoredProcedure;
            //设置要执行的存储过程
            cmd.CommandText = "proc_cuslos";
            cmd.Connection = conn;
            //执行
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        [WebMethod(Description = "查询客户流失信息")]
        public string GetCusLos(string json) {
            int size = 10;
            CusLosView c = JsonTools.ToObject<CusLosView>(json);
            int index =Convert.ToInt32( c.CLID);
            StringBuilder sbwhere = new StringBuilder();
            sbwhere.Append(c.CusID.Trim().Length>0?" and CusID like '%"+c.CusID+"%' " :"");
            sbwhere.Append(c.CusName.Trim().Length > 0 ? " and CusName like '%" + c.CusName + "%' " : "");
            sbwhere.Append(c.CLDate.ToString().Trim().Length > 0 ? " and CLDate > '" + c.CLDate + "'" : "");
            sbwhere.Append(c.CLEnterDate.ToString().Trim().Length > 0 ? " and CLEnterDate > '" + c.CLEnterDate + "'" : "");
            sbwhere.Append(c.CLState > 0 ? " and CLState = " + c.CLState + " " : "");
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string sqlcount = "select count(*) from CusLosView where 1=1 "+sbwhere.ToString();
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount,null));
            dic.Add("count",count);//总记录条数
            count = count % size == 0 ? count / size : count / size + 1;
            dic.Add("page",count);//页数
            StringBuilder sb1 = new StringBuilder();
            sb1.Append("select top ");
            sb1.Append(size);
            sb1.Append(" * from CusLosView where ");
            sb1.Append(" CLID not in ( select top ");
            sb1.Append((index-1)*size);
            sb1.Append(" CLID from CusLosView where 1=1 ");
            sb1.Append(sbwhere.ToString());
            sb1.Append(" ) ");
            sb1.Append(sbwhere.ToString());
            string sql = sb1.ToString();
            List<CusLosView> cl = DALBase<CusLosView>.SelectArg(sql);
            dic.Add("list", cl);
            return JsonTools.ToJson(dic);
        }

        [WebMethod(Description = "根据客户ID查询交往记录")]
        public string GetLosByCusID(string clid)
        {
            string sql = "select * from Measures where clid =" + clid + "";
            return JsonTools.ToJson(DALBase<Measures>.SelectArg(sql));
        }

        [WebMethod(Description = "添加客户流失缓存措施")]
        public int AddMea(string json) {
            Measures m = JsonTools.ToObject<Measures>(json);
            int id = -1;
            string maxsql="select max(MeID) from Measures";
            id = DALBase<Measures>.Insert(m) > 0 ? Convert.ToInt32(SQLHelper.SelectObject(maxsql, null)) : id;
            return id;
          }

        [WebMethod(Description = "修改客户流失缓存")]
        public int UpdateMea(string json) {
               CustomLosts m = JsonTools.ToObject<CustomLosts>(json);
               m.CLEnterDate = DateTime.Now;
                  return DALBase<CustomLosts>.Update(m);
        }


    }
}
