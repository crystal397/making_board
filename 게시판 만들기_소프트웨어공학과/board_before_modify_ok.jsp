<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>�Խ��� ����� �ǽ�</title>
</head>
<body>
<h3>��й�ȣ ���� �� ����</h3>

<%
//JDBC ����̹� �ε�
Class.forName("org.mariadb.jdbc.Driver");
//�����ͺ��̽��� �����մϴ�.
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
Statement stmt = conn.createStatement();

//PreparedStatement ��ü ����
PreparedStatement pstmt = null;

// ���޵� �����͸� �޾Ƽ� ������ ����
String strNumber = request.getParameter("write_number"); //�۹�ȣ
String strPass = request.getParameter("write_pass"); //��й�ȣ
String strName = request.getParameter("fld_name"); // �ۼ���
String strEmail = request.getParameter("fld_email"); // �̸���
String strTitle = request.getParameter("fld_title"); // ������
String strContent = request.getParameter("fld_content"); // �۳���
%>
//�ٽ� ����
<input type="hidden" name="write_number" value=<%= request.getParameter("write_number") %>>
<input type="hidden" name="fld_name" value=<%= request.getParameter("fld_name") %>>
<input type="hidden" name="fld_email" value=<%= request.getParameter("fld_email") %>>
<input type="hidden" name="fld_title" value=<%= request.getParameter("fld_title") %>>
<input type="hidden" name="fld_content" value=<%= request.getParameter("fld_content") %>>
<%

// �����ͺ��̽����� ����� ���� ���� ��й�ȣ�� �˾Ƴ��ϴ�.
String strSQL = "SELECT * FROM myboard WHERE fld_number = " + strNumber;
pstmt = conn.prepareStatement(strSQL);
ResultSet rs = pstmt.executeQuery();

rs.first();
String dbPass = rs.getString("fld_pass");// �����ͺ��̽����� ��й�ȣ�� �����ɴϴ�.

if(strPass.equals(dbPass)) {//��й�ȣ�� ������ %>
	<jsp:forward page="./board_modify.jsp"/>
<%} else {
	out.println("��й�ȣ�� Ʋ���ϴ�.");
}

//�����ͺ��̽��� ���� �Ҵ��ߴ� �ڿ����� �����Ѵ�.
pstmt.close();
conn.close();
%>
<a href="board_list.jsp">[�۸��]</a>
</body>
</html>