
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateMenun;
import com.popultrade.dao.TemplateMenunDAO;
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

public class TemplateMenunDAOHibernate extends BaseDAOHibernate implements TemplateMenunDAO {

  public List getTemplateMenuns(final TemplateMenun templateMenun,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateMenun order by datum_TemplateMenuna");

      Example ex = Example.create(templateMenun).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateMenun.class).add(ex);
        if (templateMenun.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateMenun.getId()));
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

	public int getStTemplateMenun(final TemplateMenun templateMenun,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateMenun).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateMenun.class).add(ex) ; 

			  if (templateMenun.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateMenun.getId()));
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

	public Connection pridobiConnectionZaProceduro() {
	
		    java.sql.Connection connection = null;
		
		    return connection;
	}
    public List getTemplateMenuns(final TemplateMenun templateMenun,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateMenun");

          if (templateMenun == null) {
              return getHibernateTemplate().find("from TemplateMenun");
          } else {
              // filter on properties set in the templateMenun
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateMenun.getSFT_SIFRA());
                  	Example ex = Example.create(templateMenun).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateMenun.class).add(ex);
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
    public List getTemplateMenuns2(final TemplateMenun templateMenun,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateMenun");

          if (templateMenun == null) {
              return getHibernateTemplate().find("from TemplateMenun");
          } else {
              // filter on properties set in the templateMenun
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateMenun.getSFT_SIFRA());
                  	Example ex = Example.create(templateMenun).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateMenun.class).add(ex);
                   if (templateMenun.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateMenun.getId()));
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

    /**
     * @see com.popultrade.dao.TemplateMenunDAO#getTemplateMenuns(com.popultrade.model.TemplateMenun)
     */
    public List getTemplateMenuns(final TemplateMenun templateMenun) {
       if (templateMenun == null) {
            return getHibernateTemplate().find("from TemplateMenun");
        } else {
            // filter on properties set in the templateMenun
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateMenun).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateMenun.class).add(ex);
if (templateMenun.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateMenun.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateMenunDAO#getTemplateMenun(Long id)
     */
    public TemplateMenun getTemplateMenun(final Long id) {
        TemplateMenun templateMenun = (TemplateMenun) getHibernateTemplate().get(TemplateMenun.class, id);
        if (templateMenun == null) {
            log.warn("uh oh, templateMenun with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateMenun.class, id);
        }

        return templateMenun;
    }

    /**
     * @see com.popultrade.dao.TemplateMenunDAO#saveTemplateMenun(TemplateMenun templateMenun)
     */    
    public void saveTemplateMenun(final TemplateMenun templateMenun) {
        getHibernateTemplate().saveOrUpdate(templateMenun);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateMenunDAO#removeTemplateMenun(Long id)
     */
    public void removeTemplateMenun(final Long id) {
        getHibernateTemplate().delete(getTemplateMenun(id));
        getHibernateTemplate().flush();
    }
}
