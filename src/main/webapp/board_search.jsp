<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>

<%
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>

<head>
	<jsp:include page="head.jsp" />
</head>
<body>
	<div id="wrap">
		<jsp:include page="nav.jsp" />
		<div id="contents">
			<div class="wrap">
				<div id="boardList">
				    <table class="boardList">
				    	<colgroup>
				    		<col width="10%">
				    		<col width="40%">
				    		<col width="10%">
				    		<col width="20%">
				    		<col width="10%">
				    	</colgroup>
				        <thead>
				            <tr>
				                <th>글 번호</th>
				                <th>제 목</th>
				                <th>글쓴이</th>
				                <th>작성일</th>
				                <th>조회수</th>
				            </tr>
				        </thead>
				        <tbody>
				        <%
				        	BoardDAO boardDAO = new BoardDAO();
				        	ArrayList<Board> list = boardDAO.getSearch(request.getParameter("searchField"), request.getParameter("searchText"));
				        	if (list.size() == 0){
				        		PrintWriter script = response.getWriter();
				    			script.println("<script>");
				    			script.println("alert('검색결과가 없습니다.')");
				    			script.println("history.back()");
				    			script.println("</script>");
				        	}
				        	for(int i = 0; i < list.size(); i++){
				        %>
							 <tr>
				                 <td><%= list.get(i).getBoard_no() %></td>
				                 <td><a href="board_view.jsp?board_no=<%= list.get(i).getBoard_no() %>"><span class="boardIndex">[<%= list.get(i).getBoard_index()%>]</span><strong><%= list.get(i).getBoard_title() %></strong></a></td>
				                 <td><%= list.get(i).getUser_id() %></td>
				                 <td><%= list.get(i).getBoard_date() %></td>
				                 <td><%= list.get(i).getBoard_count() %></td>
				            </tr>       	
				        <% } %>
				        </tbody>
					</table>
					<div id="search">
				        <div class="searchArea">
				        	 <form method="get" name="search" action="board_search.jsp">
				                <div class="searchCategory">
				                    <select name="searchField">
				                    	<option value="board_title">제목</option>
				                    	<option value="board_contents">내용</option>
				                        <option value="user_id">작성자</option>
				                    </select>
				       			 </div>
				       		<div class="searchContents">
				                    <input type="text" name="searchText" placeholder="검색어 입력">
				                </div>
				                <div class="searchBtn">
				                    <button type="submit">검색</button>
				                </div>
				            </form>
				        </div>
						<% 
							String userID = null;
							if (session.getAttribute("userID") != null){
						%>
						<div class="writeBtn">
				            <button type="button" onClick="location.href='board_write.jsp'">글쓰기</button>
				        </div>
			        <%
						}
			        %>
			        </div>
		    	</div>
			</div>
		</div>
	</div>
</body>
