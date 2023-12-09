package kr.ezen.memo.dao;

import java.io.FileReader;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.ezen.memo.vo.TestVO;

public class TestDAO {
	public static List<TestVO> readMemo(String path) {
		List<TestVO> list = null;
		try (FileReader fr = new FileReader(path)) {
			Gson gson = new Gson();
			list = gson.fromJson(fr, new TypeToken<List<TestVO>>() {
			}.getType());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 쓰기
	public static void writeMemo(String path, List<TestVO> list) {
		try (PrintWriter pw = new PrintWriter(path)) {
			Gson gson = new Gson();
			gson.toJson(list,pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
