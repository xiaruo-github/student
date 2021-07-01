<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试ajax请求里的contentType以及dataType</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-ui-1.12.1.custom/external/jquery/jquery.js"></script>

</head>
<body>
<script>
    var param ={
        "userName":"郭新桥",
        "webSite":"http://www.roadjava.com"
    };
    /*
    Content-Type
        1.默认值: application/x-www-form-urlencoded; charset=UTF-8
        对应的后台使用request.getParameter("userName")的方式来进行接受参数.
        2."application/json",给后台传递的参数要是json字符串
    dataType:用于预期服务器的返回类型,xml、html、text、json(会尝试使用
    JSON.parse来读返回的结果解析)，不一定和Content-Type连用,一般不需要使用;
    要和服务器返回的类型保持一致
     */
    $.ajax({
        type:"post",
        url:"<%=request.getContextPath()%>/testAjaxServlet",
        // data:param,
        data:JSON.stringify(param),
        contentType:"application/json",
        // dataType:"json",
        success:function (result) {
            console.log(result);
            console.log(typeof result);
            // console.log(JSON.parse(result));
            // console.log(typeof JSON.parse(result));
        }
    });

</script>

</body>
</html>
