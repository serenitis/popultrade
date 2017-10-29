package com.popultrade.model;

import javax.persistence.*;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/// hibernate tabele 



@Entity
@Table (name="templatetables")


public class TemplateTables extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 4231235666556544441L;
	private Long id;
	private String table_name;
	private String table_name_hibernate; 
	private String production_status; /// status, na produ ali ne
	private Date last_build; /// zadnji build datum
	private String description; /// opis tabele
	private Long id_nad; /// veza na templatetablesgen
	private String table_type; /// nosql = 1 ali navadna = 0
	
	private String sort_column; /// sort column samo za nosql in embeded , ce je ime se doda, ime je isto kot dodaten column, ki se generira v db
	
	private String sort_column_rabi; /// rabi sort column samo za nosql
	
	
	private List templatetables = new ArrayList();




	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateTables.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_nad",referencedColumnName="id")



	public List getTemplatetables() {
		return templatetables;
	}
	public void setTemplatetables(List templatetables) {
		this.templatetables = templatetables;
	}
	
	
	
	@Column(name="sort_column_rabi",length=1)
	
	
	public String getSort_column_rabi() {
		return sort_column_rabi;
	}
	public void setSort_column_rabi(String sort_column_rabi) {
		this.sort_column_rabi = sort_column_rabi;
	}
	@Column(name="sort_column",length=35)
	
	public String getSort_column() {
		return sort_column;
	}
	public void setSort_column(String sort_column) {
		this.sort_column = sort_column;
	}
	@Column(name="table_type",length=1)
	
	
	public String getTable_type() {
		return table_type;
	}
	public void setTable_type(String table_type) {
		this.table_type = table_type;
	}
	@Column(name="id_nad")
	
	
	public Long getId_nad() {
		return id_nad;
	}
	public void setId_nad(Long id_nad) {
		this.id_nad = id_nad;
	}
	
	
	
	@Column(name="description",length=800)
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
	
	private List templateTablesCol = new ArrayList();
	
	
	@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.TemplateTablesCol.class,cascade = CascadeType.REMOVE)
	@JoinColumn(name="id_nad",referencedColumnName="id")
	
	

	public List getTemplateTablesCol() {
		return templateTablesCol;
	}
	public void setTemplateTablesCol(List templateTablesCol) {
		this.templateTablesCol = templateTablesCol;
	}
	/**
     * 
     * @hibernate.id column="id"
     */
	
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
	
	
@Column(name="table_name",length=70)

	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	
	
@Column(name="table_name_hibernate",length=70)

	public String getTable_name_hibernate() {
		return table_name_hibernate;
	}
	public void setTable_name_hibernate(String table_name_hibernate) {
		this.table_name_hibernate = table_name_hibernate;
	}
	
	
@Column(name="production_status",length=1)

	public String getProduction_status() {
		return production_status;
	}
	public void setProduction_status(String production_status) {
		this.production_status = production_status;
	}
	
	
@Column(name="last_build")

	public Date getLast_build() {
		return last_build;
	}
	public void setLast_build(Date last_build) {
		this.last_build = last_build;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((last_build == null) ? 0 : last_build.hashCode());
		result = prime
				+ ((production_status == null) ? 0 : production_status
						.hashCode());
		result = prime * result
				+ ((table_name == null) ? 0 : table_name.hashCode());
		result = prime
				+ ((table_name_hibernate == null) ? 0 : table_name_hibernate
						.hashCode());
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
		TemplateTables other = (TemplateTables) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (last_build == null) {
			if (other.last_build != null)
				return false;
		} else if (!last_build.equals(other.last_build))
			return false;
		if (production_status == null) {
			if (other.production_status != null)
				return false;
		} else if (!production_status.equals(other.production_status))
			return false;
		if (table_name == null) {
			if (other.table_name != null)
				return false;
		} else if (!table_name.equals(other.table_name))
			return false;
		if (table_name_hibernate == null) {
			if (other.table_name_hibernate != null)
				return false;
		} else if (!table_name_hibernate.equals(other.table_name_hibernate))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	

	
	
	
	
	
	
	
	
	
	
	
	

}
