<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="DisplayDoubt.aspx.cs" Inherits="NetworkEducation.DisplayDoubt" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>软件工程与计算 @ 答疑列表</title>
    <link href="Content/CSS/DisplayDoubt.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="answer">
            <div id="index">
                <img src="Content/Image/EducationImage/xia.gif" />
            </div>
            <div id="location">  
                <p>
                    您当前的位置：<a href="Index.aspx">首页</a> >> 在线答疑 >> 显示答疑</p>
            </div>
            <div id="logo">
                <div id="logo-question">
                    <div class="image1">
                        <img src="Content/Image/EducationImage/ty.gif" /></div>
                    <div id="questionCon">
                        <a href="AskQuestion.aspx">在线提问</a></div>
                    <div id="logo-answer">
                        <div class="image2">
                            <img src="Content/Image/EducationImage/ck.gif" /></div>
                        <div id="answerContent">
                            <a href="DisplayDoubt.aspx">显示答疑</a></div>
                    </div>
                </div>
            </div>
        </div>
        <div id="xian">
            <hr />
        </div>
        <asp:Repeater ID="rptQuestion" runat="server" OnItemDataBound="rptQuestion_ItemDataBound">
            <ItemTemplate>
                <div class="message">
                    <div class="message-info">
                        <span class="message-info-right">#<%#Eval("id") %>
                            <a href="ReplyDoubt.aspx?qid=<%#Eval("id") %>">【回复】</a></span> <span class="message-info-left">
                                <%#Eval("PostTime","{0:f}")%></span>
                    </div>
                    <div class="message-userInfo">
                        昵称：<%#Eval("NickName").ToString()%><br />
                        <br />
                        性别：<%#Eval("Gender").ToString() == "" ? "保密" : (bool)Eval("Gender") ? "先生" : "女士"%><br />
                        <br />
                        QQ：<%#Eval("QQ").ToString() == "" ? "保密" : Eval("QQ").ToString()%><br />
                        <br />
                        地址：<%#Eval("Address").ToString() == "" ? "保密" : Eval("Address").ToString()%><br />
                        <br />
                        联系方式：<%#Eval("PhoneNumber").ToString() == "" ? "保密" : Eval("PhoneNumber").ToString()%>
                    </div>
                    <div class="question-content">
                        提问内容：<hr />
                        <%#Eval("Content").ToString()%>
                        <asp:Repeater ID="rptQuestionReply" runat="server">
                            <ItemTemplate>
                                <div class="<%#(bool)Eval("UserType")?"question-teacher-replay":"question-student-replay" %>">
                                    <div id="message-replay-time">
                                        <%#(bool)Eval("UserType")?"老师":"学生"%>【<%#Eval("NickName").ToString()%>】于【<%#Eval("PostTime","{0:f}")%>】回复：</div>
                                    <hr />
                                    <%#Eval("Content").ToString()%>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>         
            </ItemTemplate>
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
