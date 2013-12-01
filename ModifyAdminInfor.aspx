<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifyAdminInfor.aspx.cs"
    Inherits="NetworkEducation.Admin.ModifyAdminInfor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Edit.css" rel="stylesheet" type="text/css" />
    <link href="../Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/Script/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script src="../Content/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="edit">
        <table>
            <tr>
                <th>
                    登录名：
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" class="inputBox" ID="tbUserName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbUserName"
                        Display="Dynamic" ErrorMessage="请输入登录名！" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="tbUserName"
                        Display="Dynamic" ErrorMessage="登录名只能在3-12个字符之间" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="^(\s|\S){3,12}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    真实姓名：
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" class="inputBox" ID="tbRealName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbRealName"
                        Display="Dynamic" ErrorMessage="请输入用户真实姓名！" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="tbRealName"
                        Display="Dynamic" ErrorMessage="姓名只能在2-6个字符之间" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="^(\s|\S){2,6}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    修改密码：
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" TextMode="Password" class="inputBox" ID="tbPassword"
                        runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="tbPassword"
                        Display="Dynamic" ErrorMessage="密码只能在3-12个字符之间" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="^(\s|\S){3,12}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    确认密码：
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" TextMode="Password" class="inputBox" ID="tbCofirmPassword"
                        runat="server"></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="tbPassword"
                        ControlToValidate="tbCofirmPassword" Display="Dynamic" ErrorMessage="密码确认错误"
                        ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <th>
                </th>
                <td id="btn">
                    <asp:Button class="l-button" ID="Button1" runat="server" Text="提交" OnClick="Button1_Click" /><asp:Button
                        class="l-button" ID="Reset1" runat="server" Text="重置" OnClick="Reset1_Click" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
