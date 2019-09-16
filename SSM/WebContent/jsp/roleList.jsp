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
<table id="dg" title="管理员列表" class="easyui-datagrid" pagination="false"
       fit="true" rownumbers="true"
       url="${pageContext.request.contextPath}/getRoleList"  
       toolbar="#tb">
    <thead data-options="frozen:true">
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="role_id" width="100" align="center"  hidden="true">编号</th>
        <th field="role_name" width="200" align="center">用户名</th>
        <th field="role_pwd" width="200" align="center">用户密码</th>
        <th field="role_identity" width="200" align="center">用户身份</th>
        <th field="role_status" width="200" align="center">用户状态</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openRoleAddDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">添加</a> <a
            href="javascript:openRoleModifyDialog()"
            class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a> <a
            href="javascript:deleteRole()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除</a>
    </div>
    <div>
        &nbsp;姓名：&nbsp;<input type="text" id="e_name" size="20" />&nbsp; <a
            href="javascript:searchRole()" class="easyui-linkbutton"
            iconCls="icon-search" plain="true">搜索</a>
    </div>
</div>
<div id="dlg" class="easyui-dialog"
     style="width: 340px;height:344px;padding: 30px 20px; position: relative; z-index:1000;"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr><td>用户名：</td><td><input type="text" id="fusername" name="role_name"class="easyui-validatebox" required="true"/></td></tr>
            <tr><td>密码：</td><td><input type="text  id="fpassword" name="role_pwd" ></td></tr>
            <tr><td>身份：</td>
            <td><select id="fidentity" name="role_identity">
            	<option value="admin">admin</option>
            	<option value="user">user</option>
            </select></td></tr>
            <tr><td>可用状态：</td><td>
            <select id="fstatus" name="role_status">
            	<option value="0" selected="selected">0</option>
            	<option value="1">1</option>
            </select></td></tr>
        </table>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:saveRole()" class="easyui-linkbutton" iconCls="icon-ok">保存</a><a href="javascript:closeRoleDialog()"class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
<script type="text/javascript">
    var url;
    /****************************按照姓名查询********************************/
    function searchRole() {
   		$("#dg").datagrid('load', {
               "role_name": $("#role_name").val(),
        });
    }
    /********************************删除************************************/
    function deleteRole() {
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
                    $.post("${pageContext.request.contextPath}/deleteRole",
                    		{ids: ids},
                    		$.messager.alert("系统提示","数据已成功删除！"),
                    		$("#dg").datagrid("reload"), "json");
                }});
    }
    /*******************************打开添加面板********************************/
    function openRoleAddDialog() {
        $("#dlg").dialog("open").dialog("setTitle", "添加文本信息");
        url = "${pageContext.request.contextPath}/saveRole";
    }
    /************************************保存***********************************/
    function saveRole() {
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
    function openRoleModifyDialog() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length != 1) {
            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
            return;
        }
        var row = selectedRows[0];
        $("#dlg").dialog("open").dialog("setTitle", "修改信息");
        $('#fm').form('load', row);
        url = "${pageContext.request.contextPath}/saveRole?role_id="+ row.role_id;
    }

    function resetValue() {
        $("#fusername").val("");
        $("#fpassword").val("");
        $("#fidentity").val("user");
        $("#fstatus").val("1");
    }

    function closeRoleDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }
</script>
</body>
</html>