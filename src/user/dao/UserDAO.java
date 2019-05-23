package user.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;
import user.dto.UserDTO;

public class UserDAO {

	public UserDTO login(String userid, String pwd) {
		SqlSession session = null; 
		UserDTO dto = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			Map<String,Object> map = new HashMap<>();
			map.put("userid", userid);
			map.put("pwd", pwd);
			
			dto = session.selectOne("user.login", map);

			if(dto == null) {
				dto = new UserDTO();
				dto.setUserid("비밀번호가 올바르지 않습니다...");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("login Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		return dto;
	}

	public String idCheck(String userid) {
		SqlSession session = null; 
		String tempId = "";
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			tempId = session.selectOne("user.idCheck", userid);
			
			if(tempId == null) {
				tempId = "아이디가 없어요...";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("login Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		return tempId;
	}

}
