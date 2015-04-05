﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="UI.Customer.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../CSS/style2.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table class="tableEdit">
        <thead>
            <tr>
                <td colspan="4">客户信息编辑</td>
            </tr>
        </thead>
        <tr>
            <th>客户编号：</th>
            <td>
                HK201002120003</td>
            <th>客户经理：</th>
            <td>张三
            </td>
        </tr>
        <tr>
            <th>客户名称：</th>
            <td>
                <input type="text" />
             </td>
            <th>邮政编码：</th>
            <td><input type="text" />
            </td>
        </tr>
        <tr>
            <th>地址：</th>
            <td colspan="3">
                <input type="text" style="width:90%"/>
             </td>
        </tr>
        <tr>
            <th>传真：</th>
            <td>
                <input type="text" />
             </td>
            <th>Email：</th>
            <td><input type="text" />
            </td>
        </tr>
         <tr>
            <th>营业执照注册号：</th>
            <td>
                <input type="text" />
             </td>
            <th>法人：</th>
            <td><input type="text" />
            </td>
        </tr>
        <tr>
            <th>注册资金：</th>
            <td>
                <input type="text" />
             </td>
            <th>年营业额：</th>
            <td><input type="text" />
            </td>
        </tr>
        <tr>
            <th>开户银行：</th>
            <td>
                <input type="text" />
             </td>
            <th>银行账号：</th>
            <td><input type="text" />
            </td>
        </tr>
        <tr>
            <th>地税登记号：</th>
            <td>
                <input type="text" />
             </td>
            <th>国税登记号：</th>
            <td><input type="text" />
            </td>
        </tr>
        <tr>
            <th>创建时间：</th>
            <td>
                2011-2-11
             </td>
            <th></th>
            <td>
            </td>
        </tr>
        <tfoot>
            <tr>
                <td colspan="4">
                    <input type="button" value="确定" />&nbsp;&nbsp;
                    <input type="button" value="关闭" onclick="window.close()" />
                </td>
            </tr>
        </tfoot>
    </table>
</body>
</html>
