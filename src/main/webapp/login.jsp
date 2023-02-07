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
                    <div id="login">
                        <h3 class="subTitle">로그인</h3>
                        <form action="loginOk.jsp" method="post">
                            <ul>
                                <li><label for="user_id">ID : </label></li>
                                <li><input type="text" id="user_id" name="user_id" value="" required></li>
                            </ul>
                            <ul>
                                <li><label for="user_pw">P/W : </label></li>
                                <li><input type="password" id="user_pw" name="user_pw" value="" required></li>
                            </ul>
                            <div class="btnArea">
                                <p><button type="submit">로그인</button></p>
                                <p><button type="button" onClick="location.href='join.jsp'">회원가입</button></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
	</div>
</body>
</html>