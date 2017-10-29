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
@Table (name="teemplates")

public class Teemplates extends BaseObject implements Serializable {


private static final long serialVersionUID = 177361487999646232L;
private List templatetaskss = new ArrayList();
private String template_name;
private String template_description;
private Long id_owner;
private Long id;


@OneToMany(fetch=FetchType.LAZY,targetEntity=com.popultrade.model.Teemplatetasks.class,cascade = CascadeType.REMOVE)
@JoinColumn(name="id_template",referencedColumnName="id")
public List getTemplatetaskss() {
return templatetaskss;
}
public void setTemplatetaskss(List templatetaskss) {
this.templatetaskss = templatetaskss;
}


@Column(name="template_name",length=70)
public String getTemplate_name() {
return template_name;
}
public void setTemplate_name(String template_name) {
this.template_name = template_name;
}


@Column(name="template_description",length=300)
public String getTemplate_description() {
return template_description;
}
public void setTemplate_description(String template_description) {
this.template_description = template_description;
}


@Index(name="idownertemplatesindex")
@Column(name="id_owner")
public Long getId_owner() {
return id_owner;
}
public void setId_owner(Long id_owner) {
this.id_owner = id_owner;
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
result = prime * result + ((template_name == null) ? 0 : template_name.hashCode());
result = prime * result + ((template_description == null) ? 0 : template_description.hashCode());
result = prime * result + ((id == null) ? 0 : id.hashCode());
return result;
}


public boolean equals(Object obj) {
if (this == obj)
return true;
if (getClass() != obj.getClass())
return false;
Teemplates other = (Teemplates) obj;
if (template_name == null) {
if (other.template_name != null)
return false;
} else if (!template_name.equals(other.template_name))
return false;
if (template_description == null) {
if (other.template_description != null)
return false;
} else if (!template_description.equals(other.template_description))
return false;
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
