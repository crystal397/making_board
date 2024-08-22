<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 만들기 실습</title>
</head>
<body>
<h3>검색결과 보여주기</h3>

<%
//전달받은 값 받아오기
String strType = request.getParameter("search_type");
String strString = request.getParameter("search_string");

//SQL문을 저장할 변수 선언 및 초기화
String strSql = "";

if(strType.equals("name")) {
	strSql = "SELECT * FROM myboard WHERE fld_name like '%" + strString + "%'";
} else if(strType.equals("title")) {
	strSql = "SELECT * FROM myboard WHERE fld_title like '%" + strString + "%'";
} else {
	strSql = "SELECT * FROM myboard WHERE fld_content like '%" + strString + "%'";
}

//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");

//데이터베이스를 연결합니다.
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
Statement stmt = conn.createStatement();

//SQL 실행(쿼리 수행), 수행한 결과는 ResultSet으로 가져옴
ResultSet rs = stmt.executeQuery(strSql);
%>

<table border=0 bordercolor="#DFFFDF" cellspacing=1 cellpadding=2 width=600>
	<tr bgcolor="#FBC48F">
		<td>번호</td><td>제목</td><td>작성자</td><td>작성일</td><td>조회수</td>
	</tr>

<%
//rs의 데이터를 마지막 레코드가 될 때까지 반복해서 출력
while(rs.next()) {
	out.println("<tr>");
	String strNumber = rs.getString("fld_number"); //글번호
	out.println("<td>" + strNumber + "</td>"); //글번호
	//문제3) 검색어의 글자색 변경을 위해 검색어도 전달
	out.println("<td><a href=board_view.jsp?write_number=" + strNumber + "&key_word=" + strString + ">" +rs.getString("fld_title") + "</a></td>"); // 글제목
	out.println("<td>"+ rs.getString("fld_name") + "</td>"); // 작성자
	out.println("<td>"+ rs.getDate("fld_date") + "</td>"); // 작성일
	out.println("<td>"+ rs.getString("fld_count") + "</td>"); // 조회수
	out.println("</tr>");
	}


//데이터베이스를 위해 할당했던 자원들을 해제한다
rs.close();
stmt.close();
conn.close();
%>
</table>

</body>
</html>