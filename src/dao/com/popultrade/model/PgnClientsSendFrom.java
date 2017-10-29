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
@Table (name="pgnclientssendfrom")

public class PgnClientsSendFrom extends BaseObject implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2128377345211205632L;
	private Long id;
	private Long id_pgnclients;
	
	
	private String title;
	private String receiver_client;
	private String receiver_end;
	private String receiver_url;
	private String receiver_enccode;
	private Integer sequence;
	private String archive_sent_file;

	private String status;
	private Date created;
	private Date updated;
	private List pgnClientsSendFromSrc = new ArrayList();
	
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
	
	
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.PgnClientsSendFromSrc.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_pgnclientssendfrom",referencedColumnName="id")
	
	public List getPgnClientsSendFromSrc() {
		return pgnClientsSendFromSrc;
	}
	public void setPgnClientsSendFromSrc(List pgnClientsSendFromSrc) {
		this.pgnClientsSendFromSrc = pgnClientsSendFromSrc;
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
	
	
	
	
	@Column(name="receiver_client",length=70,nullable=false)
	public String getReceiver_client() {
		return receiver_client;
	}
	public void setReceiver_client(String receiver_client) {
		this.receiver_client = receiver_client;
	}
	
	@Column(name="receiver_end",length=70)
	public String getReceiver_end() {
		return receiver_end;
	}
	public void setReceiver_end(String receiver_end) {
		this.receiver_end = receiver_end;
	}
	
	
	@Column(name="receiver_url",length=100,nullable=false)
	public String getReceiver_url() {
		return receiver_url;
	}
	public void setReceiver_url(String receiver_url) {
		this.receiver_url = receiver_url;
	}
	
	@Column(name="receiver_enccode",length=35,nullable=false)
	public String getReceiver_enccode() {
		return receiver_enccode;
	}
	public void setReceiver_enccode(String receiver_enccode) {
		this.receiver_enccode = receiver_enccode;
	}
	
	@Column(name="sequence_")
	public Integer getSequence() {
		return sequence;
	}
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
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
				+ ((receiver_client == null) ? 0 : receiver_client.hashCode());
		result = prime
				* result
				+ ((receiver_enccode == null) ? 0 : receiver_enccode.hashCode());
		result = prime * result
				+ ((receiver_end == null) ? 0 : receiver_end.hashCode());
		result = prime * result
				+ ((receiver_url == null) ? 0 : receiver_url.hashCode());
		result = prime * result
				+ ((sequence == null) ? 0 : sequence.hashCode());
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
		PgnClientsSendFrom other = (PgnClientsSendFrom) obj;
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
		if (receiver_client == null) {
			if (other.receiver_client != null)
				return false;
		} else if (!receiver_client.equals(other.receiver_client))
			return false;
		if (receiver_enccode == null) {
			if (other.receiver_enccode != null)
				return false;
		} else if (!receiver_enccode.equals(other.receiver_enccode))
			return false;
		if (receiver_end == null) {
			if (other.receiver_end != null)
				return false;
		} else if (!receiver_end.equals(other.receiver_end))
			return false;
		if (receiver_url == null) {
			if (other.receiver_url != null)
				return false;
		} else if (!receiver_url.equals(other.receiver_url))
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
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	

}
