<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<jsp:directive.page import="java.sql.Date" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'manageMain.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<script src="js/jquery-3.2.0.min.js"></script> 
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

  </head>
  
  <body>
  
  <nav class="navbar navbar-default" role="navigation" style="margin:0px 0px 3px 0px;"> 
    <div class="container-fluid"> 
    <div class="navbar-header"> 
        <a class="navbar-brand" href="#">管理员管理系统</a> 
    </div> 
    <div> 
        <ul class="nav navbar-nav"> 
            <li><a href="manageMain.jsp">学生管理</a></li> 
            <li><a href="bookManage.jsp">图书管理</a></li> 
            <li><a href="showMessage.jsp">留言信息查阅</a></li> 
            <li class="active"><a href="#">发布公告</a></li>
            <li><a href="main.jsp">注销登录</a></li>
        </ul> 
       
    </div> 
</nav>

<%	
	Connection cont=null;
	Statement stmt=null;
	ResultSet rs=null;

	try{
		String sql="select * from announce";
		cont=DBManager.getConnection();
		stmt=cont.createStatement();
		rs=stmt.executeQuery(sql);
		
 %>
 <a class="btn btn-info" href="addAnnounce.jsp"><span class="glyphicon glyphicon-book">新建公告</span></a>
 <form role="form" action="operationStudent.jsp" method=post>
	 <table class="table table-bordered table-condensed">
	 	<caption>公告编辑</caption>
		<thead>
	 	<tr>
		    <th>&nbsp;</th>
		    <th>编号</th>
		    <th>内容</th>
		    <th>操作</th>
		</tr>
		</thead>
		<tbody>
		<%
			while(rs.next()){

				String id=rs.getString("announce_id");
				
				String text=rs.getString("text");
				
				out.println("		<tr bgcolor=#FFFFFF>");
				out.println("	<td><input type=checkbox name=id value=" + id
						+ "></td>");
				out.println("	<td>" + id + "</td>");
				out.println("	<td>" + text + "</td>");
				out.println("	<td>");
						out.println("		<a class='btn btn-default' href='operationAnnounce.jsp?action=del&id="
						+ id + "' onclick='return confirm(\"确定删除该记录？\")'>删除</a>");
						out.println("		<a class='btn btn-default' href='operationAnnounce.jsp?action=edit&id="
						+ id + "'>修改</a>");
						out.println("	</td>");
						out.println("		</tr>");
		
			}
		%>
				
		 </tbody>		
		 </table>
			<table align=left>
				<tr>
					<td>
						<a class='btn btn-primary' href='#'
							onclick="var array=document.getElementsByName('id');for(var i=0; i<array.length;
							i++){array[i].checked=true;}">全选</a>
						<a class='btn btn-primary' href='#'
							onclick="var array=document.getElementsByName('id');for(var i=0; i<array.length;
							i++){array[i].checked=false;}">取消全选</a>
						<input class="btn btn-info" type='submit'
							onclick="return confirm('即将删除所选择的记录。是否提交？'); " value='删除' />
					</td>
				</tr>
		</table>
 </form>
<%
	}catch(SQLException e){
		out.println("发生了异常：" + e.getMessage());
		e.printStackTrace();
	}finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (cont != null)
				cont.close();
		}

 %>
  
  
  
  </body>
</html>
