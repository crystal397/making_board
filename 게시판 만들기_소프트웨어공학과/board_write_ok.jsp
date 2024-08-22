<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입력글 데이터베이스에 저장하기</title>
</head>
<body>

<%
//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");
//데이터베이스를 연결합니다.
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
Statement stmt = conn.createStatement();

//PreparedStatement 객체 생성
PreparedStatement pstmt = null;

//전달된 데이터를 받아서 변수에 보관
String strName = request.getParameter("write_name"); // 작성자
String strPass = request.getParameter("write_pass"); // 비밀번호
String strEmail = request.getParameter("write_email"); // 이메일
String strTitle = request.getParameter("write_title"); // 글제목
String strContent = request.getParameter("write_content"); // 글내용

// fld_number에서 가장 큰 값을 읽어옴
ResultSet rs = stmt.executeQuery("SELECT MAX(fld_number) AS max_number FROM myboard");
rs.next();
// rs의 첫번째 레코드로 이동
//글번호의 최대값 + 1을 해서 변수 intNumber에 넣음
int intNumber = rs.getInt("max_number") + 1;

//현재 날짜 구하기
java.sql.Date dtDate = new java.sql.Date(new java.util.Date().getTime());

//데이터베이스에 레코드 삽입
String strSQL = "INSERT INTO myboard(fld_number, fld_name, fld_pass, fld_email, fld_title, fld_content, fld_date, fld_count)";
strSQL = strSQL +"VALUES(?,?,?,?,?,?,?,?)"; //8개 패러미터

//PreparedStatement 객체의 연결문자열 생성
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, intNumber);
pstmt.setString(2, strName);
pstmt.setString(3, strEmail);
pstmt.setString(4, strEmail);
pstmt.setString(5, strTitle);
pstmt.setString(6, strContent);
pstmt.setDate(7, dtDate);
pstmt.setInt(8, 0);

pstmt.executeUpdate();
//데이터베이스를 위해 할당했던 자원들을 해제한다.
pstmt.close();
conn.close();
%>
<a href="board_list.jsp">[글목록]</a>

</body>
</html>