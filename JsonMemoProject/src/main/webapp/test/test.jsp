<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="kr.ezen.memo.dao.TestDAO"%>
<%@page import="kr.ezen.memo.vo.TestVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 글 전체를 읽어보자
//String path = application.getRealPath("./data/test.json"); // 이렇게 읽어야함!
String path = application.getRealPath("./data/test.json");
System.out.println(path);
List<TestVO> list = TestDAO.readMemo(path);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>메모장</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
  <style>
    body{color: #333333; background: #ffffff; font-family: 'Gaegu'; font-size: 22px;}
    a{text-decoration: none;color: inherit;}
    li{list-style: none;}
    
    img{max-width: 100%;}
    table{border-collapse: collapse;}

    #wrap {width: 1200px; margin: 0 auto;}
    table { display: flex; justify-content: center; align-items: center; text-align: center;}
    table th {background: lightcoral; color: #fff;}
    table tr,th,td{width: 700px; padding: 20px; border: 1px solid #ccc;}
    h1 {font-size: 36px; text-align: center;}
    button{border: 1px solid #333;background: none;cursor: pointer; padding: 10px 30px; float: right; margin-top: 10px;}
    #write {
    	display:none;
    }
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script type="text/javascript">
	$(function() {
		$("button").click(function(){
			$("#write").css("display","block");
		});
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
	}
	// 저장폼으로 바꾼다.
	function resetForm(){
		//$("#cancelBtn").css('display','none'); // 취소버튼을 숨긴다.
		$("#submitBtn").val("저장");
		$("#idx").val(0); // 글번호 초기화
		$("#mode").val("insert"); // 저장모드로 변경
		$("#name").val(""); // 이름에 이름 지우고
		$("#memo").val(""); // 메모에 메모 지우고
		$("#name").focus(); // 이름에 커서 위치
		$("#write").css("display","none");
	}
</script>
</head>
<body>
  <div id="wrap">
    <main class="menoList">
      <h1>MEMO</h1>
        <table class="writer">
          <tr>
            <th>No</th>
            <th>작성자</th>
            <th>MEMO</th>
            <th>일자</th>
			<th>수정/삭제</th>
          </tr>
          <% for(int i = list.size()-1 ; i>=0;i--) { %>
          <tr>
          	<td><%= list.size()-i%></td>
          	<td><%= list.get(i).getName()%></td>
          	<td><%= list.get(i).getMemo()%> </td>
          	<td><%= list.get(i).getWriteDate()%></td>
          	<td>
          	  <button onclick="updateForm(<%=i%>, <%=list.get(i).getName()%>, <%=list.get(i).getMemo() %>)">수정</button>
          	  <button onclick="deleteForm(<%=i%>, <%=list.get(i).getName()%>, <%=list.get(i).getMemo() %>)">삭제</button>
			</td>
          </tr>
          <% } %>
          <%-- 저장/수정/삭제 폼 --%>        
        </table>
        <button onclick='resetForm()'>글쓰기</button>
        <div id="write">
          <form action="testOk.jsp" method="post">
			<input type="hidden" name="idx" id="idx" value="0" />
			<!-- 수정할때 글번호 저장할 필드  -->
			<input type="hidden" name="mode" id="mode" value="insert" />
			<!-- 값이 insert면 저장, update면 수정, delete면 삭제  -->
			<input type="text" name="name" id="name" required placeholder="이름입력" size="10" />
			<input type="password" name="password" id="password" required placeholder="비밀번호" size="10" />
			<input type="text" name="memo" id="memo" required placeholder="메모 내용 입력" size="73" />
			<input type="submit" id="submitBtn" value="저장" /> 
			<input type="button" id="cancelBtn" value="취소" onclick='resetForm()'/>
		  </form>
        </div>
    </main>
  </div>
</body>
</html>