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
<h3>수정글 DB에 저장</h3>

<%
//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");
//데이터베이스를 연결합니다.
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
Statement stmt = conn.createStatement();

//PreparedStatement 객체 생성
PreparedStatement pstmt = null;

//전달된 데이터를 받아서 변수에 보관
String strNumber = request.getParameter("write_number"); // 글번호
String strName = request.getParameter("write_name"); // 작성자
String strPass = request.getParameter("write_pass"); // 비밀번호
String strEmail = request.getParameter("write_email"); // 이메일
String strTitle = request.getParameter("write_title"); // 글제목
String strContent = request.getParameter("write_content"); // 글내용

//데이터베이스에 레코드 수정
String strSQL = "UPDATE myboard SET fld_name=?, fld_email=?, fld_title=?, fld_content=? WHERE fld_number=" + strNumber;
pstmt = conn.prepareStatement(strSQL);

pstmt.setString(1, strName);
pstmt.setString(2, strEmail);
pstmt.setString(3, strTitle);
pstmt.setString(4, strContent);

pstmt.executeUpdate();

//데이터베이스를 위해 할당했던 자원들을 해제한다.
pstmt.close();
conn.close();
%>

<a href="board_list.jsp">[글목록]</a>

</body>
</html>