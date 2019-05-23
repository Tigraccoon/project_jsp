package user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.dao.UserDAO;
import user.dto.UserDTO;

@WebServlet("/user_servlet/*")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String uri = request.getRequestURI();
		String page = "";
		UserDAO dao = new UserDAO();
		
		if(uri.indexOf("login.do") != -1) {
			System.out.println("\nlogin.do\n");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			String tempid = dao.idCheck(userid);
			
			if(tempid.equals("아이디가 없어요...")) {	//아이디 없음
				request.setAttribute("message", "아이디가 없습니다.");
				
				page = "/user/login.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
				
			} else {	//아이디 있음
				
				UserDTO user = dao.login(userid, pwd);
				
				if(user.getUserid().equals("비밀번호가 올바르지 않습니다...")) {	//비밀번호 틀림
					request.setAttribute("message", "비밀번호가 올바르지 않습니다.");
					
					page = "/user/login.jsp";
					RequestDispatcher rd = request.getRequestDispatcher(page);
					rd.forward(request, response);
					
				} else { //로그인 성공
					session.setAttribute("user", user);
					
					page = "/main/index.jsp";
					RequestDispatcher rd = request.getRequestDispatcher(page);
					rd.forward(request, response);
				}
				
				
			}
			
		}	//로그인
		
		else if(uri.indexOf("logout.do") != -1) {
			session.invalidate();
			session = request.getSession();
			
			page = "/main/index.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}	//로그아웃
		
		
	
	}//doget

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
