<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NetworkEducation.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>软件工程与计算 @ 登陆页面</title>
    <link href="Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="Content/CSS/Default.css" rel="stylesheet" type="text/css" />
    <link href="Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        function LoginCheck() {
            var loginName = document.getElementById("LoginName");
            var userPassword = document.getElementById("UserPassword");

            if (loginName.value == "") {
                alert("请输入登录名！");
                loginName.focus();
                return false;
            }

            if (userPassword.value == "") {
                alert("请输入登录密码！");
                userPassword.focus();
                return false;
            }
            return true;
        }
        inputBox

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="container">
        <div id="header">
            <div id="title">
                <h1>
                    软件工程与计算</h1>                   
            </div>    
        </div>
        <div id="main">
            <h2 class="index-in">
                登陆 || <a href="Register.aspx">立即注册</a></h2>
            <div id="nav">
                <div id="nav-logo">
                </div>      
            </div>            
            <fieldset>
                <div class="editor-label">
                    <label for="UserName">
                        登录名：</label>
                </div>
                <div class="editor-field">
                    <asp:TextBox class="inputBox" ID="tbLoginName" runat="server"></asp:TextBox>
                    <span style="color:Red;">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="tbLoginName" Display="Dynamic" ErrorMessage="登请输入登录名！" 
                        ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="editor-label">
                    <label for="Password">
                        密码：</label>
                </div>
                <div class="editor-field">
                    <asp:TextBox class="inputBox" TextMode="Password" ID="tbPassword" runat="server"></asp:TextBox>
                    <span style="color:Red;">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="tbPassword" Display="Dynamic" ErrorMessage="请输入密码！" 
                        ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="editor-label">
                    <label for="Validation">
                        用户类别：</label>
                </div>
                <div class="editor-field inputBox">
                    <asp:RadioButtonList RepeatDirection="Horizontal" RepeatLayout="Flow" ID="rblType"
                        runat="server">
                        <asp:ListItem Text="管理员" Value=""></asp:ListItem>
                        <asp:ListItem class="userType" Text="老师" Value="1"></asp:ListItem>
                        <asp:ListItem class="userType" Text="学生" Value="0" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                    <%-- <input id="admin" type="radio" name="type" value="" /><label for="admin">管理员</label>
                    <input id="teacher" type="radio" name="type" value="1" /><label for="teacher">教师</label>
                    <input id="student" type="radio" name="type" value="0" checked="checked" /><label
                        for="student">学生</label>--%>
                </div>
                <div class="editor-label">
                    <label for="Validation">
                        验证码：</label>
                </div>
                <div class="editor-field">
                    <div class="valideImage">
                        <img src="valid.ashx" /></div>
                    <asp:TextBox Style="width: 80px;" ID="tbValideCode" runat="server"></asp:TextBox><asp:CustomValidator
                        ID="CustomValidator1" runat="server" ErrorMessage="验证码错误！" ControlToValidate="tbValideCode"
                        Display="Dynamic" ForeColor="Red" OnServerValidate="CustomValidator1_ServerValidate"
                        SetFocusOnError="True" ValidateEmptyText="True"></asp:CustomValidator>
                </div>
                <br />
                <div>
                    <asp:Button class="l-button" ID="submit" runat="server" Text="提交" 
                        onclick="submit_Click" />
                    <input class="l-button" id="Reset1" type="reset" value="重置" />
                </div>
            </fieldset>
        </div>
        <div id="footer">
            <div id="footContaint">
                <p>
                    版权所有：贵大某开发小组&nbsp;&nbsp;&nbsp; 开发时间2013年10月&nbsp;&nbsp;&nbsp; 联系人：XXX</p>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
