package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import java.io.Serializable;


@Entity
@Table (name="usersparametri")


public class UsersParametri extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = -9086999786110266786L;
	private Long id;
	private Long users_id;
	private String parameter; /// ime parametra iz baze
	private String parameter_value;/// value parametra
	
	
	/**
	 * 
	 * @hibernate.id 
	 * name="id"
	 */
	
	@Id
	@Column(name="id")
	@SequenceGenerator(name="template_seq",allocationSize=1, sequenceName="template_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="template_seq")
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name="users_id")
	public Long getUsers_id() {
		return users_id;
	}
	public void setUsers_id(Long users_id) {
		this.users_id = users_id;
	}
	
	@Column(name="parameter",length=35)
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
	
	@Column(name="parameter_value",length=70)
	public String getParameter_value() {
		return parameter_value;
	}
	public void setParameter_value(String parameter_value) {
		this.parameter_value = parameter_value;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((parameter == null) ? 0 : parameter.hashCode());
		result = prime * result
				+ ((parameter_value == null) ? 0 : parameter_value.hashCode());
		result = prime * result
				+ ((users_id == null) ? 0 : users_id.hashCode());
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
		UsersParametri other = (UsersParametri) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (parameter == null) {
			if (other.parameter != null)
				return false;
		} else if (!parameter.equals(other.parameter))
			return false;
		if (parameter_value == null) {
			if (other.parameter_value != null)
				return false;
		} else if (!parameter_value.equals(other.parameter_value))
			return false;
		if (users_id == null) {
			if (other.users_id != null)
				return false;
		} else if (!users_id.equals(other.users_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
