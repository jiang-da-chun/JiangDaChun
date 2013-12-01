<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifyUserInfor.aspx.cs"
    Inherits="NetworkEducation.Admin.ModifyUserInfor" %>

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
                    登录名
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" class="inputBox" ID="tbUserName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="tbUserName" Display="Dynamic" ErrorMessage="请输入登录名！" 
                        ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" 
                        ControlToValidate="tbUserName" Display="Dynamic" ErrorMessage="登录名只能在3-12个字符之间" 
                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(\s|\S){3,12}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    昵称
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" class="inputBox" ID="tbNickName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="tbNickName" Display="Dynamic" ErrorMessage="请输入用户昵称！" 
                        ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="tbNickName"
                        Display="Dynamic" ErrorMessage="昵称只能在2-6个字符之间" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="^(\s|\S){2,6}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    性别
                </th>
                <td>
                    <asp:RadioButton GroupName="rbSex" Text="男" ID="sexMale" runat="server" Checked="true" />
                    <asp:RadioButton GroupName="rbSex" Text="女" ID="sexFemale" runat="server" />
                </td>
            </tr>
            <tr>
                <th>
                    QQ
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" class="inputBox" ID="tbQQ" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbQQ"
                        Display="Dynamic" ErrorMessage="QQ号只能是数字且5-12位" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="[0-9]{5,12}"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    地址
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" class="inputBox" ID="tbAddress" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="tbAddress"
                        Display="Dynamic" ErrorMessage="只能输入2到12个字符" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="^(\s|\S){2,12}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th>
                    用户类型
                </th>
                <td>
                    <asp:DropDownList class="inputBox" ID="ddlUserType" runat="server">
                        <asp:ListItem Selected="True" Value="0">学生</asp:ListItem>
                        <asp:ListItem Value="1">老师</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>
                    联系方式
                </th>
                <td>
                    <asp:TextBox ToolTip="不输入表示不修改" class="inputBox" ID="tbPhoneNo" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="tbPhoneNo"
                        Display="Dynamic" ErrorMessage="只能输入7到11为数字" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="^\d{7,11}$"></asp:RegularExpressionValidator>
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
