package com.popultrade.model;

import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.Date;


@Entity
@Table (name="gt1dbchange")


public class Gt1dbchange extends BaseObject implements Serializable {

	private static final long serialVersionUID = -482846479692173717L;
	private Long id;
	private Long record_id;
	private String table_name;
	private Date log_time;

	private String user_name;

	
	/**@hibernate.id 
	 * 
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
	
	
	
	@Column(name="record_id")
	public Long getRecord_id() {
		return record_id;
	}
	public void setRecord_id(Long record_id) {
		this.record_id = record_id;
	}	
	
	
	@Column(name="table_name")
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}	
	
	
	@Column(name="log_time")
	public Date getLog_time() {
		return log_time;
	}
	public void setLog_time(Date log_time) {
		this.log_time = log_time;
	}	
	
	
	@Column(name="user_name")
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((log_time == null) ? 0 : log_time.hashCode());
		result = prime * result
				+ ((record_id == null) ? 0 : record_id.hashCode());
		result = prime * result
				+ ((table_name == null) ? 0 : table_name.hashCode());
		result = prime * result
				+ ((user_name == null) ? 0 : user_name.hashCode());
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
		Gt1dbchange other = (Gt1dbchange) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (log_time == null) {
			if (other.log_time != null)
				return false;
		} else if (!log_time.equals(other.log_time))
			return false;
		if (record_id == null) {
			if (other.record_id != null)
				return false;
		} else if (!record_id.equals(other.record_id))
			return false;
		if (table_name == null) {
			if (other.table_name != null)
				return false;
		} else if (!table_name.equals(other.table_name))
			return false;
		if (user_name == null) {
			if (other.user_name != null)
				return false;
		} else if (!user_name.equals(other.user_name))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
}
