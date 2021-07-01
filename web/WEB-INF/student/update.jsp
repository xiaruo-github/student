<%@ page import="com.roadjava.javaweb.student.beans.vo.StudentVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>更新学生页面-学生成绩管理系统-java web实战</title>
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
        <form action="<%= request.getContextPath()%>/studentServlet?type=update&pageNow=${requestScope.pageNow}" method="post">
            <%
                StudentVO studentVO = (StudentVO) request.getAttribute("studentVO");
            %>
            <div>
                <label>
                    学生编号:
                    <!--disabled的不能提交，如果用了disabled又想提交，就要再加个hidden的input来提交
                    disabled的input里面的内容-->
                    <input type="text" readonly name="studentId" value="<%= studentVO.getId()%>"/>
                </label>
            </div>
            <div>
                <label>
                    学生姓名:
                    <!--pagescope req session application-->
                    <input type="text" name="studentName" value="${studentVO.name}"/>
                </label>
            </div>
            <div>
                <label>
                    &nbsp;&nbsp;&nbsp;&nbsp;学号:
                    <input type="text" name="no" value="${requestScope.studentVO.no}"/>
                </label>
            </div>
            <div>
                <label>
                    &nbsp;&nbsp;&nbsp;&nbsp;生日:
                    <input type="text" name="birthDay" value="${studentVO.birthDay}"/>
                </label>
            </div>
            <div>
                <label>
                    &nbsp;&nbsp;&nbsp;&nbsp;专业:
                    <input type="text" name="maj" value="${studentVO.maj}"/>
                </label>
            </div>
            <div>
                <input type="submit" value="更新"/>
            </div>
        </form>
    </div>
    <jsp:include page="../bottom.jsp"/>
</div>
</body>
</html>
