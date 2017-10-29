
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.Users;

public interface UsersDAO extends DAO {
	public int getStUsers(final Users users,String dodatni_sql_pogoji);
	public List getUserss2(final Users users,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getUserss(final Users users,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStUsers(final Users users);
	public List getUserss(final Users users,final int pageNumber,final int pageSize) ;
	public List getUserssExactly(final Users users);
	public List getUserss(final Users vd1osebe,final String orderby,final String orderby_smer);
    /**
     * Retrieves all of the userss
     */
    public List getUserss(Users users);

    /**
     * Gets users's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the users's id
     * @return users populated users object
     */
    public Users getUsers(final Long id);

    /**
     * Saves a users's information
     * @param users the object to be saved
     */	
    public void saveUsers(Users users);

	/**
     * Removes a users from the database by id
     * @param id the users's id
     */
    public void removeUsers(final Long id);
}

