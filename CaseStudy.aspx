<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="CaseStudy.aspx.cs" Inherits="NetworkEducation.CaseStudy" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/CSS/Teaching.css" rel="stylesheet" type="text/css" />
    <script src="Content/Script/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="Content/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="Content/Script/jquery-querystring.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        //搜索栏的滑动
        function slideToggle() {
            $("#searchBox").slideToggle();
        }



        //当网页加载完后自动执行
        $(
            function () {
                //alert($("input[name='ctl00$mainContent$rblDevolopment']:checked").val());
                if ($("#tbKey").val() != "" || $("input[name='ctl00$mainContent$rblDevolopment']:checked").val() == "1" || $("input[name='ctl00$mainContent$rblDevolopment']:checked").val() == "0")
                {
                    $("#searchBox").show();
                }
            }
        );

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="locatin1">
            <div id="index">
                <img src="Content/Image/EducationImage/xia.gif" />&nbsp;&nbsp;&nbsp;
            </div>
            <div id="location">
                <p>
                    您当前的位置：<a href="Index.aspx">首页</a> >>在线学习 >> 案例学习 | <a href="#" onclick="slideToggle();">
                        搜索</a><span>
                            <%=Session["UserType"].ToString()=="1" ? "|【<a href='UpCase.aspx'>上传文件</a>】" : ""%></span></p>
            </div>
        </div>
        <div id="searchBox">
            查询关键字：<asp:TextBox ID="tbKey" runat="server"></asp:TextBox>
            开发方式：<asp:RadioButtonList AutoPostBack="true" RepeatDirection="Horizontal" RepeatLayout="Flow"
                ID="rblDevolopment" runat="server">
                <asp:ListItem Text="面向结构化" Value="0"></asp:ListItem>
                <asp:ListItem Text="面向对象化" Value="1"></asp:ListItem>
                <asp:ListItem Text="两者" Value="" Selected="True"></asp:ListItem>
            </asp:RadioButtonList>
            <asp:Button ID="btnSearch" runat="server" Text="查询" OnClick="btnSearch_Click" />
        </div>
        <div id="xian">
            <hr />
        </div>
        <asp:Repeater ID="rptCase" runat="server">
            <HeaderTemplate>
                <table id="teaching-list">
                    <tr class="teaching-content">
                        <th>
                            标题
                        </th>
                        <th>
                            发布人
                        </th>
                        <th>
                            开发方式
                        </th>
                        <th>
                            点击率
                        </th>
                        <th>
                            上传时间
                        </th>
                        <th>
                            下载
                        </th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <span style="color: <%#Eval("TitleColor").ToString()%>">
                            <%#Eval("Title").ToString()%></span>
                    </td>
                    <td>
                        <%#Eval("NickName").ToString()%>
                    </td>
                     <td>
                        <%#(bool)Eval("Develop")?"面向对象化":"面向结构化"%>
                    </td>
                    <td>
                        <%#Eval("ViewCount").ToString()%>
                    </td>
                    <td>
                        <%#Eval("PostTime", "{0:f}").ToString()%>
                    </td>
                    <td>
                        <%#Eval("Content").ToString()%>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <div class="pager">
            <webdiyer:AspNetPager ID="AspNetPager1" runat="server" UrlPaging="true" FirstPageText=""
                PrevPageText="上一页" NextPageText="下一页" LastPageText="" ShowPageIndexBox="Never"
                CustomInfoHTML="" PageIndexBoxType="DropDownList" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转向第"
                CustomInfoSectionWidth="27px" CustomInfoTextAlign="Right" ShowCustomInfoSection="Right"
                UrlPageSizeName="pageSize" AlwaysShow="True" ShowNavigationToolTip="True" ViewStateMode="Enabled"
                PagingButtonSpacing="8px" NumericButtonCount="5" ShowFirstLast="False" ShowMoreButtons="False"
                OnPageChanged="AspNetPager1_PageChanged">
            </webdiyer:AspNetPager>
        </div>
    </div>
</asp:Content>
