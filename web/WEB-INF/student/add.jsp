<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加学生页面-学生成绩管理系统-java web实战</title>
    <style>
        #cont {
            text-align: center;
            margin-top: 150px;
        }
        #cont div {
            padding: 15px;
        }
    </style>
</head>
<body>
<div>
    <jsp:include page="../top.jsp"/>
    <div id="cont">
        <form action="<%= request.getContextPath()%>/studentServlet?type=add" method="post">
            <div>
                <label>
                    学生姓名:
                    <input type="text" name="studentName"/>
                </label>
            </div>
            <div>
                <label>
                    &nbsp;&nbsp;&nbsp;&nbsp;学号:
                    <input type="text" name="no"/>
                </label>
            </div>
            <div>
                <label>
                    &nbsp;&nbsp;&nbsp;&nbsp;生日:
                    <input type="text" name="birthDay"/>
                </label>
            </div>
            <div>
                <label>
                    &nbsp;&nbsp;专业:
                    <input type="text" name="maj"/>
                </label>
            </div>
            <div>
                <input type="submit" value="登记"/>
            </div>
        </form>
    </div>
    <jsp:include page="../bottom.jsp"/>
</div>
</body>
</html>
