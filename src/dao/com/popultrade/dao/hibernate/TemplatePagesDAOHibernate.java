
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplatePages;
import com.popultrade.dao.TemplatePagesDAO;
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

public class TemplatePagesDAOHibernate extends BaseDAOHibernate implements TemplatePagesDAO {

  public List getTemplatePagess(final TemplatePages templatePages,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplatePages order by datum_TemplatePagesa");

      Example ex = Example.create(templatePages).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplatePages.class).add(ex);
        if (templatePages.getId()!=null) {
        	cri.add(Restrictions.eq("id",templatePages.getId()));
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

	public int getStTemplatePages(final TemplatePages templatePages,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templatePages).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplatePages.class).add(ex) ; 

			  if (templatePages.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templatePages.getId()));
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



    public List getTemplatePagess(final TemplatePages templatePages,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplatePages");

          if (templatePages == null) {
              return getHibernateTemplate().find("from TemplatePages");
          } else {
              // filter on properties set in the templatePages
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templatePages.getSFT_SIFRA());
                  	Example ex = Example.create(templatePages).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplatePages.class).add(ex);
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
    public List getTemplatePagess2(final TemplatePages templatePages,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplatePages");

          if (templatePages == null) {
              return getHibernateTemplate().find("from TemplatePages");
          } else {
              // filter on properties set in the templatePages
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templatePages.getSFT_SIFRA());
                  	Example ex = Example.create(templatePages).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplatePages.class).add(ex);
                   if (templatePages.getId()!=null) {
        	cri.add(Restrictions.eq("id",templatePages.getId()));
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
     * @see com.popultrade.dao.TemplatePagesDAO#getTemplatePagess(com.popultrade.model.TemplatePages)
     */
    public List getTemplatePagess(final TemplatePages templatePages) {
       if (templatePages == null) {
            return getHibernateTemplate().find("from TemplatePages");
        } else {
            // filter on properties set in the templatePages
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templatePages).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplatePages.class).add(ex);
if (templatePages.getId()!=null) {
                    cri.add(Restrictions.eq("id",templatePages.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplatePagesDAO#getTemplatePages(Long id)
     */
    public TemplatePages getTemplatePages(final Long id) {
        TemplatePages templatePages = (TemplatePages) getHibernateTemplate().get(TemplatePages.class, id);
        if (templatePages == null) {
            log.warn("uh oh, templatePages with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplatePages.class, id);
        }

        return templatePages;
    }

    /**
     * @see com.popultrade.dao.TemplatePagesDAO#saveTemplatePages(TemplatePages templatePages)
     */    
    public void saveTemplatePages(final TemplatePages templatePages) {
        getHibernateTemplate().saveOrUpdate(templatePages);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplatePagesDAO#removeTemplatePages(Long id)
     */
    public void removeTemplatePages(final Long id) {
        getHibernateTemplate().delete(getTemplatePages(id));
        getHibernateTemplate().flush();
    }
}
