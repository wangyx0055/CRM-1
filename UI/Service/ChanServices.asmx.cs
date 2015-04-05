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
    /// ChanServices 的摘要说明
    /// 
    /// 
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。  
     [System.Web.Script.Services.ScriptService]
    public class ChanServices : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true, Description = "添加销售机会（-1失败，大于0成功）")]
        public int AddChances(string json)
        {

            Chances chan = JsonTools.ToObject<Chances>(json);
            chan.ChanState = 1;
            chan.ChanCreateMan=Convert.ToInt32(Session["id"]);
            int id = -1;
            if (chan.ChanID==null)//当ID为null时为添加
            {
                if (DALBase<Chances>.Insert(chan) > 0)
                {
                    Chances c = new Chances()
                    {
                        ChanID = 1
                    };
                    //得到添加后的主键ID
                    id = Convert.ToInt32(DALBase<Chances>.GetGroup(c, 1));
                }
            }
            else//修改
            {
                if (DALBase<Chances>.Update(chan)>0)
                {
                    id = 1;
                }
            }
            
            return id;

        }
      
        [WebMethod(Description = "分页查询所有未分配销售机会")]
        public string GetChancesAll(string json) {
            Chances ch = JsonTools.ToObject<Chances>(json);
            int index =Convert.ToInt32( ch.ChanID);
            StringBuilder sbwhere = new StringBuilder();
            sbwhere.Append(ch.ChanName.Trim().Length>0?" and ChanName like '%"+ch.ChanName+"%'" : "");
            sbwhere.Append(ch.ChanLinkMan.Trim().Length > 0 ? " and ChanLinkMan like '%" + ch.ChanLinkMan + "%'" : "");
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string sqlcount = "select count(*) from Chances where ChanState=1 " + sbwhere.ToString() ;
            int page = Convert.ToInt32(SQLHelper.SelectObject(sqlcount,null));
            dic.Add("count",page);
            page = page % 10 == 0 ? page / 10 : page / 10 + 1;
            string sql = "select top 10 * from Chances where  ChanState=1 and ChanID not in(select top " + (index - 1) * 10 + " ChanID from Chances where ChanState=1"+sbwhere.ToString()+" ) "+sbwhere.ToString();
            List<Chances> list = DALBase<Chances>.SelectArg(sql);
            dic.Add("page",page);
            dic.Add("list",list);
            return JsonTools.ToJson(dic);

        }

         [WebMethod(Description = "分页查询所有销售机会",EnableSession =true)]
        public string GetChancesAllRe(string  json)
        {
            ChanUNameView ch = JsonTools.ToObject<ChanUNameView>(json);
            int index =Convert.ToInt32( ch.ChanID);
            int userid = Convert.ToInt32(Session["id"]);
            StringBuilder sbwhere = new StringBuilder();
            sbwhere.Append(ch.ChanName.Trim().Length>0?" and ChanName like '%"+ch.ChanName+"%'":"");
            sbwhere.Append(ch.ChanLinkMan.Trim().Length > 0 ? " and ChanLinkMan like '%" + ch.ChanLinkMan + "%'" : "");
            sbwhere.Append(ch.UserName2.Trim().Length > 0 ? " and UserName2 like '%" + ch.UserName2 + "%'" : "");
            sbwhere.Append(ch.ChanState > 0 ? " and ChanState =" + ch.ChanState + "" : "");
            sbwhere.Append(ch.ChanDueMan > 0 ? " and ChanDueMan =" + userid + "" : "");
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string sqlcount = "select count(*) from ChanUNameView where ChanState!=1 "+sbwhere.ToString();
            int page = Convert.ToInt32(SQLHelper.SelectObject(sqlcount, null)); 
            dic.Add("count", page);
            page = page % 10 == 0 ? page / 10 : page / 10 + 1;
            string sql = "select top 10 * from ChanUNameView where  ChanState!=1 and ChanID not in(select top " + (index - 1) * 10 + " ChanID from ChanUNameView where ChanState!=1 "+sbwhere.ToString()+" ) "+sbwhere.ToString();
            List<ChanUNameView> list = DALBase<ChanUNameView>.SelectArg(sql);
            dic.Add("page", page);
            dic.Add("list", list);
            return JsonTools.ToJson(dic);
        }

        [WebMethod(Description = "根据ID删除销售机会信息")]
        public bool DelChances(int id) {
            return DALBase<Chances>.Delete(id)>0;
        }

        [WebMethod(Description="查询ChanNameView视图")]
        public string GetChanNameViewAll(string rtjs) {
            ChanUNameView cuv = JsonTools.ToObject<ChanUNameView>(rtjs);
            Dictionary<string, object> dic = new Dictionary<string, object>();
            StringBuilder sbcount = new StringBuilder();
            StringBuilder sqlwhere = new StringBuilder();//条件
            sqlwhere.Append(cuv.ChanName.Trim().Length != 0 ? " and ChanName like '%" + cuv.ChanName + "%'" : "");
            sqlwhere.Append(cuv.ChanLinkMan.Trim().Length != 0 ? " and ChanLinkMan like '%" + cuv.ChanLinkMan + "%'" : "");
            sqlwhere.Append(cuv.UserName.Trim().Length != 0 ? " and UserName like '%" + cuv.UserName + "%'" : "");
            sqlwhere.Append(cuv.UserName2.Trim().Length != 0 ? " and UserName2 like '%" + cuv.UserName2 + "%'" : "");
            sqlwhere.Append(cuv.ChanState> 0 ? " and ChanState = " + cuv.ChanState + "" : "");
            //查询个数
            sbcount.Append("select count(*) from ChanUNameView where ChanState<3  ");
            sbcount.Append(sqlwhere.ToString());
            int page =Convert.ToInt32( SQLHelper.SelectObject(sbcount.ToString(), null));
            dic.Add("count", page);
            page = page % 10 == 0 ? page / 10 : page / 10 + 1;
            int index = Convert.ToInt32(cuv.ChanID);
            StringBuilder sb1 = new StringBuilder();//主sql语句
            StringBuilder sb2 = new StringBuilder();//子sql语句
            sb1.Append("select top 10 * from ChanUNameView where ChanState<3  and ChanID not in( ");
            sb2.Append(" select top " + (index - 1) * 10 + " ChanID from ChanUNameView where ChanState<3  ");
            sb2.Append(sqlwhere.ToString());
            sb1.Append(sb2.ToString() + ")");
            sb1.Append(sqlwhere.ToString());
            string sql = sb1.ToString();
            List<ChanUNameView> list = DALBase<ChanUNameView>.SelectArg(sql);
            dic.Add("page", page);
            dic.Add("list", list);
            return JsonTools.ToJson(dic);
        }

        [WebMethod(Description="查询所有的用户信息")]
        public string GetUserNameAll(int roleid) {
            string sql = "select * from Users where roleid="+roleid;
            return JsonTools.ToJson(DALBase<Users>.SelectArg(sql));
        }
        [WebMethod(Description="修改分配人")]
        public int UpdataChanDueName(string json) {
            Chances ch = JsonTools.ToObject<Chances>(json);
            ch.ChanState = 2;
            return DALBase<Chances>.Update(ch);
        }

        [WebMethod(Description = "添加或修改销售计划")]
        public int AddPlanUpdate(string json) {
            Plans p = JsonTools.ToObject<Plans>(json);
            int id = -1;
            if (p.PlanID==null)//添加
            {
                if (DALBase<Plans>.Insert(p)>0)
                {
                    Plans ps = new Plans() { 
                      PlanID=1 
                    };
                    id =Convert.ToInt32( DALBase<Plans>.GetGroup(ps, 1));
                }
            }
            else//修改
            {
                p.PlanResultDate = DateTime.Now;
                id = DALBase<Plans>.Update(p) > 0 ? 1 : id;
            }
            return id;
        }

        [WebMethod(Description = "根据ID查询销售计划")]
        public string GetPlanByID(int id) {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string sql = "select * from plans where chanid="+id;
            dic.Add("list", DALBase<Plans>.SelectArg(sql));
            string sqlcount="select count(*) from plans where ChanID="+id+" and PlanResult is null";
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount, null));
            dic.Add("count",count);
            string sqlch = "select * from chances where chanid ="+id;
            Chances ch = DALBase<Chances>.SelectArg(sqlch)[0];
            dic.Add("ch",ch);
            return JsonTools.ToJson(dic);
        }

        [WebMethod(Description="开发客户成功")]
        public int AddCustom(string json)
        {
            #region  执行存储过程
            //SqlConnection conn = new SqlConnection("server=.;uid=sa;pwd=123;database=CRM;");
            //conn.Open();
            //SqlCommand cmd = new SqlCommand();
            ////设置命令对象不去执行SQL语句，去执行存储过程
            //cmd.CommandType = CommandType.StoredProcedure;
            ////设置要执行的存储过程
            //cmd.CommandText = "proc_addcustom";
            //cmd.Connection = conn;
            ////参数
            //SqlParameter p1 = new SqlParameter("@chanid", SqlDbType.Int);
            //p1.Value = chanid;
            //p1.Direction = ParameterDirection.Output;//指定参数的类型是输出
            //cmd.Parameters.Add(p1);
            ////执行
            //cmd.ExecuteNonQuery();
            //conn.Close();
            //return Convert.ToInt32(cmd.Parameters["@chanid"].Value);
        #endregion
            Chances ch = JsonTools.ToObject<Chances>(json);
            return DALBase<Chances>.Update(ch);
        }

        [WebMethod(Description = "开发失败")]
        public int SetError(string json) {
            Chances ch = JsonTools.ToObject<Chances>(json);
            return DALBase<Chances>.Update(ch);
        }


    }
}
