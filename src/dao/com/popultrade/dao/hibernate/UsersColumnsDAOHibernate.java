
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.UsersColumns;
import com.popultrade.dao.UsersColumnsDAO;
import org.springframework.orm.ObjectRetrievalFailureException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.spi.SessionFactoryImplementor;

import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class UsersColumnsDAOHibernate extends BaseDAOHibernate implements UsersColumnsDAO {

  public List getUsersColumnss(final UsersColumns usersColumns,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from UsersColumns order by datum_UsersColumnsa");

      Example ex = Example.create(usersColumns).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(UsersColumns.class).add(ex);
        if (usersColumns.getId()!=null) {
        	cri.add(Restrictions.eq("id",usersColumns.getId()));
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

	public int getStUsersColumns(final UsersColumns usersColumns,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(usersColumns).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(UsersColumns.class).add(ex) ; 

			  if (usersColumns.getId()!=null) {
				  criteria.add(Restrictions.eq("id",usersColumns.getId()));
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
    public List getUsersColumnss(final UsersColumns usersColumns,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from UsersColumns");

          if (usersColumns == null) {
              return getHibernateTemplate().find("from UsersColumns");
          } else {
              // filter on properties set in the usersColumns
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+usersColumns.getSFT_SIFRA());
                  	Example ex = Example.create(usersColumns).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(UsersColumns.class).add(ex);
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
    public List getUsersColumnss2(final UsersColumns usersColumns,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from UsersColumns");

          if (usersColumns == null) {
              return getHibernateTemplate().find("from UsersColumns");
          } else {
              // filter on properties set in the usersColumns
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+usersColumns.getSFT_SIFRA());
                  	Example ex = Example.create(usersColumns).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(UsersColumns.class).add(ex);
                   if (usersColumns.getId()!=null) {
        	cri.add(Restrictions.eq("id",usersColumns.getId()));
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
     * @see com.popultrade.dao.UsersColumnsDAO#getUsersColumnss(com.popultrade.model.UsersColumns)
     */
    public List getUsersColumnss(final UsersColumns usersColumns) {
       if (usersColumns == null) {
            return getHibernateTemplate().find("from UsersColumns");
        } else {
            // filter on properties set in the usersColumns
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(usersColumns).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(UsersColumns.class).add(ex);
if (usersColumns.getId()!=null) {
                    cri.add(Restrictions.eq("id",usersColumns.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.UsersColumnsDAO#getUsersColumns(Long id)
     */
    public UsersColumns getUsersColumns(final Long id) {
        UsersColumns usersColumns = (UsersColumns) getHibernateTemplate().get(UsersColumns.class, id);
        if (usersColumns == null) {
            log.warn("uh oh, usersColumns with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(UsersColumns.class, id);
        }

        return usersColumns;
    }

    /**
     * @see com.popultrade.dao.UsersColumnsDAO#saveUsersColumns(UsersColumns usersColumns)
     */    
    public void saveUsersColumns(final UsersColumns usersColumns) {
        getHibernateTemplate().saveOrUpdate(usersColumns);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.UsersColumnsDAO#removeUsersColumns(Long id)
     */
    public void removeUsersColumns(final Long id) {
        getHibernateTemplate().delete(getUsersColumns(id));
        getHibernateTemplate().flush();
    }
}
