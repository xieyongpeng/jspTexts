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
	Connection cont=null;
	PreparedStatement preStmt = null;
	ResultSet rs=null;
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String action = request.getParameter("action");
	
	if("login".equals(action)){
		
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		int timeout = new Integer(request.getParameter("time"));
		try{
			String sql="select * from student_information where name=? and password=?";
			cont = DBManager.getConnection();
			preStmt = cont.prepareStatement(sql);
			DBManager.setParams(preStmt,account,password);
			rs = preStmt.executeQuery();
			if("root".equals(account)){
				if(rs.next()){
					session.setAttribute("uname", account);
					session.setAttribute("password", password);
					response.sendRedirect(request.getContextPath()+"/manageMain.jsp");
					return;
				}
			}
			else{
				if(rs.next()){
					// 把帐号连同密钥使用MD5后加密后保存
					String ssid = calcMD5(account + KEY);
							
					// 把帐号保存到Cookie中 并控制有效期
					Cookie accountCookie = new Cookie("account",URLEncoder.encode(account,"utf-8"));
					accountCookie.setMaxAge(timeout);
					
					// 把加密结果保存到Cookie中 并控制有效期
					Cookie ssidCookie = new Cookie("ssid",URLEncoder.encode(ssid,"utf-8"));
					ssidCookie.setMaxAge(timeout);
					
					//cookie发送到客户端
					response.addCookie(accountCookie);
					response.addCookie(ssidCookie);
					
					// 重新请求本页面，禁止浏览器缓存该页面
					response.sendRedirect(request.getRequestURI() + "?" + System.currentTimeMillis());
					return;
				}
			}
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

	}
	else if("logout".equals(action)){

		// 删除Cookie中的帐号
		Cookie accountCookie = new Cookie("account", "");
		accountCookie.setMaxAge(0);
		
		// 删除Cookie中的加密结果
		Cookie ssidCookie = new Cookie("ssid", "");
		ssidCookie.setMaxAge(0);

		response.addCookie(accountCookie);
		response.addCookie(ssidCookie);

		// 重新请求本页面，禁止浏览器缓存该页面
		response.sendRedirect(request.getRequestURI() + "?" + System.currentTimeMillis());
		return;
	}
	
	boolean loggin = false;
	session.setAttribute("islog", "No");
	session.setAttribute("name", "No");
	
	String account = null;
	String ssid = null;
	
	// 获取Cookie中的account与ssid
	if(request.getCookies() != null){
		for(Cookie cookie : request.getCookies()){
			if(cookie.getName().equals("account"))
				account = URLDecoder.decode(cookie.getValue(), "utf-8");
			if(cookie.getName().equals("ssid"))
				ssid = URLDecoder.decode(cookie.getValue(), "utf-8");
		}
	}
	
	if(account != null && ssid != null){
		// 如果加密规则正确, 则视为已经登录
		loggin = ssid.equals(calcMD5(account + KEY));
		if(loggin){
			session.setAttribute("islog", "Yes");
			session.setAttribute("name", account);
		}
		
		
	}
	
 %>


<!DOCTYPE html>
  <head>
    <title>bookmain.html</title>
    
    
	
    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css"> 
    
    <link rel="stylesheet" href="css/css.css">
    <script src="js/jquery-3.2.0.min.js"></script> 
  	<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  	
  	
<script>
$(document).ready(function(){                          
    var index=0;
    var length=$("#img img").length;
    var i=1;
    
    //关键函数：通过控制i ，来显示图片
    function showImg(i){
        $("#img img")
            .eq(i).stop(true,true).fadeIn(800)
            .siblings("img").hide();
         $("#cbtn li")
            .eq(i).addClass("hov")
            .siblings().removeClass("hov");
    }
    
    function slideNext(){
        if(index >= 0 && index < length-1) {
             ++index;
             showImg(index);
        }else{
			if(confirm("已经是最后一张,点击确定重新浏览！")){
				showImg(0);
				index=0;
				aniPx=(length-5)*142+'px'; //所有图片数 - 可见图片数 * 每张的距离 = 最后一张滚动到第一张的距离
				$("#cSlideUl ul").animate({ "left": "+="+aniPx },200);
				i=1;
			}
            return false;
        }
        if(i<0 || i>length-5) {return false;}						  
               $("#cSlideUl ul").animate({ "left": "-=142px" },200)
               i++;
    }
     
    function slideFront(){
       if(index >= 1 ) {
             --index;
             showImg(index);
        }
        if(i<2 || i>length+5){return false;}
               $("#cSlideUl ul").animate({ "left": "+=142px" },200)
               i--;
    }	
        $("#img img").eq(0).show();
        $("#cbtn li").eq(0).addClass("hov");
        $("#cbtn tt").each(function(e){
            var str=(e+1)+""+length;
            $(this).html(str)
        })
    
        $(".picSildeRight,#next").click(function(){
               slideNext();
           })
        $(".picSildeLeft,#front").click(function(){
               slideFront();
           })
        $("#cbtn li").click(function(){
            index  =  $("#cbtn li").index(this);
            showImg(index);
        });	
		$("#next,#front").hover(function(){
			$(this).children("a").fadeIn();
		},function(){
			$(this).children("a").fadeOut();
		})
    })	
</script>
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
  <body>
  
  
    <nav class="navbar navbar-default" role="navigation" style="margin:0px 0px 3px 0px;"> 
    <div class="container-fluid"> 
    <div class="navbar-header"> 
        <a class="navbar-brand" href="#">图书管理系统</a> 
    </div> 
    <div> 
        <ul class="nav navbar-nav"> 
        	<li class="active"><a href="#">主页</a></li> 
            <li><a href="isLog.jsp">图书借阅查询</a></li> 
            <li><a href="#">用户留言</a></li> 
            <li class="dropdown"> 
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
                    	图书借还 <b class="caret"></b> 
                </a> 
                <ul class="dropdown-menu"> 
                     
                    <li><a href="#">图书归还</a></li> 
                    <li><a href="#">图书挂失</a></li> 
                    <li><a href="#">图书续借</a></li> 
                    <li class="divider"></li> 
                    <li><a href="#">缴费</a></li>
                </ul> 
            </li>
            <li><a href="operationStudentMain2.jsp?action=find">编辑资料</a></li> 
            <li><%if(!loggin){ %><a href="#"><span class="glyphicon glyphicon-user">
            </span>用户注册/登录</a><%} else{%><a href="${ pageContext.request.requestURI }?action=logout">
            	欢迎您, <%=URLDecoder.decode(account, "utf-8") %>. &nbsp;&nbsp;注销</a><%} %></li> 
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

<div class="container" style="margin:0px;padding:0px">
    <div class="row" >
    
    <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2" >
       		<nav class="navbar navbar-default" role="navigation"> 
    			<div class="container-fluid"> 
    				<div class="navbar-header"> 
       					 <a class="navbar-brand" href="#">图书分类</a> 
    				</div> 
   					<div> 
        				<ul class="nav navbar-nav">  
        				<li><a href="findclass.jsp?zhonglei=计算机类">计算机类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=人文类">人文类图书</a></li> 
            			<li><a href="findclass.jsp?zhonglei=科技类">科技类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=励志类">励志类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=健身类">健身类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=哲学类">哲学类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=儿童类">儿童类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=散文类">散文类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=旅游类">旅游类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=传记类">传记类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=青春文学类">青春文学类图书</a></li>
            			<li><a href="findclass.jsp?zhonglei=其他">其他</a></li>
       					</ul>
       				</div>
       			</div>
       		</nav>
    </div>
    	
    	
    	 <div class="hidden-xs col-sm-6 col-lg-6 col-md-6" >
			            <div id="wrapper">
				<!--滚动看图-->
				<div id="picSlideWrap" class="clearfix"><br>
			        <div class="imgnav" id="imgnav"> 
			             <div id="img"> 
			                <img src="images/100260_1306276811398.jpg" width="100%" height="570">
			                <img src="images/100261_1306276853791.jpg"  width="100%" height="570">
			                <img src="images/100391_4381_1306217104406.jpg" width="100%" height="570" />
			                <img src="images/bImg.jpg"  width="100%" height="570" />
			                <img src="images/100260_1306276811398.jpg" width="100%" height="570">
			                <img src="images/100261_1306276853791.jpg"  width="100%" height="570">
			                <img src="images/100391_4381_1306217104406.jpg" width="100%" height="570" />
			                <img src="images/bImg.jpg"  width="100%" height="570" />
			                <img src="images/100260_1306276811398.jpg" width="100%" height="570">
			                <img src="images/100261_1306276853791.jpg"  width="100%" height="570">
			                <div id="front" title="上一张"><a href="javaScript:void(0)" class="pngFix"></a></div>
			                <div id="next" title="下一张"><a href="javaScript:void(0)" class="pngFix"></a></div>
			             </div>
			             
			             <div id="content">
			    　　         			<p>在大学期间一定要找一本属于自己的图书进行阅读，每一次阅读都是一场旅行，他会带你去你生活中无法碰触的你一个板块，带你领略别人不能碰触的生活经历，欢迎来到cuit图书馆</p>
			             </div>
			              
			             <div id="cbtn">
			                <i class="picSildeLeft"><img src="images/ico/picSlideLeft.gif"></i> 
			                <i class="picSildeRight"><img src="images/ico/picSlideRight.gif"></i> 
			                <div id="cSlideUl">
			                    <ul>
			                        <li><img src="images/100260_1306276811398.jpg"><tt></tt></li>
			                        <li><img src="images/100261_1306276853791.jpg"><tt></tt></li>
			                        <li><img src="images/100391_4381_1306217104406.jpg" /><tt></tt></li>
			                        <li><img src="images/bImg.jpg"><tt></tt></li>
			                        <li><img src="images/100260_1306276811398.jpg"><tt></tt></li>
			                        <li><img src="images/100261_1306276853791.jpg"><tt></tt></li>
			                        <li><img src="images/100391_4381_1306217104406.jpg" /><tt></tt></li>
			                        <li><img src="images/bImg.jpg"><tt></tt></li>
			                        <li><img src="images/100260_1306276811398.jpg"><tt></tt></li>
			                        <li><img src="images/100261_1306276853791.jpg"><tt></tt></li>
			                    </ul>
			                </div>
			             </div>         
			        </div>
			    </div><!--end滚动看图-->
			</div>
        </div>
    	
    	
        <div class="col-xs-6 col-sm-4 col-md-4 col-lg-4" >
        <%if(!loggin){ %>
        	<form class="form-horizontal" role="form" action="${ pageContext.request.requestURI }?action=login" method="post">
				  <div class="form-group">
				    <label for="firstname" class="col-sm-2 control-label">姓名</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="firstname" placeholder="请输入姓名" name="account">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="lastname" class="col-sm-2 control-label">密码</label>
				    <div class="col-sm-10">
				      <input type="password" class="form-control" id="lastname" placeholder="请输入密码" name="password">
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <div class="checkbox">
				        <label>
				          <input type="radio" name="time" value="-1" checked="checked">忘记密码
				        </label>
				        <label>
				          <input type="radio" name="time" value="<%= Integer.MAX_VALUE %>">记住密码
				        </label>
				      </div>
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <button type="submit" class="btn btn-default">登录</button>
				    </div>
				  </div>
			</form>
			<br />
			<br />
			<br />
			<%} %>
			<div class="panel panel-default">
				<div class="panel-heading">公告信息</div>
					<div class="panel-body">
						<p>这是一个基本的面板内容。这是一个基本的面板内容。
							这是一个基本的面板内容。这是一个基本的面板内容。
							这是一个基本的面板内容。这是一个基本的面板内容。
							这是一个基本的面板内容。这是一个基本的面板内容。
						</p>
					</div>
					<ul class="list-group">
						<li class="list-group-item">免费域名注册</li>
						<li class="list-group-item">免费 Window 空间托管</li>
						<li class="list-group-item">图像的数量</li>
						<li class="list-group-item">24*7 支持</li>
						<li class="list-group-item">每年更新成本</li>
					</ul>
				</div>
	        </div>
	       
       
</div>
 			<fieldset>
				<legend>当前有效的 Cookie</legend>
				<script type="text/javascript">
				document.write(document.cookie);
				</script>
			</fieldset>
  </body>
</html>
