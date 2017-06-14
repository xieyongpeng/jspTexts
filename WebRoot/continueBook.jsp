<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<%!
	/** SQL 值中的单引号(')需要转化为 \'  */
	public String forSQL(String sql){
		return sql.replace("'", "\\'");
	}
%>

<%
	String log=(String)session.getAttribute("islog");
	if("No".equals(log)){
		response.sendRedirect(request.getContextPath()+"/log.jsp");
	}
	
	
	String name=(String)session.getAttribute("name");
	
	
	String idbook=request.getParameter("bookid");
	
	int money=-1;
	int expens=0;
	Connection conn=null;
  	PreparedStatement prestmt=null;
  	Statement stmt=null;
  	ResultSet rs=null;
  	int booknumber=0;
	Date date=new Date();
	Timestamp timestart = new Timestamp(date.getTime());
	Timestamp timeend= new Timestamp(date.getTime());
	Timestamp timeend1=null;
	timeend.setTime(timestart.getTime() - 1000 * 60 * 60 * 24 * 30);
  	String sql="update borrow_book set returnDate=? where idbook='"+idbook+"' and name='"+name+"'";
  	
  	
  	String sql2="select * from borrow_book where idbook='"+idbook+"' and name='"+name+"'";
  	String sql3="update student_information set expens=? where name='"+name+"'";
  	String sql5="select * from student_information where name='"+name+"'";

  	
  	try{
  		conn=DBManager.getConnection();
  		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql2);
  		if(rs.next()){
  			timeend1=rs.getTimestamp("returnDate");
  		}
  	}catch(SQLException e){
   		out.println("执行失败"+e.getMessage());
  		return;
   	}finally{
   		if(stmt!=null)stmt.close();
  		if(conn!=null)conn.close();
  		if(stmt!=null)stmt.close();
   	}
  	
  	money=(int)(timestart.getTime()-timeend1.getTime())/(1000 * 60 * 60 * 24);
  	System.out.println(money);
  	
  	if(money>0){
  		try{
	  		conn=DBManager.getConnection();
	  		stmt=conn.createStatement();
			rs=stmt.executeQuery(sql5);
	  		if(rs.next()){
	  			expens=rs.getInt("expens");
	  		}
	  	}catch(SQLException e){
	   		out.println("执行失败"+e.getMessage());
	  		return;
	   	}finally{
	   		if(stmt!=null)stmt.close();
	  		if(conn!=null)conn.close();
	  		if(stmt!=null)stmt.close();
	   	}
  	
  	
  	
	  	try{
		  		conn=DBManager.getConnection();
		  		prestmt=conn.prepareStatement(sql3);
		  		DBManager.setParams(prestmt, money+expens);
		  		prestmt.executeUpdate();
		  	}catch(SQLException e){
		   		out.println("执行失败"+e.getMessage());
		  		return;
		   	}finally{
		   		if(prestmt!=null)prestmt.close();
		  		if(conn!=null)conn.close();
		  		if(stmt!=null)stmt.close();
		   	}
	  }
  	
  	try{
  		conn=DBManager.getConnection();
  		prestmt=conn.prepareStatement(sql);
  		DBManager.setParams(prestmt,timeend);
  		prestmt.executeUpdate();
  	}catch(SQLException e){
   		out.println("执行失败"+e.getMessage());
  		return;
   	}finally{
   		if(prestmt!=null)prestmt.close();
  		if(conn!=null)conn.close();
   	}
 
  	
  
	
 %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'text.jsp' starting page</title>


</head>
 <body>
 	<div style="margin: auto 25%;">
		<h2>续借成功</h2>
		<a href="main.jsp" class="btn btn-info">返回主页面</a>
		</div>
 </body>
</html>
