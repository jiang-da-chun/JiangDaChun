<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifyUserPassword.aspx.cs"
    Inherits="NetworkEducation.Admin.ModifyUserPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Edit.css" rel="stylesheet" type="text/css" />
    <link href="../Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet"
        type="text/css" />
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
                    <asp:TextBox class="inputBox" ID="tbName" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="请输入登录名！" 
                        ControlToValidate="tbName" Display="Dynamic" ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" 
                        ControlToValidate="tbName" Display="Dynamic" ErrorMessage="登录名不存在！" 
                        ForeColor="Red" onservervalidate="CustomValidator1_ServerValidate" 
                        SetFocusOnError="True"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <th>
                    修改密码：
                </th>
                <td>
                    <asp:TextBox TextMode="Password" class="inputBox" ID="tbPassword" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="tbPassword" Display="Dynamic" ErrorMessage="请输入密码！" 
                        ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="tbPassword" Display="Dynamic" ErrorMessage="密码只能在3-12个字符之间" 
                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(\s|\S){3,12}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    确定密码：
                </th>
                <td>
                    <asp:TextBox TextMode="Password" class="inputBox" ID="tbConfirmPassword" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="tbConfirmPassword" Display="Dynamic" ErrorMessage="请确认密码！" 
                        ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToCompare="tbPassword" ControlToValidate="tbConfirmPassword" 
                        Display="Dynamic" ErrorMessage="密码确认错误！" ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <th>
                </th>
                <td id="btn">
                    <asp:Button class="l-button" ID="submit" runat="server" Text="提交" 
                        onclick="submit_Click" />
                    <input class="l-button" id="Reset1" type="reset" value="重置" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
