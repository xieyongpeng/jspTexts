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
	String sql1="select * from borrow_book where name='" +name+ "'";
	int count=DBManager.getCount(sql1);
	String[] idbook=request.getParameterValues("id");
	Date date=new Date();
	Timestamp timestart = new Timestamp(date.getTime());
	System.out.println(timestart);
	Timestamp timeend= new Timestamp(date.getTime());
	timeend.setTime(timestart.getTime() - 1000 * 60 * 60 * 24 * 30);
	System.out.println(timeend);
	Connection conn=null;
  	Statement stmt=null;
  	PreparedStatement prestmt=null;
  	ResultSet rs=null;
  	String sql="";
  	
  	String borrow="Yes";
  	String sql2="";
  	String sql3="";
  	for(int i=0;i<idbook.length&&"Yes".equals(borrow);i++){
  		sql2="select * from book_information where bookid='"+forSQL(idbook[i])+"'";
  		sql3="update book_information set booknumber=? where bookid=?";
  		System.out.println(sql2);
  		System.out.println(sql3);
  		try{
  			conn=DBManager.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql2);
  			rs.next();
  			int booknumber=rs.getInt("booknumber");
  			if(booknumber==0){
  				borrow="No";
  			}
  			else{
  				booknumber=booknumber-1;
  				rs.close();
  				stmt.close();
  				conn.close();
  				conn=DBManager.getConnection();
  				prestmt=conn.prepareStatement(sql3);
  				DBManager.setParams(prestmt, booknumber , idbook[i]);
  				prestmt.executeUpdate();
  			}
  			
  		}catch(SQLException e){
   			out.println("执行修改失败"+e.getMessage());
  			return;
   		}finally{
   			if(prestmt!=null)prestmt.close();
  			if(conn!=null)conn.close();
  			if(stmt!=null)stmt.close();
   		}
  	
  	}
  	
  	
	if(count+idbook.length<=5&&"Yes".equals(borrow)){
  		if(idbook==null||idbook.length==0){
  			out.println("没有选中任何图书");
  		}
  		int result=0;
  		for(int i=0;i<idbook.length;i++){
			sql="insert into borrow_book values('"+name+"', '"+forSQL(idbook[i])+
  			"', '"+timestart+"', '"+timeend+"', '"+0+"')";
	  		try{
	  			conn=DBManager.getConnection();
	  			stmt=conn.createStatement();
	  			result=stmt.executeUpdate(sql);
	  		}catch(SQLException e){
	  			out.println("执行SQL语句失败"+e.getMessage());
	  		}finally{
	  			if(stmt!=null)stmt.close();
	  			if(conn!=null)conn.close();
	  		}
	  	}
	}else{
		response.sendRedirect(request.getContextPath()+"/Welcome.jsp");
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
		<h2>借阅成功</h2>
		<a href="main.jsp" class="btn btn-info">返回主页面</a>
		</div>
 </body>
</html>
