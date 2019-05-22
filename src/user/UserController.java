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
			
			UserDTO user = dao.login(userid, pwd);
			
			session.setAttribute("user", user);
			
			page = "/main/index.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}	//로그인
		
		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
