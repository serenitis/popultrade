package com.popultrade.model;

import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;

 
@Entity
@Table (name="jeziki")


public class Jeziki extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = 56456456464565561L;
	
	private String SIFRA_JEZ;
	private String OPIS_JEZ;
	private String status;

	
	@Id
	@Column(name="SIFRA_JEZIK")

	public String getSIFRA_JEZ() {
		return SIFRA_JEZ;
	}
	public void setSIFRA_JEZ(String sifra_jez) {
		SIFRA_JEZ = sifra_jez;
	}
	
@Column(name="OPIS_JEZ",length=64,nullable=true)

	public String getOPIS_JEZ() {
		return OPIS_JEZ;
	}
	public void setOPIS_JEZ(String opis_jez) {
		OPIS_JEZ = opis_jez;
	}
	
@Column(name="status",length=1)

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((OPIS_JEZ == null) ? 0 : OPIS_JEZ.hashCode());
		result = prime * result
				+ ((SIFRA_JEZ == null) ? 0 : SIFRA_JEZ.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;

		if (getClass() != obj.getClass())
			return false;
		Jeziki other = (Jeziki) obj;
		if (OPIS_JEZ == null) {
			if (other.OPIS_JEZ != null)
				return false;
		} else if (!OPIS_JEZ.equals(other.OPIS_JEZ))
			return false;
		if (SIFRA_JEZ == null) {
			if (other.SIFRA_JEZ != null)
				return false;
		} else if (!SIFRA_JEZ.equals(other.SIFRA_JEZ))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	

	
	
}
