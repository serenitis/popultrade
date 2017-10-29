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
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import java.util.List;

@Entity
@Table (name="pgnlognosql")

public class Pgnlognosql  implements Serializable {


private static final long serialVersionUID = 483129985653212766L;
private String username;
private String type;
private String status;
private String servlet_todo;
private String sender_id;
private String sender;
private String refer;
private String phase;
private String orig_filename;
private String msg_type;
private String msg_subject;
private String msg_receiver_end;
private String msg_receiver;
private String msg_options;
private String msg_id;
private String msg_destination;
private String msg_class;
private String message;
private Date log_date;
private Long id_user;
private Long id_pgnclients;
private String id;
private String file_orig;
private String dir;
private String client_log_id;
private String archived;


@Column(name="username")
public String getUsername() {
return username;
}
public void setUsername(String username) {
this.username = username;
}


@Column(name="type")
public String getType() {
return type;
}
public void setType(String type) {
this.type = type;
}


@Column(name="status")
public String getStatus() {
return status;
}
public void setStatus(String status) {
this.status = status;
}


@Column(name="servlet_todo")
public String getServlet_todo() {
return servlet_todo;
}
public void setServlet_todo(String servlet_todo) {
this.servlet_todo = servlet_todo;
}


@Column(name="sender_id")
public String getSender_id() {
return sender_id;
}
public void setSender_id(String sender_id) {
this.sender_id = sender_id;
}


@Column(name="sender")
public String getSender() {
return sender;
}
public void setSender(String sender) {
this.sender = sender;
}


@Column(name="refer")
public String getRefer() {
return refer;
}
public void setRefer(String refer) {
this.refer = refer;
}


@Column(name="phase")
public String getPhase() {
return phase;
}
public void setPhase(String phase) {
this.phase = phase;
}


@Column(name="orig_filename")
public String getOrig_filename() {
return orig_filename;
}
public void setOrig_filename(String orig_filename) {
this.orig_filename = orig_filename;
}


@Column(name="msg_type")
public String getMsg_type() {
return msg_type;
}
public void setMsg_type(String msg_type) {
this.msg_type = msg_type;
}


@Column(name="msg_subject")
public String getMsg_subject() {
return msg_subject;
}
public void setMsg_subject(String msg_subject) {
this.msg_subject = msg_subject;
}


@Column(name="msg_receiver_end")
public String getMsg_receiver_end() {
return msg_receiver_end;
}
public void setMsg_receiver_end(String msg_receiver_end) {
this.msg_receiver_end = msg_receiver_end;
}


@Column(name="msg_receiver")
public String getMsg_receiver() {
return msg_receiver;
}
public void setMsg_receiver(String msg_receiver) {
this.msg_receiver = msg_receiver;
}


@Column(name="msg_options")
public String getMsg_options() {
return msg_options;
}
public void setMsg_options(String msg_options) {
this.msg_options = msg_options;
}


@Column(name="msg_id")
public String getMsg_id() {
return msg_id;
}
public void setMsg_id(String msg_id) {
this.msg_id = msg_id;
}


@Column(name="msg_destination")
public String getMsg_destination() {
return msg_destination;
}
public void setMsg_destination(String msg_destination) {
this.msg_destination = msg_destination;
}


@Column(name="msg_class")
public String getMsg_class() {
return msg_class;
}
public void setMsg_class(String msg_class) {
this.msg_class = msg_class;
}


@Column(name="message")
public String getMessage() {
return message;
}
public void setMessage(String message) {
this.message = message;
}


@Column(name="log_date")
public Date getLog_date() {
return log_date;
}
public void setLog_date(Date log_date) {
this.log_date = log_date;
}


@Column(name="id_user")
public Long getId_user() {
return id_user;
}
public void setId_user(Long id_user) {
this.id_user = id_user;
}


@Column(name="id_pgnclients")
public Long getId_pgnclients() {
return id_pgnclients;
}
public void setId_pgnclients(Long id_pgnclients) {
this.id_pgnclients = id_pgnclients;
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


@Column(name="file_orig")
public String getFile_orig() {
return file_orig;
}
public void setFile_orig(String file_orig) {
this.file_orig = file_orig;
}


@Column(name="dir")
public String getDir() {
return dir;
}
public void setDir(String dir) {
this.dir = dir;
}


@Column(name="client_log_id")
public String getClient_log_id() {
return client_log_id;
}
public void setClient_log_id(String client_log_id) {
this.client_log_id = client_log_id;
}


@Column(name="archived")
public String getArchived() {
return archived;
}
public void setArchived(String archived) {
this.archived = archived;
}


}
