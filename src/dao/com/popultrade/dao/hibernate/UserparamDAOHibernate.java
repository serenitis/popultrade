package com.popultrade.dao.hibernate;

import java.util.List;
import com.popultrade.model.Userparam;
import com.popultrade.dao.UserparamDAO;
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


public class UserparamDAOHibernate extends BaseDAOHibernate implements UserparamDAO {


public List getUserparams(final Userparam userparam,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
Example ex = Example.create(userparam).ignoreCase().excludeZeroes().enableLike(MatchMode.START);   
Criteria cri = currentSession().createCriteria(Userparam.class).add(ex);
if (userparam.getId()!=null) {
cri.add(Restrictions.eq("id",userparam.getId()));
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


public int getStUserparam(final Userparam userparam,String dodatni_sql_pogoji) {
try {
Example ex = Example.create(userparam).excludeZeroes();
Criteria criteria = currentSession().createCriteria(Userparam.class).add(ex) ; 
if (userparam.getId()!=null) {
 criteria.add(Restrictions.eq("id",userparam.getId()));
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
public List getUserparams(final Userparam userparam,final String orderby,final String orderby_smer) {
if (userparam == null) {
return getHibernateTemplate().find("from Userparam");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(userparam).ignoreCase().enableLike(MatchMode.START);
 Criteria cri= session.createCriteria(Userparam.class).add(ex);
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


public List getUserparams2(final Userparam userparam,final String orderby,final String orderby_smer,final String dodaten_hql) {
if (userparam == null) {
return getHibernateTemplate().find("from Userparam");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(userparam).ignoreCase().enableLike(MatchMode.START);
Criteria cri= session.createCriteria(Userparam.class).add(ex);
if (userparam.getId()!=null) {
cri.add(Restrictions.eq("id",userparam.getId()));
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


public List getUserparams(final Userparam userparam) {
if (userparam == null) {
return getHibernateTemplate().find("from Userparam");
} else {
HibernateCallback callback = new HibernateCallback() {
public Object doInHibernate(Session session) throws HibernateException {
Example ex = Example.create(userparam).ignoreCase().enableLike(MatchMode.START);
Criteria cri = session.createCriteria(Userparam.class).add(ex);
if (userparam.getId()!=null) {
cri.add(Restrictions.eq("id",userparam.getId()));	
}
return cri.list();
}
};
return (List) getHibernateTemplate().execute(callback);
}
}


public Userparam getUserparam(final Long id) {
Userparam userparam = (Userparam) getHibernateTemplate().get(Userparam.class, id);
if (userparam == null) {
log.warn("uh oh, userparam with id '" + id + "' not found...");
throw new ObjectRetrievalFailureException(Userparam.class, id);
}
return userparam;
}


public void saveUserparam(final Userparam userparam) {
getHibernateTemplate().saveOrUpdate(userparam);
getHibernateTemplate().flush();
}


public void removeUserparam(final Long id) {
getHibernateTemplate().delete(getUserparam(id));
getHibernateTemplate().flush();
}


}
