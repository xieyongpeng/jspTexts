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
 		<form role="form" action="operation.jsp" method=post>
 			<input type="hidden" name="action" value="add">
			<div style="margin: auto 25%;">
						<div class="form-group">
						    <label for="id">图书编号</label>
						    <input type="text" class="form-control" id="id" name="id" placeholder="请输入图书编号">
						</div>
						<div class="form-group">
						    <label for="name">图书名称</label>
						    <input type="text" class="form-control" id="name" name="name" placeholder="请输入图书名称">
						</div>
						<div class="form-group">
						    <label for="number">图书数量</label>
						    <input type="text" class="form-control" id="number" name="number" placeholder="请输入图书数量">
						</div>
						<div class="form-group">
						    <label for="price">图书价格</label>
						    <input type="text" class="form-control" id="price" name="price" placeholder="请输入图书价格">
						</div>
						<div class="form-group">
						    <label for="description">图书描述</label>
						    <input type="text" class="form-control" id="description" name="description" placeholder="请输入图书描述">
						</div>
						<div class="form-group">
							<label class="control-label" for="zhonglei">图书种类</label>
    						<select class="form-control" name="zhonglei" id="zhonglei">
      							<option value="计算机类">计算机类</option>
      							<option value="人文类">人文类</option>
      							<option value="科技类">科技类</option>
      							<option value="励志类">励志类</option>
      							<option value="健身类">健身类</option>
      							<option value="哲学类">哲学类</option>
      							<option value="儿童类">儿童类</option>
      							<option value="散文类">散文类</option>
      							<option value="旅游类">旅游类</option>
      							<option value="传记类">传记类</option>
      							<option value="青春文学类">青春文学类</option>
      							<option value="其他">其他</option>
    						</select>
  						</div>
						<input type="submit" class="btn btn-info" value="保存">
			</div>
			 
		</form>
  </body>
</html>
