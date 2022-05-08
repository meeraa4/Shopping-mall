<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="layout/db_connect.jsp" %>    
<%
String sql="select custno, custname, phone, address, "
  + "to_char(joindate,'yyyy-mm-dd') joindate, grade, city "
  + "from member_tbl_02 "
  + "where custno=" + request.getParameter("custno");

Statement pstmt = conn.createStatement();
ResultSet rs = pstmt.executeQuery(sql);

rs.next();
%>       

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script type="text/javascript">
    function checkValue() {
		if(!document.data.custname.value) {
			alert ("회원이름을 입력하세요");
			document.data.custname.focus();
			return false;
		} else if(!document.data.phone.value) {
			alert ("전화번호를 입력하세요");
			document.data.phone.focus();
			return false;
		}  else if(!document.data.address.value) {
			alert ("주소를 입력하세요");
			document.data.address.focus();
			return false;
		} else if(!document.data.joindate.value) {
			alert ("가입일자를 입력하세요");
			document.data.joindate.focus();
			return false;
		} else if(!document.data.grade.value) {
			alert ("고객등급을 입력하세요");
			document.data.grade.focus();
			return false;
		} else if(!document.data.city.value) {
			alert ("도시코드를 입력하세요");
			document.data.city.focus();
			return false;
		}
	}
        function checkDel(custno) {
			msg="삭제하시겠습니까?";
			if(confirm(msg)!=0){
	    		alert("삭제");
	            location.href="delete.jsp?custno="+custno;
			} else {
	    		alert("취소");
			}
    	}
    </script>
    <title>쇼핑몰 회원관리</title>
</head>
<body>
    <main class="section">
        <iframe src="./layout/header.jsp" style="width:100%; height:120px; border:none"></iframe>

        <h3 class="title">홈쇼핑 회원 정보 수정</h3>
        <form name="u_data" action="update_p.jsp" method="post" onsubmit="return checkValue()">
        <table class="table_line">
	    	<tr>
	       		<th>회원번호</th>
	       		<td><input type="text" name="custno" value=<%= rs.getString("custno") %> size="10" readonly></td>
	    	</tr>
	    	<tr>
	       		<th>회원성명</th>
	       		<td><input type="text" name="custname" value=<%= rs.getString("custname") %> size="10"></td>
	    	</tr>
	    	<tr>
	       		<th>회원전화</th>
	       		<td><input type="text" name="phone" value=<%= rs.getString("phone") %> size="15"></td>
	    	</tr>
	    	<tr>
	       		<th>회원주소</th>
	       		<td><input type="text" name="address" value=<%= rs.getString("address") %> size="25"></td>
	    	</tr>
	    	<tr>
	       		<th>가입일자</th>
	       		<td><input type="date" name="joindate" id="joindate" size="10"></td>
	    	</tr>
	    	<tr>
	    		<th>고객등급</th>
	    		<td><input type="text" name="grade" value=<%= rs.getString("grade") %> size="10"></td>
	   	 	</tr>
	    	<tr>
	       		<th>도시코드</th>
	       		<td><input type="text" name="city" value=<%= rs.getString("city") %> size="10"></td>
	       	</tr>
	    	<tr>
	       		<td colspan="2" align="center">
	       		  <input type="submit" name="submit" value="수정">
	       		  <input type="button" name="search" value="조회" onclick="parent.location.href='member_list.jsp'">
	       		  <input type="button" value="삭제" onclick="checkDel(<%= rs.getString("custno")%>);">
	       		</td>
	    	</tr>
        </table>
        <script> 
     		document.getElementById("joindate").value = new Date ("<%= rs.getString("custno")%>").toISOString().subString(0, 10);
		</script>
        
        </form>
        <footer id="footer">
           <iframe src="./layout/footer.jsp" width=100% height=30px></iframe>
        </footer>
    </main>
</body>
</html>