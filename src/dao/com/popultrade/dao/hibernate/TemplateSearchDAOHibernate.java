
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateSearch;
import com.popultrade.dao.TemplateSearchDAO;
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

public class TemplateSearchDAOHibernate extends BaseDAOHibernate implements TemplateSearchDAO {

  public List getTemplateSearchs(final TemplateSearch templateSearch,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateSearch order by datum_TemplateSearcha");

      Example ex = Example.create(templateSearch).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateSearch.class).add(ex);
        if (templateSearch.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateSearch.getId()));
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

	public int getStTemplateSearch(final TemplateSearch templateSearch,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateSearch).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateSearch.class).add(ex) ; 

			  if (templateSearch.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateSearch.getId()));
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
    public List getTemplateSearchs(final TemplateSearch templateSearch,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateSearch");

          if (templateSearch == null) {
              return getHibernateTemplate().find("from TemplateSearch");
          } else {
              // filter on properties set in the templateSearch
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateSearch.getSFT_SIFRA());
                  	Example ex = Example.create(templateSearch).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateSearch.class).add(ex);
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
    public List getTemplateSearchs2(final TemplateSearch templateSearch,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateSearch");

          if (templateSearch == null) {
              return getHibernateTemplate().find("from TemplateSearch");
          } else {
              // filter on properties set in the templateSearch
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateSearch.getSFT_SIFRA());
                  	Example ex = Example.create(templateSearch).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateSearch.class).add(ex);
                   if (templateSearch.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateSearch.getId()));
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
     * @see com.popultrade.dao.TemplateSearchDAO#getTemplateSearchs(com.popultrade.model.TemplateSearch)
     */
    public List getTemplateSearchs(final TemplateSearch templateSearch) {
       if (templateSearch == null) {
            return getHibernateTemplate().find("from TemplateSearch");
        } else {
            // filter on properties set in the templateSearch
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateSearch).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateSearch.class).add(ex);
if (templateSearch.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateSearch.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateSearchDAO#getTemplateSearch(Long id)
     */
    public TemplateSearch getTemplateSearch(final Long id) {
        TemplateSearch templateSearch = (TemplateSearch) getHibernateTemplate().get(TemplateSearch.class, id);
        if (templateSearch == null) {
            log.warn("uh oh, templateSearch with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateSearch.class, id);
        }

        return templateSearch;
    }

    /**
     * @see com.popultrade.dao.TemplateSearchDAO#saveTemplateSearch(TemplateSearch templateSearch)
     */    
    public void saveTemplateSearch(final TemplateSearch templateSearch) {
        getHibernateTemplate().saveOrUpdate(templateSearch);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateSearchDAO#removeTemplateSearch(Long id)
     */
    public void removeTemplateSearch(final Long id) {
        getHibernateTemplate().delete(getTemplateSearch(id));
        getHibernateTemplate().flush();
    }
}
