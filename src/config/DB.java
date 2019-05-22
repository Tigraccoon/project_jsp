package config;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DB {
	public static Connection getConn() {
		DataSource ds = null;
		Connection conn = null;
		
		try {
			//context.xml을 분석하는 객체
			Context ctx = new InitialContext();
			ds=(DataSource)ctx.lookup("java:comp/env/oraDB");	//Servers/context.xml의 name과 동일해야..
			conn = ds.getConnection();	//커넥션 할당
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("--------------------");
			System.out.println("서버 접속 애러");
			System.out.println("--------------------");
		}
		
		return conn;
	}
	
}
