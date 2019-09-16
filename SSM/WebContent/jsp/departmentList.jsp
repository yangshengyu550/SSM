<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>articleManger</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/ueditor.config.js">

    </script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/ueditor.all.min.js">
    </script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/common.js"></script>
</head>
<body>
<%-- <% request.setAttribute("department", request.getParameter("department"));%> --%>
<% String department =new String(request.getParameter("department").getBytes("ISO-8859-1"),"UTF-8"); ; %>
<table id="dg" title="公司人员信息管理" class="easyui-datagrid" pagination="false"
       fit="true"  rownumbers="true"
       url="${pageContext.request.contextPath}/getMapByDept?department=<%=department %>"  
       toolbar="#tb">
    <thead data-options="frozen:true">
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="100" align="center"  hidden="true">编号</th>
        <th field="name" width="100" align="center">姓名</th>
        <th field="sex" width="100" align="center">性别</th>
        <th field="age" width="100" align="center">年龄</th>
        <th field="department" width="150" align="center">部门</th>
        <th field="email" width="200" align="center">邮箱</th>
        <th field="tel" width="200" align="center">电话</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openEmployeeAddDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">添加</a> <a
            href="javascript:openEmployeeModifyDialog()"
            class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a> <a
            href="javascript:deleteEmployee()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除</a>
    </div>
    <div>
        &nbsp;姓名：&nbsp;<input type="text" id="name" size="20"
                              onkeydown="if(event.keyCode==13) searchEmployee()"/>&nbsp; <a
            href="javascript:searchEmployee()" class="easyui-linkbutton"
            iconCls="icon-search" plain="true">搜索</a>
    </div>
</div>
<div id="dlg" class="easyui-dialog"
     style="width: 340px;height:344px;padding: 30px 20px; position: relative; z-index:1000;"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr><td>姓名：</td><td><input type="text" id="fname" name="name"class="easyui-validatebox" required="true"/></td></tr>
            <tr><td>性别：</td><td><input type="radio"  id="sex" name="sex"  value="男">男<input type="radio"  id="sex" name="sex"  value="女">女</td></tr>
            <tr><td>年龄：</td><td><select id="fage" name="age">
            		<option value="18" selected="selected">18</option>
            <%for(int i=19;i<70;i++){ %>
            		<option value="<%=i%>"><%=i %></option>
            <%} %></select>岁</td></tr>
            <tr><td>部门：</td><td><select id="fdepartment" name="department">
                	<option value="生产部">生产部</option>
                	<option value="研发部">研发部</option>
                	<option value="人事部">人事部</option>
                	<option value="财务部">财务部</option>
                </select></td></tr>
            <tr><td>E-Mail：</td><td><input type="text" id="femail" name="email"class="easyui-validatebox" /></td></tr>
            <tr><td>电话：</td><td><input type="text" id="ftel" name="tel"class="easyui-validatebox" /></td></tr>
        </table>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:saveEmployee()" class="easyui-linkbutton" iconCls="icon-ok">保存</a><a href="javascript:closeEmployeeDialog()"class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
<script type="text/javascript">
    var url;
    /****************************按照姓名查询********************************/
    function searchEmployee() {
   		$("#dg").datagrid('load', {
               "name": $("#name").val(),
        });
    }
    /********************************删除************************************/
    function deleteEmployee() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的数据！");
            return;
        }
        var strIds = [];
        for (var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].id);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示","您确认要删除这<font color=red>" + selectedRows.length+ "</font>条数据吗？",
            function (r) {
                if (r) {
                    $.post("${pageContext.request.contextPath}/delete",{ids: ids},$.messager.alert("系统提示","数据已成功删除！"),$("#dg").datagrid("reload"), "json");
                }});
    }
    /*******************************打开添加面板********************************/
    function openEmployeeAddDialog() {
        $("#dlg").dialog("open").dialog("setTitle", "添加文本信息");
        url = "${pageContext.request.contextPath}/save";
    }
    /************************************保存***********************************/
    function saveEmployee() {
        $("#fm").form("submit", {
            url: url,
            onSubmit: function () {
                return $(this).form("validate");
            },
            success: function (result) {
                $.messager.alert("系统提示", "保存成功");
                $("#dlg").dialog("close");
                $("#dg").datagrid("reload");
                resetValue();
            }
        });
    }
    /*******************************打开修改面板********************************/
    function openEmployeeModifyDialog() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length != 1) {
            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
            return;
        }
        var row = selectedRows[0];
        $("#dlg").dialog("open").dialog("setTitle", "修改信息");
        $('#fm').form('load', row);
        url = "${pageContext.request.contextPath}/save?id="+ row.id;
    }

    function resetValue() {
        $("#fname").val("");
        $("#sex").val("男");
        $("#fage").val("18");
        $("#fdepartment").val("研发部");
        $("#femail").val("");
        $("#ftel").val("");
    }

    function closeEmployeeDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }
</script>
</body>
</html>