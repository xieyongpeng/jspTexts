<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'edit.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	

  </head>
  
  <body>
  
  <%
  	String log=(String)session.getAttribute("islog");
	if("No".equals(log)){
		response.sendRedirect(request.getContextPath()+"/log.jsp");
	}
  
   %>
  
  
   <nav class="navbar navbar-default" role="navigation" style="margin:0px 0px 3px 0px;"> 
    <div class="container-fluid"> 
	    <div class="navbar-header"> 
	        <a class="navbar-brand" href="#">留言系统</a> 
	    </div>
	    <div> 
        	<ul class="nav navbar-nav"> 
        		<li><a href="main.jsp">返回</a></li>  
        	</ul>
        </div>
	</div>
</nav>
  
  
  
  
  
  
	  <div style="margin: auto 20%;">
		 <form role="form" action="saveMessageBoard.jsp" method="post">
			<div class="form-group">
				<label for="name">文本框</label>
				<textarea class="form-control" rows="6" name="text"></textarea>
			</div>
			<input type="submit" class="btn btn-info" value="保存留言">
		</form>
	  </div>
  </body>
</html>
