<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page"/>
<jsp:setProperty name="comment" property="comment_contents" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	 <%
      String userID = null;
      if(session.getAttribute("userID")!=null){
         userID=(String)session.getAttribute("userID");
      }
      int board_no = 0; 
      if (request.getParameter("board_no") != null){
                board_no = Integer.parseInt(request.getParameter("board_no"));
                CommentDAO commentDAO = new CommentDAO();
                int result = commentDAO.write(comment.getComment_contents(),userID, board_no);
                if (result == -1){
                   PrintWriter script = response.getWriter();
                   script.println("<script>");
                   script.println("alert('댓글 쓰기에 실패했습니다.')");
                   script.println("history.back()");
                   script.println("</script>");
                } else{
                   PrintWriter script = response.getWriter();
                   script.println("<script>");
                   script.println("location.href=document.referrer;");
                   script.println("</script>");
                }
             }
       %>
</body>
</html>