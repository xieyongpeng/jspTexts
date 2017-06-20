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
  
  <nav class="navbar navbar-default" role="navigation" style="margin:0px 0px 3px 0px;"> 
    <div class="container-fluid"> 
	    <div class="navbar-header"> 
	        <a class="navbar-brand" href="#">图书编辑</a> 
	    </div>
	    <div> 
        	<ul class="nav navbar-nav"> 
        		<li><a href="manageMain.jsp">返回</a></li>  
        	</ul>
        </div>
	</div>
</nav>
  
  
  <%
  	request.setCharacterEncoding("utf-8");
  	response.setCharacterEncoding("utf-8");
  	String id=(String)request.getAttribute("id");
  	String name=(String)request.getAttribute("name");
  	String number=(String)request.getAttribute("number");
  	String price=(String)request.getAttribute("price");
  	String description=(String)request.getAttribute("description");
   %>
  
    <form role="form" action="operation.jsp" method=post>
 			<input type="hidden" name="action" value="save">
 			<input type="hidden" name="id" value="<%= id%>">
			<div style="margin: auto 25%;">
						<div class="form-group">
						    <label for="name">图书名称</label>
						    <input type="text" class="form-control" id="name" name="name" value="<%= name %>">
						</div>
						<div class="form-group">
						    <label for="number">图书数量</label>
						    <input type="text" class="form-control" id="number" name="number" value="<%= number %>">
						</div>
						<div class="form-group">
						    <label for="price">图书价格</label>
						    <input type="text" class="form-control" id="price" name="price" value="<%= price %>">
						</div>
						<div class="form-group">
						    <label for="description">图书描述</label>
						    <input type="text" class="form-control" id="description" name="description" value="<%= description %>">
						</div>
						<input type="submit" class="btn btn-info" value="确认修改">
			</div>	 
		</form>
  </body>
</html>
