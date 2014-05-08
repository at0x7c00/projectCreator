<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/public/forAll.jsp"%>
<%@include file="/WEB-INF/pages/public/forList.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>项目内容查看</title>
	</head>
	<body class="ui-widget-content">
	<table width="100%">
	  <tr style="border:1px solid red;">
		  <td class="ui-icon ui-icon-circle-triangle-e" width="16px">&nbsp;</td>
		  <td>项目内容查看</td>
	  </tr> 
	</table>
		<table border="0" style="position:absolute;top:0;right:0;">	
	    <tr>
			<td class="ui-icon ui-icon-play"></td>
			<td>
				<span><a href="javascript:void(0);" onclick="buildProject()">生成代码</a></span> 
			</td> 
			<td>&nbsp;</td>
			<td class="ui-icon ui-icon-home"></td>
			<td>
				<span><s:a action="project_list.action">返回项目列表</s:a></span> 
			</td> 
		</tr>
	</table>
			<input type="hidden" value="${id }" name="id"/>
			 &nbsp;&nbsp;
			 <a href="${basePath}project_viewFile.action?id=${project.id}"><b>${project.name}</b></a>
			 <c:forEach items="${parents}" var="p">
			 	&gt;&nbsp;
			 	 <a href="${basePath}project_viewFile.action?id=${project.id}&dir=${p.fullPath}">${p.name}</a>
				 <c:set var="lastParent" value="${p}"></c:set>
			 </c:forEach>
				<table class="ui-widget ui-widget-content" width="100%" style="text-align: center;">
				<thead>
					<tr class="ui-widget-header" height="30px" id="listTHead" align="left">
					<TD width="16px"  style="width:16px"></TD>
					<td>
						<b>文件名</b>
					</td>
					<td style="width:10%">
						<b>大小</b>
					</td>
					<td  style="width:20%">
						<b>修改日期</b>
					</td>
					<td  style="width:8%">
						<b>操作</b>
					</td>
					</tr>
				</thead>
				<tbody id="listTBody">
				<c:if test="${empty files}">
					<tr height="15px">
						<td class="bg" colspan="5" align="center">
							<font style="color: gray; font-weight: bold;">文件夹是空的
							</font>
						</td>
					</tr>
				</c:if>
				<c:forEach items="${files}" var="file">
					<tr align="left" height="20px">
						<TD width="16px" class="ui-icon ui-icon-${file.isDirectory?'folder-collapsed':'document'}" style="width:16px"></TD>
						<td >
							<c:choose>
								<c:when test="${file.isDirectory}">
								   <a href="${basePath}project_viewFile.action?id=${project.id}&dir=${file.fullPath}">${file.name}</a>
								</c:when>
								<c:otherwise>
									<a href="${basePath}project_checkCode.action?id=${project.id}&fileName=${file.fullPath}" target="_blank" style="text-decoration: none;">${file.name}</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td style="width:10%">
							<c:choose>
								<c:when test="${file.isDirectory}">
								--
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${file.size/1024<1000}">
											<fmt:formatNumber value="${file.size/1024}" pattern="0.00"></fmt:formatNumber>KB
										</c:when>
										<c:otherwise>
											<fmt:formatNumber value="${file.size/(1024*1024)}" pattern="0.00"></fmt:formatNumber>M
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
						<td  style="width:10%">
							<fmt:formatDate value="${file.lastModifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<a href="${basePath}project_deleteCode.action?id=${project.id}&deleteDir=${file.fullPath}&dir=${lastParent.fullPath}" >删除</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div id="InputDetailBar">
				<c:if test="${not empty files}">
				<a href="project_downloadFile.action?id=${project.id}"  class="button">
					下载代码
				</a>
				</c:if>
			</div>
			<div id="dialog-message" title="代码生成" style="display:none;">
			<p>
			    正在生成代码....
			 </p>
			 <p id="msgContent"></p>
			</div>
	</body>
	<script type="text/javascript">
		var rules = [
			<c:forEach items="${project.rules}" var="r" varStatus="s">
			{id:${r.id},name:'${r.template.name}',outputdir:'${r.outputDir}',outputfilename:'${r.outputFileName}'}<c:if test="${not s.last}">,</c:if>
			</c:forEach>
		];
		function buildProject(){
			var a = $("#msgContent");
			a.html("");
			$('#dialog-message').dialog({modal:true,
				buttons:{
				},
				width:700,
				height:300
			});
			buildCode(0);
		}
		function buildCode(i){
			if(i>=rules.length){
				$("#msgContent").html($("#msgContent").html()+"<p>生成完毕!</p>");
				window.setTimeout(function(){
					window.location.reload();
				},50)
				return;
			}
			$("#msgContent").html($("#msgContent").html()+(i+1)+"、"+rules[i].name+"--->"+rules[i].outputdir+rules[i].outputfilename+"<br/>");
			$.get("${basePath}project_build.action?id=${project.id}&ruleId="+rules[i].id,function(){
				buildCode(i+1);
			});	
		}
		$(function(){
			$( ".button" ).button({
		      icons: {
		        primary: "ui-icon-arrowthickstop-1-s"
		      },
		      text: true
		    });
		});
	</script>
</html>

