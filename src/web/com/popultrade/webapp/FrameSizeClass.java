package com.popultrade.webapp;

public class FrameSizeClass implements java.io.Serializable  {

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5676574564362462461L;


	public FrameSizeClass(String username,Integer frame1,Integer frame2,Integer frame3) {
		
		this.username=username;
		this.frame1=frame1;
		this.frame2=frame2;
		this.frame3=frame3;
		
	}
	
	
	private String username;
	private Integer frame1;
	private Integer frame2;
	private Integer frame3;
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getFrame1() {
		return frame1;
	}
	public void setFrame1(Integer frame1) {
		this.frame1 = frame1;
	}
	public Integer getFrame2() {
		return frame2;
	}
	public void setFrame2(Integer frame2) {
		this.frame2 = frame2;
	}
	public Integer getFrame3() {
		return frame3;
	}
	public void setFrame3(Integer frame3) {
		this.frame3 = frame3;
	}
	
	
	
	
	
	
}
