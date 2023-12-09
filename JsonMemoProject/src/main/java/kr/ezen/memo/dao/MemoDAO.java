package kr.ezen.memo.dao;
// DAO (Data Access Object) :
// DATA의 CRUD(Create, Read, Update, Delete)에 관계된 모아놓은 클래스

import java.io.FileReader;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.ezen.memo.vo.MemoVO;

public class MemoDAO {
	// 읽기(Read) : path에 있는 내용을 읽어서 list로 주세요
	public static List<MemoVO> readMemo(String path){
		// 1. 첫번째 줄에 리턴타입의 변수 선언 
		List<MemoVO> list = null;
		
		// 2. 사용
		try(FileReader fr = new FileReader(path)){
			Gson gson = new Gson();
			list = gson.fromJson(fr, new TypeToken<List<MemoVO>>() {}.getType());
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		// 3. 마지막줄에는 return을 써라.
		return list;
	}
	
	// 쓰기(Write) : path에 리스트를 저장해 주세요
	public static void writeMemo(String path, List<MemoVO> list) {
		// 2. 사용
		try(PrintWriter pw = new PrintWriter(path)){
			Gson gson = new Gson();
			gson.toJson(list, pw);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
