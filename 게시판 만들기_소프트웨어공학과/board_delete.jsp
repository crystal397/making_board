<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 만들기 실습</title>
</head>
<body>
<h3>게시판의 글 삭제하기 - 비밀번호 입력</h3>

<form method="post" action="board_delete_ok.jsp">
<input type="hidden" name="write_number" value=<%= request.getParameter("write_number") %>>
 비밀번호를 입력하세요 : <input type="password" name="write_pass">
 <input type="submit" value="확인">
</form>

</body>
</html>