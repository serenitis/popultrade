
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateXmlapp;
import com.popultrade.dao.TemplateXmlappDAO;
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

public class TemplateXmlappDAOHibernate extends BaseDAOHibernate implements TemplateXmlappDAO {

  public List getTemplateXmlapps(final TemplateXmlapp templateXmlapp,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateXmlapp order by datum_TemplateXmlappa");

      Example ex = Example.create(templateXmlapp).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateXmlapp.class).add(ex);
        if (templateXmlapp.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateXmlapp.getId()));
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

	public int getStTemplateXmlapp(final TemplateXmlapp templateXmlapp,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateXmlapp).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateXmlapp.class).add(ex) ; 

			  if (templateXmlapp.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateXmlapp.getId()));
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
    public List getTemplateXmlapps(final TemplateXmlapp templateXmlapp,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateXmlapp");

          if (templateXmlapp == null) {
              return getHibernateTemplate().find("from TemplateXmlapp");
          } else {
              // filter on properties set in the templateXmlapp
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateXmlapp.getSFT_SIFRA());
                  	Example ex = Example.create(templateXmlapp).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateXmlapp.class).add(ex);
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
    public List getTemplateXmlapps2(final TemplateXmlapp templateXmlapp,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateXmlapp");

          if (templateXmlapp == null) {
              return getHibernateTemplate().find("from TemplateXmlapp");
          } else {
              // filter on properties set in the templateXmlapp
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateXmlapp.getSFT_SIFRA());
                  	Example ex = Example.create(templateXmlapp).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateXmlapp.class).add(ex);
                   if (templateXmlapp.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateXmlapp.getId()));
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
     * @see com.popultrade.dao.TemplateXmlappDAO#getTemplateXmlapps(com.popultrade.model.TemplateXmlapp)
     */
    public List getTemplateXmlapps(final TemplateXmlapp templateXmlapp) {
       if (templateXmlapp == null) {
            return getHibernateTemplate().find("from TemplateXmlapp");
        } else {
            // filter on properties set in the templateXmlapp
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateXmlapp).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateXmlapp.class).add(ex);
if (templateXmlapp.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateXmlapp.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateXmlappDAO#getTemplateXmlapp(Long id)
     */
    public TemplateXmlapp getTemplateXmlapp(final Long id) {
        TemplateXmlapp templateXmlapp = (TemplateXmlapp) getHibernateTemplate().get(TemplateXmlapp.class, id);
        if (templateXmlapp == null) {
            log.warn("uh oh, templateXmlapp with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateXmlapp.class, id);
        }

        return templateXmlapp;
    }

    /**
     * @see com.popultrade.dao.TemplateXmlappDAO#saveTemplateXmlapp(TemplateXmlapp templateXmlapp)
     */    
    public void saveTemplateXmlapp(final TemplateXmlapp templateXmlapp) {
        getHibernateTemplate().saveOrUpdate(templateXmlapp);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateXmlappDAO#removeTemplateXmlapp(Long id)
     */
    public void removeTemplateXmlapp(final Long id) {
        getHibernateTemplate().delete(getTemplateXmlapp(id));
        getHibernateTemplate().flush();
    }
}
