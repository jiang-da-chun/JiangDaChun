<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Index.aspx.cs" Inherits="NetworkEducation.Index" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>软件工程与计算 @ 首页</title>
    <link href="Content/CSS/Index.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="notice">
            <div id="notice-content">       
                <h3 class="inform">    
                    通知公告栏<span>
                            <%=Session["UserType"].ToString() == "1" ? "|【<a href='AddNoticeInfor.aspx'>发布通知</a>】" : ""%></span></h3>
                <asp:Repeater ID="rptNews" runat="server">        
                    <ItemTemplate>
                        <div class="news-notice">
                            时间：<%#Eval("PostTime", "{0:f}")%>&nbsp;&nbsp;&nbsp;
                            发布人：<%#Eval("Name").ToString()%>&nbsp;&nbsp;&nbsp;
                        </div>
                        <p class="notice-main">
                            <%#Eval("Content").ToString()%></p>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <hr />
        <div id="introduce">
            <h3 class="inform">
                软件工程与计算简介</h3>
            <asp:Repeater ID="rptIndro" runat="server">
                <ItemTemplate>
                    <h4>
                        <span style="color: <%#Eval("TitleColor") %>">
                            <%#Eval("Title").ToString()%></span></h4>
                    <div class="news-info">
                        时间：<%#Eval("PostTime","{0:f}")%>&nbsp;&nbsp;&nbsp;作者：<%#Eval("Author").ToString()==""?"保密":Eval("Author").ToString()%></div>
                    <div class="news-content">
                        <%#Eval("Content").ToString()%>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="pager">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" UrlPaging="true" FirstPageText=""
                    PrevPageText="上一页" NextPageText="下一页" LastPageText="" OnPageChanged="AspNetPager1_PageChanged"
                    ShowPageIndexBox="Never" CustomInfoHTML="" PageIndexBoxType="DropDownList" TextAfterPageIndexBox="页"
                    TextBeforePageIndexBox="转向第" CustomInfoSectionWidth="27px" CustomInfoTextAlign="Right"
                    ShowCustomInfoSection="Right" UrlPageSizeName="pageSize" AlwaysShow="True" ShowNavigationToolTip="True"
                    ViewStateMode="Enabled" PagingButtonSpacing="8px" NumericButtonCount="5" ShowFirstLast="False"
                    ShowMoreButtons="False">
                </webdiyer:AspNetPager>
            </div>
        </div>
    </div>
</asp:Content>
