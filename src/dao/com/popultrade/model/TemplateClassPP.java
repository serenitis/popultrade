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
@Table (name="templateclasspp")


public class TemplateClassPP extends BaseObject implements Serializable { /// veza na template class za definicijo neznank pri uporabi pp gumba, za multi selecte
	
	
	private static final long serialVersionUID = 4231005661926544441L;
	private Long id;

	private String content; /// opis 
	private Long templateclass_id;








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
	
	
@Column(name="content",length=500)

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
@Column(name="templateclass_id")

	public Long getTemplateclass_id() {
		return templateclass_id;
	}
	public void setTemplateclass_id(Long templateclass_id) {
		this.templateclass_id = templateclass_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime
				+ ((templateclass_id == null) ? 0 : templateclass_id.hashCode());
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
		TemplateClassPP other = (TemplateClassPP) obj;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (templateclass_id == null) {
			if (other.templateclass_id != null)
				return false;
		} else if (!templateclass_id.equals(other.templateclass_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	


	
	
	
	
	
	
	
	
	

}
