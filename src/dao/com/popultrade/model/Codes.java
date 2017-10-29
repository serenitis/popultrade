package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table (name="codes")


public class Codes extends BaseObject implements Serializable {
	
	private static final long serialVersionUID = 7144204881323371265L;
	private Long id;
	
	private String code_group; /// group
	private String code; /// code of codes
	private String language; /// language pass as parameter
	
	private List translation=new ArrayList(); /// get translation based on language parameter (formula)
	private String lang_text;
	
	
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

	
	
	@Index(name="code_group_codes")
	@Column(name="code_group",length=15)
	public String getCode_group() {
		return code_group;
	}

	public void setCode_group(String code_group) {
		this.code_group = code_group;
	}

	@Index(name="code_codes")
	@Column(name="code",length=15)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	
	@Transient
	
	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	
	
	
	
	
	
	
	@Transient
	
	
	public String getLang_text() {
		return lang_text;
	}

	public void setLang_text(String lang_text) {
		this.lang_text = lang_text;
	}

	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="prevod_id",referencedColumnName="id")
	
	public List getTranslation() {
		return translation;
	}

	public void setTranslation(List translation) {
		this.translation = translation;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result
				+ ((code_group == null) ? 0 : code_group.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((language == null) ? 0 : language.hashCode());
		result = prime * result
				+ ((translation == null) ? 0 : translation.hashCode());
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
		Codes other = (Codes) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (code_group == null) {
			if (other.code_group != null)
				return false;
		} else if (!code_group.equals(other.code_group))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (language == null) {
			if (other.language != null)
				return false;
		} else if (!language.equals(other.language))
			return false;
		if (translation == null) {
			if (other.translation != null)
				return false;
		} else if (!translation.equals(other.translation))
			return false;
		return true;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}


	
	
	
	
	
	
	
	
	
	

}
