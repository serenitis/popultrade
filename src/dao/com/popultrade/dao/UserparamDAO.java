package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.Userparam;

import org.hibernate.Session;
public interface UserparamDAO extends DAO {


public List getUserparams(final Userparam userparam,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
public int getStUserparam(final Userparam userparam,String dodatni_sql_pogoji);
public List getUserparams2(final Userparam userparam,final String orderby,final String orderby_smer,final String dodaten_hql);
public List getUserparams(final Userparam userparam,final String orderby,final String orderby_smer);
public Session getSessionProcedura();
public List getUserparams(Userparam userparam);
public Userparam getUserparam(final Long id);
public void saveUserparam(Userparam userparam);
public void removeUserparam(final Long id);


}

