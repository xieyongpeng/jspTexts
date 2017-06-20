<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>




<%


	String log=(String)session.getAttribute("islog");
	if("No".equals(log)){
		response.sendRedirect(request.getContextPath()+"/log.jsp");
	}
	
	
	String name=(String)session.getAttribute("name");
	
	String idbook=request.getParameter("bookid");
	
	Connection conn=null;
  	Statement stmt=null;
  	PreparedStatement prestmt=null;
  	ResultSet rs=null;
  	int price=0;
  	
  	
  	String sql="select * from book_information where bookid='"+idbook+"'";
  	String sql2="delete from borrow_book where idbook='"+idbook+"' and name='"+name+"'";
  	String sql3="update student_information set expens=? where name='"+name+"'";
  	String sql4="select * from student_information where name='"+name+"'";
  	
  	try{
  			conn=DBManager.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
  			if(rs.next()){
  				price=rs.getInt("bookprice");
  			}
  			
  	}catch(SQLException e){
   			out.println("执行修改失败"+e.getMessage());
  			return;
   		}finally{
   			if(prestmt!=null)prestmt.close();
  			if(conn!=null)conn.close();
  			if(stmt!=null)stmt.close();
   	}
  	
  	
  	
  	
  	try{
  		conn=DBManager.getConnection();
  		stmt=conn.createStatement();
  		stmt.executeUpdate(sql2);
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
	  		stmt=conn.createStatement();
			rs=stmt.executeQuery(sql4);
	  		if(rs.next()){
	  			price=rs.getInt("expens")+price;
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
	  		DBManager.setParams(prestmt, price);
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


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'text.jsp' starting page</title>


</head>
 <body>
 	<div style="margin: auto 25%;">
		<h2>挂失成功</h2>
		<a href="main.jsp" class="btn btn-info">返回主页面</a>
		</div>
 </body>
</html>
