
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.UsersParametri;
import com.popultrade.dao.UsersParametriDAO;
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

public class UsersParametriDAOHibernate extends BaseDAOHibernate implements UsersParametriDAO {

  public List getUsersParametris(final UsersParametri usersParametri,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from UsersParametri order by datum_UsersParametria");

      Example ex = Example.create(usersParametri).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(UsersParametri.class).add(ex);
        if (usersParametri.getId()!=null) {
        	cri.add(Restrictions.eq("id",usersParametri.getId()));
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

	public int getStUsersParametri(final UsersParametri usersParametri,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(usersParametri).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(UsersParametri.class).add(ex) ; 

			  if (usersParametri.getId()!=null) {
				  criteria.add(Restrictions.eq("id",usersParametri.getId()));
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
    public List getUsersParametris(final UsersParametri usersParametri,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from UsersParametri");

          if (usersParametri == null) {
              return getHibernateTemplate().find("from UsersParametri");
          } else {
              // filter on properties set in the usersParametri
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+usersParametri.getSFT_SIFRA());
                  	Example ex = Example.create(usersParametri).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(UsersParametri.class).add(ex);
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
    public List getUsersParametris2(final UsersParametri usersParametri,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from UsersParametri");

          if (usersParametri == null) {
              return getHibernateTemplate().find("from UsersParametri");
          } else {
              // filter on properties set in the usersParametri
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+usersParametri.getSFT_SIFRA());
                  	Example ex = Example.create(usersParametri).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(UsersParametri.class).add(ex);
                   if (usersParametri.getId()!=null) {
        	cri.add(Restrictions.eq("id",usersParametri.getId()));
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
     * @see com.popultrade.dao.UsersParametriDAO#getUsersParametris(com.popultrade.model.UsersParametri)
     */
    public List getUsersParametris(final UsersParametri usersParametri) {
       if (usersParametri == null) {
            return getHibernateTemplate().find("from UsersParametri");
        } else {
            // filter on properties set in the usersParametri
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(usersParametri).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(UsersParametri.class).add(ex);
if (usersParametri.getId()!=null) {
                    cri.add(Restrictions.eq("id",usersParametri.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.UsersParametriDAO#getUsersParametri(Long id)
     */
    public UsersParametri getUsersParametri(final Long id) {
        UsersParametri usersParametri = (UsersParametri) getHibernateTemplate().get(UsersParametri.class, id);
        if (usersParametri == null) {
            log.warn("uh oh, usersParametri with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(UsersParametri.class, id);
        }

        return usersParametri;
    }

    /**
     * @see com.popultrade.dao.UsersParametriDAO#saveUsersParametri(UsersParametri usersParametri)
     */    
    public void saveUsersParametri(final UsersParametri usersParametri) {
        getHibernateTemplate().saveOrUpdate(usersParametri);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.UsersParametriDAO#removeUsersParametri(Long id)
     */
    public void removeUsersParametri(final Long id) {
        getHibernateTemplate().delete(getUsersParametri(id));
        getHibernateTemplate().flush();
    }
}
