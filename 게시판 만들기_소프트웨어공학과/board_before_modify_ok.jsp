<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 만들기 실습</title>
</head>
<body>
<h3>비밀번호 비교후 글 수정</h3>

<%
//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");
//데이터베이스를 연결합니다.
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
Statement stmt = conn.createStatement();

//PreparedStatement 객체 생성
PreparedStatement pstmt = null;

// 전달된 데이터를 받아서 변수에 보관
String strNumber = request.getParameter("write_number"); //글번호
String strPass = request.getParameter("write_pass"); //비밀번호
String strName = request.getParameter("fld_name"); // 작성자
String strEmail = request.getParameter("fld_email"); // 이메일
String strTitle = request.getParameter("fld_title"); // 글제목
String strContent = request.getParameter("fld_content"); // 글내용
%>
//다시 전달
<input type="hidden" name="write_number" value=<%= request.getParameter("write_number") %>>
<input type="hidden" name="fld_name" value=<%= request.getParameter("fld_name") %>>
<input type="hidden" name="fld_email" value=<%= request.getParameter("fld_email") %>>
<input type="hidden" name="fld_title" value=<%= request.getParameter("fld_title") %>>
<input type="hidden" name="fld_content" value=<%= request.getParameter("fld_content") %>>
<%

// 데이터베이스에서 저장된 글의 원래 비밀번호를 알아냅니다.
String strSQL = "SELECT * FROM myboard WHERE fld_number = " + strNumber;
pstmt = conn.prepareStatement(strSQL);
ResultSet rs = pstmt.executeQuery();

rs.first();
String dbPass = rs.getString("fld_pass");// 데이터베이스에서 비밀번호를 가져옵니다.

if(strPass.equals(dbPass)) {//비밀번호가 맞으면 %>
	<jsp:forward page="./board_modify.jsp"/>
<%} else {
	out.println("비밀번호가 틀립니다.");
}

//데이터베이스를 위해 할당했던 자원들을 해제한다.
pstmt.close();
conn.close();
%>
<a href="board_list.jsp">[글목록]</a>
</body>
</html>