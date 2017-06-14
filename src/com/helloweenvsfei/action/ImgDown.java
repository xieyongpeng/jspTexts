package com.helloweenvsfei.action;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.helloweenvsfei.mysqlManager.DBManager;
import java.sql.*;


public class ImgDown extends HttpServlet {

	/**
		 * Constructor of the object.
		 */
	public ImgDown() {
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
		
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		
		byte[] bt=getImg(id);
		response.getOutputStream().write(bt);
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
		
		
		
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
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
	
	public byte[] getImg(String id) throws IOException{
		BufferedInputStream ins=null;//取得BLOB的IO流 
        byte[] bt = null; 
        Connection conn = null;
		PreparedStatement preStmt = null;
		ResultSet rs = null;
		try{
			conn = DBManager.getConnection();
			preStmt = conn.prepareStatement("select * from bookimg where imgid = ? ");
			preStmt.setString(1, id);
			rs = preStmt.executeQuery();
			if(rs.next()){
				int size=rs.getInt("size");
				ins = new BufferedInputStream(rs.getBinaryStream("content"));
				bt=new byte[size];
				try{
					ins.read(bt, 0, size);		
				}catch (IOException e){
					e.getMessage();
				}
			}
		}catch(Exception e){
			e.getMessage();
		}finally{
			if(preStmt!=null)
				try {
					preStmt.close();
				} catch (SQLException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
  			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			if(ins != null)
				try {
					ins.close();
				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
		}
		return bt;
        
	}

}
