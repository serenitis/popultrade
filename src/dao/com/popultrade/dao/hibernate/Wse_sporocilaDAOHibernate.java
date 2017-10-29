package com.popultrade.dao.hibernate;

import java.util.List;
import com.popultrade.model.Wse_sporocila;
import com.popultrade.dao.Wse_sporocilaDAO;
import org.springframework.orm.ObjectRetrievalFailureException;
import java.sql.Connection;
import java.sql.SQLException;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.springframework.orm.hibernate4.HibernateCallback;


public class Wse_sporocilaDAOHibernate extends BaseDAOHibernate implements Wse_sporocilaDAO {


public List getWse_sporocilas(final Wse_sporocila wse_sporocila,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
Example ex = Example.create(wse_sporocila).ignoreCase().excludeZeroes();   
Criteria cri = currentSession().createCriteria(Wse_sporocila.class).add(ex);
if (wse_sporocila.getId()!=null) {
cri.add(Restrictions.eq("id",wse_sporocila.getId()));
}
if (!orderby.equals("")) {
if (orderby.indexOf(",")!=-1) {
String[] yum = orderby.split(",");
for (int i=0;i<yum.length;i++) {
if (yum[i].indexOf(" ")!=-1) {
if (yum[i].indexOf("asc")!=-1) {
cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(" "))));	
}
else {
cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(" "))));	
}
}
else {
cri.addOrder(Order.desc(yum[i].trim()));	
}
}
}
else {
if (orderby_smer.equals("asc")) {
cri.addOrder(Order.asc(orderby));
}
else {
cri.addOrder(Order.desc(orderby));	
}
}
}
if (!dodatni_sql_pogoji.equals("")) {
cri.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
}
return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();
}


public int getStWse_sporocila(final Wse_sporocila wse_sporocila,String dodatni_sql_pogoji) {
try {
Example ex = Example.create(wse_sporocila).excludeZeroes();
Criteria criteria = currentSession().createCriteria(Wse_sporocila.class).add(ex) ; 
if (wse_sporocila.getId()!=null) {
 criteria.add(Restrictions.eq("id",wse_sporocila.getId()));
}
criteria.setProjection(Projections.rowCount()); 
if (!dodatni_sql_pogoji.equals("")) {
 criteria.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
}
return ((Long)criteria.list().get(0)).intValue(); 
}
catch (Exception ex) {
org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
log.error(ex.toString());
}
return 0;
}


public Session getSessionProcedura() {
return this.currentSession();
}
public List getWse_sporocilas(final Wse_sporocila wse_sporocila,final String orderby,final String orderby_smer) {
if (wse_sporocila == null) {
return getHibernateTemplate().find("from Wse_sporocila");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(wse_sporocila).ignoreCase().enableLike(MatchMode.START);
 Criteria cri= session.createCriteria(Wse_sporocila.class).add(ex);
if (!orderby.equals("")) {
if (orderby.indexOf(",")!=-1) {
String[] yum = orderby.split(",");
for (int i=0;i<yum.length;i++) {
if (yum[i].indexOf(" ")!=-1) {
if (yum[i].indexOf("asc")!=-1) {
cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(" "))));	
}
else {
cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(" "))));	
}
}
else {
cri.addOrder(Order.desc(yum[i].trim()));	
}
}
}
else {
if (orderby_smer.equals("asc")) {
cri.addOrder(Order.asc(orderby));
}
else {
cri.addOrder(Order.desc(orderby));	
}
}
}
return cri.list();
 }
};
return (List) getHibernateTemplate().execute(callback);
}
}


public List getWse_sporocilas2(final Wse_sporocila wse_sporocila,final String orderby,final String orderby_smer,final String dodaten_hql) {
if (wse_sporocila == null) {
return getHibernateTemplate().find("from Wse_sporocila");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(wse_sporocila).ignoreCase().enableLike(MatchMode.START);
Criteria cri= session.createCriteria(Wse_sporocila.class).add(ex);
if (wse_sporocila.getId()!=null) {
cri.add(Restrictions.eq("id",wse_sporocila.getId()));
}
if (!orderby.equals("")) {
if (orderby.indexOf(",")!=-1) {
String[] yum = orderby.split(",");
for (int i=0;i<yum.length;i++) {
if (yum[i].indexOf(" ")!=-1) {
if (yum[i].indexOf("asc")!=-1) {
cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(" "))));	
}
else {
cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(" "))));
}
}
else {
cri.addOrder(Order.desc(yum[i].trim()));	
}
}
}
else {
if (orderby_smer.equals("asc")) {
cri.addOrder(Order.asc(orderby));
}
else {
cri.addOrder(Order.desc(orderby));	
}
}
}
if (!dodaten_hql.equals("")) {
cri.add(Restrictions.sqlRestriction(dodaten_hql));
}
return cri.list();
}
};
 return (List) getHibernateTemplate().execute(callback);
}
}


public List getWse_sporocilas(final Wse_sporocila wse_sporocila) {
if (wse_sporocila == null) {
return getHibernateTemplate().find("from Wse_sporocila");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(wse_sporocila).ignoreCase().enableLike(MatchMode.START);
Criteria cri = session.createCriteria(Wse_sporocila.class).add(ex);
if (wse_sporocila.getId()!=null) {
cri.add(Restrictions.eq("id",wse_sporocila.getId()));	
}
return cri.list();
}
};
return (List) getHibernateTemplate().execute(callback);
}
}


public Wse_sporocila getWse_sporocila(final Long id) {
Wse_sporocila wse_sporocila = (Wse_sporocila) getHibernateTemplate().get(Wse_sporocila.class, id);
if (wse_sporocila == null) {
log.warn("uh oh, wse_sporocila with id '" + id + "' not found...");
throw new ObjectRetrievalFailureException(Wse_sporocila.class, id);
}
return wse_sporocila;
}


public void saveWse_sporocila(final Wse_sporocila wse_sporocila) {
getHibernateTemplate().saveOrUpdate(wse_sporocila);
getHibernateTemplate().flush();
}


public void removeWse_sporocila(final Long id) {
getHibernateTemplate().delete(getWse_sporocila(id));
getHibernateTemplate().flush();
}


}
