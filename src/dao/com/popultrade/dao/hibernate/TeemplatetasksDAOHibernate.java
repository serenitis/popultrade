package com.popultrade.dao.hibernate;

import java.util.List;
import com.popultrade.model.Teemplatetasks;
import com.popultrade.dao.TeemplatetasksDAO;
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


public class TeemplatetasksDAOHibernate extends BaseDAOHibernate implements TeemplatetasksDAO {


public List getTeemplatetaskss(final Teemplatetasks teemplatetasks,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
Example ex = Example.create(teemplatetasks).ignoreCase().excludeZeroes().enableLike(MatchMode.START);   
Criteria cri = currentSession().createCriteria(Teemplatetasks.class).add(ex);
if (teemplatetasks.getId()!=null) {
cri.add(Restrictions.eq("id",teemplatetasks.getId()));
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


public int getStTeemplatetasks(final Teemplatetasks teemplatetasks,String dodatni_sql_pogoji) {
try {
Example ex = Example.create(teemplatetasks).excludeZeroes();
Criteria criteria = currentSession().createCriteria(Teemplatetasks.class).add(ex) ; 
if (teemplatetasks.getId()!=null) {
 criteria.add(Restrictions.eq("id",teemplatetasks.getId()));
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
public List getTeemplatetaskss(final Teemplatetasks teemplatetasks,final String orderby,final String orderby_smer) {
if (teemplatetasks == null) {
return getHibernateTemplate().find("from Teemplatetasks");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(teemplatetasks).ignoreCase().enableLike(MatchMode.START);
 Criteria cri= session.createCriteria(Teemplatetasks.class).add(ex);
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


public List getTeemplatetaskss2(final Teemplatetasks teemplatetasks,final String orderby,final String orderby_smer,final String dodaten_hql) {
if (teemplatetasks == null) {
return getHibernateTemplate().find("from Teemplatetasks");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(teemplatetasks).ignoreCase().enableLike(MatchMode.START);
Criteria cri= session.createCriteria(Teemplatetasks.class).add(ex);
if (teemplatetasks.getId()!=null) {
cri.add(Restrictions.eq("id",teemplatetasks.getId()));
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


public List getTeemplatetaskss(final Teemplatetasks teemplatetasks) {
if (teemplatetasks == null) {
return getHibernateTemplate().find("from Teemplatetasks");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(teemplatetasks).ignoreCase().enableLike(MatchMode.START);
Criteria cri = session.createCriteria(Teemplatetasks.class).add(ex);
if (teemplatetasks.getId()!=null) {
cri.add(Restrictions.eq("id",teemplatetasks.getId()));	
}
return cri.list();
}
};
return (List) getHibernateTemplate().execute(callback);
}
}


public Teemplatetasks getTeemplatetasks(final Long id) {
Teemplatetasks teemplatetasks = (Teemplatetasks) getHibernateTemplate().get(Teemplatetasks.class, id);
if (teemplatetasks == null) {
log.warn("uh oh, teemplatetasks with id '" + id + "' not found...");
throw new ObjectRetrievalFailureException(Teemplatetasks.class, id);
}
return teemplatetasks;
}


public void saveTeemplatetasks(final Teemplatetasks teemplatetasks) {
getHibernateTemplate().saveOrUpdate(teemplatetasks);
getHibernateTemplate().flush();
}


public void removeTeemplatetasks(final Long id) {
getHibernateTemplate().delete(getTeemplatetasks(id));
getHibernateTemplate().flush();
}


}
