<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		int board_no=0;
		if(request.getParameter("board_no")!=null)
			board_no=Integer.parseInt(request.getParameter("board_no"));
		
		int comment_no=0;
		if(request.getParameter("comment_no")!=null)
			comment_no=Integer.parseInt(request.getParameter("comment_no"));
		
		Comment comment = new CommentDAO().getComment(comment_no);
		if(!userID.equals(comment.getUser_id())){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
				CommentDAO commentDAO=new CommentDAO();
				int result=commentDAO.delete(comment_no);
				if(result == -1){
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("location.href=document.referrer;");
					script.println("</script>");
				}
		}
	%>
</body>
</html>