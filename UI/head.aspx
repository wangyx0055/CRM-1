<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="head.aspx.cs" Inherits="UI.head" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <script src="JS/jquery-1.4.1-vsdoc.js"></script>
    <script src="JS/json.js"></script>
    <script src="JS/MyJs.js"></script>
    <script>
        $(function () {
            //回主页
            $("#loginname").click(function () {
               top.location.href = "Main.aspx";
            });
            //注销
            $("#esc").click(function () {
                if (confirm("确认退出吗？")) {
                    $.post("/Service/MyProcessRequst.ashx?method=EscLogin", null, function (data) {
                        if (data>0) {
                            parent.document.location.href = "login.aspx";
                        }
                    });
                }
            });
          
            //显示登录信息
            myAjax("/Service/UsersServices.asmx/GetUsersInfo", null, function (data) {
                try {
                    var u = JSON.parse(data["d"]);
                    $("#loginname").text(u["Role_name"]+"-"+ u["UserName"])
                } catch (e) {
                    alert("登录错误！！！返回登录页面重新登录。");
                    $.post("/Service/MyProcessRequst.ashx?method=EscLogin", null, function (data) {
                        if (data > 0) {
                            parent.document.location.href = "login.aspx";
                        }
                    });
                }
                    
             
            });
        });

        function showtime() {
            var dt = new Date();
            var str = dt.toLocaleString();
            $("#nowdate").text(str);
        }
        window.setInterval("showtime()",1000);
    </script>
    <style type="text/css">
body {
	margin:0px;
}
.STYLE1 {
	font-size: 12px;
	color: #FFFFFF;
}
.STYLE2 {font-size: 9px}
.STYLE3 {
	color: #033d61;
	font-size: 12px;
}
</style>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="70" background="images/main_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" height="24" background="images/main_03.gif">&nbsp;</td>
            <td width="505" background="images/main_04.gif">&nbsp;</td>
            <td>&nbsp;</td>
            <td width="21"><img src="images/main_07.gif" width="21" height="24"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" height="38" background="images/main_09.gif">&nbsp;</td>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="77%" height="25" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                </table></td>
                <td width="220" valign="bottom"  nowrap="nowrap"><div align="right"><span class="STYLE1"><span class="STYLE2">■</span> 今天是：<span id="nowdate"></span></span></div></td>
              </tr>
            </table></td>
            <td width="21"><img src="images/main_11.gif" width="21" height="38"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="8" style=" line-height:8px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" background="images/main_29.gif" style=" line-height:8px;">&nbsp;</td>
            <td width="505" background="images/main_30.gif" style=" line-height:8px;">&nbsp;</td>
            <td style=" line-height:8px;">&nbsp;</td>
            <td width="21" style=" line-height:8px;"><img src="images/main_31.gif" width="21" height="8"></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="28" background="images/main_36.gif">
   <div id="loginname" style="background-image:url(images/main_32.gif);width:177px;height:28px;text-align:center;color:White;font-size:12px;line-height:35px;float:left;cursor:pointer;" title="点击回主页">

   </div>
   <div style="float:right;font-size:12px;line-height:35px;margin-right:5px;margin-top:3px;">
    <a href="#" ><img src="images/main_20.gif" style="border:solid 0px red" id="esc"/></a>
   </div>
    </td>
  </tr>
</table>
</body>
</html>
