<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserPage.aspx.cs" Inherits="UI.Manager.UserPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../CSS/Style1.css" rel="stylesheet" type="text/css" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script type="text/javascript">
        var index = 1;
        var maxpage;
        var roleid = 0;//角色ID
        var username = "";//用户名字
        var userflag = -1;//是否可用(1:可用， 0：不可用,-1：全部 )
        $(function () {
            //角色绑定
            $.post("../Service/MyProcessRequst.ashx?method=GetRoleAll", null, function (data) {
                $("#RoleID option").remove();
                var o = $("<option value='0'>所有角色</option>");
                $("#RoleID").append(o);
                $(JSON.parse(data)).each(function (k,v) {
                    var op = $("<option value='" + v["Role_id"] + "'>" + v["Role_name"] + "</option>");
                    $("#RoleID").append(op);

                });
            });
            //添加
            $("#add").click(function () {
                var rt = window.showModalDialog("../Manager/UserRolePageDialog.aspx?data=" + Math.random(), null, "dialogWidth:510px;dialogHeight:290px;help:no");
                if (rt) {
                    alert("添加成功");
                    GetData();
                }
            });
            //编辑
            $("input[type=image][title=编辑]").live("click", function () {
                var tds = $(this).parent().parent().children("th");
                var ip = $(this);
                var userid = ip.attr("key");
                var pwd = ip.attr("pwd");
                var lname = ip.attr("lname");
                var roleid = ip.attr("roleid");
                var name = ip.attr("name");
                var flag=ip.attr("flag");
                var user = { "UserID": userid, "UserLName": lname, "UserLPWD": pwd, "RoleID": roleid, "UserName": name,"UserFlag": flag};
                var rt = window.showModalDialog("../Manager/UserRolePageDialog.aspx?data=" + Math.random(), user, "dialogWidth:510px;dialogHeight:290px;help:no");
                if (rt) {
                     ip.attr("key",rt["UserID"]);
                     ip.attr("pwd", rt["UserLPWD"]);
                     ip.attr("lname", rt["UserLName"]);
                     ip.attr("roleid", rt["RoleID"]);
                     ip.attr("name", rt["UserName"]);
                     var rolestr = "";
                     switch (rt["RoleID"]) {
                         case '1':
                             rolestr = "系统管理员"
                             break;
                         case '2':
                             rolestr = "客户经理"
                             break;
                         case '3':
                             rolestr = "销售主管"
                             break;
                         case '4':
                             rolestr = "客服经理"
                             break;
                         case '5':
                             rolestr = "高管"
                             break;
                     }
                     tds[1].innerText = rolestr;
                     tds[2].innerText = rt["UserFlag"] == 1 ? "可用" : "不可用";
                }
            });
            //删除
            $("input[type=image][title=删除]").live("click", function () {
                if (confirm("用户删除后，用户所关联的数据都将会删除，确认删除？")) {
                    var userid = $(this).attr("key");
                    myAjax("/Service/RoleServices.asmx/DeleeteUser", JSON.stringify({ "id": userid }), function (data) {
                        if (data["d"] > 0) {
                            alert("删除成功！");
                            GetData();
                        } else {
                            alert("未知错误，删除失败！");
                        }
                    });
                }
            });

            //翻页
            $("input[type=image][method]").click(function () {
                var method = $(this).attr("method");
                if (method == "shou") {
                    index = 1;
                } else if (method == "shang") {
                    index = index > 1 ? index - 1 : index;
                } else if (method == "xia") {
                    index = index < maxpage ? index + 1 : index;
                } else if (method == "wei") {
                    index = maxpage;
                } else if (method == "go") {

                    var number = $("#number").val();
                    try {
                        if (parseInt(number) <= parseInt(maxpage)) {
                            index = parseInt(number);
                        }
                    } catch (e) {
                        alert("输入有误！");
                    }
                }
                GetData();
            });
            //查询
            $("input[type=button][value=查询]").click(function () {
                roleid = $("#RoleID option:selected").val();
                username = $("#UserName").val();
                userflag = $("#UserFlag option:selected").val();
                GetData();
            });
            $("#UserName").keyup(function () {
                roleid = $("#RoleID option:selected").val();
                username = $("#UserName").val();
                userflag = $("#UserFlag option:selected").val();
                GetData();
            });
         
          

            GetData();
        });
        //查询方法
        function GetData() {
            var jsstr = JSON.stringify({ "UserID":index,"Role_id": roleid, "UserName": username, "UserFlag": userflag });
            //alert(jsstr);
            myAjax("/Service/RoleServices.asmx/GetUserAll", JSON.stringify({ "json": jsstr }), function (data) {
                var rel = JSON.parse(data["d"]);
                maxpage = JSON.parse(data["d"])["page"];
                var count = JSON.parse(data["d"])["count"];
                $("#leftPage").text("共有" + count + "条记录，当前第" + index + "/" + maxpage + "页");
                $("#tbs tbody tr").remove();
                $(rel["list"]).each(function (k, v) {
                    var tr = $("<tr></tr>");
                    var td1 = $("<th>" + v["UserName"] + "</th>");
                    var td2 = $("<th>" + v["Role_name"] + "</th>");
                    var str = v["UserFlag"] == "1" ? "可用" : "不可用";
                    var td3 = $("<th>" + str+ "</th>");
                    var td4 = $("<th><input type='image' src='../images/bt_deal.gif' title='编辑' key='" + v["UserID"] + "'  pwd='" + v["UserLPWD"] + "'  lname='" + v["UserLName"] + "'  roleid='" + v["RoleID"] + "' name='" + v["UserName"] + "' flag='"+v["UserFlag"]+"' />&nbsp;&nbsp;<input type='image' title='删除' src='../images/del.gif' key='" + v["UserID"] + "' /></th>");
                    $(tr).append(td1)
                    .append(td2)
                    .append(td3)
                    .append(td4);
                    $("#tbs tbody").append(tr);
                });

            });
        }
        function change() {
            roleid = $("#RoleID option:selected").val();
            username = $("#UserName").val();
            userflag = $("#UserFlag option:selected").val();
            GetData();
        }
        function change1() {
            roleid = $("#RoleID option:selected").val();
            username = $("#UserName").val();
            userflag = $("#UserFlag option:selected").val();
            GetData();
        }
    </script>
</head>


<body>
    <div id="desDiv">
        <span>用户管理</span><br />
      添加，修改用户信息，  修改用户的角色权限
    </div>
    <table class="tableEdit"  width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>角色类型：</td>
            <td>
                <select id="RoleID"  onchange="change()">
                    
                </select>

            </td>
            <td>用户名：</td>
            <td><input type="text" id="UserName" /></td>
            <td>是否可用：</td>
            <td><select id="UserFlag" onchange="change1()" >
                 <option value="-1">全部</option>
                <option value="1">可用</option>
                <option value="0">禁用</option>
                </select></td>
        </tr>
    <tfoot>
        <tr>
            <td colspan="8"><input type="button" value="查询" /></td>
        </tr>
    </tfoot>
</table>
<br/>
    <div id="dataDiv">
        <div id="headDiv">
            <img src="../images/22.gif" />&nbsp;&nbsp;<a id="add" style="cursor:pointer;">新建</a>
        </div>
        <table class="dataTable" id="tbs">
            <thead>
                <tr>
                    <th>用户名称</th>
                    <th>用户角色</th>
                    <th>是否可用</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody></tbody>

        </table>
        <div id="pageDiv">
            <div id="leftPage">共有120条记录，当前第1/10页</div>
            <div id="rightPage">
                <input type="image" src="../images/first.gif" method="shou" />&nbsp;&nbsp;
                <input type="image" src="../images/back.gif" method="shang" />&nbsp;&nbsp;
                <input type="image" src="../images/next.gif" method="xia" />&nbsp;&nbsp;
                <input type="image" src="../images/last.gif" method="wei" />&nbsp;&nbsp;
                转到第<input type="text" size="1" id="size" />&nbsp;&nbsp;<input method="go" type="image" src="../images/go.gif" />
            </div>
        </div>
    </div>
</body>
</html>
