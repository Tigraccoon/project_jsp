package board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import board.dto.BoardDTO;
import sqlmap.MybatisManager;

public class BoardDAO {
	public int boardCount() {
		SqlSession session = MybatisManager.getInstance().openSession();
		
		int count = session.selectOne("board.boardCount");
		
		session.close();
		
		return count;
	}
	
	public List<BoardDTO> list(int start, int end){
		SqlSession session = null; 
		List<BoardDTO> list = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			
			list = session.selectList("board.list", map);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("list Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		
		return list;
	}

	public void write(BoardDTO dto) {
SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.insert("board.write", dto);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("write Error...");
		} finally {
			if(session!=null)session.close();
		}
	}
}
