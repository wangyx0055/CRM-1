using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using DAL;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    /// <summary>
    /// 数据库操作类
    /// </summary>
    public class SQLHelper
    {
        public static readonly string connstr = System.Configuration.ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        /// <summary>
        /// 增加，删除，修改的方法
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="ps"></param>
        /// <returns></returns>
        public static int CUD(string sql,SqlParameter [] ps) { 
            using(SqlConnection conn=new SqlConnection(connstr)){
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql,conn);
                if (ps!=null)
                {
                    cmd.Parameters.AddRange(ps);
                }
                return cmd.ExecuteNonQuery();
            }
        }


        /// <summary>
        /// 查询的方法
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="ps"></param>
        /// <returns></returns>
        public static SqlDataReader SelectReader(string sql,SqlParameter [] ps) {
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql,conn);
            if (ps!=null)
            {
                cmd.Parameters.AddRange(ps);
            }
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        /// <summary>
        /// 返回表结果集的查询方法
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="ps"></param>
        /// <returns></returns>
        public static DataTable SelectTable(string sql) {
            using (SqlConnection conn=new SqlConnection(connstr))
            {
                SqlDataAdapter sda = new SqlDataAdapter(sql,conn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
        }

        /// <summary>
        /// 返回单行单列的查询
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="ps"></param>
        /// <returns></returns>
        public static object SelectObject(string sql,SqlParameter [] ps) {
            using (SqlConnection conn=new SqlConnection(connstr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql,conn);
                if (ps!=null)
                {
                    cmd.Parameters.AddRange(ps);
                }
                return cmd.ExecuteScalar();
            }
        }

        


    }
}
