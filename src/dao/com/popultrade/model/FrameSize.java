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
@Table (name="framesize")


public class FrameSize extends BaseObject implements Serializable {
	
	private static final long serialVersionUID = 917442994386412645L;
	private Long id;
	private String username;
	private String jsp_page_name; /// ime jsp strani
	private Integer frame1;
	private Integer frame2;
	private Integer frame3;

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
	
@Index(name="username")
@Column(name="username",length=15)

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
@Index(name="jsp_page_name")
@Column(name="jsp_page_name",length=100)

	public String getJsp_page_name() {
		return jsp_page_name;
	}
	public void setJsp_page_name(String jsp_page_name) {
		this.jsp_page_name = jsp_page_name;
	}
	
@Column(name="frame1")

	public Integer getFrame1() {
		return frame1;
	}
	public void setFrame1(Integer frame1) {
		this.frame1 = frame1;
	}
	
@Column(name="frame2")

	public Integer getFrame2() {
		return frame2;
	}
	public void setFrame2(Integer frame2) {
		this.frame2 = frame2;
	}
	
@Column(name="frame3")

	public Integer getFrame3() {
		return frame3;
	}
	public void setFrame3(Integer frame3) {
		this.frame3 = frame3;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((frame1 == null) ? 0 : frame1.hashCode());
		result = prime * result + ((frame2 == null) ? 0 : frame2.hashCode());
		result = prime * result + ((frame3 == null) ? 0 : frame3.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((jsp_page_name == null) ? 0 : jsp_page_name.hashCode());
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		FrameSize other = (FrameSize) obj;
		if (frame1 == null) {
			if (other.frame1 != null)
				return false;
		} else if (!frame1.equals(other.frame1))
			return false;
		if (frame2 == null) {
			if (other.frame2 != null)
				return false;
		} else if (!frame2.equals(other.frame2))
			return false;
		if (frame3 == null) {
			if (other.frame3 != null)
				return false;
		} else if (!frame3.equals(other.frame3))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (jsp_page_name == null) {
			if (other.jsp_page_name != null)
				return false;
		} else if (!jsp_page_name.equals(other.jsp_page_name))
			return false;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
