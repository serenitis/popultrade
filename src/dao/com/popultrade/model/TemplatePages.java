package com.popultrade.model;

import javax.persistence.*;


import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;


@Entity
@Table (name="templatepages")

// pages made by hand only for users
public class TemplatePages extends BaseObject implements Serializable {
	
	private static final long serialVersionUID = 7144204887282670353L;
	private Long id;



	private String pagename; /// page name with extension


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
	

	
	

	
	@Column(name="pagename",length=70)

public String getPagename() {
		return pagename;
	}
	public void setPagename(String pagename) {
		this.pagename = pagename;
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
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((pagename == null) ? 0 : pagename.hashCode());
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
		TemplatePages other = (TemplatePages) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (pagename == null) {
			if (other.pagename != null)
				return false;
		} else if (!pagename.equals(other.pagename))
			return false;
		return true;
	}
	
	
	
	
	

}
