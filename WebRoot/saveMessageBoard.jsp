<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>
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
    
    <title>My JSP 'saveMessageBoard.jsp' starting page</title>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
  
  <%
  	request.setCharacterEncoding("utf-8");
  	response.setCharacterEncoding("utf-8");
  	String name=(String)session.getAttribute("name");
  	Connection conn=null;
  	Statement stmt=null;
  	Date date=new Date();
	Timestamp timestart = new Timestamp(date.getTime());
	String text=request.getParameter("text");
  	String sql="insert into message_board(name,text,date) values('"+name+"', '"+text+
  		"', '"+timestart+"')";
  	System.out.println(sql);
  	
  		
  	try{
  			conn=DBManager.getConnection();
			stmt=conn.createStatement();
			stmt.executeUpdate(sql);
  			
  	}catch(SQLException e){
   			out.println("执行修改失败"+e.getMessage());
  			return;
   		}finally{
  			if(conn!=null)conn.close();
  			if(stmt!=null)stmt.close();
   	}
   %>
   
   <div style="margin: auto 25%;">
		<h2>留言成功</h2>
		<a href="main.jsp" class="btn btn-info">返回主菜单</a>
	</div>
  </body>
</html>
