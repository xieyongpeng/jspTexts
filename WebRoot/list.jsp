<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="com.helloweenvsfei.person.Person" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">  
  <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>My JSP 'text.jsp' starting page</title>
<!--<script type="text/javascript">
    function add(num){
    	alter();
    	//document.b.a.value=num+1;
    	//num=num+1;
    }
    function sub(num){
    	num=num-1;
    }
	</script>
-->

  </head>
  <body>

<%	
	Connection cont=null;
	Statement stmt=null;
	ResultSet rs=null;
	int num=1;
	HashMap<String,Person> personMap=new HashMap<String,Person>();
	Person person=null;
	HashMap<String,Person> perMap=null;
	try{
		String sql="select * from book_information";
		cont=DBManager.getConnection();
		stmt=cont.createStatement();
		rs=stmt.executeQuery(sql);
		String type=request.getParameter("type");
		String idp=request.getParameter("idp");
		
		if("add".equals(type)){
			perMap=(HashMap<String,Person>)session.getAttribute("personMap");
			if(perMap.get(idp)!=null){
				Person p=perMap.get(idp);
				num=p.getBorrownumber();
				num=num+1;
				p=null;
			}
		}
		if("sub".equals(type)){
			perMap=(HashMap<String,Person>)session.getAttribute("personMap");
			if(perMap.get(idp)!=null){
				Person p=perMap.get(idp);
				num=p.getBorrownumber();
				num=num-1;
				p=null;
			}
		}
 %>
 <form role="form" action="carlist.jsp" method=post>
	 <table class="table table-bordered table-condensed">
	 <caption>图书借阅信息</caption>
		<thead>
	 	<tr>
		    <th>&nbsp;</th>
		    <th>图书编号</th>
		    <th>图书名称</th>
		    <th>图书数量</th>
		    <th>图书价格</th>
		    <th>图书描述</th>
		    <th>借阅数量</th>
		</tr>
		</thead>
		<tbody>
		<%
			while(rs.next()){
				person= new Person();
				String bookid=rs.getString("bookid");
				person.setId(bookid);
				String bookname=rs.getString("bookname");
				person.setName(bookname);
				int booknumber=rs.getInt("booknumber");
				person.setNumber(booknumber);
				int bookprice=rs.getInt("bookprice");
				person.setPrice(bookprice);
				String description=rs.getString("description");
				person.setDescription(description);
				out.println("		<tr bgcolor=#FFFFFF>");
				out.println("	<td><input type=checkbox name=id value=" + bookid
						+ "></td>");
				out.println("	<td>" + bookid + "</td>");
				out.println("	<td>" + bookname + "</td>");
				out.println("	<td>" + booknumber + "</td>");
				out.println("	<td>" + bookprice + "</td>");
				out.println("	<td>" + description + "</td>");
		%>
				<!-- <td><input type="button" value="-" onclick="add('<%=num%>')" >
				<input  name="a" type="text" value="<%=num%>"  style="width: 50px;" >
				<input type="button" value="+" onclick="sub(num)" ></td>
				
				 
				 <form id="form1" name="form1" method="get" action="list.jsp">
				<input type="button" value="-">
				<input type="text" name="number" value="<%=num%>">
				<a href="cart/cart.jsp?oper=1&type=1"><input type="button" value="+" ></a><br>
				-->
			<%
				if(perMap!=null){
					person.setBorrownumber(perMap.get(bookid).getBorrownumber());
				}

				if(idp!=null&&idp.equals(bookid)){
					person.setBorrownumber(num);
				}
			 %>
				<td>
				<div class="input-group">
				<span class="input-group-addon">
				<a class="btn btn-default" role="button" href="list.jsp?type=sub&idp=<%=bookid%>"><span class="glyphicon glyphicon-circle-arrow-left"></span></a>
				</span><input class="form-control" type="text" name="number" value="<%= person.getBorrownumber()%>">
				<span class="input-group-addon">
				<a class="btn btn-default" role="button" href="list.jsp?type=add&idp=<%=bookid%>"><span class="glyphicon glyphicon-circle-arrow-right"></span></a></span></div>
				</td>
				
			<%
				out.println("		</tr>");	
				personMap.put(bookid, person);			
			}
				perMap=null;
				session.setAttribute("personMap", personMap);
				int qqi=0;
		 %>
		 </tbody>
		 </table>
			<table align=left>
				<tr>
					<td>
						<a class="btn btn-default" href='#'
							onclick="var array=document.getElementsByName('id');for(var i=0; i<array.length;
							i++){array[i].checked=true;}">全选</a>
						<a class="btn btn-default" href='#'
							onclick="var array=document.getElementsByName('id');for(var i=0; i<array.length;
							i++){array[i].checked=false;}">取消全选</a>
						<input class="btn btn-info" type='submit'
							onclick="return confirm('即将选择所选择的记录。是否提交？'); " value='提交' />
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
