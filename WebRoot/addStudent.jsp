<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'add.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
 		<form role="form" action="operationStudent.jsp" method=post>
 			<input type="hidden" name="action" value="add">
			<div style="margin: auto 25%;">
						<div class="form-group">
						    <label for="id">学生学号</label>
						    <input type="text" class="form-control" id="id" name="id" placeholder="请输入学生学号">
						</div>
						<div class="form-group">
						    <label for="name">学生姓名</label>
						    <input type="text" class="form-control" id="name" name="name" placeholder="请输入学生姓名">
						</div>
						<div>
  							<label class="control-label" for="sex1">性别</label>
	  						<div class="radio">
							  <label class="checkbox-inline">
							    <input type="radio" name="sex" id="sex1" value="男" checked>男
							  </label>
							</div>
							<div class="radio">
							  <label class="checkbox-inline">
							    <input type="radio" name="sex" id="sex1" value="女">女
							  </label>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label" for="class1">所在班级</label>
    						<select class="form-control" name="class1" id="class1">
      							<option value="应用141">应用141</option>
      							<option value="应用142">应用142</option>
      							<option value="应用143">应用143</option>
      							<option value="应用144">应用144</option>
      							<option value="工程141">工程141</option>
      							<option value="工程142">工程142</option>
      							<option value="工程143">工程143</option>
    						</select>
  						</div>
						<div class="form-group">
						    <label for="age">年龄</label>
						    <input type="text" class="form-control" id="age" name="age" placeholder="请输入学生年龄">
						</div>
						<div class="form-group">
						    <label for="brithday">出生日期</label>
						    <input type="text" class="form-control" id="brithday" name="brithday" placeholder="形如：1995-07-11">
						</div>
						<div class="form-group">
						    <label for="description">学生描述</label>
						    <input type="text" class="form-control" id="description" name="description" placeholder="请输学生描述">
						</div>
						<input type="submit" class="btn btn-info" value="保存">
			</div>
			 
		</form>
  </body>
</html>
