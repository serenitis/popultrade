package com.popultrade.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table (name="pgnlog")

public class PgnLog extends BaseObject implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 5408383211211222631L;
	private Long id;
	private Long id_pgnclients;
	//private Long id_pgnclients;
	
	private Date log_date;
	private String sender;
	private String sender_id;
	private String msg_id;
	private String orig_filename;
	private String msg_class;
	private String msg_type;
	private String msg_subject;
	private String msg_receiver_end;
	private String msg_receiver;
	private String msg_options;
	
	private String type;
	private String dir;
	private String status;
	private String message;
	private String phase;
	private String file_orig; // if resend file name original
	private String archived;
	private String refer;
	private String msg_destination;
	private String client_log_id;
	
	private Date log_date1;
	private Date log_date2;

	
	private String servlet_todo; // what to do in the servlet, if log is send by servlet
	
	private String username;
	private Long id_user;
	@Column(name="username", length=15)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	@Column(name="id_user")
	public Long getId_user() {
		return id_user;
	}

	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}

	@Transient
	public String getServlet_todo() {
		return servlet_todo;
	}

	public void setServlet_todo(String servlet_todo) {
		this.servlet_todo = servlet_todo;
	}

	@Transient
	public Date getLog_date1() {
		return log_date1;
	}

	public void setLog_date1(Date log_date1) {
		this.log_date1 = log_date1;
	}
	@Transient
	public Date getLog_date2() {
		return log_date2;
	}

	public void setLog_date2(Date log_date2) {
		this.log_date2 = log_date2;
	}
	
	private PgnClients pgnClients;
	
	@OneToOne
    @JoinColumn(name = "id_pgnclients",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)

	public PgnClients getPgnClients() {
		return pgnClients;
	}

	public void setPgnClients(PgnClients pgnClients) {
		this.pgnClients = pgnClients;
	}

	
	
	
	

	//private Date created;
	//private Date updated;
	


	@Column(name="client_log_id", length=36)
	
	public String getClient_log_id() {
		return client_log_id;
	}

	public void setClient_log_id(String client_log_id) {
		this.client_log_id = client_log_id;
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
	
	
	@Index(name="id_pgnclients")
	@Column(name="id_pgnclients",nullable=true)
	

	public Long getId_pgnclients() {
		return id_pgnclients;
	}
	public void setId_pgnclients(Long id_pgnclients) {
		this.id_pgnclients = id_pgnclients;
	}
	
	

	@Column(name="log_date",nullable=false)
	

	public Date getLog_date() {
		return log_date;
	}
	public void setLog_date(Date log_date) {
		this.log_date = log_date;
	}
	
	
	
	
	
	@Index(name="sender_idindex")
	@Column(name="sender_id")
	
	
	public String getSender_id() {
		return sender_id;
	}
	public void setSender_id(String sender_id) {
		this.sender_id = sender_id;
	}
	@Column(name="msg_options")
	
	
	
	public String getMsg_options() {
		return msg_options;
	}
	public void setMsg_options(String msg_options) {
		this.msg_options = msg_options;
	}
	@Column(name="sender",length=70)
	
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	

	
	@Column(name="msg_id",length=18)
	
	public String getMsg_id() {
		return msg_id;
	}
	public void setMsg_id(String msg_id) {
		this.msg_id = msg_id;
	}
	
	@Column(name="orig_filename",length=120)
	
	public String getOrig_filename() {
		return orig_filename;
	}
	public void setOrig_filename(String orig_filename) {
		this.orig_filename = orig_filename;
	}
	
	@Column(name="msg_class",length=10)
	
	public String getMsg_class() {
		return msg_class;
	}
	public void setMsg_class(String msg_class) {
		this.msg_class = msg_class;
	}
	
	@Column(name="msg_type",length=10)
	
	public String getMsg_type() {
		return msg_type;
	}
	public void setMsg_type(String msg_type) {
		this.msg_type = msg_type;
	}
	
	@Column(name="msg_subject",length=150)
	
	public String getMsg_subject() {
		return msg_subject;
	}
	public void setMsg_subject(String msg_subject) {
		this.msg_subject = msg_subject;
	}
	
	@Column(name="msg_receiver_end",length=70)
	
	public String getMsg_receiver_end() {
		return msg_receiver_end;
	}
	public void setMsg_receiver_end(String msg_receiver_end) {
		this.msg_receiver_end = msg_receiver_end;
	}
	
	@Column(name="msg_receiver",length=70)
	
	public String getMsg_receiver() {
		return msg_receiver;
	}
	public void setMsg_receiver(String msg_receiver) {
		this.msg_receiver = msg_receiver;
	}
	
	@Column(name="type_",length=2)
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	@Column(name="dir",length=120)
	
	public String getDir() {
		return dir;
	}
	public void setDir(String dir) {
		this.dir = dir;
	}
	
	@Column(name="status",length=10)
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Column(name="message",length=500)
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	@Column(name="phase",length=3)
	
	public String getPhase() {
		return phase;
	}
	public void setPhase(String phase) {
		this.phase = phase;
	}
	
	@Column(name="file_orig",length=180)
	
	public String getFile_orig() {
		return file_orig;
	}
	public void setFile_orig(String file_orig) {
		this.file_orig = file_orig;
	}
	
	@Column(name="archived",length=180)
	
	public String getArchived() {
		return archived;
	}
	public void setArchived(String archived) {
		this.archived = archived;
	}
	
	@Column(name="refer",length=70)
	
	public String getRefer() {
		return refer;
	}
	public void setRefer(String refer) {
		this.refer = refer;
	}
	
	@Column(name="msg_destination",length=120)
	
	public String getMsg_destination() {
		return msg_destination;
	}
	public void setMsg_destination(String msg_destination) {
		this.msg_destination = msg_destination;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((archived == null) ? 0 : archived.hashCode());
		result = prime * result + ((dir == null) ? 0 : dir.hashCode());
		result = prime * result
				+ ((file_orig == null) ? 0 : file_orig.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((id_pgnclients == null) ? 0 : id_pgnclients.hashCode());
		result = prime * result
				+ ((log_date == null) ? 0 : log_date.hashCode());
		result = prime * result + ((message == null) ? 0 : message.hashCode());
		result = prime * result
				+ ((msg_class == null) ? 0 : msg_class.hashCode());
		result = prime * result
				+ ((msg_destination == null) ? 0 : msg_destination.hashCode());
		result = prime * result + ((msg_id == null) ? 0 : msg_id.hashCode());
		result = prime * result
				+ ((msg_receiver == null) ? 0 : msg_receiver.hashCode());
		result = prime
				* result
				+ ((msg_receiver_end == null) ? 0 : msg_receiver_end.hashCode());
		result = prime * result
				+ ((msg_subject == null) ? 0 : msg_subject.hashCode());
		result = prime * result
				+ ((msg_type == null) ? 0 : msg_type.hashCode());
		result = prime * result
				+ ((orig_filename == null) ? 0 : orig_filename.hashCode());

		result = prime * result + ((phase == null) ? 0 : phase.hashCode());
		result = prime * result + ((refer == null) ? 0 : refer.hashCode());
		result = prime * result + ((sender == null) ? 0 : sender.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		PgnLog other = (PgnLog) obj;
		if (archived == null) {
			if (other.archived != null)
				return false;
		} else if (!archived.equals(other.archived))
			return false;
		if (dir == null) {
			if (other.dir != null)
				return false;
		} else if (!dir.equals(other.dir))
			return false;
		if (file_orig == null) {
			if (other.file_orig != null)
				return false;
		} else if (!file_orig.equals(other.file_orig))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (id_pgnclients == null) {
			if (other.id_pgnclients != null)
				return false;
		} else if (!id_pgnclients.equals(other.id_pgnclients))
			return false;
		if (log_date == null) {
			if (other.log_date != null)
				return false;
		} else if (!log_date.equals(other.log_date))
			return false;
		if (message == null) {
			if (other.message != null)
				return false;
		} else if (!message.equals(other.message))
			return false;
		if (msg_class == null) {
			if (other.msg_class != null)
				return false;
		} else if (!msg_class.equals(other.msg_class))
			return false;
		if (msg_destination == null) {
			if (other.msg_destination != null)
				return false;
		} else if (!msg_destination.equals(other.msg_destination))
			return false;
		if (msg_id == null) {
			if (other.msg_id != null)
				return false;
		} else if (!msg_id.equals(other.msg_id))
			return false;
		if (msg_receiver == null) {
			if (other.msg_receiver != null)
				return false;
		} else if (!msg_receiver.equals(other.msg_receiver))
			return false;
		if (msg_receiver_end == null) {
			if (other.msg_receiver_end != null)
				return false;
		} else if (!msg_receiver_end.equals(other.msg_receiver_end))
			return false;
		if (msg_subject == null) {
			if (other.msg_subject != null)
				return false;
		} else if (!msg_subject.equals(other.msg_subject))
			return false;
		if (msg_type == null) {
			if (other.msg_type != null)
				return false;
		} else if (!msg_type.equals(other.msg_type))
			return false;
		if (orig_filename == null) {
			if (other.orig_filename != null)
				return false;
		} else if (!orig_filename.equals(other.orig_filename))
			return false;

		if (phase == null) {
			if (other.phase != null)
				return false;
		} else if (!phase.equals(other.phase))
			return false;
		if (refer == null) {
			if (other.refer != null)
				return false;
		} else if (!refer.equals(other.refer))
			return false;
		if (sender == null) {
			if (other.sender != null)
				return false;
		} else if (!sender.equals(other.sender))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	


	
	
	
	
	
	
	
	
	
	

}
