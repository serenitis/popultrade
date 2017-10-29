package com.popultrade.webapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;

public class PgnClientsc {

	private Long id;
	private String client_name;
	private String client_id;
	private Integer client_port;
	private Integer receive_size_limit;
	private Integer resend_times;

	private Integer sequence;


	private String status;
	
	
	private List<Pgnclientsreceivefromc> pgnclientsreceivefromc = new ArrayList<Pgnclientsreceivefromc>();
	
	
	private List<Pgnclientssendfromc> pgnclientssendfromc = new ArrayList<Pgnclientssendfromc>();
	
	
	private List<Pgnclientsschedule> pgnclientsschedule = new ArrayList<Pgnclientsschedule>();
	
	
	
	
	private String client_cryptcode;
	
	
	private Integer err_num; // number of errors received from last check
	private Date first_err_date; // date of the first error, once the error has been resolved set to null
	
	private Date last_check; // date of the last check of the server
	
	
	private Date last_check_ok; // date of the last ok check
	
	
	
	private String client_check_error; // if error during client check
	
	
	private String err_from_client;
	
	
	private Long id_user;
	
	
	private String accepted_ips;
	
	
	/// client is calling the server to get files
	private String client_call_server;

	
	private String settings_changed;

	public String getSettings_changed() {
		return settings_changed;
	}
	public void setSettings_changed(String settings_changed) {
		this.settings_changed = settings_changed;
	}
	
	
	public String getClient_call_server() {
		return client_call_server;
	}
	public void setClient_call_server(String client_call_server) {
		this.client_call_server = client_call_server;
	}

	
	public String getAccepted_ips() {
		return accepted_ips;
	}
	public void setAccepted_ips(String accepted_ips) {
		this.accepted_ips = accepted_ips;
	
	}
	
	public Long getId_user() {
		return id_user;
	}

	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}

	public String getErr_from_client() {
		return err_from_client;
	}

	public void setErr_from_client(String err_from_client) {
		this.err_from_client = err_from_client;
	}

	public String getClient_check_error() {
		return client_check_error;
	}

	public void setClient_check_error(String client_check_error) {
		this.client_check_error = client_check_error;
	}

	public Date getLast_check_ok() {
		return last_check_ok;
	}

	public void setLast_check_ok(Date last_check_ok) {
		this.last_check_ok = last_check_ok;
	}

	public Integer getErr_num() {
		return err_num;
	}

	public void setErr_num(Integer err_num) {
		this.err_num = err_num;
	}

	public Date getFirst_err_date() {
		return first_err_date;
	}

	public void setFirst_err_date(Date first_err_date) {
		this.first_err_date = first_err_date;
	}

	public Date getLast_check() {
		return last_check;
	}

	public void setLast_check(Date last_check) {
		this.last_check = last_check;
	}

	public String getClient_cryptcode() {
		return client_cryptcode;
	}

	public void setClient_cryptcode(String client_cryptcode) {
		this.client_cryptcode = client_cryptcode;
	}

	public Integer getResend_times() {
		
		
		return resend_times;
	}

	public void setResend_times(Integer resend_times) {
		this.resend_times = resend_times;
	}

	public List<Pgnclientsreceivefromc> getPgnclientsreceivefromc() {
		return pgnclientsreceivefromc;
	}

	public void setPgnclientsreceivefromc(
			List<Pgnclientsreceivefromc> pgnclientsreceivefromc) {
		this.pgnclientsreceivefromc = pgnclientsreceivefromc;
	}
	
	
	
	
	
	
	

	public List<Pgnclientssendfromc> getPgnclientssendfromc() {
		return pgnclientssendfromc;
	}

	public void setPgnclientssendfromc(List<Pgnclientssendfromc> pgnclientssendfromc) {
		this.pgnclientssendfromc = pgnclientssendfromc;
	}








	public List<Pgnclientsschedule> getPgnclientsschedule() {
		return pgnclientsschedule;
	}

	public void setPgnclientsschedule(List<Pgnclientsschedule> pgnclientsschedule) {
		this.pgnclientsschedule = pgnclientsschedule;
	}








	private String client_url; // address url

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getClient_name() {
		return client_name;
	}

	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}

	public String getClient_id() {
		return client_id;
	}

	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}

	public Integer getClient_port() {
		return client_port;
	}

	public void setClient_port(Integer client_port) {
		this.client_port = client_port;
	}

	public Integer getReceive_size_limit() {
		return receive_size_limit;
	}

	public void setReceive_size_limit(Integer receive_size_limit) {
		this.receive_size_limit = receive_size_limit;
	}



	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}




	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}



	public String getClient_url() {
		return client_url;
	}

	public void setClient_url(String client_url) {
		this.client_url = client_url;
	}
	
	
	
	
	
	
	
	
	
	

}
