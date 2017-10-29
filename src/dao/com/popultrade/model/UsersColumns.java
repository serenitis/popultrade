package com.popultrade.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.*;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;


@Entity
@Table (name="userscolumns")


public class UsersColumns  extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = -5203729634661802713L;
	private Long id;
	private Long user_id;
	private String page_list; /// page ki je narejen za listat
	private String stolpci; /// nastavitve z zaporedjem stolpcev in sirine
	
	
	
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
	
@Column(name="user_id")

	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long userId) {
		user_id = userId;
	}
	
	
@Column(name="page_list",length=55)

	public String getPage_list() {
		return page_list;
	}
	public void setPage_list(String pageList) {
		page_list = pageList;
	}
	
	
@Column(name="stolpci",length=450)

	public String getStolpci() {
		return stolpci;
	}
	public void setStolpci(String stolpci) {
		this.stolpci = stolpci;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((page_list == null) ? 0 : page_list.hashCode());
		result = prime * result + ((stolpci == null) ? 0 : stolpci.hashCode());
		result = prime * result + ((user_id == null) ? 0 : user_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		UsersColumns other = (UsersColumns) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (page_list == null) {
			if (other.page_list != null)
				return false;
		} else if (!page_list.equals(other.page_list))
			return false;
		if (stolpci == null) {
			if (other.stolpci != null)
				return false;
		} else if (!stolpci.equals(other.stolpci))
			return false;
		if (user_id == null) {
			if (other.user_id != null)
				return false;
		} else if (!user_id.equals(other.user_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
}
