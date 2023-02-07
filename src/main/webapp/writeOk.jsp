<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="board_title" />
<jsp:setProperty name="board" property="board_contents" />
<jsp:setProperty name="board" property="board_index" />
<jsp:setProperty name="board" property="board_type" />
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp" />
</head>
<body>
	<%
		String realFolder="";
		String saveFolder="boardUpload";
		String encType="utf-8";
		int maxSize=5*1024*1024;
		
		ServletContext context = this.getServletContext();
		realFolder = context.getRealPath(saveFolder);
		
		MultipartRequest multi = null;
		
		multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
		String file_name = multi.getFilesystemName("file_name");
		String board_title = multi.getParameter("board_title");
		String board_contents = multi.getParameter("board_contents");
		String board_index = multi.getParameter("board_index");
		String board_type = multi.getParameter("board_type");
		board.setBoard_title(board_title);
		board.setBoard_contents(board_contents);
		board.setBoard_index(board_index);
		board.setBoard_type(board_type);
		board.setFile_name(file_name);
				
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else{
			BoardDAO boardDAO = new BoardDAO();
			int result = boardDAO.write(board.getBoard_title(),userID,board.getBoard_contents(),board.getBoard_index(),board.getBoard_type(),board.getBoard_count(),board.getFile_name());
			
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
		}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 작성이 완료되었습니다.')");
				script.println("location.href= 'index.jsp'");
				script.println("</script>");
				}
		}
	%>
</body>
</html>