package board;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import common.Constants;
import config.Pager;

@WebServlet("/board_servlet/*")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String page = "";
		String path = request.getContextPath();
		BoardDAO dao = new BoardDAO();
		HttpSession session = request.getSession();

		if(uri.indexOf("list.do") != -1) {
			System.out.println("\nlist.do\n");
			int count = dao.boardCount();
			int curPage = 1;
			if(request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager = new Pager(count, curPage);
			int start= pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<BoardDTO> list = dao.list(start, end);
			
			request.setAttribute("list", list);
			request.setAttribute("page", pager);

			page = "/board/list.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		
		else if(uri.indexOf("write.do") != -1) {
			System.out.println("\nwrite.do\n");
			File uploadDir = new File(Constants.UPLOAD_PATH); 
			if(!uploadDir.exists()) {	
				uploadDir.mkdir();	
			}
			
			MultipartRequest mr = new MultipartRequest(request, Constants.UPLOAD_PATH, Constants.MAX_UPLOAD 
														, "UTF-8", new DefaultFileRenamePolicy());
			
			String writer = mr.getParameter("writer");
			String subject = mr.getParameter("subject");
			String content = mr.getParameter("content");
			String ip = request.getRemoteAddr();
			String filename = " ";
			int filesize = 0;
			String show = mr.getParameter("show");
			
			if(show == null) show = "y";
			
			try {
				@SuppressWarnings("rawtypes")
				Enumeration files = mr.getFileNames();
				while(files.hasMoreElements()) {
					String file1 = (String)files.nextElement();
					filename = mr.getFilesystemName(file1);
					File f1 = mr.getFile(file1);
					if(f1 != null) {
						filesize = (int)f1.length();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			BoardDTO dto = new BoardDTO();
			
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setIp(ip);
			dto.setShow(show);
			if(filename == null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			
			dao.write(dto);
			page = "/main/index.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
			
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
