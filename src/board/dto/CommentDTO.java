package board.dto;

import java.sql.Date;

public class CommentDTO {
	private int c_num;
	private int board_num;
	private String c_writer;
	private String c_content;
	private int c_ref;
	private int c_step;
	private int c_level;
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
	public int getC_ref() {
		return c_ref;
	}
	public void setC_ref(int c_ref) {
		this.c_ref = c_ref;
	}
	public int getC_step() {
		return c_step;
	}
	public void setC_step(int c_step) {
		this.c_step = c_step;
	}
	public int getC_level() {
		return c_level;
	}
	public void setC_level(int c_level) {
		this.c_level = c_level;
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
				+ c_content + ", c_ref=" + c_ref + ", c_step=" + c_step + ", c_level=" + c_level + ", c_date=" + c_date
				+ ", c_show=" + c_show + "]";
	}
	
}
