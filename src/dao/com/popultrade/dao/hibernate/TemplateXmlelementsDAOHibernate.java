
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateXmlelements;
import com.popultrade.dao.TemplateXmlelementsDAO;
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

public class TemplateXmlelementsDAOHibernate extends BaseDAOHibernate implements TemplateXmlelementsDAO {

  public List getTemplateXmlelementss(final TemplateXmlelements templateXmlelements,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateXmlelements order by datum_TemplateXmlelementsa");

      Example ex = Example.create(templateXmlelements).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateXmlelements.class).add(ex);
        if (templateXmlelements.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateXmlelements.getId()));
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

	public int getStTemplateXmlelements(final TemplateXmlelements templateXmlelements,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateXmlelements).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateXmlelements.class).add(ex) ; 

			  if (templateXmlelements.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateXmlelements.getId()));
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


    public List getTemplateXmlelementss(final TemplateXmlelements templateXmlelements,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateXmlelements");

          if (templateXmlelements == null) {
              return getHibernateTemplate().find("from TemplateXmlelements");
          } else {
              // filter on properties set in the templateXmlelements
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateXmlelements.getSFT_SIFRA());
                  	Example ex = Example.create(templateXmlelements).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateXmlelements.class).add(ex);
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
    public List getTemplateXmlelementss2(final TemplateXmlelements templateXmlelements,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateXmlelements");

          if (templateXmlelements == null) {
              return getHibernateTemplate().find("from TemplateXmlelements");
          } else {
              // filter on properties set in the templateXmlelements
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateXmlelements.getSFT_SIFRA());
                  	Example ex = Example.create(templateXmlelements).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateXmlelements.class).add(ex);
                   if (templateXmlelements.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateXmlelements.getId()));
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
     * @see com.popultrade.dao.TemplateXmlelementsDAO#getTemplateXmlelementss(com.popultrade.model.TemplateXmlelements)
     */
    public List getTemplateXmlelementss(final TemplateXmlelements templateXmlelements) {
       if (templateXmlelements == null) {
            return getHibernateTemplate().find("from TemplateXmlelements");
        } else {
            // filter on properties set in the templateXmlelements
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateXmlelements).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateXmlelements.class).add(ex);
if (templateXmlelements.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateXmlelements.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateXmlelementsDAO#getTemplateXmlelements(Long id)
     */
    public TemplateXmlelements getTemplateXmlelements(final Long id) {
        TemplateXmlelements templateXmlelements = (TemplateXmlelements) getHibernateTemplate().get(TemplateXmlelements.class, id);
        if (templateXmlelements == null) {
            log.warn("uh oh, templateXmlelements with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateXmlelements.class, id);
        }

        return templateXmlelements;
    }

    /**
     * @see com.popultrade.dao.TemplateXmlelementsDAO#saveTemplateXmlelements(TemplateXmlelements templateXmlelements)
     */    
    public void saveTemplateXmlelements(final TemplateXmlelements templateXmlelements) {
        getHibernateTemplate().saveOrUpdate(templateXmlelements);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateXmlelementsDAO#removeTemplateXmlelements(Long id)
     */
    public void removeTemplateXmlelements(final Long id) {
        getHibernateTemplate().delete(getTemplateXmlelements(id));
        getHibernateTemplate().flush();
    }

	@Override
	public Connection pridobiConnectionZaProceduro() {
		// TODO Auto-generated method stub
		return null;
	}
}
