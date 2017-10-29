
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateTablesGen;
import com.popultrade.dao.TemplateTablesGenDAO;
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

public class TemplateTablesGenDAOHibernate extends BaseDAOHibernate implements TemplateTablesGenDAO {

  public List getTemplateTablesGens(final TemplateTablesGen templateTablesGen,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateTablesGen order by datum_TemplateTablesGena");

      Example ex = Example.create(templateTablesGen).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateTablesGen.class).add(ex);
        if (templateTablesGen.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateTablesGen.getId()));
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

	public int getStTemplateTablesGen(final TemplateTablesGen templateTablesGen,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateTablesGen).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateTablesGen.class).add(ex) ; 
//System.out.println("x1");
			  if (templateTablesGen.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateTablesGen.getId()));
		        }
			//  System.out.println("x12");
			criteria.setProjection(Projections.rowCount()); 
			   if (!dodatni_sql_pogoji.equals("")) {
				   criteria.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
		        }
			 //  System.out.println("x13 " +((Long)criteria.list().get(0)).intValue());
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
    public List getTemplateTablesGens(final TemplateTablesGen templateTablesGen,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateTablesGen");

          if (templateTablesGen == null) {
              return getHibernateTemplate().find("from TemplateTablesGen");
          } else {
              // filter on properties set in the templateTablesGen
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateTablesGen.getSFT_SIFRA());
                  	Example ex = Example.create(templateTablesGen).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateTablesGen.class).add(ex);
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
    public List getTemplateTablesGens2(final TemplateTablesGen templateTablesGen,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateTablesGen");

          if (templateTablesGen == null) {
              return getHibernateTemplate().find("from TemplateTablesGen");
          } else {
              // filter on properties set in the templateTablesGen
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateTablesGen.getSFT_SIFRA());
                  	Example ex = Example.create(templateTablesGen).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateTablesGen.class).add(ex);
                   if (templateTablesGen.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateTablesGen.getId()));
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
     * @see com.popultrade.dao.TemplateTablesGenDAO#getTemplateTablesGens(com.popultrade.model.TemplateTablesGen)
     */
    public List getTemplateTablesGens(final TemplateTablesGen templateTablesGen) {
       if (templateTablesGen == null) {
            return getHibernateTemplate().find("from TemplateTablesGen");
        } else {
            // filter on properties set in the templateTablesGen
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateTablesGen).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateTablesGen.class).add(ex);
if (templateTablesGen.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateTablesGen.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateTablesGenDAO#getTemplateTablesGen(Long id)
     */
    public TemplateTablesGen getTemplateTablesGen(final Long id) {
        TemplateTablesGen templateTablesGen = (TemplateTablesGen) getHibernateTemplate().get(TemplateTablesGen.class, id);
        if (templateTablesGen == null) {
            log.warn("uh oh, templateTablesGen with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateTablesGen.class, id);
        }

        return templateTablesGen;
    }

    /**
     * @see com.popultrade.dao.TemplateTablesGenDAO#saveTemplateTablesGen(TemplateTablesGen templateTablesGen)
     */    
    public void saveTemplateTablesGen(final TemplateTablesGen templateTablesGen) {
        getHibernateTemplate().saveOrUpdate(templateTablesGen);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateTablesGenDAO#removeTemplateTablesGen(Long id)
     */
    public void removeTemplateTablesGen(final Long id) {
        getHibernateTemplate().delete(getTemplateTablesGen(id));
        getHibernateTemplate().flush();
    }
}
