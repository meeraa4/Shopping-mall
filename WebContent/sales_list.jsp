<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ include file = "layout/db_connect.jsp" %>
<%
			String sql="select a.custno, a.custname, " 
				+ "case when a.grade = 'A' then 'VIP' when a.grade = 'B' then '일반' else '직원' end grade, "
				+ "sum(b.price) price "
				+ "from member_tbl_02 a, money_tbl_02 b "
				+ "where a.custno = b.custno and nvl(b.price,0) > 0"
				+ "group by a.custno, a.custname, a.grade "
				+ "order by sum(b.price) desc";
				 PreparedStatement pstmt = conn.prepareStatement(sql);
				  ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원관리</title>
<link rel = "stylesheet" href = "./css/style.css">
</head>
<body>
	<div class = "section">
		<iframe src = "./layout/header.jsp" style = "width: 100%; height: 120px; border:none;"></iframe>
		
		<h3 class = "title">회원매출조회</h3>
		<div class = "scroll">
		<table class = "table_line">
			<tr>
				<th>회원번호</th>
				<th>회원이름</th>
				<th>고객등급</th>
				<th>매출</th>
			</tr>
			<%
				while(rs.next()) {
			%>
			<tr class = "center">
				<td><%= rs.getString("custno") %></td>
				<td><%= rs.getString("custname") %></td>
				<td><%= rs.getString("grade") %></td>
				<td><%= rs.getString("price") %></td>
			</tr>
			<%
				}
			%>
			
			<%
				if(conn!=null) {
					conn.close();
				}
			%>
		</table>
		</div>
	</div>
	
	<footer id = "footer">
		<iframe src = "./layout/footer.jsp" style = "width: 100%; height: 30px; border:none;"></iframe>
	</footer>
</body>
</html>