package com.popultrade.webapp;

import java.util.Date;
import java.util.Hashtable;

import org.apache.tools.ant.BuildEvent;
import org.apache.tools.ant.BuildListener;
import org.apache.tools.ant.Project;

public class TimerObj implements  java.io.Serializable  {

	
	private Date start_time;
	private String status; /// 1-timer paused, 2-timer working
	private String timer_id; /// id of interval or alert
	
	
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTimer_id() {
		return timer_id;
	}
	public void setTimer_id(String timer_id) {
		this.timer_id = timer_id;
	}
	
	
	private Hashtable alerts = new Hashtable(); /// all alerts inside interval, id alert, interval


	public Hashtable getAlerts() {
		return alerts;
	}
	public void setAlerts(Hashtable alerts) {
		this.alerts = alerts;
	}
	
	
	
	
	
	
	
}
