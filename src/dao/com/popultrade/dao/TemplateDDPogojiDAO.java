
package com.popultrade.dao;

import java.util.List;


import com.popultrade.model.TemplateDDPogoji;

public interface TemplateDDPogojiDAO extends DAO {
	 public List getTemplateDDPogojis(final TemplateDDPogoji templateDDPogoji,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
			
    /**
     * Retrieves all of the templateDDPogojis
     */
    public List getTemplateDDPogojis(TemplateDDPogoji templateDDPogoji);

    /**
     * Gets templateDDPogoji's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateDDPogoji's id
     * @return templateDDPogoji populated templateDDPogoji object
     */
    public TemplateDDPogoji getTemplateDDPogoji(final Long id);

    /**
     * Saves a templateDDPogoji's information
     * @param templateDDPogoji the object to be saved
     */	
    public void saveTemplateDDPogoji(TemplateDDPogoji templateDDPogoji);

	/**
     * Removes a templateDDPogoji from the database by id
     * @param id the templateDDPogoji's id
     */
    public void removeTemplateDDPogoji(final Long id);
}

