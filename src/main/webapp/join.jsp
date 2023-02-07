<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp" />
</head>
<body>
	<div id="wrap">
        <jsp:include page="nav.jsp" />
        <div id="contents">
            <div class="wrap">
                <div id="sub">
                    <div id="join">
                        <h3 class="subTitle">회원가입</h3>
                        <form action="joinOk.jsp" method="post">
                            <ul>
                                <li><label for="user_id">ID : </label></li>
                                <li><input type="text" id="user_id" name="user_id" required></li>
                            </ul>
                            <ul>
                                <li><label for="user_pw">P/W : </label></li>
                                <li><input type="password" id="user_pw" name="user_pw" required></li>
                            </ul>
                            <ul>
                                <li><label for="user_name">이름 : </label></li>
                                <li><input type="text" id="user_name" name="user_name" required></li>
                            </ul>
                            <ul>
                                <li><label for="user_email">이메일 : </label></li>
                                <li><input type="email" id="user_email" name="user_email" required></li>
                            </ul>
                            <div class="btnArea">
                                <p><button type="submit">회원가입</button></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>