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
@Table (name="pgnclientsreceivefromsrc")

public class PgnClientsReceiveFromSrc extends BaseObject implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2128377345182679632L;
	private Long id;
	private Long id_pgnclientsreceivefrom;
	
	
	private String msg_type;
	private String msg_class;

	private String save_file_to;

	private String file_extension;

	private String relative_dir;
	private Date created;
	private Date updated;
	
	private Long id_user;
	
	
	
	
	@Column(name="id_user")
	
	
	public Long getId_user() {
		return id_user;
	}
	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}
	
	private String for_client; //for client settings
	
	@Column(name="for_client",length=1)
	
	public String getFor_client() {
		return for_client;
	}
	public void setFor_client(String for_client) {
		this.for_client = for_client;
	}
	
	
	
	
	private PgnClientsReceiveFrom pgnClientsReceiveFrom;
	
	@OneToOne
    @JoinColumn(name = "id_pgnclientsreceivefrom",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	

	public PgnClientsReceiveFrom getPgnClientsReceiveFrom() {
		return pgnClientsReceiveFrom;
	}

	public void setPgnClientsReceiveFrom(PgnClientsReceiveFrom pgnClientsReceiveFrom) {
		this.pgnClientsReceiveFrom = pgnClientsReceiveFrom;
	}
	
	
	
	
	/**
     * 
     * @hibernate.id column="id"
     *   generator-class="sequence"  
     * @hibernate.generator-param
     * name="sequence"
     * value="popultrade_seq"
     */
	
	
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
	
	
	
	
	
	@Index(name="id_pgnclientsreceivefrom")
	@Column(name="id_pgnclientsreceivefrom",nullable=false)

	
	public Long getId_pgnclientsreceivefrom() {
		return id_pgnclientsreceivefrom;
	}

	public void setId_pgnclientsreceivefrom(Long id_pgnclientsreceivefrom) {
		this.id_pgnclientsreceivefrom = id_pgnclientsreceivefrom;
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
	
	
	@Column(name="save_file_to",length=120,nullable=false)
	public String getSave_file_to() {
		return save_file_to;
	}
	public void setSave_file_to(String save_file_to) {
		this.save_file_to = save_file_to;
	}
	
	@Column(name="file_extension",length=10)
	public String getFile_extension() {
		return file_extension;
	}
	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}
	
	
	@Column(name="relative_dir",length=1)
	public String getRelative_dir() {
		return relative_dir;
	}
	public void setRelative_dir(String relative_dir) {
		this.relative_dir = relative_dir;
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
		result = prime * result + ((created == null) ? 0 : created.hashCode());
		result = prime * result
				+ ((file_extension == null) ? 0 : file_extension.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				* result
				+ ((id_pgnclientsreceivefrom == null) ? 0 : id_pgnclientsreceivefrom
						.hashCode());
		result = prime * result
				+ ((msg_class == null) ? 0 : msg_class.hashCode());
		result = prime * result
				+ ((msg_type == null) ? 0 : msg_type.hashCode());
		result = prime * result
				+ ((relative_dir == null) ? 0 : relative_dir.hashCode());
		result = prime * result
				+ ((save_file_to == null) ? 0 : save_file_to.hashCode());
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
		PgnClientsReceiveFromSrc other = (PgnClientsReceiveFromSrc) obj;
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
		if (relative_dir == null) {
			if (other.relative_dir != null)
				return false;
		} else if (!relative_dir.equals(other.relative_dir))
			return false;
		if (save_file_to == null) {
			if (other.save_file_to != null)
				return false;
		} else if (!save_file_to.equals(other.save_file_to))
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
