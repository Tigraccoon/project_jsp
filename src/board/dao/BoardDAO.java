package board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import board.dto.BoardDTO;
import board.dto.CommentDTO;
import sqlmap.MybatisManager;

public class BoardDAO {
	public int boardCount() {
		SqlSession session = MybatisManager.getInstance().openSession();
		
		int count = session.selectOne("board.boardCount");
		
		session.close();
		
		return count;
	}
	
	public List<BoardDTO> list(int start, int end, String search){
		SqlSession session = null; 
		List<BoardDTO> list = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			map.put("search", "%"+search+"%");
			
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

	public String getFileName(int num) {
		String result = "";
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("board.getFileName", num);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getFileName Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		return result;
	}

	public void downCount(int num) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.update("board.downCount", num);
			
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("downCount Error...");
		} finally {
			if(session!=null)session.close();
		}
	}

	public void readCount(int num, HttpSession count_session) {
		SqlSession session = null;
		
		try {
			long read_time = 0;
			
			if(count_session.getAttribute("read_time_"+num) != null) {
				read_time = (long)count_session.getAttribute("read_time_"+num);
			}
			
			long current_time = System.currentTimeMillis();
			
			session = MybatisManager.getInstance().openSession();
			
			if(current_time-read_time > 10 * 1000) {	
				//시간값을 하루로 정하려면 24 * 60 * 60 * 1000 (24시간 * 60분 * 60초 * 1000ms)
				
				session.update("board.readCount", num);
				
				session.commit();

				count_session.setAttribute("read_time_"+num, current_time);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("readCount Error...");
		} finally {
			if(session!=null)session.close();
		}
	}

	public BoardDTO view(int num) {
		SqlSession session = null;
		BoardDTO dto = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			dto = session.selectOne("board.view", num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("view Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		return dto;
	}

	public List<CommentDTO> commentList(int num) {
		SqlSession session = null;
		List<CommentDTO> list = null;

		try {
			session = MybatisManager.getInstance().openSession();
			
			list = session.selectList("board.commentList", num);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("commentList Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		return list;
	}

	public void commentAdd(CommentDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.insert("board.commentAdd", dto);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("commentAdd Error...");
		} finally {
			if(session!=null)session.close();
		}
		
	}

	public void contentUpdate(BoardDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.update("board.contentUpdate", dto);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("contentUpdate Error...");
		} finally {
			if(session!=null)session.close();
		}
	}

	public void contentDelete(int num) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.update("board.contentDelete", num);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("contentDelete Error...");
		} finally {
			if(session!=null)session.close();
		}
		
	}

	@SuppressWarnings("null")
	public List<BoardDTO> mylist(int start, int end, String userid) {
		SqlSession session = null; 
		List<BoardDTO> list = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			map.put("userid", userid);
			
			list = session.selectList("board.mylist", map);
			if(list == null) {
				BoardDTO dto = new BoardDTO();
				dto.setSubject("글이 없음...");
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("mylist Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		
		return list;
	}
}
