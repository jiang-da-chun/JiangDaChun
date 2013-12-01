<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="AddNoticeInfor.aspx.cs"
    Inherits="NetworkEducation.AddNoticeInfor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="Admin/CSS/Edit.css" rel="stylesheet" type="text/css" />
    <link href="Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet"
        type="text/css" />
</head>
<body>  
    <form id="form1" runat="server">
    <div id="edit">
        <table>
            <tr>
                <th>
                    发布人姓名：
                </th>   
                <td>
                    <asp:TextBox class="inputBox" ID="tbName" runat="server"></asp:TextBox>
                    <span style="color: Red;">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbName"
                        Display="Dynamic" ErrorMessage="请输入发布人姓名" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="tbName"
                        Display="Dynamic" ErrorMessage="姓名只能在2-6个字符之间" ForeColor="Red" SetFocusOnError="True"
                        ValidationExpression="^(\s|\S){2,6}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th class="title-content">
                    内容：
                </th>
                <td>
                    <asp:TextBox TextMode="MultiLine" class="inputBox notice-content" ID="tbContent" runat="server"></asp:TextBox>
                    <span style="color: Red;">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbContent"
                        Display="Dynamic" ErrorMessage="请输入通知内容！" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th>
                </th>
                <td id="btn">
                    <asp:Button class="l-button" ID="submit" runat="server" Text="提交" OnClick="submit_Click" /><input
                        class="l-button" id="Reset1" type="reset" value="重置" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
