
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateClassPP;

import com.popultrade.dao.TemplateClassPPDAO;
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

public class TemplateClassPPDAOHibernate extends BaseDAOHibernate implements TemplateClassPPDAO {

	
	
    public TemplateClassPP getTemplateClassPPs(String idui) {
        List li = getHibernateTemplate().find("from TemplateClassPP where templateclass_id="+idui);
        
        if (li.size()>0) {
        	return (TemplateClassPP)li.get(0);
        }
        else {
        	return new TemplateClassPP();
        }
        
        
    }
	
	
  public List getTemplateClassPPs(final TemplateClassPP templateClassPP,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateClassPP order by datum_TemplateClassPPa");

      Example ex = Example.create(templateClassPP).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateClassPP.class).add(ex);
        if (templateClassPP.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateClassPP.getId()));
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

	public int getStTemplateClassPP(final TemplateClassPP templateClassPP,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateClassPP).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateClassPP.class).add(ex) ; 

			  if (templateClassPP.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateClassPP.getId()));
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
    public List getTemplateClassPPs(final TemplateClassPP templateClassPP,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateClassPP");

          if (templateClassPP == null) {
              return getHibernateTemplate().find("from TemplateClassPP");
          } else {
              // filter on properties set in the templateClassPP
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateClassPP.getSFT_SIFRA());
                  	Example ex = Example.create(templateClassPP).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateClassPP.class).add(ex);
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
    public List getTemplateClassPPs2(final TemplateClassPP templateClassPP,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateClassPP");

          if (templateClassPP == null) {
              return getHibernateTemplate().find("from TemplateClassPP");
          } else {
              // filter on properties set in the templateClassPP
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateClassPP.getSFT_SIFRA());
                  	Example ex = Example.create(templateClassPP).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateClassPP.class).add(ex);
                   if (templateClassPP.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateClassPP.getId()));
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
     * @see com.popultrade.dao.TemplateClassPPDAO#getTemplateClassPPs(com.popultrade.model.TemplateClassPP)
     */
    public List getTemplateClassPPs(final TemplateClassPP templateClassPP) {
       if (templateClassPP == null) {
            return getHibernateTemplate().find("from TemplateClassPP");
        } else {
            // filter on properties set in the templateClassPP
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateClassPP).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateClassPP.class).add(ex);
if (templateClassPP.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateClassPP.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateClassPPDAO#getTemplateClassPP(Long id)
     */
    public TemplateClassPP getTemplateClassPP(final Long id) {
        TemplateClassPP templateClassPP = (TemplateClassPP) getHibernateTemplate().get(TemplateClassPP.class, id);
        if (templateClassPP == null) {
            log.warn("uh oh, templateClassPP with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateClassPP.class, id);
        }

        return templateClassPP;
    }

    /**
     * @see com.popultrade.dao.TemplateClassPPDAO#saveTemplateClassPP(TemplateClassPP templateClassPP)
     */    
    public void saveTemplateClassPP(final TemplateClassPP templateClassPP) {
        getHibernateTemplate().saveOrUpdate(templateClassPP);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateClassPPDAO#removeTemplateClassPP(Long id)
     */
    public void removeTemplateClassPP(final Long id) {
        getHibernateTemplate().delete(getTemplateClassPP(id));
        getHibernateTemplate().flush();
    }
}
