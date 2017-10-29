
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateCustomClass;

import com.popultrade.dao.TemplateCustomClassDAO;
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

public class TemplateCustomClassDAOHibernate extends BaseDAOHibernate implements TemplateCustomClassDAO {

  public List getTemplateCustomClasss(final TemplateCustomClass templateCustomClass,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateCustomClass order by datum_TemplateCustomClassa");

      Example ex = Example.create(templateCustomClass).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateCustomClass.class).add(ex);
        if (templateCustomClass.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateCustomClass.getId()));
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

  
  
  
  public TemplateCustomClass getTemplateCustomClass(String thid) {
      List li = getHibernateTemplate().find("from TemplateCustomClass where class_name='"+thid+"'");
      
      try {
      	if (li.size()==1) {
      	return (TemplateCustomClass)li.get(0);
      	}
      	
      }
      catch (Exception j) {
      	
      }
      return null;
  }
  
  
  
  
  
  
  
	public int getStTemplateCustomClass(final TemplateCustomClass templateCustomClass,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateCustomClass).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateCustomClass.class).add(ex) ; 

			  if (templateCustomClass.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateCustomClass.getId()));
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
    public List getTemplateCustomClasss(final TemplateCustomClass templateCustomClass,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateCustomClass");

          if (templateCustomClass == null) {
              return getHibernateTemplate().find("from TemplateCustomClass");
          } else {
              // filter on properties set in the templateCustomClass
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateCustomClass.getSFT_SIFRA());
                  	Example ex = Example.create(templateCustomClass).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateCustomClass.class).add(ex);
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
    public List getTemplateCustomClasss2(final TemplateCustomClass templateCustomClass,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateCustomClass");

          if (templateCustomClass == null) {
              return getHibernateTemplate().find("from TemplateCustomClass");
          } else {
              // filter on properties set in the templateCustomClass
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateCustomClass.getSFT_SIFRA());
                  	Example ex = Example.create(templateCustomClass).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateCustomClass.class).add(ex);
                   if (templateCustomClass.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateCustomClass.getId()));
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
     * @see com.popultrade.dao.TemplateCustomClassDAO#getTemplateCustomClasss(com.popultrade.model.TemplateCustomClass)
     */
    public List getTemplateCustomClasss(final TemplateCustomClass templateCustomClass) {
       if (templateCustomClass == null) {
            return getHibernateTemplate().find("from TemplateCustomClass");
        } else {
            // filter on properties set in the templateCustomClass
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateCustomClass).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateCustomClass.class).add(ex);
if (templateCustomClass.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateCustomClass.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateCustomClassDAO#getTemplateCustomClass(Long id)
     */
    public TemplateCustomClass getTemplateCustomClass(final Long id) {
        TemplateCustomClass templateCustomClass = (TemplateCustomClass) getHibernateTemplate().get(TemplateCustomClass.class, id);
        if (templateCustomClass == null) {
            log.warn("uh oh, templateCustomClass with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateCustomClass.class, id);
        }

        return templateCustomClass;
    }

    /**
     * @see com.popultrade.dao.TemplateCustomClassDAO#saveTemplateCustomClass(TemplateCustomClass templateCustomClass)
     */    
    public void saveTemplateCustomClass(final TemplateCustomClass templateCustomClass) {
        getHibernateTemplate().saveOrUpdate(templateCustomClass);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateCustomClassDAO#removeTemplateCustomClass(Long id)
     */
    public void removeTemplateCustomClass(final Long id) {
        getHibernateTemplate().delete(getTemplateCustomClass(id));
        getHibernateTemplate().flush();
    }
}
