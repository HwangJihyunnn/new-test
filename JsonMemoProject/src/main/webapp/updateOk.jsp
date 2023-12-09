<%@page import="kr.ezen.memo.dao.MemoDAO"%>
<%@page import="kr.ezen.memo.vo.MemoVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	// POST전송 이외는 맊기
	if(!request.getMethod().equals("POST")){
		response.sendRedirect("index.jsp");
		return;
	}

	// 데이터 받기
	int idx = -1;
	try{
		idx = Integer.parseInt(request.getParameter("idx"));
	}catch(Exception e){
		;
	}
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String memo = request.getParameter("memo");
	String mode = request.getParameter("mode");
	// 작성일은 만들자
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeDate = sdf.format(new Date());

	// 글 전체를 읽어보자
	String path = application.getRealPath("./data/memo.json");
	List<MemoVO> list = MemoDAO.readMemo(path);
	
	// mode 데이터에 맞추어 처리를 하자
	switch(mode){
	case "insert":
		// 저장
		// 1. 넘어온 데이터를 이용하여  VO를 만들어주자
		MemoVO memoVO = new MemoVO();
		memoVO.setName(name);
		memoVO.setPassword(password);
		memoVO.setMemo(memo);
		memoVO.setWriteDate(writeDate);
		// 2. 리스트에 추가하자
		list.add(memoVO);
		// 3. 리스트를 다시 저장하자
		MemoDAO.writeMemo(path, list);
		break;
	case "update":
		// 수정
		// 1. 해당 번호의 글을 읽어와야 한다.
		MemoVO vo1 = list.get(idx);
		// 2. 글이 존재하며 비번이 같을때만 수정을 수행한다.
		if(vo1!=null && vo1.getPassword().equals(password)){
			// 3. 내용을 바꾼다. 이름과 비번은 못바꾼다.
			vo1.setMemo(memo);
			vo1.setWriteDate(writeDate);
			// 4. 다시 저장한다.
			MemoDAO.writeMemo(path, list);
		}
		break;
	case "delete":
		// 삭제
		// 1. 해당 번호의 글을 읽어와야 한다.
		MemoVO vo2 = list.get(idx);
		// 2. 글이 존재하며 비번이 같을때만 삭제를 수행한다.
		if(vo2!=null && vo2.getPassword().equals(password)){
			// 3. 글을 리스트에서 지우고
			list.remove(idx);			
			// 4. 다시 저장한다.
			MemoDAO.writeMemo(path, list);
		}
		break;
	}
	// 목록으로 가자
	response.sendRedirect("index.jsp");

%>