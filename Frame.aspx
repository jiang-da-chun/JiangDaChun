<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Frame.aspx.cs" Inherits="NetworkEducation.Admin.Frame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/CSS/Reset.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Frame.css" rel="stylesheet" type="text/css" />
    <link href="../Content/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="../Content/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/Script/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="../Content/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script type="text/javascript">

        //关闭编辑窗口
        function CloseEdit() {
            location.href = location.href; //设置当前浏览器窗口的URL为之前的URL，相当于刷新页面，刷新后的页码和页码大小的值不变。
            //location.href中既有目标网页，同时也包含参数及参数的值
        }

        var tab;

        function HeightChanged(obj) {
            if (tab) tab.addHeight(obj.diff); /*当布局的高度改变时，让选项卡的高度也改变*/
        }

        function Init() {

            var obj = {
                topHeight: $("#top").height,
                bottomHeight: $("#bottom").height,
                leftWidth: 200,
                onHeightChanged: HeightChanged/*调用HeightChanged(obj)函数*/
            }
            $("#container").ligerLayout(obj);
            $("#tree").ligerTree({
                checkbox: false
            });

            var height = $(".l-layout-center").height();
            $("#tab").ligerTab({ height: height }); /*获取选项卡*/
            tab = $("#tab").ligerGetTabManager(); /*获取选项卡的管理对象*/


            $("#tree a").click(function () {
                if (this.target == "Edit") {
                    $.ligerDialog.open({
                        url: this.href,
                        title: this.innerHTML,
                        width: this.attributes["w"].value, /*获取控件自定义的属性w的值*/
                        height: $(this).attr("h"), /*获取控件自定义的属性h的值*/
                        isResize: true
                    });
                }
                else {
                    /*通过选项卡管理对象添加选项卡*/
                    tab.addTabItem({
                        tabid: this.target,   /*给选项卡添加身份证号，即标志唯一的选项卡*/
                        url: this.href,   /*选项卡下面显示的内容是哪个网址*/
                        text: this.innerHTML  /*选项卡上面的文本*/
                    });
                }

                return false;    /*链接不会跳转*/
            });
        }
        $(Init);
    </script>
</head>
<body>
    <form id="form1" runat="server">
      <div id="container">
        <div id="top" position="top">
            <h3>
                软件工程与计算 @ 管理员管理页面</h3>
        </div>
        <div id="left" title="系统菜单" position="left">
            <ul id="tree">
                <li><span>用户信息管理</span>
                    <ul>
                        <li><span><a w="500" h="200" href="ModifyUserPassword.aspx" target="Edit">修改用户密码</a></span></li>
                        <li><span><a href="UserInfoList.aspx" target="UserInfoList">用户信息列表</a></span></li>
                    </ul>
                </li>
                <li><span>管理员信息管理</span>
                    <ul>
                        <li><span><a w="520" h="250" href="AddAdmin.aspx" target="Edit">添加管理员</a></span></li>
                        <li><span><a href="AdminList.aspx" target="AdminList">管理员信息列表</a></span></li>
                    </ul>
                </li>
                <li><span>首页信息管理</span>
                    <ul>
                        <li><span><a href="AddCourseIndro.aspx" target="AddCourseIndro">发布专业简介</a></span></li>
                        <li><span><a href="CourseInforList.aspx" target="CourseInforList">专业信息列表</a></span></li>
                        <li><span><a href="NoticeList.aspx" target="NoticeList">通知信息列表</a></span></li>
                    </ul>       
                </li>
                <li><span>答疑信息管理</span>
                    <ul>
                        <li><span><a href="../Default.aspx">登录</a></span></li>
                        <li><span>回复信息列表</span></li>
                    </ul>
                </li>
                <li><span>教学材料信息管理</span>
                    <ul>
                        <li><span>教学材料信息列表</span></li>
                    </ul>
                </li>
                <li><span>在线学习信息管理</span>
                    <ul>
                        <li><span>课程学习简介</span></li>
                        <li><span>课程学习信息列表</span></li>
                        <li><span>案例分析简介</span></li>
                        <li><span>案例分析信息列表</span></li>
                    </ul>
                </li>
                <li><span>成果信息管理</span>
                    <ul>
                        <li><span>成果信息列表</span></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div id="center" position="center">
            <div id="tab">
                <div tabid="home" title="我的主页">
                    我每天心情都很爽，爽歪歪啦！！！
                </div>
            </div>
        </div>
        <div id="bottom" position="bottom">
            版权所有：贵大某开发小组&nbsp;&nbsp;&nbsp; 开发时间2013年10月&nbsp;&nbsp;&nbsp; 联系人：XXX
        </div>
    </div>
    </form>
</body>
</html>
