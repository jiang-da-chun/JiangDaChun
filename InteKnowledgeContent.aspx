<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="InteKnowledgeContent.aspx.cs" Inherits="NetworkEducation.InteKnowledgeContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>软件工程与计算 @ 课程学习内容</title>
    <link href="Content/CSS/CourseStudyContent.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="answer">
            <div id="index">
                <img src="Content/Image/EducationImage/xia.gif" />&nbsp;&nbsp;&nbsp;
            </div>
            <div id="location">
                <p>
                    您当前的位置：<a href="Index.aspx">首页</a> >>在线学习 >> 课程内容分享</p>
            </div>
            <div id="logo">
                <div id="logo-question">
                    <div id="logo-answer">
                        
                    </div>
                </div>
            </div>
        </div>
        <div id="xian">
            <hr />
        </div>
        <div id="mainContent">
            <div id="mainContent-head">
                <span>查看知识点内容</span></div>
            <h2 style="color:<%=TitleColor%>">
                <%=this.Title1 %></h2>
            <p class="indro">
                作者：<%=NickName %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 点击率：<%=ViewCount %> </p>
            <div>
                <%=this.Content %>
            </div>
        </div>
    </div>
</asp:Content>
