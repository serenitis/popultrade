
package com.popultrade.dao;

import java.util.List;


import com.popultrade.model.TemplateUi;

public interface TemplateUiDAO extends DAO {
	 public List getTemplateUis(final TemplateUi templateUi,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
			
    /**
     * Retrieves all of the templateUis
     */
    public List getTemplateUis(TemplateUi templateUi);

    /**
     * Gets templateUi's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateUi's id
     * @return templateUi populated templateUi object
     */
    public TemplateUi getTemplateUi(final Long id);

    /**
     * Saves a templateUi's information
     * @param templateUi the object to be saved
     */	
    public void saveTemplateUi(TemplateUi templateUi);

	/**
     * Removes a templateUi from the database by id
     * @param id the templateUi's id
     */
    public void removeTemplateUi(final Long id);
}

