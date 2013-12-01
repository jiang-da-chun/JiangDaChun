using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using NetworkEducation.DBConnection;

namespace NetworkEducation.Admin
{
    /// <summary>
    /// DeleteAll 的摘要说明，这是一般处理程序
    /// </summary>
    public class DeleteAll : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (string.IsNullOrEmpty(context.Request["ids"]))
            {
                context.Response.End();
            }

            if (string.IsNullOrEmpty(context.Request["tableName"]))
            {
                context.Response.End();
            }

            string tableName = context.Request["tableName"];
            string ids = context.Request["ids"];//数组ids之间是以逗号“，”隔开的

            ids = ids.Remove(ids.Length - 1);//因为此数组中最后有一个逗号“，”，需要去除
            string sql = string.Format("delete from {0} where id in ({1})", tableName, ids);
            SqlHelper.ExecuteNonQuery(sql, null);
            context.Response.Redirect(context.Request.UrlReferrer.ToString());//获取有关客户端上次请求的URL信息，该请求链接到当前的URL
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}