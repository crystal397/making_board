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
<h3>게시판의 글 리스트 보여주기</h3>

<%
//JDBC 드라이버 로드
Class.forName("org.mariadb.jdbc.Driver");
//데이터베이스를 연결합니다.
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/myboard","root","1111");
Statement stmt = conn.createStatement();
//데이터를 가져오는 SQL 문을 실행시킵니다
ResultSet rs = stmt.executeQuery("select * from myboard");
// 문제2)글리스트의 정렬(sort_type을 설정하여 a링크 설정 후 전달 받아 type에 따라 sql문장을 구성)
%>

<table border=0 cellspacing=1 cellpadding=2 width=600>
	<tr bgcolor="#FBC48F">
		<td><a href="board_list.jsp?sort_type=number">번호</a></td>
		<td><a href="board_list.jsp?sort_type=title">제목</a></td>
		<td><a href="board_list.jsp?sort_type=name">작성자</a></td>
		<td><a href="board_list.jsp?sort_type=date">작성일</a></td>
		<td><a href="board_list.jsp?sort_type=count">조회수</a></td>
</tr>

<%
String strSortType = request.getParameter("sort_type");
String strSql="SELECT * FROM myboard";

if(strSortType != null) {
	strSql += " order by fld_" + strSortType;
}

rs = stmt.executeQuery(strSql);

//문제4) 전체 레코드 수 구하고, 총 페이지 계산
int totalRecord = 0; //전체 레코드 수
int totalPage = 0; // 전체 페이지 수
int numPerPage = 5; // 페이지당 레코드 수
//전달된 데이터를 받아서 변수에 보관
String strNowPage = request.getParameter("nowPage"); // 받기
int nowPage = Integer.parseInt(strNowPage);
int startRecord = 0; // 데이터베이스에서 가져올 페이지의 첫번째 레코드 위치
//전체 레코드 수 구하기
String intRecord="SELECT count(fld_number) as recordNum FROM myboard";
ResultSet rss = stmt.executeQuery(intRecord);
if(rss.next()) {
	totalRecord = rss.getInt(1);
}
//전체 페이지 수 구하기
totalPage = (int) Math.ceil(totalRecord/numPerPage);
//첫행번호 계산
startRecord = (nowPage-1)*numPerPage;

//데이터를 가져오는 SQL 문을 실행시킵니다
// 데이터베이스에 레코드 삽입
String strSQL = "SELECT * FROM myboard LIMIT " + startRecord + "," + numPerPage;

// PreparedStatement 객체 생성
PreparedStatement pstmt = conn.prepareStatement(strSQL);
rs = pstmt.executeQuery();

while (rs.next()) {
	String strNumber = rs.getString("fld_number"); //글번호 strNumber 변수에 저장	
	int intNumber = Integer.parseInt(strNumber);
	out.println(("<tr bgcolor=" + ((intNumber % 2 != 0) ? "#f0f8ff" : "#f5f5dc") + ">"));
	out.println("<td>"+ strNumber + "</td>"); // 글번호 출력
	out.println("<td><a href=board_view.jsp?write_number=" + strNumber + ">" +rs.getString("fld_title") + "</a></td>"); // 글제목
	out.println("<td>"+ rs.getString("fld_name") + "</td>"); // 작성자
	out.println("<td>"+ rs.getDate("fld_date") + "</td>"); // 작성일
	out.println("<td>"+ rs.getString("fld_count") + "</td>"); // 조회수
	out.println("</tr>");
}
%>
</table>
<a href="board_list.jsp">[처음]</a>
<%
for(int i=1; i<=totalPage; i++) { %>
	<a href="board_list_k.jsp?nowPage=<%=i%>">[<%=i%>]</a>
<%}%>
<a href="board_list_k.jsp?nowPage=totalPage">[마지막]</a>
<br>
<br>
<a href="board_write.jsp">글쓰기</a>
<a href="board_list.jsp">다시읽기</a>

<form method="post"action="search_result.jsp">
	<select name="search_type">
		<option value="title">글제목</option>
		<option value="name">작성자</option>
		<option value="content">글내용</option>
	</select>
	<input type="text"name="search_string"size=20>
	<input type="submit"value="검색">
</form>

<%

//데이터베이스를 위해 할당했던 자원들을 해제한다
rs.close();
stmt.close();
conn.close();
%>

</body>
</html>

