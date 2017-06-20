<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="com.helloweenvsfei.person.Person" %>
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
  
  	String log=(String)session.getAttribute("islog");
	if("No".equals(log)){
		response.sendRedirect(request.getContextPath()+"/log.jsp");
	}
	
  	request.setCharacterEncoding("utf-8");
  	response.setCharacterEncoding("utf-8");
  	int expens=Integer.parseInt(request.getParameter("expens"));
  	String name=(String)session.getAttribute("name");
  	
  	Connection conn=null;
  	Statement stmt=null;
  	PreparedStatement prestmt=null;
  	ResultSet rs=null;
  	int price=0;
  	
  	String sql="select * from student_information where name='"+name+"'";
  	String sql2="update student_information set expens=? where name='"+name+"'";
  	
  		try{
	  		conn=DBManager.getConnection();
	  		stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
	  		if(rs.next()){
	  			price=rs.getInt("expens");
	  		}
	  	}catch(SQLException e){
	   		out.println("执行失败"+e.getMessage());
	  		return;
	   	}finally{
	   		if(stmt!=null)stmt.close();
	  		if(conn!=null)conn.close();
	  		if(stmt!=null)stmt.close();
	   	}
  
  	if((price-expens)>0){
  		expens=price-expens;
  	}
 	else{
 		expens=0;
 	}
  	
  
  try{
	  		conn=DBManager.getConnection();
	  		prestmt=conn.prepareStatement(sql2);
	  		DBManager.setParams(prestmt, expens);
	  		prestmt.executeUpdate();
	  	}catch(SQLException e){
	   		out.println("执行失败"+e.getMessage());
	  		return;
	   	}finally{
	   		if(prestmt!=null)prestmt.close();
	  		if(conn!=null)conn.close();
	  		if(stmt!=null)stmt.close();
	   	}
  
  
   %>
   
   <div style="margin: auto 25%;">
		<h2>缴费成功</h2>
		<a href="main.jsp" class="btn btn-info">返回主页面</a>
	</div>
  </body>
</html>
