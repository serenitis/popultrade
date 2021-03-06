package com.popultrade.dao.ibatis;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.acegisecurity.userdetails.UserDetails;
import org.acegisecurity.userdetails.UserDetailsService;
import org.acegisecurity.userdetails.UsernameNotFoundException;
import com.popultrade.dao.UserDAO;
import com.popultrade.model.Role;
import com.popultrade.model.User;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

/**
 * This class interacts with iBatis's SQL Maps to save and retrieve User
 * related objects.
 *
 * <p><a href="UserDAOiBatis.java.html"><i>View Source</i></a></p>
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
public class UserDAOiBatis extends SqlMapClientDaoSupport implements UserDAO, UserDetailsService {
    /**
     * Get user by username.
     *
     * @param username the user's username
     * @return a populated user object
     */
    public User getUser(String username) {
        User user = (User) getSqlMapClientTemplate().queryForObject("getUser", username);

        if (user == null) {
            logger.warn("uh oh, user not found...");
            throw new ObjectRetrievalFailureException(User.class, username);
        } else {
            List roles = getSqlMapClientTemplate().queryForList("getUserRoles", user);
            user.setRoles(new HashSet(roles));
        }

        return user;
    }

    /**
     * @see com.popultrade.dao.UserDAO#getUsers(com.popultrade.model.User)
     */
    public List getUsers(User user) {
        List users = getSqlMapClientTemplate().queryForList("getUsers", null);

        // get the roles for each user
        for (int i = 0; i < users.size(); i++) {
            user = (User) users.get(i);

            List roles =  getSqlMapClientTemplate().queryForList("getUserRoles", user);
            user.setRoles(new HashSet(roles));
            users.set(i, user);
        }

        return users;
    }

    /**
     * Convenience method to delete roles
     * @param user
     */
    private void deleteUserRoles(final User user) {
        getSqlMapClientTemplate().update("deleteUserRoles", user);
    }

    private void addUserRoles(final User user) {
        if (user.getRoles() != null) {
            for (Iterator it = user.getRoles().iterator(); it.hasNext();) {
                Role role = (Role) it.next();
                Map newRole = new HashMap();
                newRole.put("username", user.getUsername());
                newRole.put("roleName", role.getName());

                List userRoles = getSqlMapClientTemplate().queryForList("getUserRoles", user.getUsername());

                if (userRoles.isEmpty()) {
                    getSqlMapClientTemplate().update("addUserRole", newRole);
                }
            }
        }
    }

    /**
     * @see com.popultrade.dao.UserDAO#saveUser(com.popultrade.model.User)
     */
    public void saveUser(final User user) {
        if (user.getVersion() == null) {
            user.setVersion(new Integer(1));
            getSqlMapClientTemplate().update("addUser", user);
            addUserRoles(user);
        } else {
            user.setVersion(new Integer(user.getVersion().intValue()+1));
            getSqlMapClientTemplate().update("updateUser", user);
            deleteUserRoles(user);
            addUserRoles(user);
        }
    }

    /**
     * @see com.popultrade.dao.UserDAO#removeUser(java.lang.String)
     */
    public void removeUser(String username) {
        User user = getUser(username);
        deleteUserRoles(user);
        getSqlMapClientTemplate().update("deleteUser", user);
    }
    
    /** 
     * @see org.acegisecurity.userdetails.UserDetailsService#loadUserByUsername(java.lang.String)
     */
     public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
         try {
             return getUser(username);
         } catch (ObjectRetrievalFailureException e) {
             throw new UsernameNotFoundException("user '" + username + "' not found...");
         }
     }
}
