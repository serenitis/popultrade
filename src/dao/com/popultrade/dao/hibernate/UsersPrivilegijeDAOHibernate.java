
package com.popultrade.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import com.popultrade.model.UsersPrivilegije;
import com.popultrade.dao.UsersPrivilegijeDAO;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class UsersPrivilegijeDAOHibernate extends BaseDAOHibernate implements UsersPrivilegijeDAO {

	
	
	   public void deleteByUser_id(String user_id) {
			
		   
			try {
				
				
				
				String que = "delete from UsersPrivilegije where user_id="+user_id+" ";
				System.out.println(que);
				currentSession().createQuery(que).executeUpdate();
				
		
				
				
			}
			catch (Exception ex) {
				org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
				log.error(ex.toString());
			}
		   
		   
	   }
	
	
	    public List getUsersPrivilegijeByUserid(String user_id) {
	        
	        
	            return getHibernateTemplate().find("from UsersPrivilegije where user_id="+user_id);
	        
	        
	    }
	
	
    /**
     * @see com.popultrade.dao.UsersPrivilegijeDAO#getUsersPrivilegijes(com.popultrade.model.UsersPrivilegije)
     */
    public List getUsersPrivilegijes(final UsersPrivilegije usersPrivilegije) {
     
        if (usersPrivilegije == null) {
            return getHibernateTemplate().find("from UsersPrivilegije");
        } else {
            // filter on properties set in the usersPrivilegije
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(usersPrivilegije).ignoreCase().enableLike(MatchMode.EXACT);
                    return session.createCriteria(UsersPrivilegije.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.UsersPrivilegijeDAO#getUsersPrivilegije(Long id)
     */
    public UsersPrivilegije getUsersPrivilegije(final Long id) {
        UsersPrivilegije usersPrivilegije = (UsersPrivilegije) getHibernateTemplate().get(UsersPrivilegije.class, id);
        if (usersPrivilegije == null) {
            log.warn("uh oh, usersPrivilegije with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(UsersPrivilegije.class, id);
        }

        return usersPrivilegije;
    }

    /**
     * @see com.popultrade.dao.UsersPrivilegijeDAO#saveUsersPrivilegije(UsersPrivilegije usersPrivilegije)
     */    
    public void saveUsersPrivilegije(final UsersPrivilegije usersPrivilegije) {
        getHibernateTemplate().saveOrUpdate(usersPrivilegije);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.UsersPrivilegijeDAO#removeUsersPrivilegije(Long id)
     */
    public void removeUsersPrivilegije(final Long id) {
        getHibernateTemplate().delete(getUsersPrivilegije(id));
getHibernateTemplate().flush();

    }
}
