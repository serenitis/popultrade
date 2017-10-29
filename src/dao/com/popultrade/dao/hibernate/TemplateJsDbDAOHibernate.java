
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateJsDb;
import com.popultrade.dao.TemplateJsDbDAO;
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

public class TemplateJsDbDAOHibernate extends BaseDAOHibernate implements TemplateJsDbDAO {

	
	
	
	
	   public void deleteAll() {
			
		   
			try {
				
				
				
				String que = "delete from TemplateJsDb where id!=-1 ";
				//System.out.println(que);
				currentSession().createQuery(que).executeUpdate();
				
		
				
				
			}
			catch (Exception ex) {
				org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
				log.error(ex.toString());
			}
		   
		   
	   }
	
	
	
	
	
	
	
	
	
  public List getTemplateJsDbs(final TemplateJsDb templateJsDb,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateJsDb order by datum_TemplateJsDba");

      Example ex = Example.create(templateJsDb).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateJsDb.class).add(ex);
        if (templateJsDb.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateJsDb.getId()));
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

	public int getStTemplateJsDb(final TemplateJsDb templateJsDb,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateJsDb).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateJsDb.class).add(ex) ; 

			  if (templateJsDb.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateJsDb.getId()));
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
    public List getTemplateJsDbs(final TemplateJsDb templateJsDb,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateJsDb");

          if (templateJsDb == null) {
              return getHibernateTemplate().find("from TemplateJsDb");
          } else {
              // filter on properties set in the templateJsDb
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateJsDb.getSFT_SIFRA());
                  	Example ex = Example.create(templateJsDb).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateJsDb.class).add(ex);
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
    public List getTemplateJsDbs2(final TemplateJsDb templateJsDb,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateJsDb");

          if (templateJsDb == null) {
              return getHibernateTemplate().find("from TemplateJsDb");
          } else {
              // filter on properties set in the templateJsDb
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateJsDb.getSFT_SIFRA());
                  	Example ex = Example.create(templateJsDb).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateJsDb.class).add(ex);
                   if (templateJsDb.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateJsDb.getId()));
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
     * @see com.popultrade.dao.TemplateJsDbDAO#getTemplateJsDbs(com.popultrade.model.TemplateJsDb)
     */
    public List getTemplateJsDbs(final TemplateJsDb templateJsDb) {
       if (templateJsDb == null) {
            return getHibernateTemplate().find("from TemplateJsDb");
        } else {
            // filter on properties set in the templateJsDb
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateJsDb).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateJsDb.class).add(ex);
if (templateJsDb.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateJsDb.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateJsDbDAO#getTemplateJsDb(Long id)
     */
    public TemplateJsDb getTemplateJsDb(final Long id) {
        TemplateJsDb templateJsDb = (TemplateJsDb) getHibernateTemplate().get(TemplateJsDb.class, id);
        if (templateJsDb == null) {
            log.warn("uh oh, templateJsDb with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateJsDb.class, id);
        }

        return templateJsDb;
    }

    /**
     * @see com.popultrade.dao.TemplateJsDbDAO#saveTemplateJsDb(TemplateJsDb templateJsDb)
     */    
    public void saveTemplateJsDb(final TemplateJsDb templateJsDb) {
        getHibernateTemplate().saveOrUpdate(templateJsDb);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateJsDbDAO#removeTemplateJsDb(Long id)
     */
    public void removeTemplateJsDb(final Long id) {
        getHibernateTemplate().delete(getTemplateJsDb(id));
        getHibernateTemplate().flush();
    }
}
