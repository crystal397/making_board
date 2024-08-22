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
<h3>게시판의 글 수정하기 - 비밀번호 입력</h3>

<form method="post" action="board_before_modify_ok.jsp">
<input type="hidden" name="write_number" value=<%= request.getParameter("write_number") %>>
<input type="hidden" name="fld_name" value=<%= request.getParameter("fld_name") %>>
<input type="hidden" name="fld_email" value=<%= request.getParameter("fld_email") %>>
<input type="hidden" name="fld_title" value=<%= request.getParameter("fld_title") %>>
<input type="hidden" name="fld_content" value=<%= request.getParameter("fld_content") %>>
 비밀번호를 입력하세요 : <input type="password" name="write_pass">
 <input type="submit" value="확인">
</form>

</body>
</html>