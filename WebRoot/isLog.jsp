<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.net.*" %>

<%
	String log=(String)session.getAttribute("islog");
	if("Yes".equals(log)){
		response.sendRedirect(request.getContextPath()+"/findBorrow.jsp");
	}else{
		response.sendRedirect(request.getContextPath()+"/log.jsp");
	}
	/*
	if(request.getCookies() != null){
		for(Cookie cookie : request.getCookies()){
			if(cookie.getName().equals("account")){
				log=1;
			}
		}
	}
	if(log==1){
		response.sendRedirect(request.getContextPath()+"/list.jsp");
		return;
	}
	else{
		response.sendRedirect(request.getContextPath()+"/log.jsp");
		return;
	}
	*/
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'isLog.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  </body>
</html>
