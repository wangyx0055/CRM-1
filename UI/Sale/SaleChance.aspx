<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaleChance.aspx.cs" Inherits="UI.Sale.SaleChance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/Style1.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.8.2.js"></script>
    <script src="../JS/json.js"></script>
    <script type="text/javascript">
        function showEdit() {
            //参数：在弹出窗体使用window.dialogArguments获取
            //returnValue：为弹出窗体的返回值，在弹出窗体设置window.returnValue
            var returnValue = window.showModalDialog("EditSale.aspx?data=" + Math.random(), "参数", "dialogWidth:600px;dialogHeight:300px;help:no");
        }

    </script>
    <script src="../JS/MyJs.js"></script>
    <script>
        var index = 1;
        var maxpage;
        var count;
        var channame = "";
        var linkman = "";
        $(function () {
            //输入查询
            $("#ChanName").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                linkman = $("#ChanLinkMan").val();
                Getdata();
            });
            $("#ChanLinkMan").keyup(function () {
                index = 1;
                channame = $("#ChanName").val();
                linkman = $("#ChanLinkMan").val();
                Getdata();
            });

           //第一次进入查询
            Getdata();
            $("#rightPage input[method]").click(function() {
                var method = $(this).attr("method");
              
                    if (method=="shou") {
                        index= 1;
                    } else if (method == "shang") {
                        index = index>1?index - 1:index;
                    } else if (method == "xia") {
                        index =index<maxpage? index + 1:index;
                    } else if (method =="wei") {
                        index = maxpage;
                    } else if (method == "go") {
                        
                        var number = $("#number").val();
                        try {
                            if (parseInt(number) <=parseInt( maxpage)) {
                                index =parseInt( number);
                            }
                        } catch (e) {
                            alert("输入有误！");
                        }
                       
                    }

                    Getdata();
               
            });

            //添加
            $("#add").click(function () {
                $.post("../Service/MyProcessRequst.ashx?&method=FGChanRoleAll&rightcode=R_0003", null, function (data) {
                    if (data < 1) {
                        alert("对不起，您当前没有拥有这个权限，如要继续进行，请联系系统管理员获取相应的权限！");
                    } else {
                        var rtdata = window.showModalDialog("EditSale.aspx?", null, "dialogWidth:600px;dialogHeight:300px;help:no");
                        if (rtdata != null) {
                            if (rtdata["ChanID"] > 0) {
                                alert("添加成功！");
                                Getdata();
                            }
                        }
                    }
                });
                
            });

            //删除
            $("img[title=删除]").live("click", function () {
                if(confirm("确认删除？"))
                {
                    var id = $(this).attr("key");
                    myAjax("/Service/ChanServices.asmx/DelChances", JSON.stringify({ "id": id }), function (d) {
                        if (d["d"]) {
                            Getdata();
                        }
                    });
                }
            });

            //修改
            $("img[title=修改]").live("click", function () {
                var desc = $(this).attr("desc");
                var rate = $(this).attr("rate");
                var update = $(this);
                var tr = $(this).parent().parent().children("th");
                $.post("../Service/MyProcessRequst.ashx?&method=FGChanRoleAll&rightcode=R_0003", null, function (data) {
                    if (data < 1) {
                        alert("对不起，您当前没有拥有这个权限，如要继续进行，请联系系统管理员获取相应的权限！");
                    } else {
                      
                        var u = { "ChanName": tr[0].innerText, "ChanTitle": tr[1].innerText, "ChanLinkMan": tr[2].innerText, "ChanLinkTel": tr[3].innerText, "ChanDesc": desc, "ChanRate": rate };
                        var rtdata = window.showModalDialog("EditSale.aspx?", u, "dialogWidth:600px;dialogHeight:300px;help:no");
                        if (rtdata != null) {
                            if (rtdata["ChanID"] > 0) {
                                alert("修改成功！");
                                //Getdata();
                                tr[0].innerText = rtdata["ChanName"];
                                tr[1].innerText = rtdata["ChanTitle"];
                                tr[2].innerText = rtdata["ChanLinkMan"];
                                tr[3].innerText = rtdata["ChanLinkTel"];
                                update.attr("desc", rtdata["ChanDesc"]);
                                update.attr("rate", rtdata["ChanRate"]);
                            }
                        }
                    }
                });
            });

            //查询
            $("input[type=button][value=查询]").click(function () {
                channame = $("#ChanName").val();
                linkman = $("#ChanLinkMan").val();
                Getdata();
            });
        });
        //分页查询方法
        function Getdata() {
            var jsstr = JSON.stringify({ "ChanID": index, "ChanLinkMan": linkman, "ChanName": channame });
            $.ajax({
                type: "POST",
                url: "/Service/ChanServices.asmx/GetChancesAll",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify({"json":jsstr}),
                success: function (d) {
                    maxpage = JSON.parse(d["d"])["page"];
                    count = JSON.parse(d["d"])["count"];
                    $("#leftPage").text("共有" + count + "条记录，当前第" + index + "/" + maxpage + "页");
                    $("#tbs1 tbody tr").remove();
                    var rel = JSON.parse(d["d"])["list"];
                    for (var i = 0; i < rel.length; i++) {
                        var tr = $("<tr></tr>");
                        var td1 = $("<th>" + rel[i]["ChanName"] + "</th>");
                        var td2 = $("<th>" + rel[i]["ChanTitle"] + "</th>");
                        var td3 = $("<th>" + rel[i]["ChanLinkMan"] + "</th>");
                        var td4 = $("<th>" + rel[i]["ChanLinkTel"] + "</th>");
                        var td5 = $("<th>" + ConvertTime(rel[i]["ChanCreateDate"]) + "</th>");
                        var td6 = $("<th><img  title='修改' key='" + rel[i]["ChanID"] + "'  desc='"+rel[i]["ChanDesc"]+"'  rate='"+rel[i]["ChanRate"]+"'  src='../images/edt.gif'/>&nbsp;&nbsp;<img title='删除' key='" + rel[i]["ChanID"] + "' src='../images/del.gif' /></th>")
                        $(tr)
                            .append(td1)
                            .append(td2)
                            .append(td3)
                            .append(td4)
                            .append(td5)
                            .append(td6);
                        $("#tbs1 tbody").append(tr);
                    }

                }
            });

        }


    </script>
</head>
<body>
<div id="desDiv">
    <span>销售机会管理</span><br />
    创建和维护销售机会
</div>
<div id="dataDiv">
    <div id="headDiv">
        <img src="../images/22.gif"  alt="新建"/>&nbsp;&nbsp;<a id="add" style="cursor:pointer;">新建</a>
    </div>
    <table class="tableEdit" style="width:100%">
        <tr>
            <th>
                客户名称：
            </th>
            <td>
                <input type="text" id="ChanName" />
            </td>
            <th>
                联系人：
            </th>
            <td>
                <input type="text" id="ChanLinkMan" />
            </td>
        </tr>
        <tfoot>
            <tr>
                <td colspan="8">
                    <input type="button" value="查询" />
                </td>
            </tr>
        </tfoot>
    </table>
    <table class="dataTable" id="tbs1">
        <thead>
            <tr>
                <th>客户名称</th>
                <th>概要</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            
        </tbody>
    </table>
    <div id="pageDiv">
        <div id="leftPage"></div>
        <div id="rightPage">
            <input method="shou"type="image" src="../images/first.gif" />&nbsp;&nbsp;
            <input method="shang" type="image" src="../images/back.gif" />&nbsp;&nbsp;
            <input method="xia" type="image" src="../images/next.gif" />&nbsp;&nbsp;
            <input method="wei" type="image" src="../images/last.gif" />&nbsp;&nbsp;
            转到第<input type="text" size="1" id="number" />&nbsp;&nbsp;<input method="go" type="image" src="../images/go.gif" />
        </div>
    </div>
</div>
</body>
</html>
