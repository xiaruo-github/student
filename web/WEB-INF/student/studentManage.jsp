<%@ page import="com.roadjava.javaweb.student.beans.res.TableResult" %>
<%@ page import="com.roadjava.javaweb.student.beans.entity.StudentDO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.roadjava.javaweb.student.beans.vo.StudentVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生管理-学生成绩管理系统-java web实战</title>
    <style>
        table {
            border-collapse: collapse;
            border-spacing: 0;
            border: 1px solid black;
        }
        tr {
            line-height: 2;
        }
        th,td{
            border: 1px solid black;
            padding: 0 10px;
        }
        #cont {
            text-align: left;
            margin-left: 560px;
            margin-top: 50px;
            line-height: 1.5;
        }
        .nav,.search,.page {
            line-height: 2;
        }
    </style>
</head>
<body>
<div>
    <jsp:include page="../top.jsp"/>
    <div id="cont">
        <section class="nav">
            <a href="<%=request.getContextPath()%>/studentServlet?type=toStudentManage">学生管理</a>
            <a href="<%=request.getContextPath()%>/scoreServlet?type=toScoreManage">成绩管理</a>
        </section>
        <section class="search">
            <%
                TableResult<StudentVO> tableResult = (TableResult) request.getAttribute("tableResult");
            %>
            <a href="<%=request.getContextPath()%>/studentServlet?type=toAdd">新增学生</a>
            <form method="post" action="<%=request.getContextPath()%>/studentServlet?type=toStudentManage">
                <input type="text" name="studentName" value="<%= tableResult.getStudentName()%>"/>
                <!--value在没有被别人修改的情况下就是1,
                    由于不是ajax局部刷新，页面是整体刷新的，所以即便pageNow被修改了，查询结果
                    出来的页面中的pageNow仍然还是1
                -->
                <input type="hidden" name="pageNow"  id="pageNow" value="1"/>
                <input type="submit" value="查询">
            </form>
        </section>
        <section>
            <table>
                <thead>
                    <tr>
                        <th>编号</th>
                        <th>学生姓名</th>
                        <th>学号</th>
                        <th>生日</th>
                        <th>专业</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<StudentVO> data = tableResult.getData();
                        for (int i =0; i< data.size();i++) {
                            StudentVO studentVO = data.get(i);
                    %>
                    <tr>
                        <td><%= studentVO.getId()%></td>
                        <td><%= studentVO.getName()%></td>
                        <td><%= studentVO.getNo()%></td>
                        <td><%= studentVO.getBirthDay()%></td>
                        <td><%= studentVO.getMaj()%></td>
                        <td>
                            <a href="<%=request.getContextPath()%>/studentServlet?type=delete&id=<%= studentVO.getId()%>">删除</a>
                            <a href="<%=request.getContextPath()%>/studentServlet?type=toUpdate&id=<%= studentVO.getId()%>&pageNow=<%=tableResult.getPageNow()%>">修改</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <div class="page">
                <%
                    // 只要不是第一页就显示
                    if (tableResult.getPageNow() != 1) {
                %>
                    <a href="#" onclick="goFirst()">首页</a>
                    <a href="#" onclick="goPre()">上一页</a>
                <%
                    }
                %>
                <%
                    // 只要不是最后一页就显示
                    if (tableResult.getPageNow() != tableResult.getPageCount()) {
                %>
                    <a href="#" onclick="goNext()">下一页</a>
                    <a href="#" onclick="goLast()">尾页</a>
                <%
                    }
                %>
                <span>共<%=tableResult.getPageCount()%>页</span>
                <span>,共<%=tableResult.getTotalCount()%>条</span>
                <span>,当前是<%=tableResult.getPageNow()%>页</span>
            </div>
        </section>
    </div>
    <jsp:include page="../bottom.jsp"/>
</div>
<script>
    // 首页
    function goFirst() {
        document.forms[0].submit();
    }
    // 上一页
    function goPre() {
        // 1.拿到当前页
        var currentPageStr = "<%=tableResult.getPageNow()%>";
        var prePage = parseInt(currentPageStr) - 1;
        // 2.修改搜索里面提交的pageNow
        document.getElementById("pageNow").value = prePage;
        document.forms[0].submit();
    }
    // 下一页
    function goNext() {
        var currentPageStr = "<%=tableResult.getPageNow()%>";
        var nextPage = parseInt(currentPageStr) + 1;
        document.getElementById("pageNow").value = nextPage;
        document.forms[0].submit();
    }
    // 尾页
    function goLast() {
        var pageCountStr = "<%=tableResult.getPageCount()%>";
        document.getElementById("pageNow").value = parseInt(pageCountStr);
        document.forms[0].submit();
    }
</script>
</body>
</html>
