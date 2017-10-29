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
import org.apache.commons.lang.builder.CompareToBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;



@Entity
@Table (name="stevci")



public class Stevci extends BaseObject implements Comparable, Serializable {

	private static final long serialVersionUID = 38326261331159411L;
	private Long id;
	private String hub; /// podjetje za popultrade
	//private String tip_mape;
	private int Leto;
	private Long stevec;
	private String tip;
	private String tip_mape;
	
	  
@Column(name="tip",length=3)

	
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
@Column(name="oznnar",length=4,nullable=true)

	
	public String getHub() {
		return hub;
	}
	public void setHub(String hub) {
		this.hub = hub;
	}
	
@Id
@Column(name="idstev")
@SequenceGenerator(name="template_seq",allocationSize=1, sequenceName="template_seq")
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="template_seq")


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	
@Column(name="leto",length=2)

	public int getLeto() {
		return Leto;
	}
	public void setLeto(int leto) {
		Leto = leto;
	}
	
@Column(name="stevec")

	public Long getStevec() {
		return stevec;
	}
	public void setStevec(Long stevec) {
		this.stevec = stevec;
	}
	
@Column(name="tip_mape",length=10,nullable=true)
public String getTip_mape() {
		return tip_mape;
	}
	public void setTip_mape(String tip_mape) {
		this.tip_mape = tip_mape;
		
	}
	public int compareTo(Object object) {
		Stevci myClass = (Stevci) object;
		return new CompareToBuilder()
				.append(this.Leto, myClass.Leto).append(this.hub, myClass.hub)
				.append(this.stevec, myClass.stevec)
				.append(this.id, myClass.id).toComparison();
	}
	public boolean equals(Object object) {
		if (!(object instanceof Stevci)) {
			return false;
		}
		Stevci rhs = (Stevci) object;
		return new EqualsBuilder().append(
				this.Leto, rhs.Leto).append(this.hub, rhs.hub).append(
				this.stevec, rhs.stevec).append(this.id, rhs.id).isEquals();
	}
	public int hashCode() {
		return new HashCodeBuilder(-81272757, -1770616235)
				.append(this.Leto).append(this.hub)
				.append(this.stevec).append(this.id).toHashCode();
	}
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("hub",
				this.hub).append("leto", this.getLeto()).append("stevec", this.stevec).toString();
	}
	
	
}
