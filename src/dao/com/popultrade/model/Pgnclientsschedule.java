package com.popultrade.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Index;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
@Entity
@Table (name="pgnclientsschedule")

public class Pgnclientsschedule extends BaseObject implements Serializable  {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6522891031104392762L;
	private Long id;
	private Long id_pgnclients;
	private Long id_user;
	
	/// monday

	private String time_from0; /// time from, client offile
	private String time_to0; /// time to, client offile
	private String offline0; /// offline whole day
	
	
	private String time_from1; /// time from, client offile
	private String time_to1; /// time to, client offile
	private String offline1; /// offline whole day
	

	private String time_from2; /// time from, client offile
	private String time_to2; /// time to, client offile
	private String offline2; /// offline whole day
	
	
	private String time_from3; /// time from, client offile
	private String time_to3; /// time to, client offile
	private String offline3; /// offline whole day
	
	
	private String time_from4; /// time from, client offile
	private String time_to4; /// time to, client offile
	private String offline4; /// offline whole day
	
	private String time_from5; /// time from, client offile
	private String time_to5; /// time to, client offile
	private String offline5; /// offline whole day
	

	private String time_from6; /// time from, client offile
	private String time_to6; /// time to, client offile
	private String offline6; /// offline whole day
	
	
	private PgnClients pgnClients;
	



	

	

	@Column(name="id_user")
	public Long getId_user() {
		return id_user;
	}
	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}
	
	
	
	@OneToOne
    @JoinColumn(name = "id_pgnclients",insertable=false,updatable=false,nullable=true)
	@NotFound(action = NotFoundAction.IGNORE)
	

	
	public PgnClients getPgnClients() {
		return pgnClients;
	}
	public void setPgnClients(PgnClients pgnClients) {
		this.pgnClients = pgnClients;
	}
	
	@Id
	@Column(name="id")
	@SequenceGenerator(name="popultrade_seq",allocationSize=1, sequenceName="popultrade_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="popultrade_seq")

	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	
	@Index(name="id_pgnclientsindex")
	@Column(name="id_pgnclients",nullable=false)
	public Long getId_pgnclients() {
		return id_pgnclients;
	}
	public void setId_pgnclients(Long id_pgnclients) {
		this.id_pgnclients = id_pgnclients;
	}
	
	
	@Column(name="time_from0",length=5)
	public String getTime_from0() {
		return time_from0;
	}
	public void setTime_from0(String time_from0) {
		this.time_from0 = time_from0;
	}
	
	
	@Column(name="time_to0",length=5)
	public String getTime_to0() {
		return time_to0;
	}
	public void setTime_to0(String time_to0) {
		this.time_to0 = time_to0;
	}
	
	
	@Column(name="offline0",length=1)
	public String getOffline0() {
		return offline0;
	}
	public void setOffline0(String offline0) {
		this.offline0 = offline0;
	}
	
	
	
	
	
	
	
	@Column(name="time_from1",length=5)
	public String getTime_from1() {
		return time_from1;
	}
	public void setTime_from1(String time_from1) {
		this.time_from1 = time_from1;
	}	
	
	@Column(name="time_to1",length=5)
	public String getTime_to1() {
		return time_to1;
	}
	public void setTime_to1(String time_to1) {
		this.time_to1 = time_to1;
	}	
	
	@Column(name="offline1",length=1)
	public String getOffline1() {
		return offline1;
	}
	public void setOffline1(String offline1) {
		this.offline1 = offline1;
	}	
	
	@Column(name="time_from2",length=5)
	public String getTime_from2() {
		return time_from2;
	}
	public void setTime_from2(String time_from2) {
		this.time_from2 = time_from2;
	}	
	
	@Column(name="time_to2",length=5)
	public String getTime_to2() {
		return time_to2;
	}
	public void setTime_to2(String time_to2) {
		this.time_to2 = time_to2;
	}	
	
	@Column(name="offline2",length=1)
	public String getOffline2() {
		return offline2;
	}
	public void setOffline2(String offline2) {
		this.offline2 = offline2;
	}	
	
	@Column(name="time_from3",length=5)
	public String getTime_from3() {
		return time_from3;
	}
	public void setTime_from3(String time_from3) {
		this.time_from3 = time_from3;
	}	
	
	@Column(name="time_to3",length=5)
	public String getTime_to3() {
		return time_to3;
	}
	public void setTime_to3(String time_to3) {
		this.time_to3 = time_to3;
	}	
	
	@Column(name="offline3",length=1)
	public String getOffline3() {
		return offline3;
	}
	public void setOffline3(String offline3) {
		this.offline3 = offline3;
	}	
	
	@Column(name="time_from4",length=5)
	public String getTime_from4() {
		return time_from4;
	}
	public void setTime_from4(String time_from4) {
		this.time_from4 = time_from4;
	}	
	
	@Column(name="time_to4",length=5)
	public String getTime_to4() {
		return time_to4;
	}
	public void setTime_to4(String time_to4) {
		this.time_to4 = time_to4;
	}	
	
	@Column(name="offline4",length=1)
	public String getOffline4() {
		return offline4;
	}
	public void setOffline4(String offline4) {
		this.offline4 = offline4;
	}	
	
	@Column(name="time_from5",length=5)
	public String getTime_from5() {
		return time_from5;
	}
	public void setTime_from5(String time_from5) {
		this.time_from5 = time_from5;
	}	
	
	@Column(name="time_to5",length=5)
	public String getTime_to5() {
		return time_to5;
	}
	public void setTime_to5(String time_to5) {
		this.time_to5 = time_to5;
	}	
	
	@Column(name="offline5",length=1)
	public String getOffline5() {
		return offline5;
	}
	public void setOffline5(String offline5) {
		this.offline5 = offline5;
	}	
	
	@Column(name="time_from6",length=5)
	public String getTime_from6() {
		return time_from6;
	}
	public void setTime_from6(String time_from6) {
		this.time_from6 = time_from6;
	}	
	
	@Column(name="time_to6",length=5)
	public String getTime_to6() {
		return time_to6;
	}
	public void setTime_to6(String time_to6) {
		this.time_to6 = time_to6;
	}	
	
	@Column(name="offline6",length=1)
	public String getOffline6() {
		return offline6;
	}
	public void setOffline6(String offline6) {
		this.offline6 = offline6;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((id_pgnclients == null) ? 0 : id_pgnclients.hashCode());
		result = prime * result
				+ ((offline0 == null) ? 0 : offline0.hashCode());
		result = prime * result
				+ ((offline1 == null) ? 0 : offline1.hashCode());
		result = prime * result
				+ ((offline2 == null) ? 0 : offline2.hashCode());
		result = prime * result
				+ ((offline3 == null) ? 0 : offline3.hashCode());
		result = prime * result
				+ ((offline4 == null) ? 0 : offline4.hashCode());
		result = prime * result
				+ ((offline5 == null) ? 0 : offline5.hashCode());
		result = prime * result
				+ ((offline6 == null) ? 0 : offline6.hashCode());
		result = prime * result
				+ ((time_from0 == null) ? 0 : time_from0.hashCode());
		result = prime * result
				+ ((time_from1 == null) ? 0 : time_from1.hashCode());
		result = prime * result
				+ ((time_from2 == null) ? 0 : time_from2.hashCode());
		result = prime * result
				+ ((time_from3 == null) ? 0 : time_from3.hashCode());
		result = prime * result
				+ ((time_from4 == null) ? 0 : time_from4.hashCode());
		result = prime * result
				+ ((time_from5 == null) ? 0 : time_from5.hashCode());
		result = prime * result
				+ ((time_from6 == null) ? 0 : time_from6.hashCode());
		result = prime * result
				+ ((time_to0 == null) ? 0 : time_to0.hashCode());
		result = prime * result
				+ ((time_to1 == null) ? 0 : time_to1.hashCode());
		result = prime * result
				+ ((time_to2 == null) ? 0 : time_to2.hashCode());
		result = prime * result
				+ ((time_to3 == null) ? 0 : time_to3.hashCode());
		result = prime * result
				+ ((time_to4 == null) ? 0 : time_to4.hashCode());
		result = prime * result
				+ ((time_to5 == null) ? 0 : time_to5.hashCode());
		result = prime * result
				+ ((time_to6 == null) ? 0 : time_to6.hashCode());
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
		Pgnclientsschedule other = (Pgnclientsschedule) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (id_pgnclients == null) {
			if (other.id_pgnclients != null)
				return false;
		} else if (!id_pgnclients.equals(other.id_pgnclients))
			return false;
		if (offline0 == null) {
			if (other.offline0 != null)
				return false;
		} else if (!offline0.equals(other.offline0))
			return false;
		if (offline1 == null) {
			if (other.offline1 != null)
				return false;
		} else if (!offline1.equals(other.offline1))
			return false;
		if (offline2 == null) {
			if (other.offline2 != null)
				return false;
		} else if (!offline2.equals(other.offline2))
			return false;
		if (offline3 == null) {
			if (other.offline3 != null)
				return false;
		} else if (!offline3.equals(other.offline3))
			return false;
		if (offline4 == null) {
			if (other.offline4 != null)
				return false;
		} else if (!offline4.equals(other.offline4))
			return false;
		if (offline5 == null) {
			if (other.offline5 != null)
				return false;
		} else if (!offline5.equals(other.offline5))
			return false;
		if (offline6 == null) {
			if (other.offline6 != null)
				return false;
		} else if (!offline6.equals(other.offline6))
			return false;
		if (time_from0 == null) {
			if (other.time_from0 != null)
				return false;
		} else if (!time_from0.equals(other.time_from0))
			return false;
		if (time_from1 == null) {
			if (other.time_from1 != null)
				return false;
		} else if (!time_from1.equals(other.time_from1))
			return false;
		if (time_from2 == null) {
			if (other.time_from2 != null)
				return false;
		} else if (!time_from2.equals(other.time_from2))
			return false;
		if (time_from3 == null) {
			if (other.time_from3 != null)
				return false;
		} else if (!time_from3.equals(other.time_from3))
			return false;
		if (time_from4 == null) {
			if (other.time_from4 != null)
				return false;
		} else if (!time_from4.equals(other.time_from4))
			return false;
		if (time_from5 == null) {
			if (other.time_from5 != null)
				return false;
		} else if (!time_from5.equals(other.time_from5))
			return false;
		if (time_from6 == null) {
			if (other.time_from6 != null)
				return false;
		} else if (!time_from6.equals(other.time_from6))
			return false;
		if (time_to0 == null) {
			if (other.time_to0 != null)
				return false;
		} else if (!time_to0.equals(other.time_to0))
			return false;
		if (time_to1 == null) {
			if (other.time_to1 != null)
				return false;
		} else if (!time_to1.equals(other.time_to1))
			return false;
		if (time_to2 == null) {
			if (other.time_to2 != null)
				return false;
		} else if (!time_to2.equals(other.time_to2))
			return false;
		if (time_to3 == null) {
			if (other.time_to3 != null)
				return false;
		} else if (!time_to3.equals(other.time_to3))
			return false;
		if (time_to4 == null) {
			if (other.time_to4 != null)
				return false;
		} else if (!time_to4.equals(other.time_to4))
			return false;
		if (time_to5 == null) {
			if (other.time_to5 != null)
				return false;
		} else if (!time_to5.equals(other.time_to5))
			return false;
		if (time_to6 == null) {
			if (other.time_to6 != null)
				return false;
		} else if (!time_to6.equals(other.time_to6))
			return false;
		return true;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
	
	
	
	
	
}
