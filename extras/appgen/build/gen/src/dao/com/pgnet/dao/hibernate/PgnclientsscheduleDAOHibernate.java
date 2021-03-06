
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.Pgnclientsschedule;
import com.popultrade.dao.PgnclientsscheduleDAO;
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
import org.hibernate.service.jdbc.connections.spi.ConnectionProvider;

import org.springframework.orm.hibernate4.HibernateCallback;

public class PgnclientsscheduleDAOHibernate extends BaseDAOHibernate implements PgnclientsscheduleDAO {

  public List getPgnclientsschedules(final Pgnclientsschedule pgnclientsschedule,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from Pgnclientsschedule order by datum_Pgnclientsschedulea");

      Example ex = Example.create(pgnclientsschedule).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(Pgnclientsschedule.class).add(ex);
        if (pgnclientsschedule.getId()!=null) {
        	cri.add(Restrictions.eq("id",pgnclientsschedule.getId()));
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

	public int getStPgnclientsschedule(final Pgnclientsschedule pgnclientsschedule,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(pgnclientsschedule).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(Pgnclientsschedule.class).add(ex) ; 

			  if (pgnclientsschedule.getId()!=null) {
				  criteria.add(Restrictions.eq("id",pgnclientsschedule.getId()));
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

	public Session getSessionProcedura() {
		return this.currentSession();
	}

    public List getPgnclientsschedules(final Pgnclientsschedule pgnclientsschedule,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from Pgnclientsschedule");

          if (pgnclientsschedule == null) {
              return getHibernateTemplate().find("from Pgnclientsschedule");
          } else {
              // filter on properties set in the pgnclientsschedule
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+pgnclientsschedule.getSFT_SIFRA());
                  	Example ex = Example.create(pgnclientsschedule).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(Pgnclientsschedule.class).add(ex);
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
    public List getPgnclientsschedules2(final Pgnclientsschedule pgnclientsschedule,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from Pgnclientsschedule");

          if (pgnclientsschedule == null) {
              return getHibernateTemplate().find("from Pgnclientsschedule");
          } else {
              // filter on properties set in the pgnclientsschedule
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+pgnclientsschedule.getSFT_SIFRA());
                  	Example ex = Example.create(pgnclientsschedule).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(Pgnclientsschedule.class).add(ex);
                   if (pgnclientsschedule.getId()!=null) {
        	cri.add(Restrictions.eq("id",pgnclientsschedule.getId()));
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
     * @see com.popultrade.dao.PgnclientsscheduleDAO#getPgnclientsschedules(com.popultrade.model.Pgnclientsschedule)
     */
    public List getPgnclientsschedules(final Pgnclientsschedule pgnclientsschedule) {
       if (pgnclientsschedule == null) {
            return getHibernateTemplate().find("from Pgnclientsschedule");
        } else {
            // filter on properties set in the pgnclientsschedule
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(pgnclientsschedule).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(Pgnclientsschedule.class).add(ex);
if (pgnclientsschedule.getId()!=null) {
                    cri.add(Restrictions.eq("id",pgnclientsschedule.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.PgnclientsscheduleDAO#getPgnclientsschedule(Long id)
     */
    public Pgnclientsschedule getPgnclientsschedule(final Long id) {
        Pgnclientsschedule pgnclientsschedule = (Pgnclientsschedule) getHibernateTemplate().get(Pgnclientsschedule.class, id);
        if (pgnclientsschedule == null) {
            log.warn("uh oh, pgnclientsschedule with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Pgnclientsschedule.class, id);
        }

        return pgnclientsschedule;
    }

    /**
     * @see com.popultrade.dao.PgnclientsscheduleDAO#savePgnclientsschedule(Pgnclientsschedule pgnclientsschedule)
     */    
    public void savePgnclientsschedule(final Pgnclientsschedule pgnclientsschedule) {
        getHibernateTemplate().saveOrUpdate(pgnclientsschedule);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.PgnclientsscheduleDAO#removePgnclientsschedule(Long id)
     */
    public void removePgnclientsschedule(final Long id) {
        getHibernateTemplate().delete(getPgnclientsschedule(id));
        getHibernateTemplate().flush();
    }
}
