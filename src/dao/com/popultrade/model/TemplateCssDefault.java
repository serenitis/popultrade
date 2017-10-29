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
@Table (name="templatecssdefault")


public class TemplateCssDefault extends BaseObject implements Serializable  {

	
	private static final long serialVersionUID = 45597647563645751L;
	private Long id;
	private String dfwcontainer; /// glavni container css custom (vsebuje vse osale containerje)
	private String dfwdefcontainer; /// css za container ki vsebuje vse elemente
	
	private String dfonts; /// css za fonte
	private String dtdelement; /// css za td element
	private String dinputelement; /// css za input elemente
	private String ddivelement; /// css za div element
	private String dtable; /// css za table element za td elementom
	
	
	
	
	
	
@Column(name="dtable",length=70)

	
	
	
	public String getDtable() {
		return dtable;
	}
	public void setDtable(String dtable) {
		this.dtable = dtable;
	}
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
	
	
@Column(name="dfwcontainer",length=70)

	public String getDfwcontainer() {
		return dfwcontainer;
	}
	public void setDfwcontainer(String dfwcontainer) {
		this.dfwcontainer = dfwcontainer;
	}
	
	
@Column(name="dfwdefcontainer",length=70)

	public String getDfwdefcontainer() {
		return dfwdefcontainer;
	}
	public void setDfwdefcontainer(String dfwdefcontainer) {
		this.dfwdefcontainer = dfwdefcontainer;
	}
	
	
@Column(name="dfonts",length=70)

	public String getDfonts() {
		return dfonts;
	}
	public void setDfonts(String dfonts) {
		this.dfonts = dfonts;
	}
	
	
@Column(name="dtdelement",length=70)

	public String getDtdelement() {
		return dtdelement;
	}
	public void setDtdelement(String dtdelement) {
		this.dtdelement = dtdelement;
	}
	
	
@Column(name="dinputelement",length=70)

	public String getDinputelement() {
		return dinputelement;
	}
	public void setDinputelement(String dinputelement) {
		this.dinputelement = dinputelement;
	}
	
	
@Column(name="ddivelement",length=70)

	public String getDdivelement() {
		return ddivelement;
	}
	public void setDdivelement(String ddivelement) {
		this.ddivelement = ddivelement;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((ddivelement == null) ? 0 : ddivelement.hashCode());
		result = prime * result + ((dfonts == null) ? 0 : dfonts.hashCode());
		result = prime * result
				+ ((dfwcontainer == null) ? 0 : dfwcontainer.hashCode());
		result = prime * result
				+ ((dfwdefcontainer == null) ? 0 : dfwdefcontainer.hashCode());
		result = prime * result
				+ ((dinputelement == null) ? 0 : dinputelement.hashCode());
		result = prime * result
				+ ((dtdelement == null) ? 0 : dtdelement.hashCode());
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
		TemplateCssDefault other = (TemplateCssDefault) obj;
		if (ddivelement == null) {
			if (other.ddivelement != null)
				return false;
		} else if (!ddivelement.equals(other.ddivelement))
			return false;
		if (dfonts == null) {
			if (other.dfonts != null)
				return false;
		} else if (!dfonts.equals(other.dfonts))
			return false;
		if (dfwcontainer == null) {
			if (other.dfwcontainer != null)
				return false;
		} else if (!dfwcontainer.equals(other.dfwcontainer))
			return false;
		if (dfwdefcontainer == null) {
			if (other.dfwdefcontainer != null)
				return false;
		} else if (!dfwdefcontainer.equals(other.dfwdefcontainer))
			return false;
		if (dinputelement == null) {
			if (other.dinputelement != null)
				return false;
		} else if (!dinputelement.equals(other.dinputelement))
			return false;
		if (dtdelement == null) {
			if (other.dtdelement != null)
				return false;
		} else if (!dtdelement.equals(other.dtdelement))
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
