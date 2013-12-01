<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AskQuestion.aspx.cs" Inherits="NetworkEducation.AskQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>软件工程与计算 @ 在线提问</title>
    <link href="Content/CSS/AskQuestion.css" rel="stylesheet" type="text/css" />
    <link href="Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="Content/Script/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="Content/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div id="main">
        <div id="answer">              
            <div id="index">                               
                <img src="Content/Image/EducationImage/xia.gif" />
            </div>
            <div id="location">                                                 
                <p>
                    您当前的位置：<a href="Index.aspx">首页</a> >> 在线答疑 >> 在线提问</p>
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
        <table id="message">
            <tr>
                <th>
                    昵称：
                </th>
                <td>
                    <asp:TextBox Enabled="false" ID="tbNickName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    性别：
                </th>
                <td>
                    <asp:RadioButtonList Enabled="false" RepeatDirection="Horizontal" RepeatLayout="Flow"
                        ID="rblSex" runat="server">
                        <asp:ListItem Text="男" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="女" Value="0"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <th>
                    QQ：
                </th>
                <td>
                    <asp:TextBox Enabled="false" ID="tbQQ" runat="server" Height="19px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    地址：
                </th>
                <td>
                    <asp:TextBox Enabled="false" ID="tbAddress" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    联系方式：
                </th>
                <td>
                    <asp:TextBox Enabled="false" ID="tbPhoneNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    提问内容：
                </th>
                <td>
                    <asp:TextBox class="askContent" TextMode="MultiLine" ID="tbContent" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbContent"
                        Display="Dynamic" ErrorMessage="请输入提问内容！" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th>
                    验证码：
                </th>
                <td>
                    <input id="Text1" type="text" />
                </td>
            </tr>
            <tr>
                <th>
                </th>
                <td>
                    <asp:Button class="l-button" ID="Button1" runat="server" Text="提交" 
                        onclick="Button1_Click1"/><input
                        class="l-button" id="Reset1" type="reset" value="重置" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
