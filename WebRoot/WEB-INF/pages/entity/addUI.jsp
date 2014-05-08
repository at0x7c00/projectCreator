<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/public/forAll.jsp"%>
<%@include file="/WEB-INF/pages/public/jqueryValidate.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加实体</title>
	</head>
	<body class="ui-widget-content">
	<table width="100%">
	  <tr style="border:1px solid red;">
		  <td class="ui-icon ui-icon-circle-triangle-e" width="16px">&nbsp;</td>
		  <td>添加实体-${PROJECT.name}</td>
	  </tr>
	</table>
		<form METHOD="POST" NAME="fmOperator" id="formID" style="margin-top: 15; margin-bottom: 0" action="${basePath}entity_add.action" >
			<input type="hidden" value="${id }" name="id"/>
			 <div class="ItemBlockBorder">
				<div class="ItemBlock">
				<table width="100%">
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						名称：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<input type="text" name="entity.name" maxlength="100" class="InputStyle"
							vl="validate[required]" id="entity.name"> <font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						表名称：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<input type="text" name="entity.tableName" maxlength="100" class="InputStyle"
							vl="validate[required]" id="entity.tableName"> <font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						类名称：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<input type="text" name="entity.className" maxlength="100" class="InputStyle"
							vl="validate[required]" id="entity.className"> <font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						所属包：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<select name="packageId" class="SelectStyle" id="parentId" vl="validate[required]">
							<option value="">-请选择-</option>
							<c:forEach items="${parentPacks}" var="parent">
								<option value="${parent.id}">${parent.name }</option>
							</c:forEach>
						</select> <font color="red">*</font>
					</td>
				</tr>
				
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						类型：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<select name="entity.type" class="SelectStyle" id="entity.type" vl="validate[required]">
							<option value="0" ${entity.type==0?'selected':''}>普通类</option>
							<option value="1" ${entity.type==1?'selected':''}>枚举</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						枚举值：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<textarea name="entity.enumValue" rows="5" cols="50" class="TextareaStyle">${entity.enumValue }</textarea>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						是否可查询：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<select name="entity.queryAble" class="SelectStyle" id="entity.queryAble" vl="validate[required]">
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						是否可导出：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<select name="entity.exportable" class="SelectStyle" id="entity.exportable" vl="validate[required]">
							<option value="0" ${entity.exportable==0?'selected':''}>否</option>
							<option value="1" ${entity.exportable==1?'selected':''}>是</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						是否可导入：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<select name="entity.importable" class="SelectStyle" id="entity.importable" vl="validate[required]">
							<option value="0" ${entity.importable==0?'selected':''}>否</option>
							<option value="1" ${entity.importable==1?'selected':''}>是</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">
						主键生成策略:
					</td>
					<td>
						<select id="entity.idGenerateType" name="entity.idGenerateType" class="SelectStyle">
							<option value="0" ${entity.idGenerateType==0?'selected':''}>自增长</option>
							<option value="1" ${entity.idGenerateType==1?'selected':''}>指定值</option>
						</select><font color="red"> *</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="TextStyle" align="right" height="16"	valign="middle">
						对代码生成器不可见：
					</td>
					<td width="85%" class="TextStyle" align="left" height="16"
						valign="middle">
						<select name="entity.visiablity" class="SelectStyle" id="entity.importable" vl="validate[required]">
							<option value="1" ${entity.visiablity==1?'selected':''}>否</option>
							<option value="0" ${entity.visiablity==0?'selected':''}>是</option>
						</select>
					</td>
				</tr>
			</table>
			</div>
			</div>
			<div id="InputDetailBar">
				<input type="submit" name="btnSave" value="添 加" class="ButtonStyle" />
				<input type="reset" name="btnCancel" value="重 置" class="ButtonStyle" />
				<input type="button" name="btnBack" value="返 回" class="ButtonStyle"
					onClick="goBack();" />
			</div>
		</form>
	</body>
</html>

