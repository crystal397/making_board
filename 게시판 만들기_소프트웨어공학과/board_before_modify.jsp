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

<form method="post" action="board_before_modify_ok.jsp">
<input type="hidden" name="write_number" value=<%= request.getParameter("write_number") %>>
<input type="hidden" name="fld_name" value=<%= request.getParameter("fld_name") %>>
<input type="hidden" name="fld_email" value=<%= request.getParameter("fld_email") %>>
<input type="hidden" name="fld_title" value=<%= request.getParameter("fld_title") %>>
<input type="hidden" name="fld_content" value=<%= request.getParameter("fld_content") %>>
 ��й�ȣ�� �Է��ϼ��� : <input type="password" name="write_pass">
 <input type="submit" value="Ȯ��">
</form>

</body>
</html>