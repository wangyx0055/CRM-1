using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Data.SqlClient;
using System.Data;
using System.Reflection;


namespace DAL
{
 
    /// <summary>
    ///  万能数据操作类
    /// </summary>
    /// <typeparam name="T">类型泛型</typeparam>
   public class DALBase<T> where T:ModelBase
   {
       #region 查询所有
                //  查询所有
                //  return  返回查询对象集合
               public static List<T> SelectArg() {
                   List<T> list = new List<T>();
                   //反射得到类型
                   Type t=typeof(T);
                   string sql = "select * from "+t.Name;
                   using (SqlDataReader sd=SQLHelper.SelectReader(sql,null))
                   {

                       while (sd.Read())
                       {
                           //动态创建一个实例
                           T obj = Activator.CreateInstance<T>();
                           //反射得到一个对象
                           Type t1 = obj.GetType();
                           //通过类型对象获取所有的公有属性
                           PropertyInfo[] ppti = t1.GetProperties();
                           //遍历查询结果中的列
                           for (int i = 0; i < sd.FieldCount; i++)
                           {
                               //获取查询结果中列的名字
                               string f_name = sd.GetName(i);
                               foreach (PropertyInfo p in ppti)
                               {
                                   if (f_name.ToLower() == p.Name.ToLower())
                                   {
                                       if (sd[f_name] != DBNull.Value)
                                       {
                                           p.SetValue(obj, sd[f_name], null);
                                       }
                                       else
                                       {
                                           p.SetValue(obj, null, null);
                                       }
                                       break;
                                   }
                               }
                           }
                           list.Add(obj);
                       }
                   }
                   return list;
               }
       #endregion

       #region 添加
               /// <summary>
               /// 添加方法
               /// </summary>
               /// <returns></returns>
               public static int Insert(ModelBase mb) {
                   StringBuilder sb = new StringBuilder();//主sql语句
                   StringBuilder sb1 = new StringBuilder();//sql语句参数名字
                   List<SqlParameter> ps = new List<SqlParameter>();//参数集合
                   sb.Append("insert into ");
                   Type t=typeof(T);//反射得到类型
                   sb.Append(t.Name);
                   sb.Append("(");
                   Type t1 = mb.GetType();//反射获取一个对象
                   PropertyInfo[] pt = t1.GetProperties();//由对象获取属性对象数组
                   for (int i = 0; i < pt.Length; i++)//遍历这个数组
                   {
                       if (pt[i].GetValue(mb,null)!=null)//判断这个属性是否有值
                       {
                           sb.Append(pt[i].Name);
                           sb.Append(",");
                           sb1.Append("@" + pt[i].Name);
                           sb1.Append(",");
                           ps.Add(new SqlParameter("@"+pt[i].Name,pt[i].GetValue(mb,null)));
                       }
                   }
                   sb.Remove(sb.Length-1,1);
                   sb1.Remove(sb1.Length - 1, 1);
                   sb.Append(")");
                   sb.Append(" values ("+sb1.ToString()+")");
                   //调用sqlhelper类的方法并返回
                   return SQLHelper.CUD(sb.ToString(),ps.ToArray());
               }
       #endregion

       #region 修改
               public static int Update(ModelBase mb) {
                   StringBuilder sb = new StringBuilder();
                   List<SqlParameter> ps = new List<SqlParameter>();
                   sb.Append(" update ");
                   Type t=typeof(T);
                   string tableName = t.Name;
                   sb.Append(tableName);//表名
                   sb.Append(" set ");
                   Type t1 = mb.GetType();
                   PropertyInfo[] pt = t1.GetProperties();//属性对象数组
                   string keyName = "";
                   object[] objs = t1.GetCustomAttributes(true);
                   if (objs.Length>0)
                   {
                       keyName = (objs[0] as KeyInfoAttribute).KeyName;//获取主键名
                   }
                   else
                   {
                       throw new Exception("没有标明主键特性");
                   }
                   foreach (PropertyInfo p in pt)
                   {
                       if (p.GetValue(mb,null)!=null)//如果属性不为空
                       {
                           if (p.Name.ToLower()!=keyName.ToLower())//如果当前属性不是主键
                           {
                               sb.Append(p.Name);
                               sb.Append("=@"+p.Name);
                               sb.Append(",");
                               ps.Add(new SqlParameter("@" + p.Name,p.GetValue(mb,null)));
                           }
                           else
                           {
                               ps.Add(new SqlParameter("@" + keyName, p.GetValue(mb, null)));
                           }
                       }
                   }
                   sb.Remove(sb.Length-1,1);
                   sb.Append(" where ");
                   sb.Append(keyName);
                   sb.Append("=@"+keyName);
                   string sql = sb.ToString();
                   return SQLHelper.CUD(sql,ps.ToArray());
               }        

       #endregion

       #region 条件删除
               public static int Delete(ModelBase mb) {
                   Type t=typeof(T);
                   StringBuilder sb = new StringBuilder();
                   List<SqlParameter> ps = new List<SqlParameter>();
                   sb.Append(" delete from ");
                   sb.Append(t.Name);
                   sb.Append(" where 1=1 ");
                   Type t1 = mb.GetType();
                   PropertyInfo[] pt = t1.GetProperties();
                   foreach (PropertyInfo p in pt)
                   {
                       if (p.GetValue(mb,null)!=null)
                       {
                           sb.Append(" and ");
                           sb.Append(p.Name);
                           sb.Append("  = ");
                           sb.Append("@"+p.GetValue(mb,null));
                           sb.Append(",");
                           ps.Add(new SqlParameter("@"+p.GetValue(mb,null),p.GetValue(mb,null)));
                       }
                   }
                   sb.Remove(sb.Length-1,1);
                   string sql = sb.ToString();//sql语句
                   return SQLHelper.CUD(sql,ps.ToArray());
               }
       #endregion

       #region 按主键删除
               public static int Delete(Object key) { 
                Type t=typeof(T);
                StringBuilder sb = new StringBuilder();
                string keyName = "";
                object[] objs = t.GetCustomAttributes(true);
                if (objs.Length>0)
                {
                    keyName = (objs[0] as KeyInfoAttribute).KeyName;
                }
                else
                {
                    throw new Exception("没有标明主键特性");
                }
                sb.Append(" delete ");
                sb.Append(t.Name);
                sb.Append(" where ");
                sb.Append(keyName);
                sb.Append(" = ");
                sb.Append(" @");
                sb.Append(keyName);
                string sql = sb.ToString();
                SqlParameter[] ps = new SqlParameter[] {
                    new SqlParameter("@"+keyName,key)
                };
                return SQLHelper.CUD(sql,ps);
               }
       #endregion

       #region 条件查询
               public static List<T> SelectArg(string sql)
               {
                   List<T> list = new List<T>();
                   using (SqlDataReader sd = SQLHelper.SelectReader(sql, null))
                   {
                       while (sd.Read())
                       {
                           //动态创建一个实例
                           T obj = Activator.CreateInstance<T>();
                           //反射得到一个对象
                           Type t1 = obj.GetType();
                           //通过类型对象获取所有的公有属性
                           PropertyInfo[] ppti = t1.GetProperties();
                           //遍历查询结果中的列
                           for (int i = 0; i < sd.FieldCount; i++)
                           {
                               //获取查询结果中列的名字
                               string f_name = sd.GetName(i);
                               foreach (PropertyInfo p in ppti)
                               {
                                   if (f_name.ToLower() == p.Name.ToLower())
                                   {
                                       if (sd[f_name] != DBNull.Value)
                                       {
                                           p.SetValue(obj, sd[f_name], null);
                                       }
                                       else
                                       {
                                           p.SetValue(obj, null, null);
                                       }
                                       break;
                                   }
                               }
                           }
                           list.Add(obj);
                       }
                   }
                   return list;
               }
       #endregion

       #region 个数聚合函数查询 
                /// <summary>
               /// 个数聚合函数查询 
                /// </summary>
                /// <returns>个数</returns>
               public static int GetCount() { 
                    Type t=typeof(T);
                    string sql = string.Format("select count(*) from {0}",t.Name);
                    return Convert.ToInt32( SQLHelper.SelectObject(sql,null));
               }
       #endregion

       #region 聚合函数查询
       /// <summary>
       /// 聚合函数查询
       /// state{
       ///  max=1
       ///  min=2,
       ///  avg=3
       ///  sum=4
       /// }
       /// </summary>
       /// <param name="mb">模型对象</param>
       /// <param name="state">集合函数</param>
       /// <returns></returns>
               public static object GetGroup(ModelBase mb,int state) {
                   Type t = typeof(T);
                   string maxName = "";
                   PropertyInfo[] pt = t.GetProperties();
                   foreach (PropertyInfo p in pt)
                   {
                       if (p.GetValue(mb,null)!=null)
                       {
                           maxName = p.Name;
                           break;
                       }
                   }
                   string sql = string.Format(" select {2}({0}) from {1}", maxName, t.Name, (ModelBase.GroupState)state);
                   try
                   {
                       return SQLHelper.SelectObject(sql, null);
                   }
                   catch (Exception)
                   {
                       throw new Exception("参数错误！！！");
                   }
               }
       #endregion



   }
}
