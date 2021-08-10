<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원관리 ver 1.0</title>
</head>
<script type="text/javascript"> // 자바 실행문을 사용하기위한 스크립트 생성
function check() { // 유효성 체크 메서드
	if (f.custno.value == "") {
		alert("회원 번호가 입력되지 않았습니다.");
		return f.custno.focus();
	} else if( f.custno.value == "null") {
		alert("회원 번호가 잘못 입력되었습니다.");
		return f.custno.focus();
	}
	if (f.custname.value == "") {
		alert("회원 성명이 입력되지 않았습니다.");
		return f.custname.focus();
	} else if( f.custname.value == "null") {
		alert("회원 성명이 잘못 입력되었습니다.");
		return f.custname.focus();
	}
	if (f.phone.value == "") {
		alert("회원 전화번호가 입력되지 않았습니다.");
		return f.phone.focus();
	} else if( f.phone.value == "null") {
		alert("회원 전화번호가 잘못 입력되었습니다.");
		return f.phone.focus();
	}
	if (f.address.value == "") {
		alert("회원 주소가 입력되지 않았습니다.");
		return f.address.focus();
	} else if( f.address.value == "null") {
		alert("회원 주소가 잘못 입력되었습니다.");
		return f.address.focus();
	}
	if (f.joindate.value == "") {
		alert("가입 일자가 입력되지 않았습니다.");
		return f.joindate.focus();
	} else if( f.joindate.value == "null") {
		alert("가입 일자가 잘못 입력되었습니다.");
		return f.joindate.focus();
	}
	if (f.grade.value == "") {
		alert("고객 등급이 입력되지 않았습니다.")
		return f.grade.focus();
	} else if (f.grade.value != "A" &&
			   f.grade.value != "B" &&
			   f.grade.value != "C") {
					alert("고객 등급이 잘못 입력 되었습니다.\n 'A','B','C'중 입력하세요.\n (A=VIP,B=일반,C=직원)");
					return f.grade.select();
				}
	if (f.city.value == "") {
		alert("도시 코드가 입력되지 않았습니다.");
		return f.city.focus();
	} else if( f.city.value == "null") {
		alert("도시 코드가 잘못 입력되었습니다.");
		return f.city.focus();
	}
	f.sumbit();
}
</script>
<body>
<%@ include file = "header.jsp" %> <!-- header부분에 header.jsp파일 가져온다 (db연결 구문(dbconn.jsp)이 포함되어있다.) -->

<% // 회원 번호 자동 생성 sql문
	sql = "select nvl(max(custno), 0)+1 as custno from member_tbl_02";
	// select문을 사용하므로 conn.createStatement 구문객체 사용한 stmt 객체사용
	rs = stmt.executeQuery(sql); // sql문을 삽입한 구문객체 생성
	rs.next(); // 결과 하나를 꺼내와야 하므로 하나만 꺼냄
	String custno = rs.getString("custno"); // 꺼낸 결과값을 문자열 custno 변수에 참조시킴
	
	sql = "select to_char(sysdate, 'yyyymmdd') as joindate from dual";
	rs = stmt.executeQuery(sql);
	rs.next();
	String joindate = rs.getString("joindate"); // rs.getString(1) = 결과값의 첫번째 값 이란 뜻. 이것사용가능
%>
	<section>
		<div>
			<h2>홈쇼핑 회원 등록</h2>
		</div>
	<form action = "insertPro.jsp" name = "f" method = "post">
		<table border = "1" width = "600px" style = "margin : 0 auto;">
			<tr>
				<th width = "45%">회원 번호(자동발생)</th>
				<td width = "55%">
					<input type = "text" value = "<%=custno%>" name = "custno" size = "10" maxlength = "6" readonly>
				</td>
			</tr>
			<tr>
				<th>회원 성명</th>
				<td>
					<input type = "text" value = "" name = "custname" size = "10" maxlength = "20">
				</td>
			</tr>
			<tr>
				<th>회원 전화번호</th>
				<td>
					<input type = "text" value = "" name = "phone" size = "20" maxlength = "13">
				</td>
			</tr>
			<tr>
				<th>회원 주소</th>
				<td>
					<input type = "text" value = "" name = "address" size = "30" maxlength = "60">
				</td>
			</tr>
			<tr>
				<th>가입 일자</th>
				<td>
					<input type = "text" value = "<%=joindate%>" name = "joindate" size = "10" readonly>
				</td>
			</tr>
			<tr>
				<th>고객 등급(A:VIP, B:일반, C:직원)</th>
				<td>
					<input type = "text" value = "" name = "grade" size = "10" maxlength = "1">
				</td>
			</tr>
			<tr>
				<th>도시 코드</th>
				<td>
					<input type = "text" value = "" name = "city" size = "10" maxlength = "2">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type = "submit" value = "회원등록" onclick = "check(); return false"> 
					<!-- return false 입력 안할 시 유효성 체크 도중 첫번째로 걸리는곳에서 확인을 누를 시 포커스가 해당위치에 놓이지않고
					바로 insertPro.jsp로 넘어가 insert 되어버림
					ex)전화번호 입력을 안했을 시 - 이름입력되었기때문에 전화번호 입력하라고 check()를 통해
					문구가 출력되고 확인 누를 시 포커스가 전화번호칸으로 가야하는데 가지않고 바로 insertPro.jsp로 넘어가 null값으로
					수정됨 -->
					<input type = "button" value = "조회" onclick = "location = 'select.jsp'">
				</th>
			</tr>
		</table>
	</form>
	</section>
<%@ include file = "footer.jsp" %> <!-- footer부분에 footer.jsp파일 가져온다 (db연결 해제 구문이 포함되어있다.) -->
</body>
</html>