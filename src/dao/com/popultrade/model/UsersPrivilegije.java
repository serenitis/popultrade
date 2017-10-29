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
@Table (name="usersprivilegije")


public class UsersPrivilegije  extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 1987923323265756759L;
	private Long id;
	private Long id_menija; //// veza na tocko menija
	private String meni_viden; /// je viden 1 ni viden 0
	private Long user_id; /// id userja
	
	
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
	
@Column(name="id_menija")

	public Long getId_menija() {
		return id_menija;
	}
	public void setId_menija(Long id_menija) {
		this.id_menija = id_menija;
	}
	
@Column(name="meni_viden",length=1)

	public String getMeni_viden() {
		return meni_viden;
	}
	public void setMeni_viden(String meni_viden) {
		this.meni_viden = meni_viden;
	}
	
@Index(name="user_id")
@Column(name="user_id")

	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((id_menija == null) ? 0 : id_menija.hashCode());
		result = prime * result
				+ ((meni_viden == null) ? 0 : meni_viden.hashCode());
		result = prime * result + ((user_id == null) ? 0 : user_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		UsersPrivilegije other = (UsersPrivilegije) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (id_menija == null) {
			if (other.id_menija != null)
				return false;
		} else if (!id_menija.equals(other.id_menija))
			return false;
		if (meni_viden == null) {
			if (other.meni_viden != null)
				return false;
		} else if (!meni_viden.equals(other.meni_viden))
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
