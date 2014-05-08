<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/public/forAll.jsp"%>
<%@include file="/WEB-INF/pages/public/jqueryValidate.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>添加字段</title> 
		<script type="text/javascript">
			function selType(selObj){
				var selOp = selObj.options[selObj.selectedIndex];
				if(selObj.value ==1){
					$('#lengthTr').show();
					$('#dicTr').hide();
					$('#complexObject').hide();
					$('#dateFormat').hide();
					$('#enumValue').hide();
				}else if(selObj.value ==5){
					$('#lengthTr').hide();
					$('#dicTr').show();
					$('#complexObject').hide();
					$('#dateFormat').hide();
					$('#enumValue').hide();
				}else if(selObj.value==4){
					$('#lengthTr').hide();
					$('#dicTr').hide();
					$('#complexObject').hide();
					$('#dateFormat').show();
					$('#enumValue').hide();  
				}else if(selObj.value==6){
					$('#lengthTr').hide();
					$('#dicTr').hide();
					$('#complexObject').show();
					$('#dateFormat').hide();
					$('#enumValue').hide();
				}else if(selObj.value==7){
					$('#lengthTr').hide();
					$('#dicTr').hide();
					$('#dateFormat').hide();
					$('#complexObject').show();
					$('#enumValue').hide();
				}else{
					$('#lengthTr').hide();
					$('#dicTr').hide();
					$('#complexObject').hide();
					$('#dateFormat').hide();
					$('#enumValue').hide();
				}
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body class="ui-widget-content">
	
	<table width="100%">
	  <tr style="border:1px solid red">
		  <td class="ui-icon ui-icon-circle-triangle-e" width="16px">&nbsp;</td>
		  <td>添加字段
		  <c:if test="${not empty entityy}">
		  ${entityy.fullClassName}
		  </c:if>
		  -${PROJECT.name}
		  </td>
	  </tr>
	</table>
    <table border="0" style="position:absolute;top:0;right:5;">
	    <tr>
			<td class="ui-icon ui-icon-arrowreturnthick-1-w"></td>
			<td>
				<span><a href="javascript:void(0);" onclick="history.back();">返回<a></span> 
			</td> 
		</tr>
	</table>
		<form action="${basePath }property_add.action" method="post" id="formID">
			<div class="ItemBlockBorder">
			<table width="100%" border="0">
				<tr>
					<td width="20%" align="right">
						所属实体:
					</td>
					<td>
						<select name="entityId" id="typeSelx"  vl="validate[required]" class="SelectStyle" width="80%">
								<option value="">-请选择-</option>
								<c:forEach items="${entityList}" var="entity">
									<option value="${entity.id }" ${entityId==entity.id?'selected':''}>${entity.fullClassName}</option>
								</c:forEach>
						</select> 
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="20%" align="right">
						字段名称:
					</td>
					<td>
						<input type="text" name="property.propName" class="InputStyle" id="fieldName" vl="validate[required,maxSize[20]]"
							value="<c:out value="${property.propName }"/>" title="字段的英文名称"/><font color="red"> * ${msg }</font>
					</td>
				</tr>
				<tr>
					<td width="20%" align="right">
						列名称:
					</td>
					<td>
						<input type="text" name="property.columnName" class="InputStyle" id="fieldName" 
							value="<c:out value="${property.columnName }"/>" />
					</td>
				</tr>
				<tr>
					<td align="right">
						显示名称:
					</td>
					<td>
						<input type="text" name="property.name" class="InputStyle" id="property.name" vl="validate[required]"
							value="${property.description }" /><font color="red"> *</font>
					</td>
				</tr>
				<tr>
					<td align="right">
						主键:
					</td>
					<td>
						<select id="property.isId" name="property.isId" class="SelectStyle">
							<option value="0" ${property.isId==0?'selected':''}>否</option>
							<option value="1" ${property.isId==1?'selected':''}>是</option>
						</select><font color="red"> *</font>
					</td>
				</tr>
				<tr>
					<td align="right">
						显示方式:
					</td>
					<td>
					    <select class="SelectStyle" name="property.isTotalRow" >
				   			       		<option value="0" ${property.isTotalRow==0?'selected':''}>半行</option>
				   			       		<option value="1" ${property.isTotalRow==1?'selected':''}>整行</option>
				   			       </select>
					</td>
				</tr>
				<tr>
					<td align="right">
						数据类型:
					</td>
					<td>
						<select name="property.dataType" onchange="selType(this)" id="typeSel" class="InputStyle" vl="validate[required]">
								<option value="">-请选择-</option>
								<option value="1" ${property.dataType==1?'selected':''}>字符串</option>
								<option value="2" ${property.dataType==2?'selected':''}>整数</option>
								<option value="3" ${property.dataType==3?'selected':''}>小数</option>
								<option value="4" ${property.dataType==4?'selected':''}>日期</option>
								<option value="5" ${property.dataType==5?'selected':''}>数据字典</option>
								<option value="6" ${property.dataType==6?'selected':''}>复杂类型</option>
								<option value="7" ${property.dataType==7?'selected':''}>枚举类型</option>
						</select> <font color="red">*</font>
					</td>
				</tr>
				<tr id="enumValue" <c:if test="${property.dataType!=7}">style="display: none;"</c:if>>
					<td align="right">
						枚举值:
					</td>
					<td>
						<input name="property.enumValue" id="property.enumValue" value="${property.enumValue}" class="InputStyle" vl="validate[required]"/>
						&nbsp;<font style="color:red">*</font>
						&nbsp;<font style="color:gray">例如：1=投诉;2=咨询;3=报修</font>
					</td>
				</tr>
				<tr id="lengthTr">
				   <td colspan="2">
				   		<table width="100%">
				   			<tr>
				   				<td width="20%" align="right">
									Text类型：
								</td>
								<td>
									<select name="property.isTextStringType" class="SelectStyle">
										<option value="0">否</option>
										<option value="1">是</option>
									</select>
								</td>
				   			</tr>
				   			<tr>
				   				<td width="20%" align="right">
									字段长度：
								</td>
								<td>
									<input type="text" name="property.length" id="fieldLength" class="InputStyle" value="255" vl="validate[required,custom[number]]" /><font color="red"> *</font>
								</td>
				   			</tr>
				   			<tr>
				   			    <td align="right">
				   			       显示方式：
				   			    </td>
				   			    <td>
				   			       <select class="SelectStyle" name="property.isTextArea">
				   			       		<option value="0" ${property.isTextArea==0?'selected':''}>文本框</option>
				   			       		<option value="1" ${property.isTextArea==1?'selected':''}>文本域</option>
				   			       </select>
				   			    </td>
				   			</tr>
				   			<tr>
				   			   <td align="right">行：</td>
				   			   <td>
				   			     <input class="InputStyle" name="property.row" value="5"/>
				   			   </td>
				   			</tr>
				   			<tr>
				   			   <td align="right">列：</td>
				   			   <td>
				   			     <input class="InputStyle" name="property.col" value="60"/>
				   			   </td>
				   			</tr>
				   		</table>
				   </td>
				</tr>
				<tr id="dicTr" <c:if test="${property.dataType==5}">style="display: block;"</c:if> <c:if test="${property.dataType!=5}">style="display: none;"</c:if>>
					<td align="right">
						字典编号:
					</td>
					<td>
						<input type="text" class="InputStyle" name="property.dictFix" value="${property.dictFix}" vl="validate[required]" id="property.dictFix"/>&nbsp;<font color="red">*</font>
					</td>
				</tr>
				<tr id="dateFormat" <c:if test="${property.dataType==4}">style="display: block;"</c:if> <c:if test="${property.dataType!=4}">style="display: none;"</c:if>>
				    <td colspan="2">
				    	<table width="100%">
				   			<tr>
				   				<td width="20%" align="right">
									日期格式:
								</td>
								<td>
								<input type="text" name="property.timeFormat" id="timeFormat" class="InputStyle" value="yyyy-MM-dd HH:mm:ss" vl="validate[required]" /><font color="red"> *</font>
								</td>
				   			</tr>
				   			<tr>
				   				<td width="20%" align="right">
									添加时默认系统时间：
								</td>
								<td>
									<select class="SelectStyle" name="property.defaultSysTime">
										<option value="0" ${property.defaultSysTime==0?'selected':''}>否</option>
										<option value="1" ${property.defaultSysTime==1?'selected':''}>是</option>
									</select>
								</td>
				   			</tr>
				   		</table>
				    </td>
				</tr>
				<tr id="complexObject" <c:if test="${property.dataType==6}">style="display: block;"</c:if> <c:if test="${property.dataType!=6}">style="display: none;"</c:if>>
					<td colspan="2">
					   <table width="100%" border="0">
					      <tr>
					           <td width="20%" align="right">
									关联实体:
								</td>
								<td>
									<select name="complexId" id="typeSel" class="InputStyle" vl="validate[required]">
											<option value="">-请选择-</option>
											<c:forEach items="${entityList}" var="entity">
												<option value="${entity.id }" ${entityId==entity.id?'selected':''}>${entity.fullClassName}</option>
											</c:forEach>
									</select> <font color="red">*</font>
								</td>
					      </tr>
					      <tr>
					           <td width="20%" align="right">
									关系类型:
								</td>
								<td>
									<select name="property.relationType" id="typeSel" class="InputStyle" vl="validate[required]">
											<option value="">-请选择-</option>
											<option value="1">一对一</option>
											<option value="2">多对多</option>
											<option value="3">一对多</option>
											<option value="4">多对一</option>
									</select> <font color="red">*</font>
								</td>
					      </tr>
					      <tr>
					           <td width="20%" align="right">
									中间表：
								</td>
								<td>
									<input type="text" class="InputStyle" name="property.middletable" value="${property.middletable}"/>
								</td>
					      </tr>
					      <tr>
					         <td align="right">关联关系对方关系外键id：</td>
					         <td><input type="text" class="InputStyle" name="property.setKeyCoumn" value="${property.setKeyCoumn}"/></td>
					      </tr>
					      <tr>
					         <td align="right">关系字段：</td>
					         <td>
					         	<select name="property.onlyRelationship" class="SelecteStyle">
					         		<option value="0" ${property.onlyRelationship==0?'selected':''}>否</option>
					         		<option value="1" ${property.onlyRelationship==1?'selected':''}>是</option>
					         	</select>
					         </td>
					      </tr>
					      <tr>
					         <td align="right">value path：</td>
					         <td><input type="text" class="InputStyle" name="property.valuePath" value="${property.valuePath}"/></td>
					      </tr>
					   </table>
					</td>
				</tr>
				<tr>
					<td align="right">
						允许为空:
					</td>
					<td>
						<input type="checkbox" name="property.canNull"  checked="checked" value="1"/> 
					</td>
				</tr>
				<tr>
			           <td width="20%" align="right">
							验证规则：
						</td>
						<td>
							<select name="property.validateType" id="typeSel" class="InputStyle" vl="validate[required]">
									<option value="0">-无-</option>
									<option value="1">数字</option>
									<option value="2">邮箱地址</option>
							</select> 
						</td>
			    </tr>
				<tr>
			           <td width="20%" align="right">
							列表显示：
						</td>
						<td>
							<select name="property.display" id="typeSel" class="InputStyle" vl="validate[required]">
									<option value="1">是</option>
									<option value="0">否</option>
							</select>
						</td>
			    </tr>
				<tr>
			           <td width="20%" align="right">
							列表查询：
						</td>
						<td>
							<select name="property.forQuery" id="typeSel" class="InputStyle" vl="validate[required]">
									<option value="1" ${property.forQuery==1?'selected':''}>是</option>
									<option value="0" ${property.forQuery==0?'selected':''}>否</option>
							</select>
						</td>
			    </tr>
				<tr>
			           <td width="20%" align="right">
							列表简略显示长度：
						</td>
						<td>
						  <input type="text" class="InputStyle" name="property.briefLength" value="0"/>&nbsp;0表示完整显示
						</td>
			    </tr>
				<tr>
			           <td width="20%" align="right">
							排序：
						</td>
						<td>
							<input type="text" name="property.sortValue" id="property.sortValue" class="InputStyle" value="${fn:length(entityy.properties)+1}" vl="validate[required,custom[number]]" /><font color="red"> *</font>
						</td>
			    </tr>
				<tr>
					<td colspan="2" align="center">
						
					</td>
				</tr>
			</table>
			</div>
			<div align="center">
						<input type="submit" name="submit" value="提 交" class="ButtonStyle" style="font-size:18px;width:100px;height:50px;"/>
						<input type="reset" name="submit" value="重 置" class="ButtonStyle"/>
						<input type="button" value="取 消" onclick="javascript:history.go(-1)" class="ButtonStyle"/>
			</div>
		</form>
		<font style="color: red"><s:fielderror/>
		</font>
		
	</body>
</html>
