<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/public/forAll.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>我的桌面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    

 		<style>
		.column { width: 49%; float: left; padding-bottom: 10px; border:0xp solid red; }
		.portlet { margin: 0 1em 1em 0;}
		.portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
		.portlet-header .ui-icon { float: right; }
		.portlet-content { padding: 0.4em; }
		.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
		.ui-sortable-placeholder * { visibility: hidden; }
		</style>
		
		<script>
		$(function() {
		
			$( ".column" ).sortable({
				connectWith: ".column"
			});
			
			
			$( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
				.find( ".portlet-header" )
				.addClass( "ui-widget-header ui-corner-all" )
				.prepend( "<span class='ui-icon ui-icon-refresh' title='刷新' style='cursor:pointer;'></span>")
				.prepend( "<span class='ui-icon ui-icon-minusthick'  style='cursor:pointer;'></span>")
				.end()
				.find( ".portlet-content" );
	
			$( ".portlet-header .ui-icon-minusthick" ).click(function() {
				$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
				$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
			});
			$( ".portlet-header .ui-icon-refresh" ).click(function() {
				$("#"+$(this).parents( ".portlet:first" ).attr("frameid")).attr("src","${basePath}"+$(this).parents( ".portlet:first" ).attr("src"));
			});
			
			jQuery.get("${basePath}ajax/getOperatorProcessStatus.action",{operatorId:${OPERATOR.id}},function(data,textStatus){
				if(!textStatus){
					alert("ajax请求时无响应。");
				}else if(data!=""){
					var ops = eval(data);
					var val = Math.round((ops[0].comp*100/(ops[0].dnumber*1+ops[0].cnumber*1)));
				    if(isNaN(val)){
				       val = 0;
				    }
					jQuery("#dnumber").html(ops[0].dnumber);
					jQuery("#cnumber").html(ops[0].cnumber);
					jQuery("#comp").html(ops[0].comp);
					jQuery("#pvals").html(val+"%");
					jQuery("#progressbar").progressbar({
		   		    	value:val
		   		    }); 
					jQuery("#processStatus").show();
					jQuery("#processImg").hide();
				}
			});
			//今日已完成量
	    	jQuery.get("${basePath}ajax/getDispatchedProcessedCountForToday.action",{operatorId:${OPERATOR.id}},function(data,textStatus){
	    		$("#ap").html(data);
			});
			//未完成量
	    	jQuery.get("${basePath}ajax/getDispatchedUnProcessedCount.action",{operatorId:${OPERATOR.id}},function(data,textStatus){
	    		$("#up").html(data);
			});
			//我已处理量
	    	jQuery.get("${basePath}ajax/getOperatorProcessedCountForToday.action",null,function(data,textStatus){
	    		$("#processCount").html(data);
			});
			
			$( ".column" ).disableSelection();
	
		});
		function getData(){ 
			jQuery.get("${basePath}ajax/getOperatorProcessStatus.action",{operatorId:${OPERATOR.id}},function(data,textStatus){
				if(!textStatus){
					alert("ajax请求时无响应。");
				}else if(data!=""){
					var ops = eval(data);
					var val = Math.round((ops[0].comp*100/(ops[0].dnumber*1+ops[0].cnumber*1)));
				    if(isNaN(val)){
				       val = 0;
				    }
					jQuery("#dnumber").html(ops[0].dnumber);
					jQuery("#cnumber").html(ops[0].cnumber);
					jQuery("#comp").html(ops[0].comp);
					jQuery("#pvals").html(val+"%");
					jQuery("#progressbar").progressbar({
		   		    	value:val
		   		    }); 
					jQuery("#processStatus").show();
					jQuery("#processImg").hide();
				}
			});
			//今日已完成量
	    	jQuery.get("${basePath}ajax/getDispatchedProcessedCountForToday.action",{operatorId:${OPERATOR.id}},function(data,textStatus){
	    		$("#ap").html(data);
			});
			//未完成量
	    	jQuery.get("${basePath}ajax/getDispatchedUnProcessedCount.action",{operatorId:${OPERATOR.id}},function(data,textStatus){
	    		$("#up").html(data);
			});
			//我已处理量
	    	jQuery.get("${basePath}ajax/getOperatorProcessedCountForToday.action",null,function(data,textStatus){
	    		$("#processCount").html(data);
			});
		}
		</script>
		
  </head>
  
 <body class="ui-widget-content">
	<div class="demo" style="margin-top:5px;">
	<div class="column"  style="width:100%">
	    <c:if test="${empty OPERATOR.role.modulars}">
	    <font style="color:gray;">暂无模块</font>
	    </c:if>
		<c:forEach items="${OPERATOR.role.modulars}" var="modular">
			<div class="portlet" frameid="frame_${modular.id}" src="${modular.url}">
				<div class="portlet-header">${modular.title}</div>
				<div class="portlet-content">
				    <c:choose>
				    	<c:when test="${modular.title=='我的状态'}">
				    	    <table width="100%">
				    	         <tr>
				    	            <td>
				    					<div id="progressbar" style="width:99%" style="margin-bottom:5px;"></div>
		   								已分配:<span id="dnumber" class="num"></span>&nbsp;&nbsp;已完成:<span id="comp" class="num"></span>&nbsp;&nbsp;完成率:<span id="pvals" class="num"></span>
		   					        </td>
		   						</tr>
			   					<tr>
								   <td><b>今日已经处理：</b>	<span id="processCount"></span></td>
								</tr>
			   					<tr>
								   <td><input type="button" value="刷新" onclick="getData();"></td>
								</tr>
		   					</table>
				    	</c:when>
				    	<c:otherwise>
				    		<c:if test="${modular.outSite==1}">
								<iframe src="${modular.url}" frameborder="0" id="frame_${modular.id}" style="height:${modular.height }px;width:100%"></iframe>
							</c:if>
							<c:if test="${modular.outSite==0}">
								<iframe src="${basePath}${modular.url}" frameborder="0" id="frame_${modular.id}" style="height:${modular.height }px;width:100%"></iframe>
							</c:if>
				    	</c:otherwise>
				    </c:choose>
				</div>
			</div>
		</c:forEach>
	</div>
	</div>
	<!-- End demo -->
  </body>
</html>
