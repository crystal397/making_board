<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 만들기 실습</title>
</head>
<body>
<h3>게시판의 글쓰기</h3>
<form method="post" action="board_write_ok.jsp">
	<table border=1>
	<tr>
		<td bgcolor="FBC48F"><b>이름</b></td>
		<td><input type="text" size=20 name="write_name" maxlength=20></td></tr>
	<tr>
		<td bgcolor="FBC48F"><b>비밀번호</b></td>
		<td><input type="password" size=10 name="write_pass" maxlength=10></td></tr>
	<tr>
		<td bgcolor="FBC48F"><b>전자우편</b></td>
		<td><input type="text" size=30 name="write_email" maxlength=30></td></tr>
	<tr>
		<td bgcolor="FBC48F"><b>제목</b></td>
		<td><input type="text" size=50 name="write_title" maxlength=50></td></tr>
	<tr><td colspan=2>
		<textarea name="write_content" rows=15 cols=75></textarea></td></tr>
	<tr><td colspan=2>	
		<input type = "reset" value="다시작성">
		<input type = "submit" value="저장">
	</table>
</form>
</body>
</html>