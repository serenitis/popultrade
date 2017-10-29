
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.UsersParametri;

public interface UsersParametriDAO extends DAO {

	public List getUsersParametris(final UsersParametri usersParametri,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStUsersParametri(final UsersParametri usersParametri,String dodatni_sql_pogoji);
	public Connection pridobiConnectionZaProceduro();

	public List getUsersParametris2(final UsersParametri usersParametri,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getUsersParametris(final UsersParametri usersParametri,final String orderby,final String orderby_smer);

    /**
     * Retrieves all of the usersParametris
     */
    public List getUsersParametris(UsersParametri usersParametri);

    /**
     * Gets usersParametri's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the usersParametri's id
     * @return usersParametri populated usersParametri object
     */
    public UsersParametri getUsersParametri(final Long id);

    /**
     * Saves a usersParametri's information
     * @param usersParametri the object to be saved
     */	
    public void saveUsersParametri(UsersParametri usersParametri);

	/**
     * Removes a usersParametri from the database by id
     * @param id the usersParametri's id
     */
    public void removeUsersParametri(final Long id);
}

