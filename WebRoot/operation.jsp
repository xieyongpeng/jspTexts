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

  	request.setCharacterEncoding("utf-8");
  	response.setCharacterEncoding("utf-8");
  	String action=request.getParameter("action");
  	
  	
  	if("add".equals(action)){
  		String id=request.getParameter("id");
  		String name=request.getParameter("name");
  		String number=request.getParameter("number");
  		String price=request.getParameter("price");
  		String description=request.getParameter("description");
  		String zhonglei=request.getParameter("zhonglei");
  		String sql="insert into book_information values('"+forSQL(id)+"', '"+forSQL(name)+
  		"', '"+forSQL(number)+"', '"+forSQL(price)+"', '"+forSQL(description)+"', '"+forSQL(zhonglei)+"','No')";
  		Connection conn=null;
  		Statement stmt=null;
  		int result=0;
  		try{
  			conn=DBManager.getConnection();
  			stmt=conn.createStatement();
  			result=stmt.executeUpdate(sql);
  		}catch(SQLException e){
  			out.println("执行SQL语句失败"+e.getMessage());
  			response.sendRedirect(request.getContextPath()+"/add.jsp");
  			return;
  		}finally{
  			if(stmt!=null)stmt.close();
  			if(conn!=null)conn.close();
  		}
	%>
	<div style="margin: auto 25%;">
		<h2>添加成功</h2>
		<a href="bookManage.jsp" class="btn btn-info">返回图书列表主菜单</a>
	</div>
	<%
    }
    else if("edit".equals(action)){
   		String id=request.getParameter("id");
   		Connection conn=null;
  		PreparedStatement prestmt=null;
  		ResultSet rs=null;
  		String sql="select * from book_information where bookid=?";
   		try{
   			conn=DBManager.getConnection();
   			prestmt=conn.prepareStatement(sql);
   			DBManager.setParams(prestmt, id);
   			rs=prestmt.executeQuery();
   			if(rs.next()){
   				request.setAttribute("id",rs.getString("bookid"));
   				request.setAttribute("name",rs.getString("bookname"));
   				request.setAttribute("number",rs.getString("booknumber"));
   				request.setAttribute("price",rs.getString("bookprice"));
   				request.setAttribute("description",rs.getString("description"));
   				request.getRequestDispatcher("/edit.jsp").forward(request, response);
   			}
   			else{
   				out.println("未找到该记录");
   			}
   		}catch(SQLException e){
   			out.println("执行修改失败"+e.getMessage());
  			//response.sendRedirect(request.getContextPath()+"/bookManage.jsp");
  			return;
   		}finally{
   			if(prestmt!=null)prestmt.close();
  			if(conn!=null)conn.close();
   		}
   }
   
   else if("save".equals(action)){
   		String id=request.getParameter("id");
  		String name=request.getParameter("name");
  		String number=request.getParameter("number");
  		String price=request.getParameter("price");
  		String description=request.getParameter("description");
  		String sql="update book_information set bookname='"+forSQL(name)+
  		"', booknumber='"+forSQL(number)+"', bookprice='"+forSQL(price)+"', description='"+
  		forSQL(description)+"' where bookid="+id;
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
  				response.sendRedirect(request.getContextPath()+"/bookManage.jsp");
  			}
  		}catch(SQLException e){
  			out.println("执行SQL语句失败"+e.getMessage());
  			return;
  		}finally{
  			if(stmt!=null)stmt.close();
  			if(conn!=null)conn.close();
  		}
  	}
  	
  	else if("del".equals(action)){
  		String[] id=request.getParameterValues("id");
  		if(id==null||id.length==0){
  			out.println("没有选中任何图书");
  		}
  		String condition="";
  		for(int i=0;i<id.length;i++){
  			if(i==0) condition=""+id[i];
  			else	 condition=", "+id[i];
  		}
  		Connection conn=null;
  		Statement stmt=null;
  		int result=0;
  		String sql="delete from book_information where bookid in ("+condition+") ";
  		try{
  			conn=DBManager.getConnection();
  			stmt=conn.createStatement();
  			result=stmt.executeUpdate(sql);
  %>
  		<div style="margin: auto 25%;">
		<h2>删除成功</h2>
		<a href="bookManage.jsp" class="btn btn-info">返回图书列表主菜单</a>
		</div>
  <%
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
