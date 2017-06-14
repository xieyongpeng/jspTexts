<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<%
	Connection cont=null;
	PreparedStatement preStmt = null;
	ResultSet rs=null;
	String uname="";
	String password="";
	String message="";
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	uname=request.getParameter("uname");
	password=request.getParameter("password");
	try{
		if((("".equals(uname))||("".equals(password)))||(uname==null||password==null)){
		 message="请用户输入用户名和密码";
		}
		else{
			String sql="select * from student_information where name=? and password=?";
			cont = DBManager.getConnection();
			preStmt = cont.prepareStatement(sql);
			DBManager.setParams(preStmt,uname,password);
			rs = preStmt.executeQuery();
			if("root".equals(uname)){
				if(rs.next()){
					session.setAttribute("uname", uname);
					session.setAttribute("password", password);
					response.sendRedirect(request.getContextPath()+"/bookManage.jsp");
					return;
				}
				else{
					message="请检查输入的用户名和密码";
				}
			}
			else{
				if(rs.next()){
					session.setAttribute("uname", uname);
					session.setAttribute("password", password);
					//message="jimao        sa";
					response.sendRedirect(request.getContextPath()+"/list.jsp");
					return;
				}
				else{
					message="请检查输入的用户名和密码";
				}
			}
		}
 %>
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户登录界面</title>
<style type="text/css">
body{
	font-family:"Lucida Console", Monaco, monospace;
	font-size:12px;
}
p,h1,from,button{
	border:0;
	margin:0;
	padding:0;
}
.spacer{
	clear:both;
	height:1px;
}
.myform{
	margin:0 auto;
	width: 400px;
	padding:14px;
}
#stylized{
	border:solid 2px #b7ddf2;
	background:#ebf4fb;
}
#stylized h1{
	font-size:40px;
	font-weight:bold;
	margin-bottom:8px;
}
#stylized p{
	font-size:20px;
	color:#6666666;
	margin-bottom:20px;
	border-bottom:solid 1px #b7ddf2;
	padding-bottom:10px;
}
#stylized label{
	font-size:17px;
	display:block;
	font-weight: bold;
	text-align:right;
	width:140px;
	float:left;
}
.small{
	display:block;
	color:#666666;
	font-size:17px;
	font-weight:normal;
	text-align:right;
	width: 140;
}
#stylized input{
	float:left;
	font-size:17px;
	padding:4px 2px;
	border:solid 1px #aacfe4;
	width:200px;
	margin:2px 0 20px 10px;
	
}
#stylized button{
	clear:both;
	margin-left:150px;
	width:125px;
	height:31px;
	background:#6666666;
	text-align:center;
	line-height:31px;
	color:#33F;
	font-size:17px;
	font-weight:bold;
}
input:focus,button:focus{outline:thick solid #b7ddf2}
input:active,button:active{outline:thick solid #aaa}
</style>

</head>

<body>
	<% if(!message.equals("")){ %>
	<span style="color:red; "><%= message %></span>
	<%} %>
	<div id="stylized" class="myform">
    	<form id="form1" name="form1" method="post" action="log.jsp">
        	<h1>登录</h1>
            <p>请输入登录信息</p>
            <label>Name<span class="small">姓名</span></label>
            <input type="text" name="uname" id="textfiled" />
            <label>Email<span class="small">电子邮件</span></label>
            <input type="text" name="email" id="textfiled" />
            <label>Password<span class="small">密码</span></label>
            <input type="password" name="password" id="textfiled" />
            <button type="submit">登录</button>
            <div class="spacer"></div>
        </form>
    </div>
</body>
</html>
