package com.popultrade.webapp;

import java.util.Date;
import java.util.Hashtable;

import org.apache.tools.ant.BuildEvent;
import org.apache.tools.ant.BuildListener;
import org.apache.tools.ant.Project;

public class AlertObj implements  java.io.Serializable  {

	
	
	
	private String status; /// 1-timer paused, 2-timer working
//	private String interval_id; /// id of  interval
	private String alert_id; /// alert id
	private Long interval; /// interval in milliseconds
	private Date date_from; /// alert from/to inside interval
	private Date date_to;
	private Integer interval_repeat_n; /// repeat interval n times
	private String interval_repeat; /// repeat interval
	
	
	
	public Integer getInterval_repeat_n() {
		return interval_repeat_n;
	}
	public void setInterval_repeat_n(Integer interval_repeat_n) {
		this.interval_repeat_n = interval_repeat_n;
	}
	public String getInterval_repeat() {
		return interval_repeat;
	}
	public void setInterval_repeat(String interval_repeat) {
		this.interval_repeat = interval_repeat;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAlert_id() {
		return alert_id;
	}
	public void setAlert_id(String alert_id) {
		this.alert_id = alert_id;
	}
	public Long getInterval() {
		return interval;
	}
	public void setInterval(Long interval) {
		this.interval = interval;
	}
	public Date getDate_from() {
		return date_from;
	}
	public void setDate_from(Date date_from) {
		this.date_from = date_from;
	}
	public Date getDate_to() {
		return date_to;
	}
	public void setDate_to(Date date_to) {
		this.date_to = date_to;
	}
	
	
	
	

	
	
	
	
}
