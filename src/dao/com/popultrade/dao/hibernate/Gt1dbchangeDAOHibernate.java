
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.Gt1dbchange;
import com.popultrade.dao.Gt1dbchangeDAO;
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

public class Gt1dbchangeDAOHibernate extends BaseDAOHibernate implements Gt1dbchangeDAO {

  public List getGt1dbchanges(final Gt1dbchange gt1dbchange,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from Gt1dbchange order by datum_Gt1dbchangea");

      Example ex = Example.create(gt1dbchange).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(Gt1dbchange.class).add(ex);
        if (gt1dbchange.getId()!=null) {
        	cri.add(Restrictions.eq("id",gt1dbchange.getId()));
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

	public int getStGt1dbchange(final Gt1dbchange gt1dbchange,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(gt1dbchange).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(Gt1dbchange.class).add(ex) ; 

			  if (gt1dbchange.getId()!=null) {
				  criteria.add(Restrictions.eq("id",gt1dbchange.getId()));
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



    public List getGt1dbchanges(final Gt1dbchange gt1dbchange,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from Gt1dbchange");

          if (gt1dbchange == null) {
              return getHibernateTemplate().find("from Gt1dbchange");
          } else {
              // filter on properties set in the gt1dbchange
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+gt1dbchange.getSFT_SIFRA());
                  	Example ex = Example.create(gt1dbchange).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(Gt1dbchange.class).add(ex);
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
    public List getGt1dbchanges2(final Gt1dbchange gt1dbchange,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from Gt1dbchange");

          if (gt1dbchange == null) {
              return getHibernateTemplate().find("from Gt1dbchange");
          } else {
              // filter on properties set in the gt1dbchange
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+gt1dbchange.getSFT_SIFRA());
                  	Example ex = Example.create(gt1dbchange).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(Gt1dbchange.class).add(ex);
                   if (gt1dbchange.getId()!=null) {
        	cri.add(Restrictions.eq("id",gt1dbchange.getId()));
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
     * @see com.popultrade.dao.Gt1dbchangeDAO#getGt1dbchanges(com.popultrade.model.Gt1dbchange)
     */
    public List getGt1dbchanges(final Gt1dbchange gt1dbchange) {
       if (gt1dbchange == null) {
            return getHibernateTemplate().find("from Gt1dbchange");
        } else {
            // filter on properties set in the gt1dbchange
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(gt1dbchange).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(Gt1dbchange.class).add(ex);
if (gt1dbchange.getId()!=null) {
                    cri.add(Restrictions.eq("id",gt1dbchange.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.Gt1dbchangeDAO#getGt1dbchange(Long id)
     */
    public Gt1dbchange getGt1dbchange(final Long id) {
        Gt1dbchange gt1dbchange = (Gt1dbchange) getHibernateTemplate().get(Gt1dbchange.class, id);
        if (gt1dbchange == null) {
            log.warn("uh oh, gt1dbchange with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Gt1dbchange.class, id);
        }

        return gt1dbchange;
    }

    /**
     * @see com.popultrade.dao.Gt1dbchangeDAO#saveGt1dbchange(Gt1dbchange gt1dbchange)
     */    
    public void saveGt1dbchange(final Gt1dbchange gt1dbchange) {
        getHibernateTemplate().saveOrUpdate(gt1dbchange);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.Gt1dbchangeDAO#removeGt1dbchange(Long id)
     */
    public void removeGt1dbchange(final Long id) {
        getHibernateTemplate().delete(getGt1dbchange(id));
        getHibernateTemplate().flush();
    }
}
