package board;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import board.dto.CommentDTO;
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
			
			String search = request.getParameter("search");
			if(search==null) search="";

			int count = dao.boardCount();
			int curPage = 1;
			if(request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager = new Pager(count, curPage);
			int start= pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<BoardDTO> list = dao.list(start, end, search);
			
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
			page = "/board_servlet/list.do";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}
		
		else if(uri.indexOf("download.do") != -1) {
			System.out.println("\ndownload.do\n");

			int num = Integer.parseInt(request.getParameter("num"));
			String filename = dao.getFileName(num);
			
			System.out.println(filename);
			
			path=Constants.UPLOAD_PATH+filename;
			
			byte b[]=new byte[4096];
			
			FileInputStream fis=new FileInputStream(path);
			
			String mimeType=getServletContext().getMimeType(path);
			
			if(mimeType==null) {
				mimeType="application/octet-stream;charset=utf-8";
			}
			
			filename = new String(filename.getBytes("utf-8"), "8859_1");
			
			response.setHeader("Content-Disposition", "attachment;filename="+filename);
			ServletOutputStream out=response.getOutputStream();
			
			int numRead;
			
			while(true) {
				numRead = fis.read(b,0,b.length);
				
				if(numRead == -1) break;
				
				out.write(b,0,numRead);
			}
			
			out.flush();
			out.close();
			fis.close();
			
			dao.downCount(num);
			
		}
		
		else if(uri.indexOf("view.do") != -1) {
			System.out.println("\nview.do\n");

			int num = Integer.parseInt(request.getParameter("num"));
			
			//조회수 증가
			dao.readCount(num, session);
			
			BoardDTO dto = dao.view(num);
			
			request.setAttribute("list", dto);
			
			page = "/board/view.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		
		else if(uri.indexOf("commentList.do") != -1) {
			System.out.println("\ncommentList.do\n");
			
			int num = Integer.parseInt(request.getParameter("num"));
			
			List<CommentDTO> list = dao.commentList(num);
			
			request.setAttribute("c_list", list);
			
			page = "/board/comment_list.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		
		else if(uri.indexOf("comment_add.do") != -1) {
			System.out.println("\ncomment_add.do\n");

			int board_num = Integer.parseInt(request.getParameter("board_num"));
			String c_writer = request.getParameter("c_writer");
			String c_content = request.getParameter("c_content");
			
			System.out.println();
			System.out.println(board_num);
			System.out.println(c_writer);
			System.out.println(c_content);
			System.out.println();
			
			CommentDTO dto = new CommentDTO();
			
			dto.setBoard_num(board_num);
			dto.setC_writer(c_writer);
			dto.setC_content(c_content);
			
			dao.commentAdd(dto);
		}
		
		else if(uri.indexOf("contentUpdate.do") != -1) {
			System.out.println("\ncontentUpdate.do\n");
			
			File uploadDir = new File(Constants.UPLOAD_PATH); 
			if(!uploadDir.exists()) {	//해당 디렉토리가 존재하지 않으면?
				uploadDir.mkdir();	//디렉토리 생성
			}
			
			MultipartRequest mr = new MultipartRequest(request, Constants.UPLOAD_PATH, Constants.MAX_UPLOAD 
														, "UTF-8", new DefaultFileRenamePolicy());
			
			int num = Integer.parseInt(mr.getParameter("num"));
			String writer = mr.getParameter("writer");
			String subject = mr.getParameter("subject");
			String content = mr.getParameter("content");
			String ip = request.getRemoteAddr();
			String show = mr.getParameter("show");
			if(show == null) show = "y";
			String filename = " ";
			int filesize = 0;
			
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
			
			dto.setNum(num);
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setIp(ip);
			dto.setShow(show);
			
			if(filename == null || filename.trim().equals("")) {
				BoardDTO dto2 = dao.view(num);
				String fName = dto2.getFilename();
				int fSize = dto2.getFilesize();
				int fDown = dto2.getDown();
				
				dto.setFilename(fName);
				dto.setFilesize(fSize);
				dto.setDown(fDown);
			} else {
				dto.setFilename(filename);
				dto.setFilesize(filesize);
			}
			String fileDel = mr.getParameter("fileDel");
			if(fileDel != null && fileDel.equals("on")) {
				String fileName = dao.getFileName(num);
				File f = new File(Constants.UPLOAD_PATH+fileName);
				f.delete();
				dto.setFilename("-");
				dto.setFilesize(0);
				dto.setDown(0);
			}
			
			dao.contentUpdate(dto);
			
			page = "/board_servlet/view.do?num="+num;
			response.sendRedirect(path + page);
		}
		
		else if(uri.indexOf("contentDelete.do") != -1) {
			System.out.println("\ncontentDelete.do\n");
			
			MultipartRequest mr = new MultipartRequest(request, Constants.UPLOAD_PATH, Constants.MAX_UPLOAD 
					, "UTF-8", new DefaultFileRenamePolicy());
			int num = Integer.parseInt(mr.getParameter("num"));

			dao.contentDelete(num);
			
			page = "/board_servlet/list.do";
			response.sendRedirect(path + page);
		}
		
		else if(uri.indexOf("myList.do") != -1) {
			System.out.println("\nmyList.do\n");
			String userid = request.getParameter("userid");
			
			int count = dao.boardCount();
			int curPage = 1;
			if(request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager = new Pager(count, curPage);
			int start= pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<BoardDTO> list = dao.mylist(start, end, userid);
			
			request.setAttribute("list", list);
			request.setAttribute("page", pager);

			page = "/board/mylist.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
