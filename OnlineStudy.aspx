<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="OnlineStudy.aspx.cs" Inherits="NetworkEducation.OnlineStudy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>软件工程与计算 @ 在线学习</title>
    <link href="Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="Content/CSS/OnlineStudy.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="knownCross">
            <div id="knownCross-head">
                <span><a href="InteKnowledgeList.aspx">知识点整合</a></span></div>
            <div id="knownCross-introduce">
                <%=this.StudyContent %>
            </div>
        </div>
        <div id="caseAnalyse">
            <div id="caseAnalyse-head">
                <span><a href="CaseStudy.aspx">软件设计的案例</a></span></div>
            <div id="caseAnalyse-intruduce">
                <%=this.CaseContent %>
            </div>
        </div>
    </div>
</asp:Content>
