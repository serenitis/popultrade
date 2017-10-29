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

import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table (name="pgnclientssendfromsrc")

public class PgnClientsSendFromSrc extends BaseObject implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1908377345211222632L;
	private Long id;
	private Long id_pgnclientssendfrom;
	
	
	private String msg_type;
	private String msg_class;
	
	private String subject;
	private String send_file_from_dir;
	private String option;
	private Integer sequence;
	private String file_extension;
	private String relative_dir;
	private String movefrom_dir;
	

	private Date created;
	private Date updated;
	private String for_client; //for client settings
	private Long id_user;
	
	
	
	
	@Column(name="id_user")
	
	
	public Long getId_user() {
		return id_user;
	}
	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}
	@Column(name="for_client",length=1)
	
	public String getFor_client() {
		return for_client;
	}
	public void setFor_client(String for_client) {
		this.for_client = for_client;
	}
	
	private PgnClientsSendFrom pgnClientsSendFrom;
	
	@OneToOne
    @JoinColumn(name = "id_pgnclientssendfrom",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	
	public PgnClientsSendFrom getPgnClientsSendFrom() {
		return pgnClientsSendFrom;
	}

	public void setPgnClientsSendFrom(PgnClientsSendFrom pgnClientsSendFrom) {
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
	
	
	
	@Index(name="id_pgnclientssendfrom")
	@Column(name="id_pgnclientssendfrom",nullable=false)
	

	
	
	public Long getId_pgnclientssendfrom() {
		return id_pgnclientssendfrom;
	}
	public void setId_pgnclientssendfrom(Long id_pgnclientssendfrom) {
		this.id_pgnclientssendfrom = id_pgnclientssendfrom;
	}
	
	
	
	@Column(name="msg_type",length=10,nullable=false)
	public String getMsg_type() {
		return msg_type;
	}
	public void setMsg_type(String msg_type) {
		this.msg_type = msg_type;
	}
	
	@Column(name="msg_class",length=10,nullable=false)
	public String getMsg_class() {
		return msg_class;
	}
	public void setMsg_class(String msg_class) {
		this.msg_class = msg_class;
	}
	
	
	
	
	
	@Column(name="sequence_")
	public Integer getSequence() {
		return sequence;
	}
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
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
	
	
	
	@Column(name="relative_dir",length=1)
	public String getRelative_dir() {
		return relative_dir;
	}
	public void setRelative_dir(String relative_dir) {
		this.relative_dir = relative_dir;
	}
	
	
	
	
	@Column(name="subject",length=150)
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	
	@Column(name="send_file_from_dir",length=120)
	public String getSend_file_from_dir() {
		return send_file_from_dir;
	}
	public void setSend_file_from_dir(String send_file_from_dir) {
		this.send_file_from_dir = send_file_from_dir;
	}
	
	
	
	
	
	@Column(name="option_",length=10)
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	
	@Column(name="file_extension",length=10)
	public String getFile_extension() {
		return file_extension;
	}
	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}
	
	
	@Column(name="movefrom_dir",length=1)
	public String getMovefrom_dir() {
		return movefrom_dir;
	}
	public void setMovefrom_dir(String movefrom_dir) {
		this.movefrom_dir = movefrom_dir;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((created == null) ? 0 : created.hashCode());
		result = prime * result
				+ ((file_extension == null) ? 0 : file_extension.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				* result
				+ ((id_pgnclientssendfrom == null) ? 0 : id_pgnclientssendfrom
						.hashCode());
		result = prime * result
				+ ((movefrom_dir == null) ? 0 : movefrom_dir.hashCode());
		result = prime * result
				+ ((msg_class == null) ? 0 : msg_class.hashCode());
		result = prime * result
				+ ((msg_type == null) ? 0 : msg_type.hashCode());
		result = prime * result + ((option == null) ? 0 : option.hashCode());
		result = prime * result
				+ ((relative_dir == null) ? 0 : relative_dir.hashCode());
		result = prime
				* result
				+ ((send_file_from_dir == null) ? 0 : send_file_from_dir
						.hashCode());
		result = prime * result
				+ ((sequence == null) ? 0 : sequence.hashCode());
		result = prime * result + ((subject == null) ? 0 : subject.hashCode());
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
		PgnClientsSendFromSrc other = (PgnClientsSendFromSrc) obj;
		if (created == null) {
			if (other.created != null)
				return false;
		} else if (!created.equals(other.created))
			return false;
		if (file_extension == null) {
			if (other.file_extension != null)
				return false;
		} else if (!file_extension.equals(other.file_extension))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (id_pgnclientssendfrom == null) {
			if (other.id_pgnclientssendfrom != null)
				return false;
		} else if (!id_pgnclientssendfrom.equals(other.id_pgnclientssendfrom))
			return false;
		if (movefrom_dir == null) {
			if (other.movefrom_dir != null)
				return false;
		} else if (!movefrom_dir.equals(other.movefrom_dir))
			return false;
		if (msg_class == null) {
			if (other.msg_class != null)
				return false;
		} else if (!msg_class.equals(other.msg_class))
			return false;
		if (msg_type == null) {
			if (other.msg_type != null)
				return false;
		} else if (!msg_type.equals(other.msg_type))
			return false;
		if (option == null) {
			if (other.option != null)
				return false;
		} else if (!option.equals(other.option))
			return false;
		if (relative_dir == null) {
			if (other.relative_dir != null)
				return false;
		} else if (!relative_dir.equals(other.relative_dir))
			return false;
		if (send_file_from_dir == null) {
			if (other.send_file_from_dir != null)
				return false;
		} else if (!send_file_from_dir.equals(other.send_file_from_dir))
			return false;
		if (sequence == null) {
			if (other.sequence != null)
				return false;
		} else if (!sequence.equals(other.sequence))
			return false;
		if (subject == null) {
			if (other.subject != null)
				return false;
		} else if (!subject.equals(other.subject))
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
