package com.popultrade.model;
import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import java.util.List;

@Entity
@Table (name="user_param")

public class Userparam extends BaseObject implements Serializable {


private static final long serialVersionUID = 196551613452319161L;
private Long users_id;
private Long id;


@Index(name="usersidindex")
@Column(name="users_id")
public Long getUsers_id() {
return users_id;
}
public void setUsers_id(Long users_id) {
this.users_id = users_id;
}


@Id
@Column(name="id")
@SequenceGenerator(name="popultrade_seq", sequenceName="popultrade_seq",allocationSize=1)
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="popultrade_seq")
public Long getId() {
return id;
}
public void setId(Long id) {
this.id = id;
}


public int hashCode() {
final int prime = 31;
int result = 1;
result = prime * result + ((id == null) ? 0 : id.hashCode());
return result;
}


public boolean equals(Object obj) {
if (this == obj)
return true;
if (getClass() != obj.getClass())
return false;
Userparam other = (Userparam) obj;
if (id == null) {
if (other.id != null)
return false;
} else if (!id.equals(other.id))
return false;

return true;
}


public String toString() {
return null;
}


}
