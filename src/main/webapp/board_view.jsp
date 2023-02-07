<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
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
	%>
	<div id="wrap">
	<jsp:include page="nav.jsp" />
        <div id="contents">
            <div class="wrap">
                <div id="boardView">
                    <div class="boardViewTitle">
                        <h2>[<%=board.getBoard_index() %>] <%=board.getBoard_title() %></h2>
                        <div class="boardViewInfo">
                            <span><%=board.getUser_id() %></span>
                            <span><%=board.getBoard_date() %></span>
                            <span>조회수 <%=board.getBoard_count()+1 %></span>
                        </div>
                    </div>
                    <div class="boardViewContents">
                        <div class="boardViewImage">
                        <%
                        	String real = "D:\\2학년2학기\\JSP\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\JSP project_201844019\\boardUpload";
                        	File viewFile = new File(real+"\\"+ board.getFile_name());
                        	if(viewFile.exists()){                     	
                        %>
                            <img src="boardUpload/<%=board.getFile_name()%>">
						<%
                        	}
						%>                           
                        <pre><%=board.getBoard_contents() %></pre>
                    </div>
                    <div class="boardViewComment">
                   	 <% 
                             	CommentDAO commentDAO = new CommentDAO();
                            	ArrayList<Comment> list = commentDAO.getList(board_no);
                   	 %>
                   	 </div>
                        <h3>댓글 [<%=list.size() %>]</h3>          
                        <div class="boardViewControl">
                            <ul>
                                <li><a href="index.jsp">[목록]</a></li>
                                <li><a href="board_modify.jsp?board_no=<%=board.getBoard_no() %>">[수정]</a></li>
                                <li><a href="board_delete.jsp?board_no=<%=board.getBoard_no() %>"onClick="return confirm('정말 삭제하시겠습니까?')">[삭제]</a></li>
                            </ul>
                        </div>
                        <div class="commentList">
                            <% 
                            	for(int i=0; i<list.size(); i++){
                            %>
                                <div class="comment">
                                    <h4 class="commentWriter"><%= list.get(i).getUser_id() %></h4>
                                    <span class="commentDate"><%= list.get(i).getComment_date() %></span>
                                    <p class="commentContents"><b><%= list.get(i).getComment_contents() %></b></p>
                                    <a onclick="return confirm('정말 삭제하시겠습니까?')" href="commentDelete.jsp?bbsID=<%=board_no%>&comment_no=<%=list.get(i).getComment_no() %>">&nbsp;&nbsp; 삭제</a>
                                </div>
                            <%  } %>
                        </div>
                        <div class="writeComment">
                            <form action="writeCommentOk.jsp?board_no=<%=board_no %>" method="POST">
                                <% 
                                	if(session.getAttribute("userID") == null){ 
                                %>
                                    <div class="commentContents">
                                        <input type="text" name="comment_contents" value="" placeholder="로그인 후 이용 가능합니다." disabled>
                                    </div>
                                    <div class="commentSubmit">
                                        <button type="submit" disabled>댓글</button>
                                    </div>
                                <% } else { %>
                                    <div class="commentContents">
                                        <input type="text" name="comment_contents" value="" placeholder="댓글을 남겨보세요" required>
                                    </div>
                                    <div class="commentSubmit">
                                        <button type="submit">댓글</button>
                                    </div>
                                <%  } %>
                            </form>
                        </div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</body>
</html>