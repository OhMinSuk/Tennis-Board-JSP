<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
	}
	int board_no = 0;
	if (request.getParameter("board_no") != null){
		board_no = Integer.parseInt(request.getParameter("board_no"));
	}
	if (board_no == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}

	Board board = new BoardDAO().getBoard(board_no);
	
	String realFolder="";
	String saveFolder = "boardUpload";
	String encType = "utf-8";
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
	
	
	if (!userID.equals(board.getUser_id())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다')");
		script.println("location.href = './'");
		script.println("</script>");
	} else {
		BoardDAO boardDAO = new BoardDAO();
		int result = boardDAO.update(board_no, board.getBoard_index(), board.getBoard_title(), board.getBoard_contents(), board.getBoard_type(), board.getFile_name());
		
		PrintWriter script = response.getWriter();
		
		if (result == -1){
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('수정이 완료되었습니다.')");
			script.println("location.href= 'board_view.jsp?board_no="+board_no+"\'");
			script.println("</script>");
		}
		
	}
%>
</body>
</html>