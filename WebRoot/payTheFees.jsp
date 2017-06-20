<%@ page language="java" import="java.util.Date" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'editStudentMain.jsp' starting page</title>
    
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    
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
	        <a class="navbar-brand" href="#">缴费系统</a> 
	    </div>
	    <div> 
        	<ul class="nav navbar-nav"> 
        		<li><a href="main.jsp">返回</a></li>  
        	</ul>
        </div>
	</div>
</nav>
  
  	<form role="form" action="payFees.jsp" method=post>
  			<div style="margin: auto 25%;">
  						<div class="form-group">
							<label class="control-label" for="expens">缴费金额</label>
    						<select class="form-control" name="expens" id="expens" >
      							<option value=5>5</option>
      							<option value=10>10</option>
      							<option value=20>20</option>
      							<option value=50>50</option>
      							<option value=100>100</option>
      							<option value=200>200</option>
      							<option value=500>500</option>
    						</select>
    						
  						</div>
  						<input type="submit" class="btn btn-info" value="缴费">
  			</div>
  				
			 
		</form>
  </body>
</html>
