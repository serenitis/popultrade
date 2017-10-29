
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.UsersPrivilegije;

public interface UsersPrivilegijeDAO extends DAO {
	public void deleteByUser_id(String user_id);
	 public List getUsersPrivilegijeByUserid(String user_id) ;
    /**
     * Retrieves all of the usersPrivilegijes
     */
    public List getUsersPrivilegijes(UsersPrivilegije usersPrivilegije);

    /**
     * Gets usersPrivilegije's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the usersPrivilegije's id
     * @return usersPrivilegije populated usersPrivilegije object
     */
    public UsersPrivilegije getUsersPrivilegije(final Long id);

    /**
     * Saves a usersPrivilegije's information
     * @param usersPrivilegije the object to be saved
     */	
    public void saveUsersPrivilegije(UsersPrivilegije usersPrivilegije);

	/**
     * Removes a usersPrivilegije from the database by id
     * @param id the usersPrivilegije's id
     */
    public void removeUsersPrivilegije(final Long id);
}

