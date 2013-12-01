<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfoList.aspx.cs" Inherits="NetworkEducation.Admin.UserInfoList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="../Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet"
        type="text/css" />
    <link href="CSS/UserInfoList.css" rel="stylesheet" type="text/css" />
    <script src="../Content/Script/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="../Content/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="../Content/Script/jquery-querystring.js" type="text/javascript"></script>
    <script type="text/javascript">

        //打开编辑窗口，调用此函数将弹出一个窗口
        function OpenEdit(obj) {/*当使用onclick调用此函数时，要传一个this过来，此时用obj来接收；当是$("#id").click(function(){})这种调用方式可以不需要传this指针*/
            var p = {
                url: obj.href,
                title: obj.innerHTML,
                width: $(obj).attr("w") || 400,
                height: $(obj).attr("h") || 200,
                isResize: true
            };
            $.ligerDialog.open(p);
            return false;
        }

        //关闭编辑窗口
        function CloseEdit() {
            location.href = location.href; //设置当前浏览器窗口的URL为之前的URL，相当于刷新页面，刷新后的页码和页码大小的值不变。
            //location.href中既有目标网页，同时也包含参数及参数的值
        }

        //关闭添加信息的窗口
        function CloseAdd() {
            location.href = location.pathname + $.query.set("page", 1);
        }

        //删除行数据
        function DeleteData(id) {
            if (confirm("确认删除吗？")) {
                location.href = location.pathname + $.query.set("id", id);
                //location.pathname只包含目标网页的路径，如"/Admin/UserInfoList.aspx"，不包含参数和参数值
                //$.query.set(key,value)方法会自动保留之前的所有url中的参数以及参数值，然后再修改指定的"id"参数值
            }
        }

        //搜索栏的滑动
        function slideToggle() {
            $("#search").slideToggle();
        }


        //总的复选框（全选或取消）
        function IsSelectedAll(obj) {
            var ckbArray = $("input[name='DelBox']");
            for (var i = 0; i < ckbArray.length; i++) {
                ckbArray[i].checked = obj.checked;
            }
            SetRowBackGroundColor();
        }

        //给选中行加上背景色
        function SetRowBackGroundColor() {
            $("tbody > tr").removeClass("tr-background");
            $("tbody > tr:has(:checked)").addClass("tr-background");
        }

        /*批量删除*/
        function DeleteSelected(tableName) {
            var ckbArray = $("input[name='DelBox']:checked");
            if (ckbArray.length == 0) {
                alert("请选择要删除的数据行！");
                return false;
            }

            if (!confirm("确认删除吗？")) {
                return false;
            }

            var ids = "";
            for (var i = 0; i < ckbArray.length; i++) {
                ids += ckbArray[i].value + ","; //数组元素之间用","隔开
            }

            location.href = "DeleteAll.ashx?tableName=" + tableName + "&ids=" + ids;
        }


        //当网页加载完后自动执行
        $(
            function () {
                //alert($("input[name='rblUserType']:checked").val());
                if ($("#tbKey").val() != "" || $("input[name='rblUserType']:checked").val() == "1" || $("input[name='rblUserType']:checked").val() == "0") {
                    $("#search").show();
                }
            }
        );

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="list">
        <div id="nav-list">
            <a onclick="return OpenEdit(this);" w="500" h="420" href="AddUserInfor.aspx">添加信息</a>
            | <a href="#" onclick="DeleteSelected('UserInfor');">批量删除</a> | <a href="#" onclick="slideToggle();">
                搜索</a>
        </div>
        <div id="search">
            查询关键字：<asp:TextBox ID="tbKey" runat="server"></asp:TextBox>
            用户类别：<asp:RadioButtonList AutoPostBack="true" RepeatDirection="Horizontal" RepeatLayout="Flow"
                ID="rblUserType" runat="server">
                <asp:ListItem Text="学生" Value="0"></asp:ListItem>
                <asp:ListItem Text="老师" Value="1"></asp:ListItem>
                <asp:ListItem Text="两者" Value="" Selected="True"></asp:ListItem>
            </asp:RadioButtonList>
            <asp:Button ID="btnSearch" runat="server" Text="查询" OnClick="btnSearch_Click" />
        </div>
        <asp:Repeater ID="rptMessage" runat="server">
            <HeaderTemplate>
                <table id="main-list">
                    <tr>
                        <th>
                            <input onclick="IsSelectedAll(this);" title="全选/取消" id="Checkbox1" type="checkbox" />
                        </th>
                        <th>
                            编号
                        </th>
                        <th>
                            登录名
                        </th>
                        <th>
                            昵称
                        </th>
                        <th>
                            性别
                        </th>
                        <th>
                            QQ
                        </th>
                        <th>
                            地址
                        </th>
                        <th>
                            用户类型
                        </th>
                        <th>
                            联系方式
                        </th>
                        <th>
                            操作
                        </th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="check-box">
                        <input onclick="SetRowBackGroundColor();" value="<%#Eval("id").ToString() %>" name="DelBox"
                            id="Checkbox2" type="checkbox" />
                    </td>
                    <td>
                        <%#Eval("RowNo")%>
                    </td>
                    <td>
                        <%#Eval("LoginName").ToString()%>
                    </td>
                    <td>
                        <%#Eval("NickName").ToString()%>
                    </td>
                    <td>
                        <%#Eval("Gender").ToString() == "" ? "保密" : (bool)Eval("Gender")?"先生":"女士"%>
                    </td>
                    <td>
                        <%#Eval("QQ").ToString() == "" ? "保密" : Eval("QQ")%>
                    </td>
                    <td>
                        <%#Eval("Address").ToString() == "" ? "保密" : Eval("Address").ToString()%>
                    </td>
                    <td>
                        <%#(bool)Eval("UserType") == true ? "老师" : "学生"%>
                    </td>
                    <td>
                        <%#Eval("PhoneNumber").ToString() == "" ? "保密" : Eval("PhoneNumber")%>
                    </td>
                    <td>
                        <a onclick="return OpenEdit(this);" w="500" h="335" href="ModifyUserInfor.aspx?id=<%#Eval("id").ToString() %>">
                            <img title="编辑" src="../Content/Image/EducationImage/edit.png" /></a> | <a href="#"
                                onclick="DeleteData(<%#Eval("id").ToString() %>);">
                                <img title="删除" src="../Content/Image/EducationImage/delete.png" /></a>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <div class="pager">
            <webdiyer:AspNetPager ID="AspNetPager1" runat="server" UrlPaging="true" FirstPageText="首页"
                PrevPageText="上一页" NextPageText="下一页" LastPageText="尾页" OnPageChanged="AspNetPager1_PageChanged"
                ShowPageIndexBox="Always" CustomInfoHTML="页大小：&lt;a href=&quot;?pageSize=5&quot;&gt;5&lt;/a&gt;|&lt;a href=&quot;?pageSize=10&quot;&gt;10&lt;/a&gt; 第%CurrentPageIndex%/%PageCount%页，共%RecordCount%条数据"
                PageIndexBoxType="DropDownList" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转向第"
                CustomInfoSectionWidth="270px" CustomInfoTextAlign="Right" ShowCustomInfoSection="Right"
                UrlPageSizeName="pageSize" AlwaysShow="True" ShowNavigationToolTip="True" ViewStateMode="Enabled"
                PagingButtonSpacing="8px">
            </webdiyer:AspNetPager>
        </div>
    </div>
    </form>
</body>
</html>
