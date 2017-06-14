<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helloweenvsfei.person.Person" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>


<%
	final int pageSize = 5;	// 一页显示 10 条记录

	int pageNum = 1; 			// 当前页数
	int pageCount = 1;			// 总页数

	int recordCount = 0;		// 总记录数
	
	try{
		// 从地址栏参数取当前页数
		pageNum = Integer.parseInt(request.getParameter("pageNum"));//获取的是字符串型，要转为数值
	}catch(Exception e){}

 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'text.jsp' starting page</title>


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
            <li class="active"><a href="#">图书管理</a></li> 
            <li><a href="#">留言信息查阅</a></li> 
            <li><a href="#">发布公告</a></li>
            <li><a href="main.jsp">注销登录</a></li>
        </ul> 
        <div>
			<form class="navbar-form navbar-left" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
				<button type="submit" class="btn btn-default">提交</button>
			</form>
		</div>
    </div> 
</nav>

<%	
	Connection cont=null;
	PreparedStatement preStmt = null;
	ResultSet rs=null;
	try{
		String sql="select * from book_information";
		recordCount = DBManager.getCount(sql);//计算出所有记录条数
		
		pageCount = ( recordCount + pageSize - 1 ) / pageSize;// 计算总页数
		
		int startRecord = ( pageNum - 1) * pageSize;// 本页从 startRecord 行开始
		
		// MySQL 使用limit实现分页
		sql = "SELECT * FROM book_information LIMIT ?, ? ";
		cont = DBManager.getConnection();
		preStmt = cont.prepareStatement(sql);
		DBManager.setParams(preStmt, startRecord, pageSize);//从几页开始显示几条
		rs = preStmt.executeQuery();
		
 %>
 <a class="btn btn-info" href="add.jsp"><span class="glyphicon glyphicon-user">新建图书信息</span></a>
 <form role="form" action="operation.jsp" method=post>
	 <table class="table table-bordered table-condensed">
	 	<caption>图书借阅信息编辑</caption>
		<thead>
	 	<tr>
		    <th>&nbsp;</th>
		    <th>图书编号</th>
		    <th>图书名称</th>
		    <th>图书数量</th>
		    <th>图书价格</th>
		    <th>图书描述</th>
		    <th>操作</th>
		</tr>
		</thead>
		<tbody>
		<%
			while(rs.next()){
				
				String bookid=rs.getString("bookid");
				
				String bookname=rs.getString("bookname");
				
				int booknumber=rs.getInt("booknumber");
				
				int bookprice=rs.getInt("bookprice");
				
				String description=rs.getString("description");
				
				out.println("		<tr bgcolor=#FFFFFF>");
				out.println("	<td><input type=checkbox name=id value=" + bookid
						+ "></td>");
				out.println("	<td>" + bookid + "</td>");
				out.println("	<td>" + bookname + "</td>");
				out.println("	<td>" + booknumber + "</td>");
				out.println("	<td>" + bookprice + "</td>");
				out.println("	<td>" + description + "</td>");
				out.println("	<td>");
						out.println("		<a class='btn btn-default' href='operation.jsp?action=del&id="
						+ bookid + "' onclick='return confirm(\"确定删除该记录？\")'>删除</a>");
						out.println("		<a class='btn btn-default' href='operation.jsp?action=edit&id="
						+ bookid + "'>修改</a>");
						/*out.println("		<a class='btn btn-default' href='imgbolb.jsp?action=img&id="
						+ bookid + "'>查看</a>");*/
						out.println("	</td>");
						out.println("		</tr>");
			
			}
		%>
				
		 </tbody>		
		 </table>
					<table class="table table-bordered table-condensed">
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
							
							
							<div style="display:inline">
							<%
									String pageUrl=request.getRequestURI();
									String url = pageUrl.contains("?") ? pageUrl : pageUrl + "?";
									if(!url.endsWith("?") && !url.endsWith("&")){
										url += "&";
									}
								
								 %>
									第 <%=pageNum %>/<%=pageCount %>&nbsp;页 共&nbsp;<%=recordCount %>记录
								<%
									if(pageNum==1){
								 %> 
								 	第一页&nbsp;上一页 
								<%
								 	}else{
								 %>
									<a href='<%=url + "pageNum=1" %>' >第一页</a>
									<a href='<%=url + "pageNum=" + (pageNum-1) %>' >上一页</a>
								<%
									}if(pageNum == pageCount){
								%>
									下一页&nbsp;最后一页
								<%
								 	}else{
								 %>
								 	<a href='<%=url + "pageNum=" + (pageNum+1) %>' >下一页</a>
									<a href='<%=url + "pageNum="+pageCount %>' >最后一页</a>
								<%
									}
								%>
							
							</div>
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
			if (preStmt != null)
				preStmt.close();
			if (cont != null)
				cont.close();
		}
 %>

  
  
 </body>
</html>
