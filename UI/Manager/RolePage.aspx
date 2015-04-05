<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RolePage.aspx.cs" Inherits="UI.Manager.RolePage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <style>
        .d1 {
            margin-bottom:5px;
            height:25px;
            width:190px;
            line-height:25px;
            text-align:left;
            background-color:#1A7BB0;
            margin-left:0px;
               cursor:pointer;
            color:white;
            float:left;
        }
         .d2 {
             width:180px;
             background-color:white;
             display:none;
            margin-left:10px;
            cursor:pointer;
        }
        .d3 {
            background-color:#B5D6E6;
            height:25px;
            margin-right:5px;
            float:left;
        }
          .d4 {
            background-color:#B5D6E6;
            height:25px;
            float:left;
        }
    </style>
    <link href="../themes/icon.css" rel="stylesheet" />
    <link href="../themes/default/easyui.css" rel="stylesheet" />
    <script src="../JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="../JS/jquery.easyui.min.js"></script>
    <script src="../JS/json.js"></script>
    <script src="../JS/MyJs.js"></script>
    <script type="text/javascript">
        var id = null;
        var url = "../Service/MyProcessRequst.ashx";
        $(function () {
            //模块权限全选
            $("input[type=checkbox][ck1=ck1]").live("click", function () {
                var fg = $(this).attr("checked");
                var d = $(this).parent().parent();
                $(d).next("div").children(":checkbox").attr("checked",fg);
            });
            //树形菜单展开
            $(".d4").live("click", function () {
               // alert($(this).html());
                var pdiv = $(this).parent();
                $(pdiv).next("div").slideToggle(450);
            });
            //授权操作
            $("#div_right").dialog({
                title: "权限管理",
                width: 270,
                height: 400,
                modal: true,
                closed: true,
                toolbar: [
                    {
                        text: "返回",
                        iconCls: "icon-back",
                        handler: function () {
                            $("#div_right").dialog("close");
                        }
                    },
                    {//授权操作
                        text: "保存",
                        iconCls: "icon-save",
                        handler: function () {
                            if (confirm("确认授权操作？")) {
                                var roleid = $("#roleid").val();
                                $.post(url + "?method=DelRightRoleByID&role_id=" + roleid, null, function (data) { });//清除角色权限
                                var roleright = "";
                                $("#div_right .d2 input[type=checkbox]:checked").each(function (k, v) {
                                    roleright += v.value;
                                    roleright += ".";
                                });
                                $.post(url + "?method=AddRightRole&role_id=" + roleid + "&right=" + roleright, null, function (data) {
                                    if (data > 0) {
                                        alert("操作成功！");
                                        $("#div_right").dialog("close");
                                    }
                                });//添加角色权限
                            }
                        }
                    }
                ]
            });
            //授权页面访问
            $("#div_list").dialog({
                title: "页面访问权限编辑",
                width: 270,
                height: 400,
                modal: true,
                closed: true,
                toolbar: [
                    {
                        text: "返回",
                        iconCls: "icon-back",
                        handler: function () {
                            $("#div_list").dialog("close");
                        }
                    },
                    {//授权操作
                        text: "保存",
                        iconCls: "icon-save",
                        handler: function () {
                            if (confirm("确认授权操作？")) {
                                var roleid = $("#roleid").val();
                                $.post(url + "?method=ClearRoleList&role_id=" + roleid, null, function (data) {
                                    if (data < 1) {
                                        alert('操作失败！！！');
                                        return;
                                    }
                                });//清除角色权限
                                var roleright = "";
                                $("#div_list .d2 input[type=checkbox]:checked").each(function (k, v) {
                                    roleright += v.value;
                                    roleright += ".";
                                });
                                $.post(url + "?method=AddRoleList&role_id=" + roleid + "&right=" + roleright, null, function (data) {
                                    if (data > 0) {
                                        alert("操作成功！");
                                        $("#div_list").dialog("close");
                                    }
                                });//添加访问页面权限
                            }
                        }
                    }
                ]
            });
            //查询出所有操作权限
            $.post("../Service/MyProcessRequst.ashx?method=GetRightAll", null, function (data) {
                    $.post("../Service/MyProcessRequst.ashx?method=GetRightTpye", null, function (da) {
                        $(JSON.parse(da)).each(function (k, v) {
                            var d1 = $("<div class='d1'><div>");
                            var d1_1 = $("<div class='d3' > <input type='checkbox' ck1='ck1'/> </div>");
                            var d1_2 = $("<div class='d4'> <font  style='color:white;font-size:16px;font-weight:bolder;'>" + v["Right_type"] + "&nbsp;&nbsp;</font> <div>");
                            //str1.addClass("t");
                            
                            var br1 = $("<br/>");
                            $(d1).append(d1_1).append(d1_2).append(br1);
                            $("#right").append(d1);
                            var d2 = $("<div class='d2'><div>")
                            $(JSON.parse(data)).each(function (i, j) {
                                if (v["Typeid"] == j["Typeid"]) {
                                    var chx = $("<input type='checkbox' name='rights' value='" + j["Right_code"] + "' >");
                                    var str = $("<font rt='" + j["Right_code"] + "' >" + j["Right_tip"] + "&nbsp;&nbsp;</font>");
                                    str.addClass("c");
                                    var br = $("<br/>");
                                    d2.append(chx).append(str).append(br);
                                    $("#right").append(d2);
                                }
                            });
                        });
                    });
            });
            //查询出所有页面访问权限
            $.post("/Service/MyProcessRequst.ashx?method=GetUserListToolsAll", null, function (data) {
                var llist = JSON.parse(data)["llist"];
                var tlist = JSON.parse(data)["tlist"];
                $(tlist).each(function (k, v) {
                    var d1 = $("<div class='d1'><div>");
                    var d1_1 = $("<div class='d3' > <input type='checkbox' ck1='ck1'/> </div>");
                    var d1_2 = $("<div class='d4' > <font style='color:white;font-size:16px;font-weight:bolder;'>" + v["Typename"] + "&nbsp;&nbsp;</font></div>");
                    var br1 = $("<br/>");
                    d1.append(d1_1).append(d1_2).append(br1);
                    $("#list").append(d1);
                    var d2 = $("<div class='d2'><div>")
                    $(llist).each(function (i, j) {
                        if (j["Listtype"] == v["Id"]) {
                            var chx = $("<input type='checkbox' name='rights' value='" + j["Listid"] + "' >");
                            var str = $("<font rt='" + j["Listid"] + "' >" + j["Listname"] + "&nbsp;&nbsp;</font>");
                            str.addClass("c");
                            var br = $("<br/>");
                            d2.append(chx).append(str).append(br);
                            $("#list").append(d2);
                        }
                    });
                   
                });
            });
        });
      
        $(function () {
            $("#diva").dialog({
                title: "权限管理",
                width: 300,
                height: 250,
                modal: true,
                closed: true,
                toolbar: [
                     {
                         text:"返回",
                         iconCls: "icon-back",
                         handler: function () {
                             $("#diva").dialog("close");
                         }
                     },
                    {
                        text: "保存",
                        iconCls: "icon-save",
                        handler: function () {
                            if (IsNULL($("input[name=Role_name]").val())) {
                                alert("角色名不能为空！");
                                return;
                            }
                            if (confirm("确认修改？")) {
                                var flag = $("input[type=radio]:checked").val();
                                var jsstr = JSON.stringify({
                                    "Role_id": id,
                                    "Role_name": $("input[name=Role_name]").val(),
                                    "Role_desc": $("textarea[name=Role_desc]").text(),
                                    "Role_flag": flag
                                });
                              
                                $.get(url + "?method=UpOrAddRole&json=" + encodeURI(jsstr), null, function (data) {
                                    if (data > 0) {
                                        alert("操作成功！");
                                        $("#diva").dialog("close");
                                        GetData();
                                    } else {
                                        alert("未知错误，操作失败！");
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            GetData();
        });

        function GetData() {
            $("#tbs").datagrid({
                url: "../Service/MyProcessRequst.ashx",//请求路径
                queryParams: {//参数
                    method: "GetRoleAll"
                },
                loadMsg: "数据正在加载中，请稍等...",
                striped: true,//是否显示斑马线
                rownumbers: true,//是否显示行号
                singleSelect:true,//只能选择一行
                // pagination:true,//是否使用分页
                columns: [[//显示数据绑定列
                        { field: "Role_name", title: "角色名称", align: "center", width: 220 },
                         { field: "Role_desc", title: "角色描述", align: "center", width: 530 },
                          {
                              field: "Role_flag", title: "是否可用", align: "center", width: 150, formatter: function (value, row, index) {
                                  return value == 1 ? "可用" : "不可用";
                              }
                          },
                           { field: "Role_name", title: "操作", align: "center", width: 200 }
                ]],
                toolbar: [
                    {//添加
                        text: "添加",
                        iconCls: "icon-add",
                        handler: function () {
                            $("#f1").form("clear");//清除表单数据
                            $("#diva").dialog("open");
                            id = null;
                        }
                    },
                     {//查看权限
                         text: "编辑操作权限",
                         iconCls: "icon-search",
                         handler: function () {
                             var row = $("#tbs").datagrid("getSelected");
                             if (row) {
                                 role_id = row["Role_id"];
                                 $("#div_right").dialog("open");
                                 $("#roleid").val( row["Role_id"]);
                                 $.post("../Service/MyProcessRequst.ashx?method=GetRightRoleByID&role_id=" + role_id + "", null, function (data) {
                                     $("#div_right input[type=checkbox]").attr("checked", false);
                                     var rel = JSON.parse(data);
                                     $("#div_right font").removeClass("x");
                                     $("#div_right font").addClass("c");
                                     $(rel).each(function (k, v) {
                                         $("#div_right input[type=checkbox]");
                                         $("#div_right input[type=checkbox][value=" + v["Rf_right_code"] + "]").attr("checked", true);
                                         $("#div_right font[rt=" + v["Rf_right_code"] + "]").removeClass("c").addClass("x");
                                     });
                                 });
                             } else {
                                 alert("请选择行！");
                             }
                         }
                     },
                     {//查看权限
                         text: "编辑页面访问权限",
                         iconCls: "icon-search",
                         handler: function () {
                             $("#div_list").dialog("open");
                             var row = $("#tbs").datagrid("getSelected");
                             if (row) {
                                 role_id = row["Role_id"];
                                 $("#div_list").dialog("open");
                                 $("#roleid").val(row["Role_id"]);
                                 $.post("../Service/MyProcessRequst.ashx?method=GetUserListToolstoo&role_id=" + role_id + "", null, function (data) {
                                     $("#div_list input[type=checkbox]").attr("checked", false);
                                     var rel = JSON.parse(data);
                                     $("#div_list font").removeClass("x");
                                     $("#div_list font").addClass("c");
                                     $(rel).each(function (k, v) {
                                         $("#div_list input[type=checkbox]");
                                         $("#div_list input[type=checkbox][value=" + v["Listid"] + "]").attr("checked", true);
                                         $("#div_list font[rt=" + v["Listid"] + "]").removeClass("c").addClass("x");
                                     });
                                 });
                             } else {
                                 alert("请选择行！");
                             }
                         }
                     },
                    
                       {//修改
                           text: "修改",
                           iconCls: "icon-edit",
                           handler: function () {
                               var row = $("#tbs").datagrid("getSelected");
                               if (row) {
                                   $("#diva").dialog("open");
                                   id = row["Role_id"]
                                   $("#f1").form("load", row);//将行对象里面的数据绑定到表单中
                                   $("input[type=radio][value="+row["Role_flag"]+"]").attr("checked", true);
                                   
                               } else {
                                   alert("请选择行！");
                               }
                           }
                       },
            //    {//删除
            //    text: "删除",
            //iconCls: "icon-cancel",
            //handler: function () {
            //    var row = $("#tbs").datagrid("getSelected");
            //    if (row) {
            //        if (confirm("确认删除?")) {
            //            $.get("../Service/MyProcessRequst.ashx" + "?method=DelRole&id=" + row["Role_id"], null, function (data) {
            //                if (data > 0) {
            //                    alert("操作成功！");
            //                    GetData();
            //                } else {
            //                    alert("操作失败！");
            //                }
            //            });
            //        }
            //    } else {
            //        alert("请选择要删除的行！");
            //    }
                          
            //}
            //    }

                ]
            });
        }

    </script>
    <style>
        .headDiv {
            border: solid 1px #B5D6E6;
            background-color: #EFEFEF;
            padding: 5px;
            font-size:12px;
        }
        .sp {
             
            font-weight: bold;
            font-size: 14px;
        }
       
          .c {
            color:silver;
        }
        .x {
            color:#1A7BB0;
        }

    </style>
</head>


<body>
   <div>
     
       <div class="headDiv">
           <span class="sp">角色管理</span><br />
           添加，修改，删除，禁用角色,管理角色的权限
       </div>
        <table class="dataTable" id="tbs">
           
        </table>
       <div id="diva">
           <form id="f1">
               <table>
                   <tr>
                       <th >角色名称：</th>
                       <th><input name="Role_name" type="text" placeholder="请输入角色名称" /></th>
                   </tr>
                   <tr>
                       <th>角色描述：</th>
                       <th>
                           <textarea name="Role_desc" rows="6" cols="17"></textarea>
                       </th>
                   </tr>
                   <tr>
                       <th>是否启用：</th>
                       <th><input name="Role_flag" type="radio" value="1" />启用&nbsp;<input name="Role_flag" type="radio" value="0" />禁用</th>
                   </tr>
               </table>
           </form>
       </div>
       <div id="div_right">
           <div id="right" style="padding:30px;font-size:15px;">
               <input id="roleid" type="hidden"  />
           </div>
       </div>
          <div id="div_list">
           <div id="list" style="padding:30px;font-size:15px;">
              
           </div>
       </div>

    </div>

</body>
</html>
