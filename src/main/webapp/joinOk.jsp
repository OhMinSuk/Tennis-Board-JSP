<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_pw" />
<jsp:setProperty name="user" property="user_name" />
<jsp:setProperty name="user" property="user_email" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp" />
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입 성공')");
			script.println("location.href= 'login.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>