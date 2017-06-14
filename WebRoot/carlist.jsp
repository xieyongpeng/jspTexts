<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helloweenvsfei.person.Person" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<table class="table table-bordered table-condensed">
	<caption>图书借阅信息</caption>
	<thead>
	 	<tr>
		    <th>图书编号</th>
		    <th>图书名称</th>
		    <th>图书数量</th>
		    <th>图书价格</th>
		    <th>图书描述</th>
		    <th>取消借阅</th>
		</tr>
	</thead>
	<tbody>
<%
	Connection cont=null;
	PreparedStatement preStmt = null;
	ResultSet rs=null;
	HashMap<String,Person> perMap=(HashMap<String,Person>)session.getAttribute("personMap");
	Person person=null;
	int numprice=0;
	String[] books=request.getParameterValues("id");
	try{
		String sql="select * from book_information where bookid=?";
		cont = DBManager.getConnection();
		preStmt = cont.prepareStatement(sql);
		for(int i=0;books.length>i;i++){
			DBManager.setParams(preStmt,books[i]);
			rs = preStmt.executeQuery();
				while(rs.next()){
				String bookid=rs.getString("bookid");
				String bookname=rs.getString("bookname");
				int booknumber=rs.getInt("booknumber");
				int bookprice=rs.getInt("bookprice");
				String description=rs.getString("description");
				out.println("		<tr bgcolor=#FFFFFF>");
				out.println("	<td>" + bookid + "</td>");
				out.println("	<td>" + bookname + "</td>");
				out.println("	<td>" + booknumber + "</td>");
				out.println("	<td>" + bookprice + "</td>");
				out.println("	<td>" + description + "</td>");
				out.println("	<td><a class='btn btn-primary' role='button' href=\"###\">取消</a></td>");
				out.println("		</tr>");
				person=perMap.get(bookid);	
				numprice=numprice+person.getBorrownumber()*person.getPrice();			
				}
				
		}
 %>
 	<tr>
 		<td colspan="3">图书价值</td>
 		<td colspan="3"><%=numprice %></td>
 	</tr>
 	</tbody>
 	</table>
<%
	}catch(SQLException e){
		out.println("发生了异常：" + e.getMessage());
		e.printStackTrace();
	}finally {
			if (rs != null)
				rs.close();
			if (preStmt != null)
				preStmt.close();
			if (cont != null)
				cont.close();
		}
	%>
		<a class="btn btn-primary" role="button" href='list.jsp'>继续借阅</a>
		<a class="btn btn-primary" role="button" href='log.jsp'>退出登录</a>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'carlist.jsp' starting page</title>
    


  </head>
  
  <body>
     
  </body>
</html>
