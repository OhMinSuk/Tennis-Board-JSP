<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp" />
</head>
<body>
	<%
		session.invalidate();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그아웃 되었습니다.')");
		script.println("location.href= 'index.jsp'");
		script.println("</script>");
	%>
</body>
</html>