package sqlmap;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisManager {
	
	//SqlSessionFactoryBuilder 생성 -> SqlSessionFactory 호출 -> SqlSession 생성
	//SqlSession 객체 생성기
	
	private static SqlSessionFactory instance;
	//객체 생성자는 보통 public인데 여기선 private처리. 따라서 외부에서 접근 x
	//new 접근이 안 되기 때문에 밑에 getInstance로 우회 접근(getter/setter처럼)
	//public 생성자를 막아서 외부 직접 접근을 방지
	//웹은 사용자들이 많기 때문에 접속할 때 마다 객체를 생성하게되면 메모리가 곤란..
	//다수의 인스턴스화를 막고 하나의 인스턴스만 생성하여 사용(싱글톤)
	
	private MybatisManager() {
	}
	
	public static SqlSessionFactory getInstance() {
		Reader reader = null;
		//InputStream, OutputStream -> 1byte단위
		//InputStreamReader, OutputStreamWriter -> 1 char 단위
		//Reader는 InputStreamReader의 상위 객체
		
		try {
			//getResourceAsReader()는 java Resources/src/xml을 읽어들이는 메소드
			//instance는 SqlSessionFactory이다
			reader = Resources.getResourceAsReader("sqlmap/sqlMapConfig.xml");
			instance = new SqlSessionFactoryBuilder().build(reader);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("MybatisManager.getInstance Error...");
		} finally {
			try {
				if(reader != null) reader.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return instance;
	}
	
	
}
