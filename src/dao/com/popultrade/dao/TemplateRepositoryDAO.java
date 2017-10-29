
package com.popultrade.dao;

import java.util.List;
import java.sql.Connection;
import com.popultrade.model.TemplateRepository;

public interface TemplateRepositoryDAO extends DAO {

	public List getTemplateRepositorys(final TemplateRepository templateRepository,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
	public int getStTemplateRepository(final TemplateRepository templateRepository,String dodatni_sql_pogoji);
	public List getTemplateRepositorys2(final TemplateRepository templateRepository,final String orderby,final String orderby_smer,final String dodaten_hql);
	public List getTemplateRepositorys(final TemplateRepository templateRepository,final String orderby,final String orderby_smer);


    /**
     * Retrieves all of the templateRepositorys
     */
    public List getTemplateRepositorys(TemplateRepository templateRepository);

    /**
     * Gets templateRepository's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateRepository's id
     * @return templateRepository populated templateRepository object
     */
    public TemplateRepository getTemplateRepository(final Long id);

    /**
     * Saves a templateRepository's information
     * @param templateRepository the object to be saved
     */	
    public void saveTemplateRepository(TemplateRepository templateRepository);

	/**
     * Removes a templateRepository from the database by id
     * @param id the templateRepository's id
     */
    public void removeTemplateRepository(final Long id);
}

