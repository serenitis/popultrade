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
import java.util.Date;


@Entity
@Table (name="wse_prijave")


public class Wse_prijave extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = -6561138036152058772L;
	private Long id;
	private String username;
	private Date datum_prijave;
	private Date datum_odjave;
	private String ip;
	private String drzava;
	private String hostname;
	
	private Date datum_prijave1;
	private Date datum_odjave1;
	private Date datum_prijave2;
	private Date datum_odjave2;
	private String status; /// status prijave 1-ok,2-ni ok prijava,3-ni ok user disabled,4-ni ok certifikat,5-vec kot 3x probal prijavit,6-admin iz nepravilnega ipja
	
	private Long id_user; /// id userja
	
	
	
	@Column(name="id_user")

	
	public Long getId_user() {
		return id_user;
	}
	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}
	
	
	@Column(name="status",length=2)

	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Transient
	public Date getDatum_prijave1() {
		return datum_prijave1;
	}
	public void setDatum_prijave1(Date datum_prijave1) {
		this.datum_prijave1 = datum_prijave1;
	}
	@Transient
	public Date getDatum_odjave1() {
		return datum_odjave1;
	}
	public void setDatum_odjave1(Date datum_odjave1) {
		this.datum_odjave1 = datum_odjave1;
	}
	
	@Transient
	public Date getDatum_prijave2() {
		return datum_prijave2;
	}
	public void setDatum_prijave2(Date datum_prijave2) {
		this.datum_prijave2 = datum_prijave2;
	}
	
	@Transient
	public Date getDatum_odjave2() {
		return datum_odjave2;
	}
	public void setDatum_odjave2(Date datum_odjave2) {
		this.datum_odjave2 = datum_odjave2;
	}
@Id
@Column(name="id")
@SequenceGenerator(name="wse_prijave_SEQ",allocationSize=1, sequenceName="wse_prijave_SEQ")
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="wse_prijave_SEQ")


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	
@Column(name="username",length=32)

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	
@Column(name="datum_prijave")

	public Date getDatum_prijave() {
		return datum_prijave;
	}
	public void setDatum_prijave(Date datum_prijave) {
		this.datum_prijave = datum_prijave;
	}
	
@Column(name="datum_odjave")

	public Date getDatum_odjave() {
		return datum_odjave;
	}
	public void setDatum_odjave(Date datum_odjave) {
		this.datum_odjave = datum_odjave;
	}
	
@Column(name="ip",length=16)

	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
@Column(name="drzava",length=16)

	public String getDrzava() {
		return drzava;
	}
	public void setDrzava(String drzava) {
		this.drzava = drzava;
	}
	
@Column(name="hostname",length=48)

	public String getHostname() {
		return hostname;
	}
	public void setHostname(String hostname) {
		this.hostname = hostname;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((datum_odjave == null) ? 0 : datum_odjave.hashCode());
		result = prime * result
				+ ((datum_prijave == null) ? 0 : datum_prijave.hashCode());
		result = prime * result + ((drzava == null) ? 0 : drzava.hashCode());
		result = prime * result
				+ ((hostname == null) ? 0 : hostname.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((ip == null) ? 0 : ip.hashCode());
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
		Wse_prijave other = (Wse_prijave) obj;
		if (datum_odjave == null) {
			if (other.datum_odjave != null)
				return false;
		} else if (!datum_odjave.equals(other.datum_odjave))
			return false;
		if (datum_prijave == null) {
			if (other.datum_prijave != null)
				return false;
		} else if (!datum_prijave.equals(other.datum_prijave))
			return false;
		if (drzava == null) {
			if (other.drzava != null)
				return false;
		} else if (!drzava.equals(other.drzava))
			return false;
		if (hostname == null) {
			if (other.hostname != null)
				return false;
		} else if (!hostname.equals(other.hostname))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (ip == null) {
			if (other.ip != null)
				return false;
		} else if (!ip.equals(other.ip))
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
