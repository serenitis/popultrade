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
@Table (name="pgnproblemsolved")

public class PgnProblemSolved extends BaseObject implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2128377918211999632L;
	private Long id;
	private Long id_pgnclients;
	
	
	private String problem_desc;
	private String problem_phase;

	private String solution;

	private Date solved_date;

	private String status;
	private Date created;
	private Date updated;
	
	private String msg_class;
	private String msg_type;
	
	
	
	private PgnClients pgnClients;
	
/// problem solved by
	private Long id_user;
	private String username;
	
	
	
	
	
	
	
	
	
	
	
	@Column(name="id_user")
	public Long getId_user() {
		return id_user;
	}
	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}
	
	@Column(name="username",length=15)
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	
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
	

	
	
	
	
	
	
	@Column(name="problem_desc",length=450)
	public String getProblem_desc() {
		return problem_desc;
	}
	public void setProblem_desc(String problem_desc) {
		this.problem_desc = problem_desc;
	}
	
	@Column(name="problem_phase",length=3)
	public String getProblem_phase() {
		return problem_phase;
	}
	public void setProblem_phase(String problem_phase) {
		this.problem_phase = problem_phase;
	}
	
	@Column(name="solution",length=1000)
	public String getSolution() {
		return solution;
	}
	public void setSolution(String solution) {
		this.solution = solution;
	}
	
	
	@Column(name="solved_date")
	public Date getSolved_date() {
		return solved_date;
	}
	public void setSolved_date(Date solved_date) {
		this.solved_date = solved_date;
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
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((created == null) ? 0 : created.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((id_pgnclients == null) ? 0 : id_pgnclients.hashCode());
		result = prime * result
				+ ((msg_class == null) ? 0 : msg_class.hashCode());
		result = prime * result
				+ ((msg_type == null) ? 0 : msg_type.hashCode());
		result = prime * result
				+ ((pgnClients == null) ? 0 : pgnClients.hashCode());
		result = prime * result
				+ ((problem_desc == null) ? 0 : problem_desc.hashCode());
		result = prime * result
				+ ((problem_phase == null) ? 0 : problem_phase.hashCode());
		result = prime * result
				+ ((solution == null) ? 0 : solution.hashCode());
		result = prime * result
				+ ((solved_date == null) ? 0 : solved_date.hashCode());
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
		PgnProblemSolved other = (PgnProblemSolved) obj;
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
		if (pgnClients == null) {
			if (other.pgnClients != null)
				return false;
		} else if (!pgnClients.equals(other.pgnClients))
			return false;
		if (problem_desc == null) {
			if (other.problem_desc != null)
				return false;
		} else if (!problem_desc.equals(other.problem_desc))
			return false;
		if (problem_phase == null) {
			if (other.problem_phase != null)
				return false;
		} else if (!problem_phase.equals(other.problem_phase))
			return false;
		if (solution == null) {
			if (other.solution != null)
				return false;
		} else if (!solution.equals(other.solution))
			return false;
		if (solved_date == null) {
			if (other.solved_date != null)
				return false;
		} else if (!solved_date.equals(other.solved_date))
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

	
	
	
	
	

}
