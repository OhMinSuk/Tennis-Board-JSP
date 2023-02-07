<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<header id="header">
	<div class="wrap">
		<h1 id="logo"><a href="index.jsp" title="HOME">테니스 용품 중고거래 게시판</a></h1>
		
		<ul id="util">
		<% 
			String userID = null;
			if (session.getAttribute("userID") != null){
				userID = (String) session.getAttribute("userID");
			}
			
			String boardType = "";
			if(request.getParameter("boardType") != null){
				boardType = request.getParameter("boardType");
			}
			
		%>
		<% if(userID == null){ %>
			<li><a href="login.jsp">로그인</a></li>
			<li><a href="join.jsp">회원가입</a></li>
		<% } else {		 %>
			<li><strong><%=userID %></strong> 님 환영합니다</li>
			<li><a href="logout.jsp"><strong>로그아웃</strong></a></li>
		<% } %>
		</ul>
		
		<nav id="menu">
			<ul class="menu">
				<li><a href="index.jsp?boardType=racket" <% if(boardType.equals("racket")) out.print("class='activeMenu'"); %>>테니스 라켓</a></li>
				<li><a href="index.jsp?boardType=etc" <% if(boardType.equals("etc")) out.print("class='activeMenu'"); %>>테니스 용품</a></li>
				<li><a href="index.jsp?boardType=cloth" <% if(boardType.equals("cloth")) out.print("class='activeMenu'"); %>>테니스 의류</a></li>
			</ul>
		</nav>	
	</div>
</header>