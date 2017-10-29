package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.Wse_sporocila;

import org.hibernate.Session;
public interface Wse_sporocilaDAO extends DAO {


public List getWse_sporocilas(final Wse_sporocila wse_sporocila,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
public int getStWse_sporocila(final Wse_sporocila wse_sporocila,String dodatni_sql_pogoji);
public List getWse_sporocilas2(final Wse_sporocila wse_sporocila,final String orderby,final String orderby_smer,final String dodaten_hql);
public List getWse_sporocilas(final Wse_sporocila wse_sporocila,final String orderby,final String orderby_smer);
public Session getSessionProcedura();
public List getWse_sporocilas(Wse_sporocila wse_sporocila);
public Wse_sporocila getWse_sporocila(final Long id);
public void saveWse_sporocila(Wse_sporocila wse_sporocila);
public void removeWse_sporocila(final Long id);


}

