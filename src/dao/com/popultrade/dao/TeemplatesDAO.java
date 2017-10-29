package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.Teemplates;

import org.hibernate.Session;
public interface TeemplatesDAO extends DAO {


public List getTeemplatess(final Teemplates teemplates,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
public int getStTeemplates(final Teemplates teemplates,String dodatni_sql_pogoji);
public List getTeemplatess2(final Teemplates teemplates,final String orderby,final String orderby_smer,final String dodaten_hql);
public List getTeemplatess(final Teemplates teemplates,final String orderby,final String orderby_smer);
public Session getSessionProcedura();
public List getTeemplatess(Teemplates teemplates);
public Teemplates getTeemplates(final Long id);
public void saveTeemplates(Teemplates teemplates);
public void removeTeemplates(final Long id);


}

