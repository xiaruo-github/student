<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>jsp的本质</title>
  </head>
  <body>
  <jsp:forward page="/loginServlet"/>
  <h1 style='color:red'>下面是登录页面</h1>
  <form>
    <input type="text" name="userName"/>
    <input type="button" value="登录"/>
  </form>
  </body>
</html>
