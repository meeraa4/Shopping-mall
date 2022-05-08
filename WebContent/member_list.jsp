<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%@ include file="layout/db_connect.jsp" %>
<%
String sql="select custno, custname, phone, address, " 
         + "to_char(joindate,'yyyy-mm-dd') joindate, "
         + "case when grade = 'A' then 'VIP' "
         + "when grade = 'B' then '일반' "
         + "else '직원' end grade, city "
         + "from member_tbl_02 order by custno asc";

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();

%>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>쇼핑몰 회원관리</title>
    <script type="text/javascript">
    	function checkDel(custno) {
            msg="삭제하시겠습니까?";
			if(confirm(msg)!=0){
				location.href="delete.jsp?custno="+custno;
	    		alert("삭제되었습니다.");
			} else {
		    	alert("삭제가 취소되었습니다.")
	    		return;
			}
    	}
    </script>
</head>
<body>

    <main id="m_list" class="section">
        <iframe src="./layout/header.jsp" style="width:100%; height:120px; border:none"></iframe>

        <h3 class="title">회원목록조회/수정</h3>
        <div class="scroll">
            <table class="table_line">
	    		<tr>
	        		<th>회원번호</th>
	        		<th>회원성명</th>
	        		<th>전화번호</th>
	        		<th>주소</th>
	        		<th>가입일자</th>
	        		<th>고객등급</th>
	        		<th>거주지역</th>
	        		<th>수정 및 삭제</th>
	    		</tr>
			<%
				while(rs.next()) {
			%>
				<tr class="center">
					<td class="link"><a href="update.jsp?custno=<%= rs.getString("custno")%>"><%= rs.getString("custno")%></a></td>
					<td><%= rs.getString("custname") %></td>
					<td><%= rs.getString("phone") %></td>
					<td><%= rs.getString("address") %></td>
					<td><%= rs.getString("joindate") %></td>
					<td><%= rs.getString("grade") %></td>
					<td><%= rs.getString("city") %></td>
					<td><input type="button" value="수정" onclick="document.location.href='update.jsp?custno=<%= rs.getString("custno")%>'"> 
						<input type="button" value="삭제" onclick="checkDel(<%= rs.getString("custno")%>);">
					</td>
				</tr>
			<%
				}
			%>
             	</table>
         	</div>
     </main>

     <footer id="footer">
    	 <iframe src="./layout/footer.jsp" style="width:100%; height:30px; border:none"></iframe>
	</footer>
</body>
</html>