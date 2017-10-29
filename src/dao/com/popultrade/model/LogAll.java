package com.popultrade.model;
import javax.persistence.*;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import javax.persistence.GeneratedValue;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import java.util.List;

@Entity
@Table (name="logall")

public class LogAll  {


private static final long serialVersionUID = 818373269916142692L;
private String user_log;
private String type;
private String status;
private String id;
private String description;
private Date datee;
private Date datee1;
private Date datee2;
private String company_receiver;
private String company_log;
private String company_hub;
private String company_bank;


@Column(name="user_log",length=35)
public String getUser_log() {
return user_log;
}
public void setUser_log(String user_log) {
this.user_log = user_log;
}


@Column(name="type",length=35)
public String getType() {
return type;
}
public void setType(String type) {
this.type = type;
}


@Column(name="status",length=1)
public String getStatus() {
return status;
}
public void setStatus(String status) {
this.status = status;
}


@GeneratedValue(generator = "uuid")
@GenericGenerator(name = "uuid", strategy = "uuid2")
@Id

public String getId() {
return id;
}
public void setId(String id) {
this.id = id;
}


@Column(name="description",length=1000)
public String getDescription() {
return description;
}
public void setDescription(String description) {
this.description = description;
}


@Column(name="datee")
public Date getDatee() {
return datee;
}
public void setDatee(Date datee) {
this.datee = datee;
}


@Transient
public Date getDatee1() {
return datee1;
}
public void setDatee1(Date datee1) {
this.datee1 = datee1;
}


@Transient
public Date getDatee2() {
return datee2;
}
public void setDatee2(Date datee2) {
this.datee2 = datee2;
}


@Column(name="company_receiver",length=35)
public String getCompany_receiver() {
return company_receiver;
}
public void setCompany_receiver(String company_receiver) {
this.company_receiver = company_receiver;
}


@Column(name="company_log",length=35)
public String getCompany_log() {
return company_log;
}
public void setCompany_log(String company_log) {
this.company_log = company_log;
}


@Column(name="company_hub",length=35)
public String getCompany_hub() {
return company_hub;
}
public void setCompany_hub(String company_hub) {
this.company_hub = company_hub;
}


@Column(name="company_bank",length=35)
public String getCompany_bank() {
return company_bank;
}
public void setCompany_bank(String company_bank) {
this.company_bank = company_bank;
}


}
