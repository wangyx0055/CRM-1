<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="500.aspx.cs" Inherits="UI.Error._500" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script>
        //确保登录页面不作为框架页面显示，而是显示为独立的页面
        if (window.top != window.self) {
            window.top.location = "~/Error/500.aspx";
        }
    </script>
</head>
<body>
 <div style="background-image:url('../Images/logo.jpg');background-repeat:round;width:100%;height:600px">
        <div style="font-size:20px;color:red;font-family:'Segoe UI Emoji';font-weight:bold;margin-left:10px;">
            好像出错了，⊙﹏⊙b汗！！！<br/><br/><br/>
              <a  href="#" onclick="javacsript:history.go(-1)">点击返回上页</a>
        </div>
        </div>
</body>
</html>
