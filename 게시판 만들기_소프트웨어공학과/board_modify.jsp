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
<h3>�Խ����� �� �����ϱ�</h3>
<%
//JDBC ����̹� �ε�
Class.forName("org.mariadb.jdbc.Driver");
//�����ͺ��̽��� ����
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
//Statement ��ü ����
Statement stmt = conn.createStatement();

//���޵� ������(�۹�ȣ)�� �޾Ƽ� ������ ����
String strNumber = request.getParameter("write_number");

//�� ��ȣ�� �ش��ϴ� ���ڵ� ã�Ƽ� rs�� �����ɴϴ�.
String strSQL = "SELECT * FROM myboard WHERE fld_number = " + strNumber;
ResultSet rs = stmt.executeQuery(strSQL);

rs.first(); //ù��° ���ڵ�� �̵�
String strName = rs.getString("fld_name"); // �ۼ���
String strEmail = rs.getString("fld_email"); // �̸���
String strTitle = rs.getString("fld_title"); // ������
String strContent = rs.getString("fld_content"); // �۳���

%>

<!-- �� ���� �� ���� �����ֱ� �Է¹ޱ� -->
<form method="post" action="board_modify_ok.jsp">
<input type="hidden" name="write_number"value=<%=strNumber %>>
<table>
<tr> <td bgcolor="FBC48F"> <b>����</b></td>
	<td><input type="text" name="write_name" size=20 maxlength=20 value="<%=strName %> "></td>
</tr>
<tr> <td bgcolor="FBC48F"> <b>���ڿ���</b></td>
	<td><input type="text" name="write_email" size=30 maxlength=30 value="<%=strEmail %> "></td>
</tr>
<tr> <td bgcolor="FBC48F"> <b>����</b></td>
	<td><input type="text" name="write_title" size=50 maxlength=50 value="<%=strTitle %> "></td>
</tr>
<tr> <td bgcolor="FBC48F"> <b>��й�ȣ</b></td>
	<td><input type="text" name="write_pass" size=10 maxlength=10></td>
</tr>
<!-- �� ���� �� ���� �����ֱ� �Է¹ޱ� �� -->

<!-- �� ���� �����ֱ� -->
<tr><td colspan=2>
	<textarea name="write_content" rows=15 cols=75><%=strContent %></textarea></td>
</tr>
<tr><td colspan=2><input type="reset" value="������">
<input type="submit" value="�����ϱ�"></td>
</tr>
</table>
</form>
<!-- �� ���� �����ֱ� �� -->

<%
//�����ͺ��̽��� ���� �Ҵ��ߴ� �ڿ����� �����Ѵ�.
rs.close();
stmt.close();
conn.close();
%>

</body>
</html>