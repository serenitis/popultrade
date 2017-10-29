
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateTablesCol;
import com.popultrade.dao.TemplateTablesColDAO;
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

public class TemplateTablesColDAOHibernate extends BaseDAOHibernate implements TemplateTablesColDAO {

  public List getTemplateTablesCols(final TemplateTablesCol templateTablesCol,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateTablesCol order by datum_TemplateTablesCola");

      Example ex = Example.create(templateTablesCol).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateTablesCol.class).add(ex);
        if (templateTablesCol.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateTablesCol.getId()));
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

	public int getStTemplateTablesCol(final TemplateTablesCol templateTablesCol,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateTablesCol).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateTablesCol.class).add(ex) ; 

			  if (templateTablesCol.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateTablesCol.getId()));
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
    public List getTemplateTablesCols(final TemplateTablesCol templateTablesCol,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateTablesCol");

          if (templateTablesCol == null) {
              return getHibernateTemplate().find("from TemplateTablesCol");
          } else {
              // filter on properties set in the templateTablesCol
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateTablesCol.getSFT_SIFRA());
                  	Example ex = Example.create(templateTablesCol).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateTablesCol.class).add(ex);
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
    public List getTemplateTablesCols2(final TemplateTablesCol templateTablesCol,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateTablesCol");

          if (templateTablesCol == null) {
              return getHibernateTemplate().find("from TemplateTablesCol");
          } else {
              // filter on properties set in the templateTablesCol
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateTablesCol.getSFT_SIFRA());
                  	Example ex = Example.create(templateTablesCol).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateTablesCol.class).add(ex);
                   if (templateTablesCol.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateTablesCol.getId()));
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
     * @see com.popultrade.dao.TemplateTablesColDAO#getTemplateTablesCols(com.popultrade.model.TemplateTablesCol)
     */
    public List getTemplateTablesCols(final TemplateTablesCol templateTablesCol) {
       if (templateTablesCol == null) {
            return getHibernateTemplate().find("from TemplateTablesCol");
        } else {
            // filter on properties set in the templateTablesCol
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateTablesCol).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateTablesCol.class).add(ex);
if (templateTablesCol.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateTablesCol.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateTablesColDAO#getTemplateTablesCol(Long id)
     */
    public TemplateTablesCol getTemplateTablesCol(final Long id) {
        TemplateTablesCol templateTablesCol = (TemplateTablesCol) getHibernateTemplate().get(TemplateTablesCol.class, id);
        if (templateTablesCol == null) {
            log.warn("uh oh, templateTablesCol with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateTablesCol.class, id);
        }

        return templateTablesCol;
    }

    /**
     * @see com.popultrade.dao.TemplateTablesColDAO#saveTemplateTablesCol(TemplateTablesCol templateTablesCol)
     */    
    public void saveTemplateTablesCol(final TemplateTablesCol templateTablesCol) {
        getHibernateTemplate().saveOrUpdate(templateTablesCol);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateTablesColDAO#removeTemplateTablesCol(Long id)
     */
    public void removeTemplateTablesCol(final Long id) {
        getHibernateTemplate().delete(getTemplateTablesCol(id));
        getHibernateTemplate().flush();
    }
}
