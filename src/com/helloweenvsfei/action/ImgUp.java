package com.helloweenvsfei.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.*;
import com.helloweenvsfei.mysqlManager.DBManager;
import java.sql.*;
import java.util.*;

public class ImgUp extends HttpServlet {

	/**
		 * Constructor of the object.
		 */
	public ImgUp() {
		super();
	}

	/**
		 * Destruction of the servlet. <br>
		 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
		 * The doGet method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to get.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
		 * The doPost method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to post.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		DiskFileUpload diskFileUpload=new DiskFileUpload();
		diskFileUpload.setHeaderEncoding("utf-8");
		List<FileItem> list=null;
		try {
			list = diskFileUpload.parseRequest(request);
		} catch (FileUploadException e1) {
			// TODO 自动生成的 catch 块
			e1.printStackTrace();
		}
		Connection conn=null;
		PreparedStatement preStmt=null;
		String sql="insert into bookimg (content,size,filetype,filename,imgid) values(?,?,?,?,?)";
		String filename=null;
		String id=null;
		FileItem fileItemstairt=null;
		for(FileItem fileItem : list){
			if(!fileItem.isFormField()){//如果不是文本域
				fileItemstairt=fileItem;
				filename=fileItem.getName().replace("\\", "/");
				filename=filename.substring(filename.lastIndexOf("/")+1);
			}
			else{
				id=fileItem.getString();
			}
		}
				try{
					conn=DBManager.getConnection();
   					preStmt=conn.prepareStatement(sql);
					preStmt.setString(4,filename);
					preStmt.setString(5,id);
					preStmt.setInt(2,(int)fileItemstairt.getSize());
					preStmt.setString(3,fileItemstairt.getContentType());
					preStmt.setBinaryStream(1,fileItemstairt.getInputStream(),(int)fileItemstairt.getSize());
					preStmt.executeUpdate();
				}catch(Exception e){
					out.println("操作失败"+e.getMessage());
				}finally{
					if(preStmt!=null){
						try {
							preStmt.close();
						} catch (SQLException e) {
							// TODO 自动生成的 catch 块
							e.printStackTrace();
						}
					}
  					if(conn!=null){
						try {
							conn.close();
						} catch (SQLException e) {
							// TODO 自动生成的 catch 块
							e.printStackTrace();
						}
  					}
			
			
		}
		
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    上传成功 ");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
		 * Initialization of the servlet. <br>
		 *
		 * @throws ServletException if an error occurs
		 */
	public void init() throws ServletException {
		// Put your code here
	}

}
