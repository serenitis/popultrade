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
@Table (name="teemplatetasks")

public class Teemplatetasks extends BaseObject implements Serializable {


private static final long serialVersionUID = 396115592473356411L;
private Double tax;
private String subtask;
private Integer sequence;
private String name;
private Long id_template;
private Long id_task;
private Long id;
private Double fixed_cost;
private String estimated_time;
private String description;
private Double billable_rate;
private String billable;


@Column(name="tax")
public Double getTax() {
return tax;
}
public void setTax(Double tax) {
this.tax = tax;
}


@Column(name="subtask",length=1)
public String getSubtask() {
return subtask;
}
public void setSubtask(String subtask) {
this.subtask = subtask;
}


@Column(name="sequence",length=5)
public Integer getSequence() {
return sequence;
}
public void setSequence(Integer sequence) {
this.sequence = sequence;
}


@Column(name="name",length=70)
public String getName() {
return name;
}
public void setName(String name) {
this.name = name;
}


@Index(name="idtemtemlinks")
@Column(name="id_template")
public Long getId_template() {
return id_template;
}
public void setId_template(Long id_template) {
this.id_template = id_template;
}


@Index(name="idtasktemlinks")
@Column(name="id_task")
public Long getId_task() {
return id_task;
}
public void setId_task(Long id_task) {
this.id_task = id_task;
}


@Id
@Column(name="id")
@SequenceGenerator(name="template_seq", sequenceName="template_seq",allocationSize=1)
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="template_seq")
public Long getId() {
return id;
}
public void setId(Long id) {
this.id = id;
}


@Column(name="fixed_cost")
public Double getFixed_cost() {
return fixed_cost;
}
public void setFixed_cost(Double fixed_cost) {
this.fixed_cost = fixed_cost;
}


@Column(name="estimated_time",length=8)
public String getEstimated_time() {
return estimated_time;
}
public void setEstimated_time(String estimated_time) {
this.estimated_time = estimated_time;
}


@Column(name="description")
public String getDescription() {
return description;
}
public void setDescription(String description) {
this.description = description;
}


@Column(name="billable_rate")
public Double getBillable_rate() {
return billable_rate;
}
public void setBillable_rate(Double billable_rate) {
this.billable_rate = billable_rate;
}


@Column(name="billable",length=1)
public String getBillable() {
return billable;
}
public void setBillable(String billable) {
this.billable = billable;
}


public int hashCode() {
final int prime = 31;
int result = 1;
result = prime * result + ((subtask == null) ? 0 : subtask.hashCode());
result = prime * result + ((name == null) ? 0 : name.hashCode());
result = prime * result + ((id == null) ? 0 : id.hashCode());
result = prime * result + ((estimated_time == null) ? 0 : estimated_time.hashCode());
result = prime * result + ((description == null) ? 0 : description.hashCode());
result = prime * result + ((billable == null) ? 0 : billable.hashCode());
return result;
}


public boolean equals(Object obj) {
if (this == obj)
return true;
if (getClass() != obj.getClass())
return false;
Teemplatetasks other = (Teemplatetasks) obj;
if (subtask == null) {
if (other.subtask != null)
return false;
} else if (!subtask.equals(other.subtask))
return false;
if (name == null) {
if (other.name != null)
return false;
} else if (!name.equals(other.name))
return false;
if (id == null) {
if (other.id != null)
return false;
} else if (!id.equals(other.id))
return false;
if (estimated_time == null) {
if (other.estimated_time != null)
return false;
} else if (!estimated_time.equals(other.estimated_time))
return false;
if (description == null) {
if (other.description != null)
return false;
} else if (!description.equals(other.description))
return false;
if (billable == null) {
if (other.billable != null)
return false;
} else if (!billable.equals(other.billable))
return false;

return true;
}


public String toString() {
return null;
}


}
