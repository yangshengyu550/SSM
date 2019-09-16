<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- <e:referer site="localhost:8080/SSM" page="login.jsp"></e:referer> -->
<html>
<head>
<meta charset="UTF-8">
<title>主界面</title>
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
<script type="text/javascript">
	var url;
	$("#dg").datagrid("loaded");
	$.messager.progress('close');
	function addTab(url, text, iconCls) {
		var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/jsp/"
				+ url + "'></iframe>";
		$("#tabs").tabs("add", {
			title : text,
			iconCls : iconCls,
			closable : true,
			content : content
		});
	}
	function openTab(text, url, iconCls) {
		if ($("#tabs").tabs("exists", text)) {
			$("#tabs").tabs("close", text);
			addTab(url, text, iconCls);
			$("#tabs").tabs("select", text);
		} else {
			addTab(url, text, iconCls);
		}
	}
	function getReseachMap() {
		$("#dg").datagrid('load', {
			"department" : $("#reseach").html(),
		});
	}
	function logout() {
		$.messager
				.confirm(
						"系统提示",
						"您确定要退出系统吗",
						function(r) {
							if (r) {
								window.location.href = "${pageContext.request.contextPath}/logout";
							}
						});
	}
</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String username = request.getParameter("role_name");
%>
<body class="easyui-layout">
	<!-- Top -->
	<div region="north" style="height: 120px;">
		<div align="center" style="height: 58px;">
			<h1>员工管理系统</h1>
			<div align="right" style="position:relative;top:10px,right:10px;">欢迎你，<font color="#118fff">${role.role_name}</font></div>
			<div align="right">你的身份是：<font color="#118fff">${role.role_identity}</font></div>
		</div>
		
	</div>
	<!-- Show Page -->
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="所有员工" data-options="iconCls:'icon-home'">
				<table id="dg" title="公司人员信息管理" class="easyui-datagrid"
					pagination="false" fit="true" 
					data-options="total:100,pageSize:10" rownumbers="true"
					url="${pageContext.request.contextPath}/getMap" toolbar="#tb">
					<thead data-options="frozen:true">
						<tr>
							<th field="cb" checkbox="true" align="center"></th>
							<th field="id" width="100" align="center" hidden="true">编号</th>
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
						<a href="javascript:openEmployeeAddDialog()"
							class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
						<a href="javascript:openEmployeeModifyDialog()"
							class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
						<a href="javascript:deleteEmployee()" class="easyui-linkbutton"
							iconCls="icon-remove" plain="true">删除</a>
					</div>
					<div>
						&nbsp;姓名：&nbsp;<input type="text" id="e_name" size="20"
							onkeydown="if(event.keyCode==13) searchEmployee()" />&nbsp; 
							<a href="javascript:searchEmployee()" class="easyui-linkbutton"
							iconCls="icon-search" plain="true">搜索</a>
					</div>
				</div>
				<div id="dlg" class="easyui-dialog"
					style="width: 340px; height: 344px; padding: 30px 20px; position: relative; z-index: 1000;"
					closed="true" buttons="#dlg-buttons">
					<form id="fm" method="post">
						<table cellspacing="8px">
							<tr>
								<td>姓名：</td>
								<td><input type="text" id="fname" name="name"
									class="easyui-validatebox" required="true" /></td>
							</tr>
							<tr>
								<td>性别：</td>
								<td><input type="radio" id="fsex" name="sex" value="男" checked="checked">男
								<input type="radio" id="fsex" name="sex" value="女" >女</td>
							</tr>
							<tr>
								<td>年龄：</td>
								<td><select id="fage" name="age">
										<option value="18" selected="selected">18</option>
										<%
											for (int i = 19; i < 70; i++) {
										%>
										<option value="<%=i%>"><%=i%></option>
										<%
											}
										%>
								</select>岁</td>
							</tr>
							<tr>
								<td>部门：</td>
								<td><select id="fdepartment" name="department">
										<option value="管理层">财务部</option>
										<option value="研发部">研发部</option>
										<option value="人事部">人事部</option>
										<option value="生产部">生产部</option>
								</select></td>
							</tr>
							<tr>
								<td>E-Mail：</td>
								<td><input type="text" id="femail" name="email"
									class="easyui-validatebox" required="required"/></td>
							</tr>
							<tr>
								<td>电话：</td>
								<td><input type="text" id="ftel" name="tel"
									class="easyui-validatebox"  required="required" /></td>
							</tr>
						</table>
					</form>
				</div>
				<div id="dlg-buttons">
					<a href="javascript:saveEmployee()" class="easyui-linkbutton"
						iconCls="icon-ok">保存</a><a href="javascript:closeEmployeeDialog()"
						class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
				</div>
				<script type="text/javascript">
					var url;
					/****************************按照姓名查询********************************/
					function searchEmployee() {
						$("#dg").datagrid('load', {
							name : $("#e_name").val(),
						});
					}
					/********************************删除************************************/
					function deleteEmployee() {
						if("${rolerole_identity}"=='superadmin'){
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
							$.messager.confirm("系统提示","您确认要删除这<font color=red>"+ selectedRows.length+ "</font>条数据吗？",
									function(r) {
										if (r) {
											$.post("${pageContext.request.contextPath}/deleteEmployee",
												{
													ids : ids
												},
												$.messager.alert("系统提示","数据已成功删除！"),
												$("#dg").datagrid("reload"),"json");
										}
									});
						}else{
							alert("您没有该权限！");
						}
						
					}
					/*******************************打开添加面板********************************/
					function openEmployeeAddDialog() {
						if("${role.role_identity}"!='user'){
							alert("${role.role_identity}");
							$("#dlg").dialog("open").dialog("setTitle", "添加文本信息");
							url = "${pageContext.request.contextPath}/save";
						}else{
							alert("您没有该权限！");
						}
					}
					/************************************保存***********************************/
					function saveEmployee() {
						$("#fm").form("submit", {
							url : url,
							onSubmit : function(param) {
								var isValid = $(this).form('validate');
								if (!isValid){
									$.messager.progress('close');	
								}
								return isValid;
							},
							success : function(data) {
								$.messager.alert("系统提示", "保存成功");
								$("#dlg").dialog("close");
								$("#dg").datagrid("reload");
								resetValue();
							}
						});
					}
					/*******************************打开修改面板********************************/
					function openEmployeeModifyDialog() {
						if("${role.role_identity}"!='user'){
							var selectedRows = $("#dg").datagrid('getSelections');
							if (selectedRows.length != 1) {
								$.messager.alert("系统提示", "请选择一条要编辑的数据！");
								return;
							}
							var row = selectedRows[0];
							$("#dlg").dialog("open").dialog("setTitle", "修改信息");
							$('#fm').form('load', row);
							url = "${pageContext.request.contextPath}/saveEmployee?id="
									+ row.id;
						}else{
							alert("您没有该权限！");
						}
					}
					//添加默认值
					function resetValue() {
						$("#fname").val("");
						$("#fsex").val("男");
						$("#fage").val("18");
						$("#fdepartment").val("研发部");
						$("#femail").val("");
						$("#ftel").val("");
					}
					//关闭界面
					function closeEmployeeDialog() {
						$("#dlg").dialog("close");
						resetValue();
					}
				</script>
			</div>
		</div>
	</div>
	<!-- Menu -->
	<div region="west" style="width: 200px; height: 500px;" title="导航菜单"
		split="true">
		<div class="easyui-accordion">
			<div title="员工管理" data-options="selected:true,iconCls:'icon-student'"
				style="padding: 10px; height: 10px;">
				<a href="javascript:openTab(' 生产部人员列表','departmentList.jsp?department=生产部','icon-guanliyuan')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-guanliyuan'"
					style="width: 150px;"> 生产部</a> 
				<a href="javascript:openTab(' 研发部人员列表','departmentList.jsp?department=研发部','icon-guanliyuan')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-guanliyuan'"
					style="width: 150px;"> 研发部</a> 
				<a href="javascript:openTab(' 人事部人员列表','departmentList.jsp?department=人事部','icon-guanliyuan')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-guanliyuan'"
					style="width: 150px;"> 人事部</a>
				 <a href="javascript:openTab(' 财务部人员列表','departmentList.jsp?department=财务部','icon-guanliyuan')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-guanliyuan'"
					style="width: 150px;"> 财务部</a>
			</div>
		</div>
		<div title="系统管理" data-options="iconCls:'icon-item'"
			style="padding: 10px; border: none;">
			<a href="javascript:openTab(' 管理员列表','roleList.jsp','icon-lxr')" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-lxr'" style="width: 150px;">管理员列表</a>
			<a href="javascript:logout()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
		</div>
	</div>
</body>
</html>