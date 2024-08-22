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
<h3>게시판의 글 내용 보여주기</h3>
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
String strDate = rs.getString("fld_date"); // 작성일
String strCount = rs.getString("fld_count"); // 조회수
String strTitle = rs.getString("fld_title"); // 글제목
String strContent = rs.getString("fld_content"); // 글내용

//글의 내용(strContent)중에 엔터 부분을 <br>로 바꾼다.
strContent = strContent.replaceAll("\r\n","<br>");

//문제1) 글을 클릭했을 때 보이는 srtCount가 +1 되게 하기
String strSql = "UPDATE myboard SET fld_count = fld_count + 1 WHERE fld_number = " + strNumber;
stmt.executeQuery(strSql);

//문제3) 검색어의 글자색 변경, 전달받은 검색어를 이용하여 srtContent에 포함된 단어의 색을 변경
//전달받은 값 받아오기
if(request.getParameter("key_word")!=null) {
	String strString = request.getParameter("key_word");
	strString = strContent.replaceAll(strString, "<span style='color:red';>"+strString+"</span>");
}
%>

<!-- 글 정보 시작 -->
<table border=0 width="600">
	<tr>
		<td align="left"> 작성자 : <a href="mailto":<%=strEmail %>"><%=strName %></a></td>
		<td align="right"> 작성일 : <%=strDate %>, 조회수 : <%=strCount %></td>
	</tr>
</table>
<!-- 글 정보 끝 -->

<!-- 글 정보 시작 -->
<table border=2 cellspacing=3 cellpadding=3 width="600" bordercolor="DFFFDF">
	<tr bgcolor="FBC48F">
		<td align="center"><font size=3 color="#0000057"><%=strTitle %></font></td>
	</tr>
</table>
<!-- 글 정보 끝 -->

<!-- 글 정보 시작 -->
<table border=1 cellspacing=5 cellpadding=10 width="600" bordercolor="DFFFDF">
	<tr bgcolor="FFE6D9">
		<td align="left"><font size=2><%=strContent %></font></td>
	</tr>
</table>
<!-- 글 정보 끝 -->

<!-- 하단 메뉴 시작 -->
<table border=0 width="600">
	<tr>
		<td align="left">
			<a href="board_before_modify.jsp?write_number=<%=strNumber %>">[수정]</a>
			<a href="board_delete.jsp?write_number=<%=strNumber %>">[삭제]</a>
		</td>
		<td align="right"> 
			<a href="board_write.jsp">[쓰기]</a>
			<a href="board_list.jsp">[목록]</a>
		</td>
	</tr>
</table>
<!-- 하단 메뉴 끝 -->

<%
// 데이터베이스를 위해 할당했던 자원들을 해제한다.
rs.close();
stmt.close();
conn.close();
%>

</body>
</html>