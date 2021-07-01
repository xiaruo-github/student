<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面-学生成绩管理系统</title>
    <style>
        #cont div {
            text-align: center;
            padding: 15px;
        }
        #cont div:last-child input:first-child {
            margin-right: 30px;
        }
        #cont div:last-child input:last-child {
            margin-left: 30px;
        }
    </style>
</head>
<body>
<div style="margin-top: 150px">
    <jsp:include page="top.jsp"/>
    <div id="cont">
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
        <h3 style="color: red;text-align: center">出错信息:${message}</h3>
        <%
            }
        %>
        <form action="<%= request.getContextPath()%>/loginServlet?type=trueLogin" method="post">
            <div>
                <label for="userName">
                    用户名:
                </label>
                <input type="text" name="userName" id="userName"/>
            </div>
            <div>
                <label>
                    &nbsp;&nbsp;密码:
                    <input type="password" name="pwd"/>
                </label>
            </div>
            <div>
                <input type="submit" value="登录"/>
                <input type="button" onclick="resetForm()" value="重置"/>
            </div>
        </form>
    </div>
    <jsp:include page="bottom.jsp"/>
</div>
<script>
    function resetForm() {
        document.forms[0].reset();
    }
</script>
</body>
</html>
