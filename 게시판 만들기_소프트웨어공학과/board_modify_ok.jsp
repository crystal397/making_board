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
<h3>������ DB�� ����</h3>

<%
//JDBC ����̹� �ε�
Class.forName("org.mariadb.jdbc.Driver");
//�����ͺ��̽��� �����մϴ�.
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
Statement stmt = conn.createStatement();

//PreparedStatement ��ü ����
PreparedStatement pstmt = null;

//���޵� �����͸� �޾Ƽ� ������ ����
String strNumber = request.getParameter("write_number"); // �۹�ȣ
String strName = request.getParameter("write_name"); // �ۼ���
String strPass = request.getParameter("write_pass"); // ��й�ȣ
String strEmail = request.getParameter("write_email"); // �̸���
String strTitle = request.getParameter("write_title"); // ������
String strContent = request.getParameter("write_content"); // �۳���

//�����ͺ��̽��� ���ڵ� ����
String strSQL = "UPDATE myboard SET fld_name=?, fld_email=?, fld_title=?, fld_content=? WHERE fld_number=" + strNumber;
pstmt = conn.prepareStatement(strSQL);

pstmt.setString(1, strName);
pstmt.setString(2, strEmail);
pstmt.setString(3, strTitle);
pstmt.setString(4, strContent);

pstmt.executeUpdate();

//�����ͺ��̽��� ���� �Ҵ��ߴ� �ڿ����� �����Ѵ�.
pstmt.close();
conn.close();
%>

<a href="board_list.jsp">[�۸��]</a>

</body>
</html>