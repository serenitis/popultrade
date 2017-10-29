package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.Teemplatetasks;

import org.hibernate.Session;
public interface TeemplatetasksDAO extends DAO {


public List getTeemplatetaskss(final Teemplatetasks teemplatetasks,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
public int getStTeemplatetasks(final Teemplatetasks teemplatetasks,String dodatni_sql_pogoji);
public List getTeemplatetaskss2(final Teemplatetasks teemplatetasks,final String orderby,final String orderby_smer,final String dodaten_hql);
public List getTeemplatetaskss(final Teemplatetasks teemplatetasks,final String orderby,final String orderby_smer);
public Session getSessionProcedura();
public List getTeemplatetaskss(Teemplatetasks teemplatetasks);
public Teemplatetasks getTeemplatetasks(final Long id);
public void saveTeemplatetasks(Teemplatetasks teemplatetasks);
public void removeTeemplatetasks(final Long id);


}

