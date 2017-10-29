package com.popultrade.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.*;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;


import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;



@Entity
@Table (name="app_user")


public class User extends BaseObject  {
    private static final long serialVersionUID = 3832626162173359411L;

    protected String username;                    // assigned primary key
    protected String password;                    // required
    protected String confirmPassword;
    protected String firstName;                   // required
    protected String lastName;                    // required
   // protected Address address = new Address();
    protected String phoneNumber;
    protected String email;                       // required; unique
    protected String website;
    protected String passwordHint;
    protected Integer version;
    protected Set roles = new HashSet();
    public Set getRoles() {
		return roles;
	}

	protected boolean enabled;
    protected boolean accountExpired;
    protected boolean accountLocked;
    protected boolean credentialsExpired;

    public User() {}

    public User(String username) {
        this.username = username;
    }

@Id
@Column(name="",length=20)
@SequenceGenerator(name="template_seq",allocationSize=1, sequenceName="template_seq")
@GeneratedValue(strategy = GenerationType.SEQUENCE ,generator="template_seq")


    public String getUsername() {
        return username;
    }

@Column(name="password",nullable=true)

    public String getPassword() {
        return password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

@Column(name="first_name",length=50,nullable=true)

    public String getFirstName() {
        return firstName;
    }

@Column(name="last_name",length=50,nullable=true)

    public String getLastName() {
        return lastName;
    }

    public String getFullName() {
        return firstName + ' ' + lastName;
    }



@Column(name="",nullable=true)

    public String getEmail() {
        return email;
    }

@Column(name="phone_number",nullable=false)

    public String getPhoneNumber() {
        return phoneNumber;
    }

@Column(name="website",nullable=false)

    public String getWebsite() {
        return website;
    }

@Column(name="password_hint",nullable=false)

    public String getPasswordHint() {
        return passwordHint;
    }



    

    public Integer getVersion() {
        return version;
    }
    
@Column(name="account_enabled")

    public boolean isEnabled() {
        return enabled;
    }
    
@Column(name="account_expired",nullable=true)

    public boolean isAccountExpired() {
        return accountExpired;
    }
    
    public boolean isAccountNonExpired() {
        return !isAccountExpired();
    }

@Column(name="account_locked",nullable=true)

    public boolean isAccountLocked() {
        return accountLocked;
    }
    
    public boolean isAccountNonLocked() {
        return !isAccountLocked();
    }

@Column(name="credentials_expired",nullable=true)

    public boolean isCredentialsExpired() {
        return credentialsExpired;
    }
    
    public boolean isCredentialsNonExpired() {
        return !credentialsExpired;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }


    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public void setPasswordHint(String passwordHint) {
        this.passwordHint = passwordHint;
    }

    public void setRoles(Set roles) {
        this.roles = roles;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
    
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public void setAccountExpired(boolean accountExpired) {
        this.accountExpired = accountExpired;
    }
    
    public void setAccountLocked(boolean accountLocked) {
        this.accountLocked = accountLocked;
    }

    public void setCredentialsExpired(boolean credentialsExpired) {
        this.credentialsExpired = credentialsExpired;
    }
    
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;

        final User user = (User) o;

        if (username != null ? !username.equals(user.getUsername()) : user.getUsername() != null) return false;

        return true;
    }

    public int hashCode() {
        return (username != null ? username.hashCode() : 0);
    }

    public String toString() {
        ToStringBuilder sb = new ToStringBuilder(this,
                ToStringStyle.DEFAULT_STYLE).append("username", this.username)
                .append("enabled", this.enabled)
                .append("accountExpired",this.accountExpired)
                .append("credentialsExpired",this.credentialsExpired)
                .append("accountLocked",this.accountLocked);

   
        return sb.toString();
    }
}
