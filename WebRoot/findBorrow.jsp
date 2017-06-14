<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<%!
	/** SQL 值中的单引号(')需要转化为 \'  */
	public String forSQL(String sql){
		return sql.replace("'", "\\'");
	}
%>

<%
	String log=(String)session.getAttribute("islog");
	String name=(String)session.getAttribute("name");
	if("No".equals(log)){
		response.sendRedirect(request.getContextPath()+"/log.jsp");
	}
	
	String sql2="select * from student_information where name='"+name+"'";
	String sql="select * from borrow_book where name='" +name+ "'";
	
	Connection cont=null;
	Statement stmt=null;
	ResultSet rs=null;
	int expens=0;
	try{
  		cont=DBManager.getConnection();
  		stmt=cont.createStatement();
		rs=stmt.executeQuery(sql2);
  		if(rs.next()){
  			expens=rs.getInt("expens");
  		}
  	}catch(SQLException e){
   		out.println("执行失败"+e.getMessage());
  		return;
   	}finally{
   		if(stmt!=null)stmt.close();
  		if(cont!=null)cont.close();
  		if(stmt!=null)stmt.close();
   	}
 %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'findBorrow.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

  </head>
  
  <body>
  
  <nav class="navbar navbar-default" role="navigation" style="margin:0px 0px 3px 0px;"> 
    <div class="container-fluid"> 
    <div class="navbar-header"> 
        <a class="navbar-brand" href="#">图书管理系统</a> 
    </div> 
    <div> 
        <ul class="nav navbar-nav"> 
        	<li><a href="#">借阅查询</a></li> 
            <li><a href="#">图书归还</a></li>
            <li><a href="#">图书挂失</a></li>
            <li><a href="#">图书续借</a></li>
            <li><a href="#">缴费</a></li>
            <li><a href="main.jsp">返回</a></li>
        </ul> 
    </div> 
</nav>
  
  
  
  
  	<table class="table table-bordered table-condensed">
	 <caption>借阅图书情况</caption>
		<thead>
	 	<tr>
		    <th>学生姓名</th>
		    <th>图书编号</th>
		    <th>借书日期</th>
		    <th>还书日期</th>
		    <th>操作</th>
		</tr>
		</thead>
		<tbody>
		
<%
			
			
			
			try{
				cont=DBManager.getConnection();
				stmt=cont.createStatement();
				rs=stmt.executeQuery(sql);
				while(rs.next()){
					String bookid=rs.getString("idbook");
					String Studentname=rs.getString("name");
					Timestamp timestart=rs.getTimestamp("borrowDate");
					Timestamp timeend=rs.getTimestamp("returnDate");
					out.println("	<td>" + Studentname + "</td>");
					out.println("	<td>" + bookid + "</td>");
					out.println("	<td>" + timestart + "</td>");
					out.println("	<td>" + timeend + "</td>");
					
					
					
			%>
				<td>
				<div class="input-group">
				<a class="btn btn-default" role="button" href="returnBook.jsp?bookid=<%=bookid%>">还书</a>
				<a class="btn btn-default" role="button" href="continueBook.jsp?bookid=<%=bookid%>">续借</a></div>
				</td>
				
			<%
					out.println("		</tr>");
				}
			%>
				<tr>
 					<td colspan="2">欠费情况</td>
 					<td colspan="3"><%= expens%></td>
 				</tr>
			
			<%
			}catch(SQLException e){
  			out.println("执行SQL语句失败"+e.getMessage());
  			return;
  		}finally{
  			if(stmt!=null)stmt.close();
  			if(cont!=null)cont.close();
  		}

 %>
		</tbody>
  </body>
</html>
