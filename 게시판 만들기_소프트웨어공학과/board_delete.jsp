<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� ����� �ǽ�</title>
</head>
<body>
<h3>�Խ����� �� �����ϱ� - ��й�ȣ �Է�</h3>

<form method="post" action="board_delete_ok.jsp">
<input type="hidden" name="write_number" value=<%= request.getParameter("write_number") %>>
 ��й�ȣ�� �Է��ϼ��� : <input type="password" name="write_pass">
 <input type="submit" value="Ȯ��">
</form>

</body>
</html>