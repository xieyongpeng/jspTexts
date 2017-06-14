<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="com.helloweenvsfei.person.Student" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<%!
	/** SQL 值中的单引号(')需要转化为 \'  */
	public String forSQL(String sql){
		return sql.replace("'", "\\'");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'operation.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
  
  <%

  	
   		String id=request.getParameter("id");
  		String name=request.getParameter("name");
  		String sex=request.getParameter("sex");
  		String class1=request.getParameter("class1");
  		String brithday=request.getParameter("brithday");
  		String age=request.getParameter("age");
  		String description=request.getParameter("description");
  		String password=request.getParameter("password");
  		String expens=request.getParameter("expens");
  		
  		
  		String sql="update student_information set id='"+forSQL(id)+
  		"', name='"+forSQL(name)+"', class='"+forSQL(class1)+"', sex='"+forSQL(sex)+
  		"', brithday='"+forSQL(brithday)+"', age='"+forSQL(age)+"', description='"+
  		forSQL(description)+"', password='"+forSQL(password)+"', expens='"+forSQL(expens)+"' where name="+name;
  		Connection conn=null;
  		Statement stmt=null;
  		int result=0;
  		try{
  			conn=DBManager.getConnection();
  			stmt=conn.createStatement();
  			result=stmt.executeUpdate(sql);
  			if(result==0){
  				out.println("修改失败");
  			}
  		}catch(SQLException e){
  			out.println("执行SQL语句失败"+e.getMessage());
  			return;
  		}finally{
  			if(stmt!=null)stmt.close();
  			if(conn!=null)conn.close();
  		}
  	%>
  	  	<div style="margin: auto 25%;">
		<h2>删除成功</h2>
		<a href="main.jsp" class="btn btn-info">返回主菜单</a>
		</div>
  
  </body>
</html>
