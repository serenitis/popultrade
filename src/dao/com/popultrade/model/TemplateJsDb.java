package com.popultrade.model;

import javax.persistence.*;
import java.io.Serializable;


@Entity
@Table (name="templatejsdb")


public class TemplateJsDb extends BaseObject implements Serializable {
	
	
	private static final long serialVersionUID = 4233500061926544441L;
	private Long id;

	private String table_name; /// ime tabele , ki se kopira v js db
	
/**
 * @hibernate.id name=id
 * @return
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
	
	

@Column(name="table_name",length=35)

public String getTable_name() {
	return table_name;
}
public void setTable_name(String table_name) {
	this.table_name = table_name;
}




@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((id == null) ? 0 : id.hashCode());
	result = prime * result
			+ ((table_name == null) ? 0 : table_name.hashCode());
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
	TemplateJsDb other = (TemplateJsDb) obj;
	if (id == null) {
		if (other.id != null)
			return false;
	} else if (!id.equals(other.id))
		return false;
	if (table_name == null) {
		if (other.table_name != null)
			return false;
	} else if (!table_name.equals(other.table_name))
		return false;
	return true;
}
@Override
public String toString() {
	// TODO Auto-generated method stub
	return null;
}


	
	
	
	
	
	
	

}
