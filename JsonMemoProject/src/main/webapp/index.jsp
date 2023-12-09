<%@page import="kr.ezen.memo.dao.MemoDAO"%>
<%@page import="kr.ezen.memo.vo.MemoVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 글 전체를 읽어보자
String path = application.getRealPath("./data/memo.json");
System.out.println(path);
List<MemoVO> list = MemoDAO.readMemo(path);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Json 1줄 메모장</title>
<style type="text/css">
table {
	width: 1000px;
	padding: 5px;
	margin: auto;
}

td, th {
	padding: 5px;
	border: 1px solid gray;
	text-align: center;
}

th {
	background-color: silver;
	text-align: center;
}

.main_title {
	text-align: center;
	border: none;
	font-size: 18pt;
	font-weight: bold;
}

.sub_title {
	text-align: right;
	border: none;
	font-weight: bold;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 취소 버튼을 숨긴다. : 저장시에는 취소버튼이 필요 없다.
		$("#cancelBtn").css('display','none'); // 
	});
	// 수정폼으로 바꾼다.
	function updateForm(idx,name,memo){
		$("#cancelBtn").css('display','inline'); // 취소버튼을 보이게 한다.
		$("#submitBtn").val("수정");
		$("#idx").val(idx); // 글번호 넣기
		$("#mode").val("update"); // 수정모드로 변경
		$("#name").val(name); // 이름에 이름 넣고
		$("#memo").val(memo); // 메모에 메모 넣고
		$("#password").focus(); // 비번에 커서 위치
	}
	
	// 삭제폼으로 바꾼다.
	function deleteForm(idx,name,memo){
		$("#cancelBtn").css('display','inline'); // 취소버튼을 보이게 한다.
		$("#submitBtn").val("삭제");
		$("#idx").val(idx); // 글번호 넣기
		$("#mode").val("delete"); // 삭제모드로 변경
		$("#name").val(name); // 이름에 이름 넣고
		$("#memo").val(memo); // 메모에 메모 넣고
		$("#password").focus(); // 비번에 커서 위치		
	}
	
	// 저장폼으로 바꾼다.
	function resetForm(){
		$("#cancelBtn").css('display','none'); // 취소버튼을 숨긴다.
		$("#submitBtn").val("저장");
		$("#idx").val(0); // 글번호 초기화
		$("#mode").val("insert"); // 저장모드로 변경
		$("#name").val(""); // 이름에 이름 지우고
		$("#memo").val(""); // 메모에 메모 지우고
		$("#name").focus(); // 이름에 커서 위치		
	}
</script>
</head>
<body>
	<table>
		<tr>
			<td colspan="5" class="main_title">Json 1줄 메모장</td>
		</tr>
		<tr>
			<td colspan="5" class="sub_title">전체 : <%=list.size()%>개
			</td>
		</tr>
		<tr>
			<th>No</th>
			<th>작성자</th>
			<th width="65%">내용</th>
			<th>작성일</th>
			<th>수정/삭제</th>
		</tr>
		<%
		// 글을 출력하는데 최근글을 위로 나오게하기 위하여 뒤에서부터 출력하자
		for (int i = list.size() - 1; i >= 0; i--) {
			MemoVO vo = list.get(i); // 글 1개 얻기
			// 글 1개당 1줄이다.
			out.println("<tr>");
			out.println("<td>" + (i + 1) + "</td>");
			out.println("<td>" + (vo.getName()) + "</td>");
			out.println("<td style='text-align:left'>" + (vo.getMemo()) + "</td>");
			out.println("<td>" + (vo.getWriteDate()) + "</td>");
			out.println("<td><button onclick=\"updateForm('" + i + "','"+vo.getName()+"','"+vo.getMemo()+"')\">수정</button>");
			out.println("<button onclick=\"deleteForm('" + i + "','"+vo.getName()+"','"+vo.getMemo()+"')\">삭제</button></td>");
			out.println("</tr>");
		}
		%>
		<%-- 저장/수정/삭제 폼을 달아보자 --%>
		<tr>
			<td colspan="5" style="border: none; text-align: left;">
				<form action="updateOk.jsp" method="post">
					<input type="hidden" name="idx" id="idx" value="0" />
					<!-- 수정할때 글번호 저장할 필드  -->
					<input type="hidden" name="mode" id="mode" value="insert" />
					<!-- 값이 insert면 저장, update면 수정, delete면 삭제  -->
					<input type="text" name="name" id="name" required placeholder="이름입력" size="10" />
					<input type="password"	name="password" id="password" required placeholder="비번입력" size="10" /> 
					<input type="text" name="memo" id="memo" required placeholder="메모 내용 입력" size="73" />
					<input type="submit" id="submitBtn" value="저장" /> 
					<input type="button" id="cancelBtn" value="취소" onclick='resetForm()'/>
				</form>
			</td>
		</tr>
	</table>
</body>
</html>