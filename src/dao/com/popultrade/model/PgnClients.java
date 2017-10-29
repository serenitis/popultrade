package com.popultrade.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Index;

@Entity
@Table (name="pgnClients")

public class PgnClients extends BaseObject implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2128377425211205632L;
	private Long id;
	private String client_name;
	private String client_id;
	private Integer client_port;
	private Integer receive_size_limit;
	private Integer resend_times;
	private Integer sequence;
	private Integer send_n_files_simu;
	private String comment;
	private String status;
	private Date created;
	private Date updated;
	
	private String client_url; // address url
	
	private List pgnClientsReceiveFrom = new ArrayList();
	private List pgnClientsSendFrom = new ArrayList();
	private List pgnlogs = new ArrayList();
	private List pgnproblemsolved = new ArrayList();
	private List pgnlogclients = new ArrayList();
	private List pgnclientsschedule = new ArrayList();
	private String client_cryptcode;
	
	private String client_json;
	
	private String server_url;
	private String client_alert_msg;
	
	private String username;
	private String user_desc;
	private String password;
	private String userid;
	
	// last log from to got from client
	private Date lastlogfrom;
	private Date lastlogto;
	
	private String err_from_client;
	private Integer err_num; // number of errors received from last check
	private Date first_err_date; // date of the first error, once the error has been resolved set to null
	
	private Date last_check; // date of the last check of the server
	private Date last_check_ok; // date of the last ok check of the server
	//private String last_error;
	
	
	private String client_check_error;
	private String accepted_ips;
	
	private Long id_user;
	
	
	
	/// client is calling the server to get files
	private String client_call_server;
	
	/// settings are changed, to inform client to download settings, only if client_call_server=1
	private String settings_changed;
	
	
	
	
	
	
	
	@Column(name="settings_changed",length=1)
	
	
	public String getSettings_changed() {
		return settings_changed;
	}
	public void setSettings_changed(String settings_changed) {
		this.settings_changed = settings_changed;
	}
	@Column(name="client_call_server",length=1)
	
	
	public String getClient_call_server() {
		return client_call_server;
	}
	public void setClient_call_server(String client_call_server) {
		this.client_call_server = client_call_server;
	}
	@Column(name="accepted_ips",length=450)
	
	
	public String getAccepted_ips() {
		return accepted_ips;
	}
	public void setAccepted_ips(String accepted_ips) {
		this.accepted_ips = accepted_ips;
	}
	@Column(name="id_user")
	
	
	public Long getId_user() {
		return id_user;
	}
	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}
	@Column(name="err_from_client")
	
	public String getErr_from_client() {
		return err_from_client;
	}
	public void setErr_from_client(String err_from_client) {
		this.err_from_client = err_from_client;
	}
	@Column(name="client_check_error")
	
	
	public String getClient_check_error() {
		return client_check_error;
	}
	public void setClient_check_error(String client_check_error) {
		this.client_check_error = client_check_error;
	}
	@Column(name="last_check_ok")
	
	public Date getLast_check_ok() {
		return last_check_ok;
	}
	public void setLast_check_ok(Date last_check_ok) {
		this.last_check_ok = last_check_ok;
	}
	
	
	
	
	
	
	
	
	@Column(name="err_num")
	
	public Integer getErr_num() {
		return err_num;
	}

	public void setErr_num(Integer err_num) {
		this.err_num = err_num;
	}
	
	@Column(name="first_err_date")
	public Date getFirst_err_date() {
		return first_err_date;
	}
	public void setFirst_err_date(Date first_err_date) {
		this.first_err_date = first_err_date;
	}
	
	
	
	
	
	
	
	@Column(name="last_check")
	public Date getLast_check() {
		return last_check;
	}
	public void setLast_check(Date last_check) {
		this.last_check = last_check;
	}
	
	
	
	@Column(name="lastlogfrom")
	public Date getLastlogfrom() {
		return lastlogfrom;
	}

	public void setLastlogfrom(Date lastlogfrom) {
		this.lastlogfrom = lastlogfrom;
	}
	
	@Column(name="lastlogto")
	public Date getLastlogto() {
		return lastlogto;
	}
	public void setLastlogto(Date lastlogto) {
		this.lastlogto = lastlogto;
	}
	
	@Column(name="username")
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	@Column(name="user_desc")
	public String getUser_desc() {
		return user_desc;
	}
	public void setUser_desc(String user_desc) {
		this.user_desc = user_desc;
	}
	
	@Column(name="password")
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Column(name="userid")
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	@Column(name="server_url")

	
	
	public String getServer_url() {
		return server_url;
	}
	public void setServer_url(String server_url) {
		this.server_url = server_url;
	}
	
	@Column(name="client_alert_msg")
	public String getClient_alert_msg() {
		return client_alert_msg;
	}
	public void setClient_alert_msg(String client_alert_msg) {
		this.client_alert_msg = client_alert_msg;
	}
	@Column(name="client_json")

	
	public String getClient_json() {
		return client_json;
	}
	public void setClient_json(String client_json) {
		this.client_json = client_json;
	}
	@Column(name="client_cryptcode",length=35)

	
	
	public String getClient_cryptcode() {
		return client_cryptcode;
	}
	public void setClient_cryptcode(String client_cryptcode) {
		this.client_cryptcode = client_cryptcode;
	}
	@Column(name="client_url",length=170,nullable=false)

	
	public String getClient_url() {
		return client_url;
	}
	public void setClient_url(String client_url) {
		this.client_url = client_url;
	}
	
	
	
	
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Pgnclientsschedule.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclients",referencedColumnName="id")
	
	
	
	public List getPgnclientsschedule() {
		return pgnclientsschedule;
	}
	public void setPgnclientsschedule(List pgnclientsschedule) {
		this.pgnclientsschedule = pgnclientsschedule;
	}
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.PgnLogClient.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclients",referencedColumnName="id")
	
	
	public List getPgnlogclients() {
		return pgnlogclients;
	}
	public void setPgnlogclients(List pgnlogclients) {
		this.pgnlogclients = pgnlogclients;
	}
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.PgnProblemSolved.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclients",referencedColumnName="id")
	
	
	
	
	public List getPgnproblemsolved() {
		return pgnproblemsolved;
	}
	public void setPgnproblemsolved(List pgnproblemsolved) {
		this.pgnproblemsolved = pgnproblemsolved;
	}

	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.PgnLog.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclients",referencedColumnName="id")
	
	
	public List getPgnlogs() {
		return pgnlogs;
	}
	public void setPgnlogs(List pgnlogs) {
		this.pgnlogs = pgnlogs;
	}
	
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.PgnClientsReceiveFrom.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclients",referencedColumnName="id")
	
	public List getPgnClientsReceiveFrom() {
		return pgnClientsReceiveFrom;
	}
	public void setPgnClientsReceiveFrom(List pgnClientsReceiveFrom) {
		this.pgnClientsReceiveFrom = pgnClientsReceiveFrom;
	}
	
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.PgnClientsSendFrom.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclients",referencedColumnName="id")
	public List getPgnClientsSendFrom() {
		return pgnClientsSendFrom;
	}

	public void setPgnClientsSendFrom(List pgnClientsSendFrom) {
		this.pgnClientsSendFrom = pgnClientsSendFrom;
	}
	
	
	
	
	@Id
	@Column(name="id")
	@SequenceGenerator(name="popultrade_seq",allocationSize=1, sequenceName="popultrade_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="popultrade_seq")

	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	
	@Column(name="client_name",length=70,nullable=false)

	public String getClient_name() {
		return client_name;
	}
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
	
	
	@Index(name="client_id")
	@Column(name="client_id",length=35,nullable=false)

	public String getClient_id() {
		return client_id;
	}
	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}
	
	
	@Column(name="client_port")
	
	public Integer getClient_port() {
		return client_port;
	}
	public void setClient_port(Integer client_port) {
		this.client_port = client_port;
	}
	
	@Column(name="receive_size_limit")
	public Integer getReceive_size_limit() {
		return receive_size_limit;
	}
	public void setReceive_size_limit(Integer receive_size_limit) {
		this.receive_size_limit = receive_size_limit;
	}
	
	@Column(name="resend_times")
	public Integer getResend_times() {
		return resend_times;
	}
	public void setResend_times(Integer resend_times) {
		this.resend_times = resend_times;
	}
	
	

	@Column(name="sequence_")
	public Integer getSequence() {
		return sequence;
	}
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}
	
	@Column(name="send_n_files_simu")
	public Integer getSend_n_files_simu() {
		return send_n_files_simu;
	}
	public void setSend_n_files_simu(Integer send_n_files_simu) {
		this.send_n_files_simu = send_n_files_simu;
	}
	
	@Column(name="comment_",length=1000)

	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
	@Column(name="status",length=1)

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	@Column(name="created")
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	
	
	@Column(name="updated")
	public Date getUpdated() {
		return updated;
	}
	public void setUpdated(Date updated) {
		this.updated = updated;
	}
	
	
	
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((client_id == null) ? 0 : client_id.hashCode());
		result = prime * result
				+ ((client_name == null) ? 0 : client_name.hashCode());
		result = prime * result
				+ ((client_port == null) ? 0 : client_port.hashCode());
		result = prime * result + ((comment == null) ? 0 : comment.hashCode());
		result = prime * result + ((created == null) ? 0 : created.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				* result
				+ ((receive_size_limit == null) ? 0 : receive_size_limit
						.hashCode());
		result = prime * result
				+ ((resend_times == null) ? 0 : resend_times.hashCode());
		result = prime
				* result
				+ ((send_n_files_simu == null) ? 0 : send_n_files_simu
						.hashCode());
		result = prime * result
				+ ((sequence == null) ? 0 : sequence.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((updated == null) ? 0 : updated.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PgnClients other = (PgnClients) obj;
		if (client_id == null) {
			if (other.client_id != null)
				return false;
		} else if (!client_id.equals(other.client_id))
			return false;
		if (client_name == null) {
			if (other.client_name != null)
				return false;
		} else if (!client_name.equals(other.client_name))
			return false;
		if (client_port == null) {
			if (other.client_port != null)
				return false;
		} else if (!client_port.equals(other.client_port))
			return false;
		if (comment == null) {
			if (other.comment != null)
				return false;
		} else if (!comment.equals(other.comment))
			return false;
		if (created == null) {
			if (other.created != null)
				return false;
		} else if (!created.equals(other.created))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (receive_size_limit == null) {
			if (other.receive_size_limit != null)
				return false;
		} else if (!receive_size_limit.equals(other.receive_size_limit))
			return false;
		if (resend_times == null) {
			if (other.resend_times != null)
				return false;
		} else if (!resend_times.equals(other.resend_times))
			return false;
		if (send_n_files_simu == null) {
			if (other.send_n_files_simu != null)
				return false;
		} else if (!send_n_files_simu.equals(other.send_n_files_simu))
			return false;
		if (sequence == null) {
			if (other.sequence != null)
				return false;
		} else if (!sequence.equals(other.sequence))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (updated == null) {
			if (other.updated != null)
				return false;
		} else if (!updated.equals(other.updated))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	

}
