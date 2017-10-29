
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateCssDefault;
import com.popultrade.dao.TemplateCssDefaultDAO;
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

public class TemplateCssDefaultDAOHibernate extends BaseDAOHibernate implements TemplateCssDefaultDAO {

  public List getTemplateCssDefaults(final TemplateCssDefault templateCssDefault,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateCssDefault order by datum_TemplateCssDefaulta");

      Example ex = Example.create(templateCssDefault).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateCssDefault.class).add(ex);
        if (templateCssDefault.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateCssDefault.getId()));
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

	public int getStTemplateCssDefault(final TemplateCssDefault templateCssDefault,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateCssDefault).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateCssDefault.class).add(ex) ; 

			  if (templateCssDefault.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateCssDefault.getId()));
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
    public List getTemplateCssDefaults(final TemplateCssDefault templateCssDefault,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateCssDefault");

          if (templateCssDefault == null) {
              return getHibernateTemplate().find("from TemplateCssDefault");
          } else {
              // filter on properties set in the templateCssDefault
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateCssDefault.getSFT_SIFRA());
                  	Example ex = Example.create(templateCssDefault).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateCssDefault.class).add(ex);
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
    public List getTemplateCssDefaults2(final TemplateCssDefault templateCssDefault,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateCssDefault");

          if (templateCssDefault == null) {
              return getHibernateTemplate().find("from TemplateCssDefault");
          } else {
              // filter on properties set in the templateCssDefault
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateCssDefault.getSFT_SIFRA());
                  	Example ex = Example.create(templateCssDefault).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateCssDefault.class).add(ex);
                   if (templateCssDefault.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateCssDefault.getId()));
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
     * @see com.popultrade.dao.TemplateCssDefaultDAO#getTemplateCssDefaults(com.popultrade.model.TemplateCssDefault)
     */
    public List getTemplateCssDefaults(final TemplateCssDefault templateCssDefault) {
       if (templateCssDefault == null) {
            return getHibernateTemplate().find("from TemplateCssDefault");
        } else {
            // filter on properties set in the templateCssDefault
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateCssDefault).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateCssDefault.class).add(ex);
if (templateCssDefault.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateCssDefault.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateCssDefaultDAO#getTemplateCssDefault(Long id)
     */
    public TemplateCssDefault getTemplateCssDefault(final Long id) {
        TemplateCssDefault templateCssDefault = (TemplateCssDefault) getHibernateTemplate().get(TemplateCssDefault.class, id);
        if (templateCssDefault == null) {
            log.warn("uh oh, templateCssDefault with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateCssDefault.class, id);
        }

        return templateCssDefault;
    }

    /**
     * @see com.popultrade.dao.TemplateCssDefaultDAO#saveTemplateCssDefault(TemplateCssDefault templateCssDefault)
     */    
    public void saveTemplateCssDefault(final TemplateCssDefault templateCssDefault) {
        getHibernateTemplate().saveOrUpdate(templateCssDefault);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateCssDefaultDAO#removeTemplateCssDefault(Long id)
     */
    public void removeTemplateCssDefault(final Long id) {
        getHibernateTemplate().delete(getTemplateCssDefault(id));
        getHibernateTemplate().flush();
    }
}
