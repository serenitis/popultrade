
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateMailList;

import com.popultrade.dao.TemplateMailListDAO;
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

public class TemplateMailListDAOHibernate extends BaseDAOHibernate implements TemplateMailListDAO {
	
    public TemplateMailList getTemplateMailListByVezaId(final Long id) {
        List mi =  getHibernateTemplate().find("from TemplateMailList where templatehead_id="+id+" ");
try {
        if (mi.size()>0) {
        	return (com.popultrade.model.TemplateMailList)mi.get(0);
        }
}
catch (Exception ex) {
	System.out.println("Napaka pri pridobivanju TemplateMailList: "+ex.toString());
}
return null;
    }
    
    
  public List getTemplateMailLists(final TemplateMailList templateMailList,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateMailList order by datum_TemplateMailLista");

      Example ex = Example.create(templateMailList).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateMailList.class).add(ex);
        if (templateMailList.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateMailList.getId()));
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

	public int getStTemplateMailList(final TemplateMailList templateMailList,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateMailList).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateMailList.class).add(ex) ; 

			  if (templateMailList.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateMailList.getId()));
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
    public List getTemplateMailLists(final TemplateMailList templateMailList,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateMailList");

          if (templateMailList == null) {
              return getHibernateTemplate().find("from TemplateMailList");
          } else {
              // filter on properties set in the templateMailList
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateMailList.getSFT_SIFRA());
                  	Example ex = Example.create(templateMailList).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateMailList.class).add(ex);
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
    public List getTemplateMailLists2(final TemplateMailList templateMailList,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateMailList");

          if (templateMailList == null) {
              return getHibernateTemplate().find("from TemplateMailList");
          } else {
              // filter on properties set in the templateMailList
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateMailList.getSFT_SIFRA());
                  	Example ex = Example.create(templateMailList).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateMailList.class).add(ex);
                   if (templateMailList.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateMailList.getId()));
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
     * @see com.popultrade.dao.TemplateMailListDAO#getTemplateMailLists(com.popultrade.model.TemplateMailList)
     */
    public List getTemplateMailLists(final TemplateMailList templateMailList) {
       if (templateMailList == null) {
            return getHibernateTemplate().find("from TemplateMailList");
        } else {
            // filter on properties set in the templateMailList
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateMailList).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateMailList.class).add(ex);
if (templateMailList.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateMailList.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateMailListDAO#getTemplateMailList(Long id)
     */
    public TemplateMailList getTemplateMailList(final Long id) {
        TemplateMailList templateMailList = (TemplateMailList) getHibernateTemplate().get(TemplateMailList.class, id);
        if (templateMailList == null) {
            log.warn("uh oh, templateMailList with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateMailList.class, id);
        }

        return templateMailList;
    }

    /**
     * @see com.popultrade.dao.TemplateMailListDAO#saveTemplateMailList(TemplateMailList templateMailList)
     */    
    public void saveTemplateMailList(final TemplateMailList templateMailList) {
        getHibernateTemplate().saveOrUpdate(templateMailList);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateMailListDAO#removeTemplateMailList(Long id)
     */
    public void removeTemplateMailList(final Long id) {
        getHibernateTemplate().delete(getTemplateMailList(id));
        getHibernateTemplate().flush();
    }
}
