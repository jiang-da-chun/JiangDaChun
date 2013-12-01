<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Teaching.aspx.cs" Inherits="NetworkEducation.Teaching" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/CSS/Teaching.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="answer">
            <div id="index">
                <img src="Content/Image/EducationImage/xia.gif" />&nbsp;&nbsp;&nbsp;
            </div>
            <div id="location">
                <p>
                    您当前的位置：<a href="Index.htm">首页</a> >>教学材料</p>
            </div>
            <div id="logo">
                <div id="logo-question">      
                    <div id="logo-answer">
                        <span id="answerContent">
                            <%=Session["UserType"].ToString()=="1"?"【<a href='UpTeaching.aspx'>上传文件</a>】" :""%></span>
                    </div>
                </div>
            </div>
        </div>
        <div id="xian">
            <hr />
        </div>
        <asp:Repeater ID="rptTeaching" runat="server">
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
                        <%#Eval("ViewCount").ToString()%>
                    </td>
                    <td>
                        <%#Eval("PostTime", "{0:f}").ToString()%>
                    </td>
                    <td>
                        <%#Eval("LinkContent").ToString()%>
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
                PagingButtonSpacing="8px" NumericButtonCount="5" ShowFirstLast="False" ShowMoreButtons="False">
            </webdiyer:AspNetPager>
        </div>
    </div>
</asp:Content>
