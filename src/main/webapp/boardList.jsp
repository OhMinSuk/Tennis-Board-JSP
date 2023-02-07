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
	
	String boardType = "";
	if(request.getParameter("boardType") != null){
		boardType = request.getParameter("boardType");
	}
%>
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
        	ArrayList<Board> list = boardDAO.getList(pageNumber, boardType);
        	if (list.size() > 0){
        	for(int i = 0; i < list.size(); i++){
        %>
			 <tr>
                 <td><%= list.get(i).getBoard_no() %></td>
                 <td><a href="board_view.jsp?board_no=<%= list.get(i).getBoard_no() %>"><span class="boardIndex">[<%= list.get(i).getBoard_index()%>]</span><strong><%= list.get(i).getBoard_title() %></strong></a></td>
                 <td><%= list.get(i).getUser_id() %></td>
                 <td><%= list.get(i).getBoard_date().substring(0, 11) + list.get(i).getBoard_date().substring(11, 13) + "시 "+ list.get(i).getBoard_date().substring(14, 16) + "분" %></td>
                 <td><%= list.get(i).getBoard_count() %></td>
            </tr>       	
        <%
        	} 
        		}else{
        %>
        	<tr>
        		<td colspan="5">작성된 글이 없습니다.</td>
         <%
        	}
        %>
        </tbody>
	</table>
	<div id="pagination">
		<ul>
	        <%
				double lastPageNumber = boardDAO.getCount(boardType) / 10;
	        	double lastPageNumber2 = Math.ceil(boardDAO.getCount(boardType) % 10 * 0.1);
	        	lastPageNumber = lastPageNumber + lastPageNumber2;
	        	
	        	if(lastPageNumber == 0){
	        %>
	        	<li><a href="index.jsp?boardType=<%=boardType %>&pageNumber=1" >[1]</a></li>
	        <% } else { %>	        	
	        	<% for (int i = 1; i <= lastPageNumber; i++) { %>
					<li><a href="index.jsp?boardType=<%=boardType %>&pageNumber=<%=i%>" class="currentPage">[<%=i%>]</a></li>
				<% } %>
			<% } %>
		</ul>
	</div>
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
