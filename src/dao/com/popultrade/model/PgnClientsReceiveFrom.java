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
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table (name="pgnclientsreceivefrom")

public class PgnClientsReceiveFrom extends BaseObject implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2128377345211999632L;
	private Long id;
	private Long id_pgnclients;
	
	
	private String title;
	private String sender_id;

	private String sender_enccode;

	private String archive_sent_file;

	private String status;
	private Date created;
	private Date updated;
	private String for_client;
	
	
	
	private List pgnClientsReceiveFromSrc = new ArrayList();
	
	
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
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.PgnClientsReceiveFromSrc.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclientsreceivefrom",referencedColumnName="id")
	

	
	public List getPgnClientsReceiveFromSrc() {
		return pgnClientsReceiveFromSrc;
	}
	public void setPgnClientsReceiveFromSrc(List pgnClientsReceiveFromSrc) {
		this.pgnClientsReceiveFromSrc = pgnClientsReceiveFromSrc;
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
	@Column(name="id_pgnclients",nullable=false)
	
	public Long getId_pgnclients() {
		return id_pgnclients;
	}
	public void setId_pgnclients(Long id_pgnclients) {
		this.id_pgnclients = id_pgnclients;
	}
	
	
	
	@Column(name="title",length=120,nullable=false)
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	

	
	
	@Column(name="archive_sent_file",length=1)
	public String getArchive_sent_file() {
		return archive_sent_file;
	}
	public void setArchive_sent_file(String archive_sent_file) {
		this.archive_sent_file = archive_sent_file;
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
	

	
	@Column(name="sender_id",length=35,nullable=false)
	public String getSender_id() {
		return sender_id;
	}
	public void setSender_id(String sender_id) {
		this.sender_id = sender_id;
	}
	
	@Column(name="sender_enccode",length=35,nullable=false)
	public String getSender_enccode() {
		return sender_enccode;
	}
	public void setSender_enccode(String sender_enccode) {
		this.sender_enccode = sender_enccode;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime
				* result
				+ ((archive_sent_file == null) ? 0 : archive_sent_file
						.hashCode());
		result = prime * result + ((created == null) ? 0 : created.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((id_pgnclients == null) ? 0 : id_pgnclients.hashCode());
		result = prime * result
				+ ((sender_enccode == null) ? 0 : sender_enccode.hashCode());
		result = prime * result
				+ ((sender_id == null) ? 0 : sender_id.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
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
		PgnClientsReceiveFrom other = (PgnClientsReceiveFrom) obj;
		if (archive_sent_file == null) {
			if (other.archive_sent_file != null)
				return false;
		} else if (!archive_sent_file.equals(other.archive_sent_file))
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
		if (id_pgnclients == null) {
			if (other.id_pgnclients != null)
				return false;
		} else if (!id_pgnclients.equals(other.id_pgnclients))
			return false;
		if (sender_enccode == null) {
			if (other.sender_enccode != null)
				return false;
		} else if (!sender_enccode.equals(other.sender_enccode))
			return false;
		if (sender_id == null) {
			if (other.sender_id != null)
				return false;
		} else if (!sender_id.equals(other.sender_id))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (updated == null) {
			if (other.updated != null)
				return false;
		} else if (!updated.equals(other.updated))
			return false;
		return true;
	}
	
	
	
	
	
	
	

}
