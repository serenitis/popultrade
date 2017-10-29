package com.popultrade.webapp;

import java.util.Date;

public class LoginAttempt {

	
	public final int MAXNOATTEMPT = 3;
	
	
	public String user; /// user try login
	public Date lastatempt; /// last attempt by user
	public int noattempt; /// number of attempts
	
	
	
	public LoginAttempt(String user,Date dt) {
		
		this.user=user;
		this.lastatempt=dt;
		this.noattempt=1;
		
	}
	
	
	
	
	
	

}
