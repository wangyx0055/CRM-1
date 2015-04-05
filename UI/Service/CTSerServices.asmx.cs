using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using DAL;
using Model;
using System.Text;

namespace UI.Service
{
    /// <summary>
    /// CTSerServices 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class CTSerServices : System.Web.Services.WebService
    {

        [WebMethod(Description="查询所有服务类型")]
        public string GetServices()
        {
            return JsonTools.ToJson(DALBase<ServiceType>.SelectArg());
        }
        [WebMethod(Description = "查询所有的正常客户编号，名字")]
        public string GetCusInfo() {
            string sql = "select * from Customers where CusState=1";
            return JsonTools.ToJson(DALBase<Customers>.SelectArg(sql));
        }
        [WebMethod(Description = "添加服务", EnableSession = true)]
        public int AddService(string json) 
        {
            int id = -1;
            CustomServices cs = JsonTools.ToObject<CustomServices>(json);
            cs.CSCreateDate = DateTime.Now;
            cs.CSCreateID = Convert.ToInt32(Session["id"]);
            cs.CSState = 1;
            string sql="select max(CSID) from CustomServices";
            id = DALBase<CustomServices>.Insert(cs) > 0 ? id = Convert.ToInt32(SQLHelper.SelectObject(sql, null)) : id;
            return id;
        }

        [WebMethod(Description = "查询所有可指派的服务")]
        public string GetServicesAll(string json) {
            int size = 10;
            CS_View c = JsonTools.ToObject<CS_View>(json);
            int index = Convert.ToInt32(c.CSID);
            StringBuilder sbwhere = new StringBuilder();
            sbwhere.Append(c.CusName.Trim().Length>0?" and CusName like '%"+c.CusName+"%' " :"");
            sbwhere.Append(c.UserName.Trim().Length > 0 ? " and UserName like '%" + c.UserName + "%' " : "");
            sbwhere.Append(c.STID > 0 ? " and STID = " + c.STID + " " : "");
            sbwhere.Append(c.CSState > 0 ? " and CSState = " + c.CSState + " " : "");
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string sqlcount = "SELECT  COUNT(*) FROM CS_View WHERE CSSTATE<3";
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount,null));
            dic.Add("count",count);
            count = count % size == 0 ? count / size : count / size + 1;
            dic.Add("page", count);
            StringBuilder sb1 = new StringBuilder();
            sb1.Append(" SELECT TOP ");
            sb1.Append(size);
            sb1.Append(" * FROM ");
            sb1.Append(" CS_VIEW ");
            sb1.Append(" WHERE ");
            sb1.Append(" CSID ");
            sb1.Append(" NOT ");
            sb1.Append(" IN( ");
            sb1.Append(" SELECT  ");
            sb1.Append(" TOP ");
            sb1.Append((index-1)*size);
            sb1.Append(" CSID ");
            sb1.Append(" FROM ");
            sb1.Append(" CS_VIEW ");
            sb1.Append(" WHERE ");
            sb1.Append(" CSSTATE<3 ");
            sb1.Append(sbwhere.ToString());
            sb1.Append(" ) AND ");
            sb1.Append(" CSSTATE<3 ");
            sb1.Append(sbwhere.ToString());
            string sql = sb1.ToString();
            List<CS_View> list = DALBase<CS_View>.SelectArg(sql);
            dic.Add("list",list);
            return JsonTools.ToJson(dic);
        }

        [WebMethod(Description = "修改服务指派人",EnableSession=true)]
        public int UpdataCSDueName(string json) {
            CustomServices cs = JsonTools.ToObject<CustomServices>(json);
            cs.CSDueDate = DateTime.Now;
            cs.CSState = 2;
            return DALBase<CustomServices>.Update(cs);
        }

         [WebMethod(Description = "查询所有需处理的服务",EnableSession =true)]
        public string GetServicesAll2(string json)
        {
            CS_View c = JsonTools.ToObject<CS_View>(json);
            int index = Convert.ToInt32(c.CSID);
            int userid = Convert.ToInt32(Session["id"]);
            StringBuilder sbwhere = new StringBuilder();
            sbwhere.Append(c.CusName.Trim().Length > 0 ? " and CusName like '%" + c.CusName + "%' " : "");
            sbwhere.Append(c.UserName.Trim().Length > 0 ? " and UserName like '%" + c.UserName + "%' " : "");
            sbwhere.Append(c.UserName2.Trim().Length > 0 ? " and UserName2 like '%" + c.UserName2 + "%' " : "");
            sbwhere.Append(c.CSDueID > 0 ? " and CSDueID = " + userid + " " : "");
            sbwhere.Append(c.STID > 0 ? " and STID = " + c.STID + " " : "");
            Dictionary<string, object> dic = new Dictionary<string, object>();
            int size = 10;
            string sqlcount = "SELECT  COUNT(*) FROM CS_View WHERE CSSTATE=2";
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount, null));
            dic.Add("count", count);
            count = count % size == 0 ? count / size : count / size + 1;
            dic.Add("page", count);
            StringBuilder sb1 = new StringBuilder();
            sb1.Append(" SELECT TOP ");
            sb1.Append(size);
            sb1.Append(" * FROM ");
            sb1.Append(" CS_VIEW ");
            sb1.Append(" WHERE ");
            sb1.Append(" CSID ");
            sb1.Append(" NOT ");
            sb1.Append(" IN( ");
            sb1.Append(" SELECT  ");
            sb1.Append(" TOP ");
            sb1.Append((index - 1) * size);
            sb1.Append(" CSID ");
            sb1.Append(" FROM ");
            sb1.Append(" CS_VIEW ");
            sb1.Append(" WHERE ");
            sb1.Append(" CSSTATE=2 ");
            sb1.Append(sbwhere.ToString());
            sb1.Append(" ) AND ");
            sb1.Append(" CSSTATE=2 ");
            sb1.Append(sbwhere.ToString());
            string sql = sb1.ToString();
            List<CS_View> list = DALBase<CS_View>.SelectArg(sql);
            dic.Add("list", list);
            return JsonTools.ToJson(dic);
        }

         [WebMethod(Description = "查询所有需反馈的服务",EnableSession =true)]
         public string GetServicesAll3(string json)
         {
            CS_View c = JsonTools.ToObject<CS_View>(json);
            int index = Convert.ToInt32(c.CSID);
            int userid = Convert.ToInt32(Session["id"]);
            StringBuilder sbwhere = new StringBuilder();
            sbwhere.Append(c.CusName.Trim().Length > 0 ? " and CusName like '%" + c.CusName + "%' " : "");
            sbwhere.Append(c.UserName.Trim().Length > 0 ? " and UserName like '%" + c.UserName + "%' " : "");
            sbwhere.Append(c.UserName2.Trim().Length > 0 ? " and UserName2 like '%" + c.UserName2 + "%' " : "");
            sbwhere.Append(c.CSDueID > 0 ? " and CSDueID = " + userid + " " : "");
            sbwhere.Append(c.STID > 0 ? " and STID = " + c.STID + " " : "");
            Dictionary<string, object> dic = new Dictionary<string, object>();
            int size = 10;
            string sqlcount = "SELECT  COUNT(*) FROM CS_View WHERE CSSTATE=3";
            int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount, null));
            dic.Add("count", count);
            count = count % size == 0 ? count / size : count / size + 1;
            dic.Add("page", count);
            StringBuilder sb1 = new StringBuilder();
            sb1.Append(" SELECT TOP ");
            sb1.Append(size);
            sb1.Append(" * FROM ");
            sb1.Append(" CS_VIEW ");
            sb1.Append(" WHERE ");
            sb1.Append(" CSID ");
            sb1.Append(" NOT ");
            sb1.Append(" IN( ");
            sb1.Append(" SELECT  ");
            sb1.Append(" TOP ");
            sb1.Append((index - 1) * size);
            sb1.Append(" CSID ");
            sb1.Append(" FROM ");
            sb1.Append(" CS_VIEW ");
            sb1.Append(" WHERE ");
            sb1.Append(" CSSTATE=3 ");
            sb1.Append(sbwhere.ToString());
            sb1.Append(" ) AND ");
            sb1.Append(" CSSTATE=3 ");
            sb1.Append(sbwhere.ToString());
            string sql = sb1.ToString();
            List<CS_View> list = DALBase<CS_View>.SelectArg(sql);
            dic.Add("list", list);
            return JsonTools.ToJson(dic);
        }

         [WebMethod(Description = "查询所有需归档的服务")]
         public string GetServicesAll4(string json)
         {
             CS_View cs=JsonTools.ToObject<CS_View>(json);
             int index =Convert.ToInt32( cs.CSID);
             StringBuilder sb = new StringBuilder();
             sb.Append(cs.STID != 0 ? " AND STID=" + cs.STID + " " : "");
             sb.Append(cs.CusName.Trim().Length!=0?" AND CUSNAME LIKE '%"+cs.CusName+"%' ":"");
             Dictionary<string, object> dic = new Dictionary<string, object>();
            int size = 10;
            string sqlcount = "SELECT  COUNT(*) FROM CS_View WHERE CSSTATE=4 "+sb.ToString();
             int count = Convert.ToInt32(SQLHelper.SelectObject(sqlcount, null));
             dic.Add("count", count);
             count = count % size == 0 ? count / size : count / size + 1;
             dic.Add("page", count);
             StringBuilder sb1 = new StringBuilder();
             sb1.Append(" SELECT TOP ");
             sb1.Append(size);
             sb1.Append(" * FROM ");
             sb1.Append(" CS_VIEW ");
             sb1.Append(" WHERE ");
             sb1.Append(" CSID ");
             sb1.Append(" NOT ");
             sb1.Append(" IN( ");
             sb1.Append(" SELECT  ");
             sb1.Append(" TOP ");
             sb1.Append((index - 1) * size);
             sb1.Append(" CSID ");
             sb1.Append(" FROM ");
             sb1.Append(" CS_VIEW ");
             sb1.Append(" WHERE ");
             sb1.Append(" CSSTATE=4 ");
             sb1.Append(sb.ToString());
             sb1.Append(" ) AND ");
             sb1.Append(" CSSTATE=4 ");
             sb1.Append(sb.ToString());
             string sql = sb1.ToString();
             List<CS_View> list = DALBase<CS_View>.SelectArg(sql);
             dic.Add("list", list);
             return JsonTools.ToJson(dic);
         }

        [WebMethod(Description="修改服务处理")]
         public int UpdateCSDeal(string json) {
             CustomServices cs = JsonTools.ToObject<CustomServices>(json);
             cs.CSState = 3;
             cs.CSDealDate = DateTime.Now;
             return DALBase<CustomServices>.Update(cs);
         }

        [WebMethod(Description="修改服务反馈")]
        public int UpdateCSRes(string json)
        {
            CustomServices cs = JsonTools.ToObject<CustomServices>(json);
            cs.CSState = 4;
            return DALBase<CustomServices>.Update(cs);
        }


    }
}
