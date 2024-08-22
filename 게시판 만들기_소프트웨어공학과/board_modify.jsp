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
<h3>게시판의 글 수정하기</h3>
<%
//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");
//데이터베이스를 연결
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
//Statement 객체 생성
Statement stmt = conn.createStatement();

//전달된 데이터(글번호)를 받아서 변수에 보관
String strNumber = request.getParameter("write_number");

//글 번호에 해당하는 레코드 찾아서 rs로 가져옵니다.
String strSQL = "SELECT * FROM myboard WHERE fld_number = " + strNumber;
ResultSet rs = stmt.executeQuery(strSQL);

rs.first(); //첫번째 레코드로 이동
String strName = rs.getString("fld_name"); // 작성자
String strEmail = rs.getString("fld_email"); // 이메일
String strTitle = rs.getString("fld_title"); // 글제목
String strContent = rs.getString("fld_content"); // 글내용

%>

<!-- 글 정보 및 내용 보여주기 입력받기 -->
<form method="post" action="board_modify_ok.jsp">
<input type="hidden" name="write_number"value=<%=strNumber %>>
<table>
<tr> <td bgcolor="FBC48F"> <b>성명</b></td>
	<td><input type="text" name="write_name" size=20 maxlength=20 value="<%=strName %> "></td>
</tr>
<tr> <td bgcolor="FBC48F"> <b>전자우편</b></td>
	<td><input type="text" name="write_email" size=30 maxlength=30 value="<%=strEmail %> "></td>
</tr>
<tr> <td bgcolor="FBC48F"> <b>제목</b></td>
	<td><input type="text" name="write_title" size=50 maxlength=50 value="<%=strTitle %> "></td>
</tr>
<tr> <td bgcolor="FBC48F"> <b>비밀번호</b></td>
	<td><input type="text" name="write_pass" size=10 maxlength=10></td>
</tr>
<!-- 글 정보 및 내용 보여주기 입력받기 끝 -->

<!-- 글 내용 보여주기 -->
<tr><td colspan=2>
	<textarea name="write_content" rows=15 cols=75><%=strContent %></textarea></td>
</tr>
<tr><td colspan=2><input type="reset" value="원래값">
<input type="submit" value="수정하기"></td>
</tr>
</table>
</form>
<!-- 글 내용 보여주기 끝 -->

<%
//데이터베이스를 위해 할당했던 자원들을 해제한다.
rs.close();
stmt.close();
conn.close();
%>

</body>
</html>