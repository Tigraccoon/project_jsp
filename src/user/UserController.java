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
		
		else if(uri.indexOf("signup1.do") != -1) {
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			String checkid = dao.idCheck(userid);
			String checkemail = dao.emailCheck(email);
			if (checkid.equals("아이디가 없어요...")) {	//아이디 중복검사
				request.setAttribute("userid", userid);
				
				if(checkemail.equals("이메일이 없어요...")) {	//이메일 중복검사
					page = "/user/signup_2.jsp";
					
				} else {
					request.setAttribute("hasEmail", "이미 가입된 이메일입니다.");
					page = "/user/signup.jsp";
				}
				
			} else {
				request.setAttribute("hasUserId", "이미 가입된 아이디입니다.");
				page = "/user/signup.jsp";
				
			}
			
			request.setAttribute("userid", userid);
			request.setAttribute("email", email);
			
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		
		else if(uri.indexOf("signup.do") != -1) {
			UserDTO dto = new UserDTO();
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String hp = request.getParameter("hp");
			String zipcode = request.getParameter("zipcode");
			String address1 = request.getParameter("address1");
			String address2 = request.getParameter("address2");
			
			dto.setUserid(userid);
			dto.setPwd(pwd);
			dto.setName(name);
			dto.setEmail(email);
			dto.setHp(hp);
			dto.setZipcode(zipcode);
			dto.setAddress1(address1);
			dto.setAddress2(address2);
			
			dao.insertUser(dto);
			
			request.setAttribute("userid", userid);
			
			page = "/user/signupCompleted.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		
		else if(uri.indexOf("set_user.do") != -1) {
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			String message = dao.pwdCheck(userid,pwd);
			
			if (message.equals("비밀번호가 올바르지 않습니다.")) {
				page ="/user/pwd_Check.jsp";
			} else {
				page = "/user/set_User.jsp";
			}
			
			request.setAttribute("message", message);
			
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} else if(uri.indexOf("update") != -1) {
			UserDTO dto = new UserDTO();
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String hp = request.getParameter("hp");
			String zipcode = request.getParameter("zipcode");
			String address1 = request.getParameter("address1");
			String address2 = request.getParameter("address2");
			
			dto.setUserid(userid);
			dto.setPwd(pwd);
			dto.setName(name);
			dto.setEmail(email);
			dto.setHp(hp);
			dto.setZipcode(zipcode);
			dto.setAddress1(address1);
			dto.setAddress2(address2);
			
			dao.updateUser(dto);
			
			
			page = "/user_servlet/logout.do";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} 
		
		else if(uri.indexOf("delete.do") != -1) {
			String userid = request.getParameter("userid");
			
			dao.deleteUser(userid);
			
			page = "/user_servlet/logout.do";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}
		
		else if(uri.indexOf("finduserinfo.do") != -1) {
			
			String email = request.getParameter("email");
			String name = request.getParameter("name");
			
			UserDTO dto = new UserDTO();
			
			dto.setEmail(email);
			dto.setName(name);
			
			dto = dao.findUser(dto);
			
			if(dto.getUserid().equals("아이디, 비밀번호 찾기에 실패하였습니다. 이메일, 이름을 확인하세요!")) {
				request.setAttribute("cantfind", dto.getUserid());
				request.setAttribute("email", email);
				request.setAttribute("name", name);
				page = "/user/finduser.jsp";
			} else {
				request.setAttribute("userid", dto.getUserid());
				request.setAttribute("pwd", dto.getPwd());
				page = "/user/find_result.jsp";
				
			}
			
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}
	
	}//doget

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
