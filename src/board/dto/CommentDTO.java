package board.dto;

import java.util.Date;

public class CommentDTO {
	private int c_num;
	private int board_num;
	private String c_writer;
	private String c_content;
	private Date c_date;
	private String c_show;
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getC_writer() {
		return c_writer;
	}
	public void setC_writer(String c_writer) {
		this.c_writer = c_writer;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public Date getC_date() {
		return c_date;
	}
	public void setC_date(Date c_date) {
		this.c_date = c_date;
	}
	public String getC_show() {
		return c_show;
	}
	public void setC_show(String c_show) {
		this.c_show = c_show;
	}
	@Override
	public String toString() {
		return "ContentDTO [c_num=" + c_num + ", board_num=" + board_num + ", c_writer=" + c_writer + ", c_content="
				+ c_content + ", c_date=" + c_date
				+ ", c_show=" + c_show + "]";
	}
	
}
