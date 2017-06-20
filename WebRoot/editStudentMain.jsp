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
	
	
	<script type="text/javascript">
		window.onload =function(){
			var select=document.getElementById("class2").value;
			var member=document.getElementById("class1");
			for(var i=0;i<member.childElementCount;i++){
				if(select==member.options[i].value){
					member.options[i].selected=true;
				}
			}
		};
	</script>

  </head>
  
  <body>
  
  <nav class="navbar navbar-default" role="navigation" style="margin:0px 0px 3px 0px;"> 
    <div class="container-fluid"> 
	    <div class="navbar-header"> 
	        <a class="navbar-brand" href="#">资料编辑</a> 
	    </div>
	    <div> 
        	<ul class="nav navbar-nav"> 
        		<li><a href="main.jsp">返回</a></li>  
        	</ul>
        </div>
	</div>
</nav>
  
  
  
  <%
  	
  	
  	String id="";
  	String sex="";
  	String class1="";
  	String age="";
  	String name="";
  	String description="";
  	String password="";
  	String expens="";
  	
  	
  	request.setCharacterEncoding("utf-8");
  	response.setCharacterEncoding("utf-8");
  	id=(String)request.getAttribute("id");
  	name=(String)request.getAttribute("name");
  	sex=(String)request.getAttribute("sex");
  	class1=(String)request.getAttribute("class1");
 	Date brithday=(Date)request.getAttribute("brithday");
 	expens=(String)request.getAttribute("expens");
 	age=(String)request.getAttribute("age");
 	
 	password=(String)request.getAttribute("password");
  	description=(String)request.getAttribute("description");
  
   %>
  
  
  <form role="form" action="operationStudentMain2.jsp" method=post>
 			
 			<input type="hidden" name="action" value="save">
			<div style="margin: auto 25%;">
						<div class="form-group">
						    <label for="id">学生学号</label>
						    <input type="text" class="form-control" id="id" name="id" value="<%= id %>" readonly="true">
						</div>
						
						<div class="form-group">
						    <label for="name">学生姓名</label>
						    <input type="text" class="form-control" id="name" name="name" value="<%= name %>">
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
							<input type="hidden" id="class2" value="<%= class1 %>">
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
						    <input type="text" class="form-control" id="age" name="age" value="<%= age %>">
						</div>
						
						<div class="form-group">
						    <label for="brithday">出生日期</label>
						    <input type="text" class="form-control" id="brithday" name="brithday" value="<%= brithday %>">
						</div>
						
						<div class="form-group">
						    <label for="description">学生描述</label>
						    <input type="text" class="form-control" id="description" name="description" value="<%= description %>">
						</div>
						
						<div class="form-group">
						    <label for="password">学生密码</label>
						    <input type="text" class="form-control" id="password" name="password" value="<%= password %>" >
						</div>
						
						<div class="form-group">
						    <label for="expens">学生欠费信息</label>
						    <input type="text" class="form-control" id="expens" name="expens" value="<%= expens %>" readonly="true">
						</div>
						
						
						<input type="submit" class="btn btn-info" value="保存">
			</div>
			 
		</form>
  
  </body>
</html>
