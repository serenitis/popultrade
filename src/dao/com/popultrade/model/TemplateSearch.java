package com.popultrade.model;

import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table (name="templatesearch")


public class TemplateSearch extends BaseObject implements Serializable {

	
	private static final long serialVersionUID = 1432538765462463388L;
	private Long id;

	private Long templatelist_id ;//
	private String stolpec_metoda;//  ime stolpca
	private String selike;// isci po like
	private String selikel;// isci po like levo
	private String seliked;// isci po like desno
	private String seupper;// isci uppercase
	private String selower;// isci lowercase
	
	private List prevodis = new ArrayList();




	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Prevodi.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="prevod_id",referencedColumnName="id")


	public List getPrevodis() {
		return prevodis;
	}

	public void setPrevodis(List prevodis) {
		this.prevodis = prevodis;
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
	
@Column(name="templatelist_id")

	public Long getTemplatelist_id() {
		return templatelist_id;
	}
	public void setTemplatelist_id(Long templatelist_id) {
		this.templatelist_id = templatelist_id;
	}
	
	
@Column(name="stolpec_metoda",length=70)

	public String getStolpec_metoda() {
		return stolpec_metoda;
	}
	public void setStolpec_metoda(String stolpec_metoda) {
		this.stolpec_metoda = stolpec_metoda;
	}
	
	
@Column(name="selike",length=1)

	public String getSelike() {
		return selike;
	}
	public void setSelike(String selike) {
		this.selike = selike;
	}
	
	
@Column(name="selikel",length=1)

	public String getSelikel() {
		return selikel;
	}
	public void setSelikel(String selikel) {
		this.selikel = selikel;
	}
	
	
@Column(name="seliked",length=1)

	public String getSeliked() {
		return seliked;
	}
	public void setSeliked(String seliked) {
		this.seliked = seliked;
	}
	
	
@Column(name="seupper",length=1)

	public String getSeupper() {
		return seupper;
	}
	public void setSeupper(String seupper) {
		this.seupper = seupper;
	}
	
	
@Column(name="selower",length=1)

	public String getSelower() {
		return selower;
	}
	public void setSelower(String selower) {
		this.selower = selower;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((selike == null) ? 0 : selike.hashCode());
		result = prime * result + ((seliked == null) ? 0 : seliked.hashCode());
		result = prime * result + ((selikel == null) ? 0 : selikel.hashCode());
		result = prime * result + ((selower == null) ? 0 : selower.hashCode());
		result = prime * result + ((seupper == null) ? 0 : seupper.hashCode());
		result = prime * result
				+ ((stolpec_metoda == null) ? 0 : stolpec_metoda.hashCode());
		result = prime * result
				+ ((templatelist_id == null) ? 0 : templatelist_id.hashCode());
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
		TemplateSearch other = (TemplateSearch) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (selike == null) {
			if (other.selike != null)
				return false;
		} else if (!selike.equals(other.selike))
			return false;
		if (seliked == null) {
			if (other.seliked != null)
				return false;
		} else if (!seliked.equals(other.seliked))
			return false;
		if (selikel == null) {
			if (other.selikel != null)
				return false;
		} else if (!selikel.equals(other.selikel))
			return false;
		if (selower == null) {
			if (other.selower != null)
				return false;
		} else if (!selower.equals(other.selower))
			return false;
		if (seupper == null) {
			if (other.seupper != null)
				return false;
		} else if (!seupper.equals(other.seupper))
			return false;
		if (stolpec_metoda == null) {
			if (other.stolpec_metoda != null)
				return false;
		} else if (!stolpec_metoda.equals(other.stolpec_metoda))
			return false;
		if (templatelist_id == null) {
			if (other.templatelist_id != null)
				return false;
		} else if (!templatelist_id.equals(other.templatelist_id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
