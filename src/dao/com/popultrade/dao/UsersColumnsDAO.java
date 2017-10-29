
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.UsersColumns;

public interface UsersColumnsDAO extends DAO {

	public List getUsersColumnss(final UsersColumns usersColumns,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStUsersColumns(final UsersColumns usersColumns,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getUsersColumnss2(final UsersColumns usersColumns,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getUsersColumnss(final UsersColumns usersColumns,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the usersColumnss
     */
    public List getUsersColumnss(UsersColumns usersColumns);

    /**
     * Gets usersColumns's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the usersColumns's id
     * @return usersColumns populated usersColumns object
     */
    public UsersColumns getUsersColumns(final Long id);

    /**
     * Saves a usersColumns's information
     * @param usersColumns the object to be saved
     */	
    public void saveUsersColumns(UsersColumns usersColumns);

	/**
     * Removes a usersColumns from the database by id
     * @param id the usersColumns's id
     */
    public void removeUsersColumns(final Long id);
}

