<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="UpInteKContent.aspx.cs"
    Inherits="NetworkEducation.UpInteKContent" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="Admin/CSS/Edit.css" rel="stylesheet" type="text/css" />
    <link href="Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="Content/Script/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="Content/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
    <script src="Content/ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="Content/ckeditor/adapters/jquery.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        $(
            function () {
                $("#tbContent").ckeditor(); //当网页加载完后，自动调用此匿名方法将编辑器和多行文本输入域绑定在一起
            }                                //另外一种绑定方法：在多行文本输入域中加入class="ckeditor"即可    
        );


        function UpdateContent() {
            var content = $("#tbContent").ckeditorGet(); //获取编辑器的内容，编辑器和多行文本输入框是绑定在一起的（可以通过class="ckeditor"，但是通过此种方法绑定不能获取编辑器的值去更新多行文本域的内容）
            content.updateElement(); //更新行文本域的内容
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="edit">
        <table id="courseInfo">
            <tr>
                <th>
                    标题
                </th>
                <td>
                    <asp:TextBox Enabled="false" ID="tbTitle" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    标题颜色
                </th>
                <td>
                    <asp:DropDownList Enabled="false" ID="ddlTitleColor" runat="server">
                        <asp:ListItem Value="#000000" Text="黑色"></asp:ListItem>
                        <asp:ListItem Value="#00CC00" Text="绿色"></asp:ListItem>
                        <asp:ListItem Value="#0000FF" Text="蓝色"></asp:ListItem>
                        <asp:ListItem Value="#FF0000" Text="红色"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>
                    作者
                </th>
                <td>
                    <asp:TextBox Enabled="false" ID="tbAuthor" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    请复制具体内容
                </th>
                <td>
                    <asp:TextBox TextMode="MultiLine" ID="tbContent" runat="server"></asp:TextBox>
                    <span style="color: Red;">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbContent"
                        ErrorMessage="请复制具体内容" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th>
                </th>
                <td id="btn">
                    <asp:Button OnClientClick="UpdateContent();" class="l-button" ID="submit" runat="server"
                        Text="提交" OnClick="submit_Click" /><input class="l-button" id="Reset1" type="reset"
                            value="重置" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
