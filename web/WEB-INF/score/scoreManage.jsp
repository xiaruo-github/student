<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>成绩管理-学生成绩管理系统-java web实战</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jquery-ui-1.12.1.custom/jquery-ui.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jquery-ui-1.12.1.custom/jquery-ui.theme.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-ui-1.12.1.custom/external/jquery/jquery.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
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
        #addScoreBtn {
            margin-top: 5px;
            margin-bottom: 10px;
        }
        #addScoreDia div label span {
            display: block;
            padding: 5px;
        }
        table a {
            display: inline-block;
            margin-left: 7px;
        }
        .page a {
            display: inline-block;
            margin-right: 7px;
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
            <input type="button" id="addScoreBtn" value="新增成绩"/>
            <form method="post">
                <input type="text" name="studentName"/>
                <input type="hidden" name="pageNow"  id="pageNow" value="1"/>
                <input type="button" onclick="doSearch()" value="查询">
            </form>
        </section>
        <section>
            <table>
                <thead>
                    <tr>
                        <th>成绩编号</th>
                        <th>学生姓名</th>
                        <th>学号</th>
                        <th>语文成绩</th>
                        <th>英语成绩</th>
                        <th>数学成绩</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="page">
            </div>
        </section>

        <section id="addScoreDia">
            <form method="post">
                <div>
                    <label>
                        <span>学生姓名:</span>
                        <select name="studentId"></select>
                    </label>
                </div>
                <div>
                    <label>
                        <span>语文成绩:</span>
                        <input type="text" name="cnScore"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>英语成绩:</span>
                        <input type="text" name="enScore"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>数学成绩:</span>
                        <input type="text" name="mathScore"/>
                    </label>
                </div>
            </form>
        </section>
        <!--更新模态框-->
        <section id="updateScoreDia">
            <form method="post">
                <div>
                    <label>
                        <span>成绩编号:</span>
                        <input type="text" name="id" readonly/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>学生姓名:</span>
                        <select name="studentId"></select>
                    </label>
                </div>
                <div>
                    <label>
                        <span>语文成绩:</span>
                        <input type="text" name="cnScore"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>英语成绩:</span>
                        <input type="text" name="enScore"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>数学成绩:</span>
                        <input type="text" name="mathScore"/>
                    </label>
                </div>
            </form>
        </section>

    </div>
    <jsp:include page="../bottom.jsp"/>
</div>
<script>
    // 点击显示
    $("#addScoreBtn").click(function () {
        $("#addScoreDia").dialog("open");
    });
    // 添加成绩模态框
    $("#addScoreDia").dialog({
        autoOpen:false,
        title :"添加成绩",
        modal: true,
        buttons : [
            {
                text:"确认添加成绩",
                click:doConfirmAddScore
            }
        ],
        create:function ( event, ui) {
            doLoadAllStudents("addScoreDia");
        }
    });
    // 更新成绩模态框
    $("#updateScoreDia").dialog({
        autoOpen:false,
        title :"更新成绩",
        modal: true,
        buttons : [
            {
                text:"确认更新成绩",
                click:doConfirmUpdateScore
            }
        ]
    });
    // 确认更新成绩
    function doConfirmUpdateScore() {
        var updateParam = {
            "type":"update",
            "id":$("#updateScoreDia input[name=id]").val(),
            "studentId":$("#updateScoreDia select[name=studentId]").val(),
            "cnScore":$("#updateScoreDia input[name=cnScore]").val(),
            "enScore":$("#updateScoreDia input[name=enScore]").val(),
            "mathScore":$("#updateScoreDia input[name=mathScore]").val()
        };
        $.ajax({
            type:"post",
            url:"<%=request.getContextPath()%>/scoreServlet",
            data:updateParam,
            success:function (result) {
                if (result.success) {
                    $("#updateScoreDia").dialog("close");
                    loadTable();
                }
            }
        });
    }
    /*
     加载所有学生
     selectedStudentId:需要被选中的学生id
     */
    function doLoadAllStudents(selector,selectedStudentId) {
        $.ajax({
           type:"post",
           url:"<%=request.getContextPath()%>/studentServlet",
           data:{"type":"loadAllStudents"},
           success:function (result) {
                if (result.success) {
                    var optionHtml = "";
                    for (var i = 0; i < result.data.length; i++) {
                        var oneStu = result.data[i];
                        if (selectedStudentId && selectedStudentId === oneStu["id"]) {
                            optionHtml += "<option selected value='"+oneStu["id"]+"'>"+oneStu["name"]+"</option>";
                        } else {
                            optionHtml += "<option value='"+oneStu["id"]+"'>"+oneStu["name"]+"</option>";
                        }
                    }
                    $("#"+selector+" select[name=studentId]").html(optionHtml);
                }
           }
        });
    }
    // 确认添加成绩
    function doConfirmAddScore() {
        // 构造提交对象
        var obj = {
            "type":"add",
            "studentId":$("#addScoreDia select[name=studentId]").val(),
            "cnScore":$("#addScoreDia input[name=cnScore]").val(),
            "enScore":$("#addScoreDia input[name=enScore]").val(),
            "mathScore":$("#addScoreDia input[name=mathScore]").val()
        };
        $.ajax({
            type:"post",
            url:"<%=request.getContextPath()%>/scoreServlet",
            data:obj,
            success:function (result) {
                if (result.success) {
                    // 重置添加表单
                    $("#addScoreDia form")[0].reset();
                    $("#addScoreDia").dialog("close");
                    doSearch();
                }else{
                    alert(result.data);
                }
            }
        });
    }

    // 加载表格
    function loadTable() {
        var paramObj = {
          "type" : "retrieveScores",
          "pageNow" : $("#pageNow").val(),
          "studentName":$("input[name=studentName]").val()
        };
        $.ajax({
            type:"post",
            url:"<%=request.getContextPath()%>/scoreServlet",
            data:paramObj,
            success:function (result) {
                if (result.success) {
                    showTbodyHtml(result.data);
                    showPageHtml(result.data);
                }else{
                    alert(result.data);
                }
            }
        });
    }
    function showTbodyHtml(tableResult) {
        var tbodyHtml = "";
        var scoreVOList = tableResult.data;
        for (let i = 0; i < scoreVOList.length; i++) {
            var scoreVO = scoreVOList[i];
            tbodyHtml += "<tr>"
                    +"<td>"+scoreVO["id"]+"</td>"
                    +"<td>"+scoreVO["name"]+"</td>"
                    +"<td>"+scoreVO["no"]+"</td>"
                    +"<td>"+scoreVO["cnScore"]+"</td>"
                    +"<td>"+scoreVO["enScore"]+"</td>"
                    +"<td>"+scoreVO["mathScore"]+"</td>"
                    +"<td>"
                    +    "<a href='#' onclick='deleteScore("+scoreVO["id"]+")'>删除</a>"
                    +    "<a href='#' onclick='updateScore("+scoreVO["id"]+")'>更新</a>"
                    +"</td>"
            +"</tr>";
        }
        $("table tbody").html(tbodyHtml);
    }
    function showPageHtml(tableResult) {
        var pageHtml = "";
        var pageNow = tableResult["pageNow"];
        var pageCount = tableResult["pageCount"];
        if (pageNow !== 1) {
            pageHtml += '<a href="#" onclick="goFirst()">首页</a>'
            + '<a href="#" onclick="goPre()">上一页</a>';
        }
        if (pageNow !== pageCount) {
            pageHtml += '<a href="#" onclick="goNext()">下一页</a>'
                + '<a href="#" onclick="goLast('+pageCount+')">尾页</a>';
        }
        pageHtml += '<span>共'+pageCount+'页</span>'
        + '<span>,共'+tableResult["totalCount"]+'条</span>'
        + '<span>,当前是'+pageNow+'页</span>';

        $(".page").html(pageHtml);
    }
    // 页面加载出来默认查询第一页
    loadTable();
    // 删除成绩
    function deleteScore(scoreId) {
        $.ajax({
            type:"post",
            url:"<%=request.getContextPath()%>/scoreServlet",
            data:{"type":"delete","id":scoreId},
            success:function (result) {
                if (result.success) {
                    loadTable();
                }else{
                    alert(result.data);
                }
            }
        });
    }
    // 更新成绩
    function updateScore(scoreId) {
        $("#updateScoreDia").dialog({
            open : function (evt,ui) {
                // 回显成绩
                $.ajax({
                    type:"post",
                    url:"<%=request.getContextPath()%>/scoreServlet",
                    data:{"type":"getScoreById","id":scoreId},
                    success:function (result) {
                        if (result.success) {
                            // 把查到的学生信息填充到模态框中
                            // 设置select下拉框查到的学生姓名为选中状态
                            fill2UpdateDia(result.data);
                        }else{
                            alert(result.data);
                        }
                    }
                });
            }
        });
        // 显示对话框
        $("#updateScoreDia").dialog("open");
    }
    // 回显score对象
    function fill2UpdateDia(scoreVO) {
        $("#updateScoreDia input[name=id]").val(scoreVO.id);
        $("#updateScoreDia input[name=cnScore]").val(scoreVO.cnScore);
        $("#updateScoreDia input[name=enScore]").val(scoreVO.enScore);
        $("#updateScoreDia input[name=mathScore]").val(scoreVO.mathScore);
        doLoadAllStudents("updateScoreDia",scoreVO.studentId);
    }

    // 按钮查询
    function doSearch() {
        $("#pageNow").val(1);
        loadTable();
    }
    // 首页
    function goFirst() {
        $("#pageNow").val(1);
        loadTable();
    }
    // 上一页
    function goPre() {
        var value = $("#pageNow").val();
        var prePage = parseInt(value) - 1;
        $("#pageNow").val(prePage);
        loadTable();
    }
    // 下一页
    function goNext() {
        var value = $("#pageNow").val();
        var prePage = parseInt(value) + 1;
        $("#pageNow").val(prePage);
        loadTable();
    }
    // 尾页
    function goLast(pageCount) {
        $("#pageNow").val(pageCount);
        loadTable();
    }
</script>
</body>
</html>
