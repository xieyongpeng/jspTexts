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
  		request.setCharacterEncoding("utf-8");
	  	response.setCharacterEncoding("utf-8");
	  	String action=request.getParameter("action");
	  	
		if("find".equals(action)){
			String log=(String)session.getAttribute("islog");
			String name=(String)session.getAttribute("name");
			if("No".equals(log)){
				response.sendRedirect(request.getContextPath()+"/log.jsp");
			}
	  	
	   		String sql="select * from student_information where name=?";
	  		Connection conn=null;
	  		PreparedStatement prestmt=null;
  			ResultSet rs=null;
	  		int result=0;
	  		try{
	  			conn=DBManager.getConnection();
	   			prestmt=conn.prepareStatement(sql);
	   			DBManager.setParams(prestmt, name);
	   			rs=prestmt.executeQuery();
	  			if(rs.next()){
	   				request.setAttribute("id",rs.getString("id"));
	   				request.setAttribute("name",rs.getString("name"));
	   				request.setAttribute("sex",rs.getString("sex"));
	   				request.setAttribute("brithday",rs.getDate("brithday"));
	   				request.setAttribute("class1",rs.getString("class"));
	   				request.setAttribute("age",rs.getString("age"));
	   				request.setAttribute("description",rs.getString("description"));
	   				request.setAttribute("password",rs.getString("password"));
	   				request.setAttribute("expens",rs.getString("expens"));
	   				
	   				request.getRequestDispatcher("/editStudentMain.jsp").forward(request, response);
	   			}
	  		}catch(SQLException e){
	  			out.println("执行SQL语句失败"+e.getMessage());
	  			return;
	  		}finally{
	  			if(prestmt!=null)prestmt.close();
	  			if(conn!=null)conn.close();
	  		}
	  	
  	%>
  	  	<div style="margin: auto 25%;">
		<h2>删除成功</h2>
		<a href="main.jsp" class="btn btn-info">返回主菜单</a>
		</div>
		
	<%
		}
		else if("save".equals(action)){
		
	  	
	 	
	 	String expens=(String)request.getParameter("expens");
	 	
	 	
	 	String password=(String)request.getParameter("password");
	 	
	  	
   		String id=request.getParameter("id");
  		String name=request.getParameter("name");
  		String sex=request.getParameter("sex");
  		String class1=request.getParameter("class1");
  		String brithday=request.getParameter("brithday");
  		String age=request.getParameter("age");
  		String description=request.getParameter("description");
  		String sql="update student_information set id='"+forSQL(id)+
  		"', name='"+forSQL(name)+"', class='"+forSQL(class1)+"', sex='"+forSQL(sex)+
  		"', brithday='"+forSQL(brithday)+"', age='"+forSQL(age)+"', expens='"+forSQL(expens)+
  		"', password='"+forSQL(password)+"', description='"+
  		forSQL(description)+"' where id="+id;
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
  			else{
  				out.println("修改成功");
  				response.sendRedirect(request.getContextPath()+"/main.jsp");
  			}
  		}catch(SQLException e){
  			out.println("执行SQL语句失败"+e.getMessage());
  			return;
  		}finally{
  			if(stmt!=null)stmt.close();
  			if(conn!=null)conn.close();
  		}
  	}
	
	 %>
  
  </body>
</html>
