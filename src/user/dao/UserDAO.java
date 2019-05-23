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
			System.out.println("idCheck Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		return tempId;
	}

	public String emailCheck(String email) {
		SqlSession session = null; 
		String tempEmail = "";
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			tempEmail = session.selectOne("user.emailCheck", email);
			
			if(tempEmail == null) {
				tempEmail = "이메일이 없어요...";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("emailCheck Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		return tempEmail;
	}

	public void insertUser(UserDTO dto) {
		SqlSession session = null; 
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.insert("user.insertUser", dto);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insertUser Error...");
		} finally {
			if(session!=null)session.close();
		}
	}

	public String pwdCheck(String userid, String pwd) {
		String result = "";
		SqlSession session = null; 
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			Map<String,Object> map = new HashMap<>();
			map.put("userid", userid);
			map.put("pwd", pwd);
			
			result = session.selectOne("user.pwdCheck", map);

			if(result == null) {
				result = "비밀번호가 올바르지 않습니다.";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("pwdCheck Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		
		return result;
	}

	public void updateUser(UserDTO dto) {
		SqlSession session = null; 
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.update("user.updateUser", dto);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("updateUser Error...");
		} finally {
			if(session!=null)session.close();
		}
		
	}

	public void deleteUser(String userid) {
		SqlSession session = null; 
		
		try {
			session = MybatisManager.getInstance().openSession();
			
			session.delete("user.deleteUser", userid);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("deleteUser Error...");
		} finally {
			if(session!=null)session.close();
		}
		
	}

}
