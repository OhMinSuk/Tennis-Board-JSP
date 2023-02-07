<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_pw" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp" />
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUser_id(), user.getUser_pw());
		if (result == 1){
			session.setAttribute("userID",user.getUser_id());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
		else if (result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 옳바르지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>