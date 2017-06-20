<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<jsp:directive.page import="java.security.MessageDigest"/>
<%!
	// 密钥
	private static final String KEY = ":cookie@helloweenvsfei.com";

	// MD5 加密算法
	public final static String calcMD5(String ss) {
	  
	   String s = ss==null ? "" : ss;
	  
	   char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
	   try {
	    byte[] strTemp = s.getBytes();
	    MessageDigest mdTemp = MessageDigest.getInstance("MD5");
	    mdTemp.update(strTemp);
	    byte[] md = mdTemp.digest();
	    int j = md.length;
	    char str[] = new char[j * 2];
	    int k = 0;
	    for (int i = 0; i < j; i++) {
	     byte byte0 = md[i];
	     str[k++] = hexDigits[byte0 >>> 4 & 0xf];
	     str[k++] = hexDigits[byte0 & 0xf];
	    }
	    return new String(str);
	   } catch (Exception e) {
	    return null;
	   }
	}
 %>
 
<%	
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	Connection cont=null;
	PreparedStatement preStmt = null;
	ResultSet rs=null;
	String uname="";
	String message="";
	String password = request.getParameter("password");
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
					response.sendRedirect(request.getContextPath()+"/manageMain.jsp");
					return;
				}
				else{
					message="请检查输入的用户名和密码";
				}
			}
			else{
				if(rs.next()){
					String ssid = calcMD5(uname + KEY);
							
					// 把帐号保存到Cookie中 并控制有效期
					Cookie accountCookie = new Cookie("account",URLEncoder.encode(uname,"utf-8"));
					
					// 把加密结果保存到Cookie中 并控制有效期
					Cookie ssidCookie = new Cookie("ssid",URLEncoder.encode(ssid,"utf-8"));
					
					//cookie发送到客户端
					response.addCookie(accountCookie);
					response.addCookie(ssidCookie);
					
					// 重新请求本页面，禁止浏览器缓存该页面
					response.sendRedirect(request.getContextPath()+"/main.jsp");
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
            <button type="submit" style="display:inline;">登录</button>
            <a href="main.jsp"><button type="button" style="display:inline;">返回</button></a>
            <div class="spacer"></div>
        </form>
    </div>
</body>
</html>
