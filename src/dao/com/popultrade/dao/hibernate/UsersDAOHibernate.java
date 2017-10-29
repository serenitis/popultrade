
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.Users;
import com.popultrade.dao.UsersDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;  
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class UsersDAOHibernate extends BaseDAOHibernate implements UsersDAO {
    public List getUserss(final Users vd1osebe,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from Users");

          if (vd1osebe == null) {
              return getHibernateTemplate().find("from Users");
          } else {
              // filter on properties set in the vd1osebe
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+vd1osebe.getSFT_SIFRA());
                  	Example ex = Example.create(vd1osebe).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(Users.class).add(ex);
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
	   
    public List getUserss(final Users users,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from Users order by datum_Usersa");

      Example ex = Example.create(users).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        
        Criteria cri = currentSession().createCriteria(Users.class).add(ex);
        if (users.getId()!=null) {
        	cri.add(Restrictions.eq("id",users.getId()));
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
        
        
        ///datumi v search

					
					
        
        return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }





	  public List getUserss2(final Users users,final String orderby,final String orderby_smer,final String dodaten_hql) {
	        //  return getHibernateTemplate().find("from Users");

	      
	          if (users == null) {
	              return getHibernateTemplate().find("from Users");
	          } else {
	              // filter on properties set in the users
	              HibernateCallback callback = new HibernateCallback() {
	              	
	                  public Object doInHibernate(Session session) throws HibernateException {
	                 // System.out.println("Sifrant opis:::::::::::::::: "+users.getSFT_SIFRA());
	                  	Example ex = Example.create(users).ignoreCase().enableLike(MatchMode.START);
	                      Criteria cri= session.createCriteria(Users.class).add(ex);
	                      
	                   if (users.getId()!=null) {
	        	cri.add(Restrictions.eq("id",users.getId()));
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


	
	public int getStUsers(final Users users,String dodatni_sql_pogoji) {
		
		try {
			Example ex = Example.create(users).ignoreCase().excludeZeroes().enableLike(MatchMode.START);
			Criteria criteria = currentSession().createCriteria(Users.class).add(ex) ; 
	
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






	
	
    public List getUserssExactly(final Users users) {
        // return getHibernateTemplate().find("from Users");

     System.out.println("ssssssssssssssssssssssssssssssss");
     	if (users != null) {
             // filter on properties set in the users
             HibernateCallback callback = new HibernateCallback() {
                 public Object doInHibernate(Session session) throws HibernateException {
                     Example ex = Example.create(users).ignoreCase().excludeZeroes();
                     return session.createCriteria(Users.class).add(Restrictions.eq("status", "1")).add(ex).list();
                 }
             };
             return (List) getHibernateTemplate().execute(callback);
     	}
     	else {
     		return null;
     	}
     }
    
    
	public int getStUsers(final Users users) {
		
		try {
			Example ex = Example.create(users).ignoreCase().excludeZeroes().enableLike(MatchMode.START);
			Criteria criteria = currentSession().createCriteria(Users.class).add(ex) ; 
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	

    public List getUserss(final Users users,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from Users order by datum_Usersa");

      Example ex = Example.create(users).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        
        return currentSession().createCriteria(Users.class).add(ex).addOrder(Order.asc("username")).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
    
    /**
     * @see com.popultrade.dao.UsersDAO#getUserss(com.popultrade.model.Users)
     */
    public List getUserss(final Users users) {
        return getHibernateTemplate().find("from Users order by username");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (users == null) {
            return getHibernateTemplate().find("from Users");
        } else {
            // filter on properties set in the users
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(users).ignoreCase().enableLike(MatchMode.ANYWHERE);
                    return session.createCriteria(Users.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.UsersDAO#getUsers(Long id)
     */
    public Users getUsers(final Long id) {
        Users users = (Users) getHibernateTemplate().get(Users.class, id);
        if (users == null) {
            log.warn("uh oh, users with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Users.class, id);
        }

        return users;
    }

    /**
     * @see com.popultrade.dao.UsersDAO#saveUsers(Users users)
     */    
    public void saveUsers(final Users users) {
        getHibernateTemplate().saveOrUpdate(users);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.UsersDAO#removeUsers(Long id)
     */
    public void removeUsers(final Long id) {
        getHibernateTemplate().delete(getUsers(id));
getHibernateTemplate().flush();

    }
}
