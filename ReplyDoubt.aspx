<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ReplyDoubt.aspx.cs" Inherits="NetworkEducation.ReplyDoubt" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>软件工程与计算 @ 回复疑问</title>
    <link href="Content/CSS/ReplyDoubt.css" rel="stylesheet" type="text/css" />
    <link href="Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="answer">
            <div id="index">
                <img src="Content/Image/EducationImage/xia.gif" />&nbsp;&nbsp;&nbsp;
            </div>
            <div id="location">
                <p>
                    您当前的位置：<a href="Index.aspx">首页</a> >> 在线答疑 >> 回复</p>
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
        <div class="message">
            <div class="message-info">
                <span class="message-info-right">#<%=QuestionID %>
                    <a href="ReplyDoubt.aspx">【回复】</a></span> <span class="message-info-left">
                        <%=this.PostTime %></span>
            </div>
            <div class="message-userInfo">
                昵称：<%=Server.HtmlEncode( this.NickName )%><br />
                <br />
                性别：<%=Server.HtmlEncode(this.Gender )%><br />
                <br />
                QQ：<%=Server.HtmlEncode(this.QQ )%><br />
                <br />
                地址：<%=Server.HtmlEncode(this.Address )%><br />
                <br />
                联系方式：<%=Server.HtmlEncode(this.PhoneNo)%>
            </div>
            <div class="message-content">
                提问内容：<hr />
                <%=Server.HtmlEncode(this.Content)%>
                <asp:Repeater ID="rptQuestionReply" runat="server">
                    <ItemTemplate>
                        <div class="<%#(bool)Eval("UserType")?"message-teacher-replay":"message-student-replay" %>">
                            <div id="message-replay-time">
                                <%#(bool)Eval("UserType")?"老师":"学生"%>【<%#Eval("NickName").ToString()%>】于【<%#Eval("PostTime","{0:f}")%>】回复：</div>
                            <hr />
                            <%#Eval("Content").ToString()%>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <span class="message-info-right pager">
            <webdiyer:AspNetPager ID="AspNetPager1" runat="server" UrlPaging="true" FirstPageText=""
                PrevPageText="上一页" NextPageText="下一页" LastPageText="" ShowPageIndexBox="Never"
                CustomInfoHTML="" PageIndexBoxType="DropDownList" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转向第"
                CustomInfoSectionWidth="27px" CustomInfoTextAlign="Right" ShowCustomInfoSection="Right"
                UrlPageSizeName="pageSize" AlwaysShow="True" ShowNavigationToolTip="True" ViewStateMode="Enabled"
                PagingButtonSpacing="8px" NumericButtonCount="5" ShowFirstLast="False" ShowMoreButtons="False">
            </webdiyer:AspNetPager>
        </span>
        <div class="message">
            <div class="message-info">
                <span class="reply-message-info-left">回复提问</span>
            </div>
            <table id="reply-question">
                <tr>
                    <th>
                        职称：
                    </th>
                    <td class="margin-bottom">
                        <asp:DropDownList Enabled="false" ID="ddlUserType" runat="server">
                            <asp:ListItem Text="学生" Value="0" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="老师" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <th>
                        昵称：
                    </th>
                    <td class="margin-bottom">
                        <asp:TextBox Enabled="false" ID="tbNickName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        回复内容：
                    </th>
                    <td class="margin-bottom">
                        <asp:TextBox class="mainContent" TextMode="MultiLine" ID="tbContent" runat="server"></asp:TextBox>
                        <span style="color: Red;">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbContent"
                            Display="Dynamic" ErrorMessage="请输入回复内容！" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <th>
                        验证码：
                    </th>
                    <td class="margin-bottom">
                        <input id="Text2" type="text" />
                    </td>
                </tr>
                <tr>
                    <th>
                    </th>
                    <td class="margin-bottom">
                        <asp:Button class="l-button" ID="Button1" runat="server" Text="提交" OnClick="Button1_Click" />
                        <input class="l-button" id="Reset1" type="reset" value="重置" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
