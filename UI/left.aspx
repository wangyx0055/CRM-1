<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="left.aspx.cs" Inherits="UI.left" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="CSS/left.css" rel="stylesheet" type="text/css" />
    <script src="JS/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="JS/MyJs.js"></script>
    <script type="text/javascript">
        $(function() {
            $(".menuDiv").live("click",function() {
            $(this).next("div").slideToggle(450);
            });
            $.post("/Service/MyProcessRequst.ashx?method=GetUserListTools", null, function (data) {
                var llist = JSON.parse(data)["llist"];
                var tlist = JSON.parse(data)["tlist"];
                $(tlist).each(function (k,v) {
                 var d1= $(" <div class='menuDiv' >" + v["Typename"] + "</div>");
                 var d2 = $("<div class='contentDiv' style='display:none'></div>");
                 $(llist).each(function (i,j) {
                     if (j["Listtype"] == v["Id"]) {
                        var d3= $("<div><img src='images/left.gif' /><a href='" + j["Listurl"] + "' target='main'>" + j["Listname"] + "</a></div>");
                         $(d2).append(d3);
                     }
                 });
                 $("#div2").append(d1).append(d2);
                });
            });
        });
    </script>
</head>
<body>
<table cellpadding="0" cellspacing="0">
    <tr>
        <td id="td1"></td>
        <td id="td2">
            <div id="div1">管理菜单
            </div>
            <div id="div2">
                <%--<!--菜单开始 -->
                <!--父菜单 -->
                <div class="menuDiv"  style="display:none">营销管理</div>
                <!--子菜单 -->
                <div class="contentDiv" style="display:none">
                    <div name="d1"><img src="images/left.gif" /><a href="sale/salechance.aspx" target="main">销售机会管理</a></div>
                    <div name="d1"><img src="images/left.gif" /><a href="Sale/SaleAllot.aspx" target="main">销售机会分配</a></div>
                    <div name="d1"><img src="images/left.gif" /><a href="sale/saleManager.aspx" target="main">客户开发计划</a></div>
                </div>
                <!--菜单结束 -->
                <!--父菜单 -->
                <div class="menuDiv"  style="display:none">客户管理</div>
                <!--子菜单 -->
                <div class="contentDiv" style="display:none">
                    <div name="d2"><img src="images/left.gif" /><a href="Customer/CustomerPage.aspx" target="main">客户信息管理</a></div>
                    <div  name="d2"><img src="images/left.gif" /><a href="Customer/LostsPage.aspx" target="main">客户流失管理</a></div>
                </div>
                <!--父菜单 -->
                <div class="menuDiv"  style="display:none">服务管理</div>
                <!--子菜单 -->
                <div class="contentDiv" style="display:none">
                    <div  name="d3"><img src="images/left.gif" /><a href="CustomerService/ServiceCreate.aspx" target="main">服务创建</a></div>
                    <div name="d3"><img src="images/left.gif" /><a href="CustomerService/ServiceAllot.aspx" target="main">服务分配</a></div>
                    <div name="d3"><img src="images/left.gif" /><a href="CustomerService/ServiceDispose.aspx" target="main">服务处理</a></div>
                    <div name="d3"><img src="images/left.gif" /><a href="CustomerService/ServiceResult.aspx" target="main">服务反馈</a></div>
                    <div name="d3"><img src="images/left.gif" /><a href="CustomerService/serviceDetail.aspx" target="main">服务归档</a></div>
                </div>
                <div class="menuDiv"  style="display:none">统计报表</div>
                <!--子菜单 -->
                <div class="contentDiv" style="display:none">
                    <div name="d4"><img src="images/left.gif" /><a href="Exce/ExceServerTypePage.aspx" target="main">客户服务分析</a></div>
                    <div name="d4"><img src="images/left.gif" /><a href="Exce/ExceCusLosPage.aspx" target="main">客户流失分析</a></div>
                </div>
            
             <!--父菜单 -->
                <div class="menuDiv"  style="display:none">系统管理</div>
                <!--子菜单 -->
                <div class="contentDiv" style="display:none">
                    <div name="d5"><img src="images/left.gif" /><a href="manager/UserPage.aspx" target="main">用户管理</a></div>
                    <div name="d5"><img src="images/left.gif" /><a href="manager/RolePage.aspx" target="main">权限管理</a></div>
                </div>--%>
            </div>

               


        </td>
    </tr>
</table>
</body>
</html>
