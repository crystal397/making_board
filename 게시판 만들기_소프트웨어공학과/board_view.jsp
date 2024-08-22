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
<h3>�Խ����� �� ���� �����ֱ�</h3>
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
String strDate = rs.getString("fld_date"); // �ۼ���
String strCount = rs.getString("fld_count"); // ��ȸ��
String strTitle = rs.getString("fld_title"); // ������
String strContent = rs.getString("fld_content"); // �۳���

//���� ����(strContent)�߿� ���� �κ��� <br>�� �ٲ۴�.
strContent = strContent.replaceAll("\r\n","<br>");

//����1) ���� Ŭ������ �� ���̴� srtCount�� +1 �ǰ� �ϱ�
String strSql = "UPDATE myboard SET fld_count = fld_count + 1 WHERE fld_number = " + strNumber;
stmt.executeQuery(strSql);

//����3) �˻����� ���ڻ� ����, ���޹��� �˻�� �̿��Ͽ� srtContent�� ���Ե� �ܾ��� ���� ����
//���޹��� �� �޾ƿ���
if(request.getParameter("key_word")!=null) {
	String strString = request.getParameter("key_word");
	strString = strContent.replaceAll(strString, "<span style='color:red';>"+strString+"</span>");
}
%>

<!-- �� ���� ���� -->
<table border=0 width="600">
	<tr>
		<td align="left"> �ۼ��� : <a href="mailto":<%=strEmail %>"><%=strName %></a></td>
		<td align="right"> �ۼ��� : <%=strDate %>, ��ȸ�� : <%=strCount %></td>
	</tr>
</table>
<!-- �� ���� �� -->

<!-- �� ���� ���� -->
<table border=2 cellspacing=3 cellpadding=3 width="600" bordercolor="DFFFDF">
	<tr bgcolor="FBC48F">
		<td align="center"><font size=3 color="#0000057"><%=strTitle %></font></td>
	</tr>
</table>
<!-- �� ���� �� -->

<!-- �� ���� ���� -->
<table border=1 cellspacing=5 cellpadding=10 width="600" bordercolor="DFFFDF">
	<tr bgcolor="FFE6D9">
		<td align="left"><font size=2><%=strContent %></font></td>
	</tr>
</table>
<!-- �� ���� �� -->

<!-- �ϴ� �޴� ���� -->
<table border=0 width="600">
	<tr>
		<td align="left">
			<a href="board_before_modify.jsp?write_number=<%=strNumber %>">[����]</a>
			<a href="board_delete.jsp?write_number=<%=strNumber %>">[����]</a>
		</td>
		<td align="right"> 
			<a href="board_write.jsp">[����]</a>
			<a href="board_list.jsp">[���]</a>
		</td>
	</tr>
</table>
<!-- �ϴ� �޴� �� -->

<%
// �����ͺ��̽��� ���� �Ҵ��ߴ� �ڿ����� �����Ѵ�.
rs.close();
stmt.close();
conn.close();
%>

</body>
</html>