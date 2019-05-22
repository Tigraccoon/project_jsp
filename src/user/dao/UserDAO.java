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
			map.put("pwd", "PACK_ENCRYPTION_DECRYPTION.FUNC_ENCRYPT(" + pwd + ")");
			
			dto = session.selectOne("user.login", map);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("login Error...");
		} finally {
			if(session!=null)session.close();
		}
		
		
		return dto;
	}

}
