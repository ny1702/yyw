
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
 登录成功！
 <shiro:hasRole name="经理">
     <a href="admin/main.jsp">进入主界面</a>
 </shiro:hasRole>
</body>
</html>
