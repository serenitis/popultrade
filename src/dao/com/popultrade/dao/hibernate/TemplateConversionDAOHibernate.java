
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateConversion;
import com.popultrade.dao.TemplateConversionDAO;
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

public class TemplateConversionDAOHibernate extends BaseDAOHibernate implements TemplateConversionDAO {

  public List getTemplateConversions(final TemplateConversion templateConversion,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateConversion order by datum_TemplateConversiona");

      Example ex = Example.create(templateConversion).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateConversion.class).add(ex);
        if (templateConversion.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateConversion.getId()));
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

	public int getStTemplateConversion(final TemplateConversion templateConversion,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateConversion).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateConversion.class).add(ex) ; 

			  if (templateConversion.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateConversion.getId()));
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
    public List getTemplateConversions(final TemplateConversion templateConversion,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateConversion");

          if (templateConversion == null) {
              return getHibernateTemplate().find("from TemplateConversion");
          } else {
              // filter on properties set in the templateConversion
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateConversion.getSFT_SIFRA());
                  	Example ex = Example.create(templateConversion).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateConversion.class).add(ex);
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
    public List getTemplateConversions2(final TemplateConversion templateConversion,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateConversion");

          if (templateConversion == null) {
              return getHibernateTemplate().find("from TemplateConversion");
          } else {
              // filter on properties set in the templateConversion
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateConversion.getSFT_SIFRA());
                  	Example ex = Example.create(templateConversion).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateConversion.class).add(ex);
                   if (templateConversion.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateConversion.getId()));
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
     * @see com.popultrade.dao.TemplateConversionDAO#getTemplateConversions(com.popultrade.model.TemplateConversion)
     */
    public List getTemplateConversions(final TemplateConversion templateConversion) {
       if (templateConversion == null) {
            return getHibernateTemplate().find("from TemplateConversion");
        } else {
            // filter on properties set in the templateConversion
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateConversion).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateConversion.class).add(ex);
if (templateConversion.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateConversion.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateConversionDAO#getTemplateConversion(Long id)
     */
    public TemplateConversion getTemplateConversion(final Long id) {
        TemplateConversion templateConversion = (TemplateConversion) getHibernateTemplate().get(TemplateConversion.class, id);
        if (templateConversion == null) {
            log.warn("uh oh, templateConversion with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateConversion.class, id);
        }

        return templateConversion;
    }

    /**
     * @see com.popultrade.dao.TemplateConversionDAO#saveTemplateConversion(TemplateConversion templateConversion)
     */    
    public void saveTemplateConversion(final TemplateConversion templateConversion) {
        getHibernateTemplate().saveOrUpdate(templateConversion);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateConversionDAO#removeTemplateConversion(Long id)
     */
    public void removeTemplateConversion(final Long id) {
        getHibernateTemplate().delete(getTemplateConversion(id));
        getHibernateTemplate().flush();
    }
}
