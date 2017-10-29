package com.popultrade.dao.hibernate;

import java.util.List;
import com.popultrade.model.Teemplates;
import com.popultrade.dao.TeemplatesDAO;
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


public class TeemplatesDAOHibernate extends BaseDAOHibernate implements TeemplatesDAO {


public List getTeemplatess(final Teemplates teemplates,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
Example ex = Example.create(teemplates).ignoreCase().excludeZeroes().enableLike(MatchMode.START);   
Criteria cri = currentSession().createCriteria(Teemplates.class).add(ex);
if (teemplates.getId()!=null) {
cri.add(Restrictions.eq("id",teemplates.getId()));
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


public int getStTeemplates(final Teemplates teemplates,String dodatni_sql_pogoji) {
try {
Example ex = Example.create(teemplates).excludeZeroes();
Criteria criteria = currentSession().createCriteria(Teemplates.class).add(ex) ; 
if (teemplates.getId()!=null) {
 criteria.add(Restrictions.eq("id",teemplates.getId()));
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
public List getTeemplatess(final Teemplates teemplates,final String orderby,final String orderby_smer) {
if (teemplates == null) {
return getHibernateTemplate().find("from Teemplates");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(teemplates).ignoreCase().enableLike(MatchMode.START);
 Criteria cri= session.createCriteria(Teemplates.class).add(ex);
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


public List getTeemplatess2(final Teemplates teemplates,final String orderby,final String orderby_smer,final String dodaten_hql) {
if (teemplates == null) {
return getHibernateTemplate().find("from Teemplates");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(teemplates).ignoreCase().enableLike(MatchMode.START);
Criteria cri= session.createCriteria(Teemplates.class).add(ex);
if (teemplates.getId()!=null) {
cri.add(Restrictions.eq("id",teemplates.getId()));
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


public List getTeemplatess(final Teemplates teemplates) {
if (teemplates == null) {
return getHibernateTemplate().find("from Teemplates");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(teemplates).ignoreCase().enableLike(MatchMode.START);
Criteria cri = session.createCriteria(Teemplates.class).add(ex);
if (teemplates.getId()!=null) {
cri.add(Restrictions.eq("id",teemplates.getId()));	
}
return cri.list();
}
};
return (List) getHibernateTemplate().execute(callback);
}
}


public Teemplates getTeemplates(final Long id) {
Teemplates teemplates = (Teemplates) getHibernateTemplate().get(Teemplates.class, id);
if (teemplates == null) {
log.warn("uh oh, teemplates with id '" + id + "' not found...");
throw new ObjectRetrievalFailureException(Teemplates.class, id);
}
return teemplates;
}


public void saveTeemplates(final Teemplates teemplates) {
getHibernateTemplate().saveOrUpdate(teemplates);
getHibernateTemplate().flush();
}


public void removeTeemplates(final Long id) {
getHibernateTemplate().delete(getTeemplates(id));
getHibernateTemplate().flush();
}


}
