<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.helloweenvsfei.mysqlManager.DBManager" %>
<jsp:directive.page import="org.apache.commons.fileupload.FileItem"/>
<jsp:directive.page import="org.apache.commons.fileupload.DiskFileUpload"/>
<%
	String id = request.getParameter("id");
	if("post".equalsIgnoreCase(request.getMethod())){
		DiskFileUpload diskFileUpload=new DiskFileUpload();
		diskFileUpload.setHeaderEncoding("utf-8");
		List<FileItem> list=diskFileUpload.parseRequest(request);
		for(FileItem fileItem : list){
			if(!fileItem.isFormField()){//如果不是文本域
				String filename=fileItem.getName().replace("\\", "/");
				filename=filename.substring(filename.lastIndexOf("/")+1);
				Connection conn=null;
				PreparedStatement preStmt=null;
				String sql="insert into bookimg (content,size,filetype,filename,imgid) values(?,?,?,?,?)";

				try{
					conn=DBManager.getConnection();
   					preStmt=conn.prepareStatement(sql);
					preStmt.setString(4,filename);
					preStmt.setString(5,id);
					preStmt.setInt(2,(int)fileItem.getSize());
					preStmt.setString(3,fileItem.getContentType());
					preStmt.setBinaryStream(1,fileItem.getInputStream(),(int)fileItem.getSize());
					preStmt.executeUpdate();
				}catch(Exception e){
					out.println("操作失败"+e.getMessage());
				}finally{
					if(preStmt!=null)preStmt.close();
  					if(conn!=null)conn.close();
				}
			}
		}
	
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'imgbolb.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
  <%
  	
  	out.clear();

	
	if(id!=null){
		Connection conn = null;
		PreparedStatement preStmt = null;
		ResultSet rs = null;
		
		try{
			conn = DBManager.getConnection();
			preStmt = conn.prepareStatement("select * from bookimg where imgid = ? ");
			preStmt.setString(1, id);
			rs = preStmt.executeQuery();
			if(rs.next()){
				response.reset();
				response.setContentType(rs.getString("filetype"));
				response.setContentLength(rs.getInt("size"));
			
				InputStream ins = null;
				OutputStream ous = null;
				try{
					ins = rs.getBinaryStream("content");
					ous = response.getOutputStream();
					
					byte[] b = new byte[1024];
					int len = 0;
					
					while((len = ins.read(b)) != -1){
						ous.write(b, 0, len);
					}
				}catch(Exception e){
					out.println("操作失败"+e.getMessage());
				}finally{
					if(ous != null)	ous.close();
					if(ins != null)	ins.close();
				}
			}
			else{
  				out.println("该图书未上传照片");
  				
  %>
  				<form action="${ pageContext.request.requestURI }" method="post" enctype="multipart/form-data">
				<input name="file" type="file" style="width: 300px; " /><input type="submit" value=" 开始上传 ">
				</form>
  <% 
  			}	
		}catch(Exception e){
			out.println("操作失败"+e.getMessage());
		}finally{
			if(preStmt!=null)preStmt.close();
  			if(conn!=null)conn.close();
		}
  	}
  	
  
   %>
  
  
  	
  </body>
</html>
