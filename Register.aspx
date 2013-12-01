<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="NetworkEducation.Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>软件工程与计算 @ 用户注册</title>
    <link href="Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="Content/CSS/Register.css" rel="stylesheet" type="text/css" />
    <link href="Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="Content/Script/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="Content/ligerUI/js/ligerui.all.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="login">
    <div id="container">
        <div id="header">
            <div id="title">
                <h1>软件工程与计算</h1>
            </div>
        </div>
        <div id="main">
            
            <div id="userRegister">
                <div id="user">用户注册 @ 欢迎使用本网站进行学习</div>
            </div>
            <fieldset>
                <table id="userInfo">
                    <tr>
                        <th class="editor-label"> 登录名：</th>
                        <td class="editor-field">
                            <asp:TextBox class="inputBox" ID="tbName" runat="server"></asp:TextBox>
                            <span style="color:Red;">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="tbName" Display="Dynamic" ErrorMessage="请输入用户名" 
                                ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" 
                                ControlToValidate="tbName" Display="Dynamic" ErrorMessage="此登陆名已经存在！" 
                                ForeColor="Red" onservervalidate="CustomValidator1_ServerValidate" 
                                SetFocusOnError="True"></asp:CustomValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" 
                                ControlToValidate="tbName" Display="Dynamic" ErrorMessage="登录名只能在3-12个字符之间" 
                                ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(\s|\S){3,12}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label"> 昵称：</th>
                        <td class="editor-field"> 
                            <asp:TextBox class="inputBox" ID="tbNickName" runat="server"></asp:TextBox>
                            <span style="color:Red;">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="tbNickName" Display="Dynamic" ErrorMessage="请输入用户昵称" 
                                ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" 
                                ControlToValidate="tbNickName" Display="Dynamic" ErrorMessage="昵称只能在2-6个字符之间" 
                                ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(\s|\S){2,6}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label"> 密码：</th>
                        <td class="editor-field">
                            <asp:TextBox class="inputBox" TextMode="Password" ID="tbPassword" runat="server"></asp:TextBox>
                            <span style="color:Red;">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="tbPassword" Display="Dynamic" ErrorMessage="请输入密码" 
                                ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                ControlToValidate="tbPassword" Display="Dynamic" ErrorMessage="密码只能在3-12个字符之间" 
                                ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(\s|\S){3,12}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label">确认密码：</th>
                        <td class="editor-field">
                            <asp:TextBox class="inputBox" TextMode="Password" ID="tbCofirmPassword" runat="server"></asp:TextBox>
                            <span style="color:Red;">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="tbCofirmPassword" Display="Dynamic" ErrorMessage="请确认密码" 
                                ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                ControlToCompare="tbPassword" ControlToValidate="tbCofirmPassword" 
                                Display="Dynamic" ErrorMessage="密码确认错误" ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label"> QQ：</th>
                        <td class="editor-field">
                            <asp:TextBox class="inputBox" ID="tbQQ" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                ControlToValidate="tbQQ" Display="Dynamic" ErrorMessage="QQ号只能数字且只能是5-12位" 
                                ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{5,12}"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label"> 地址：</th>
                        <td class="editor-field">
                            <asp:TextBox class="inputBox" ID="tbAddress" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                                ControlToValidate="tbAddress" Display="Dynamic" ErrorMessage="只能输入2到12个字符" 
                                ForeColor="Red" SetFocusOnError="True" 
                                ValidationExpression="^(\s|\S){2,12}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label"> 性别：</th>
                        <td class="editor-field">
                            <asp:RadioButton GroupName="rbSex" Text="男" ID="sexMale" runat="server" Checked="true" />
                            <asp:RadioButton GroupName="rbSex" Text="女" ID="sexFemale" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label">用户类型：</th>
                        <td class="editor-field">
                            <asp:DropDownList class="inputBox" ID="ddlUserType" runat="server">
                                <asp:ListItem Selected="True" Value="0">学生</asp:ListItem>
                                <asp:ListItem Value="1">老师</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label">联系方式：</th>
                        <td class="editor-field">
                            <asp:TextBox class="inputBox" ID="tbPhoneNumber" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" 
                                ControlToValidate="tbPhoneNumber" Display="Dynamic" ErrorMessage="只能输入7-11位数字" 
                                ForeColor="Red" SetFocusOnError="True" ValidationExpression="^\d{7,11}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <th class="editor-label"> 验证码：</th>
                        <td class="editor-field"><input class="inputBox" id="ValidateInfor" name="ValidateInfor" type="text" /></td>
                    </tr>
                    <tr>
                        <th></th> 
                        <td>
                            <asp:Button class="l-button" ID="login" runat="server" Text="提交" onclick="login_Click" />
                            <input class="l-button" id="Reset1" type="reset" value="重置" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div id="footer">
            <div id="footContaint"><p>版权所有：贵大某开发小组&nbsp;&nbsp;&nbsp; 开发时间2013年10月&nbsp;&nbsp;&nbsp; 联系人：XXX</p></div>
        </div>
 
    </div>
    </form>
</body>
</html>
