using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Configuration;
using System.Data;


namespace NetworkEducation.DBConnection
{
    public class SqlHelper
    {

        #region 数据插入、删除、修改
        /// <summary>
        /// 通用的函数，能完成插入、删除和修改操作，通过传入的sql语句区分操作类型
        /// </summary>
        /// <param name="sql">传入的sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>true：表示插入成功；false：表示插入失败</returns>
        public static bool ExecuteNonQuery(string sql, Dictionary<string, object> parameters)
        {
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
                if (con.State == System.Data.ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = sql;
                if (parameters != null)
                {
                    foreach (var item in parameters)
                    {
                        cmd.Parameters.AddWithValue(item.Key, item.Value);
                    }
                }
                cmd.ExecuteNonQuery();//返回受影响的行数
                return true; //return cmd.ExecuteNonQuery()>0;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        #endregion

        #region 返回首行首列的值
        /// <summary>
        /// 通用的函数，返回查询结果表中的首行首列的值
        /// </summary>
        /// <param name="sql">传入的sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>首行首列的值</returns>
        public static object ExecuteScalar(string sql, Dictionary<string, object> parameters)
        {
            /*使用using语句，定义一个范围，在范围结束时处理对象。(不过该对象必须实现了IDisposable接口)。其功能和try,catch,Finally完全相同。
这里con对象都默认实现了IDisposable接口*/
            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
                if (con.State == System.Data.ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = sql;
                if (parameters != null)
                {
                    foreach (var item in parameters)
                    {
                        cmd.Parameters.AddWithValue(item.Key, item.Value);
                    }
                }

                object r = cmd.ExecuteScalar();//返回查询结果表中首行首列的值
                return r;
            }
        }
        #endregion

        #region 使用适配器或阅读器查询数据

        /// <summary>
        /// 通过阅读器阅读数据
        /// </summary>
        /// <param name="sql">传入的sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>阅读器</returns>
        public static SqlDataReader ExecuteReader(string sql, Dictionary<string, object> parameters)
        {
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
                if (con.State == System.Data.ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                if (parameters != null)
                {
                    foreach (var item in parameters)
                    {
                        cmd.Parameters.AddWithValue(item.Key, item.Value);
                    }
                }

                SqlDataReader dr = cmd.ExecuteReader();//阅读器对象dr指向了XXX表的标头，还不知道是否有数据
                return dr;
            }
            catch (Exception)
            {

                throw;
            }
            //finally 如果关闭数据库，则阅读器没有办法读取数据;
            //{
            //    if (con.State == System.Data.ConnectionState.Open)
            //    {
            //        con.Close();
            //    }
            //}           
        }

        /// <summary>
        /// 通过适配器查询，返回一个数据集市
        /// </summary>
        /// <param name="sql">传入的Sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>执行成功，返回数据集市；失败返回null</returns>
        public static DataSet GetDataSet(string sql, Dictionary<string, object> parameters)
        {
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;

                //if (con.State== System.Data.ConnectionState.Closed)适配器会根据具体需要打开和关闭数据库
                //{
                //    con.Open();
                //}

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = System.Data.CommandType.Text;//此时可以不写，因为默认情况下就是Text类型
                cmd.CommandText = sql;
                if (parameters != null)
                {
                    foreach (var item in parameters)
                    {
                        cmd.Parameters.AddWithValue(item.Key, item.Value);
                    }
                }

                SqlDataAdapter da = new SqlDataAdapter();//创建一个适配器，它会根据具体的需要打开和关闭数据库
                da.SelectCommand = cmd;

                DataSet ds = new DataSet();//创建一个数据集市
                da.Fill(ds, "Infor");//适配器将查询出来的数据填充到数据集市ds中去；第二个参数 String是指定 DataSet 里表的名字，指定后，以后就可以这样调用这张表 DataSet.Tables["表名"] ；第二个参数可以不要的，如果不要第二个参数 String  那你调用这张表只能通过索引号，例如 DataSet.Tables[0]  如果填充的表比较多的话，用这个参数比较容易管理和调用。

                return ds;

            }
            catch (Exception)
            {

                throw;
            }
        }

        /// <summary>
        /// 通过适配器查询，返回一个数据表
        /// </summary>
        /// <param name="sql">传入的Sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>执行成功，返回数据表；失败返回null</returns>
        public static DataTable GetDataTable(string sql, Dictionary<string, object> parameters)
        {
            //DataTable dt = SqlHelper.GetDataSet(sql,parameters).Tables[0];
            //return dt; 这可是最简洁的写法

            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;

                //if (con.State== System.Data.ConnectionState.Closed)适配器会根据具体需要打开和关闭数据库
                //{
                //    con.Open();
                //}

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = sql;
                cmd.CommandType = System.Data.CommandType.Text;
                if (parameters != null)
                {
                    foreach (var item in parameters)
                    {
                        cmd.Parameters.AddWithValue(item.Key, item.Value);
                    }
                }

                SqlDataAdapter da = new SqlDataAdapter();//创建一个适配器,它会根据具体需要打开和关闭数据库
                da.SelectCommand = cmd;

                DataTable dt = new DataTable();
                da.Fill(dt);

                return dt;
            }
            catch (Exception)
            {

                throw;
            }

        }

        #endregion

    }
}