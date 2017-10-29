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
import java.util.ArrayList;
import java.util.List;


@Entity
@Table (name="templatecustomclass")


public class TemplateCustomClass extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = 1432534261062463388L;
	private Long id;
	private String class_name; /// naziv, samo za pregled
	
	private String classv; /// align: center,left, right




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


	
	
@Column(name="class_name",length=30)

	public String getClass_name() {
		return class_name;
	}


	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}


	
@Column(name="classv")

	
	public String getClassv() {
		return classv;
	}


	public void setClassv(String classv) {
		this.classv = classv;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((class_name == null) ? 0 : class_name.hashCode());
		result = prime * result + ((classv == null) ? 0 : classv.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		TemplateCustomClass other = (TemplateCustomClass) obj;
		if (class_name == null) {
			if (other.class_name != null)
				return false;
		} else if (!class_name.equals(other.class_name))
			return false;
		if (classv == null) {
			if (other.classv != null)
				return false;
		} else if (!classv.equals(other.classv))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}


	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}



	
	
	
	
	
}
