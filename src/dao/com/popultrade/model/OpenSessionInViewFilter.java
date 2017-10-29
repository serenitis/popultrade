package com.popultrade.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.*;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import javax.sql.DataSource;

import org.hibernate.FlushMode;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate4.SessionFactoryUtils;




public class OpenSessionInViewFilter extends org.springframework.orm.hibernate4.support.OpenSessionInViewFilter {
    
	 protected Session openSession(SessionFactory sessionFactory) throws DataAccessResourceFailureException {
		    try {
		      Session session = sessionFactory.openSession();
		      session.setFlushMode(FlushMode.AUTO); // This line changes the default behavior
		      
		      System.out.println("SESSION SETAN NA AUTO!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		      
		      return session;
		    } catch (HibernateException ex) {
		      throw new DataAccessResourceFailureException("Could not open Hibernate Session", ex);
		    }
		  }


    
    
    
}


