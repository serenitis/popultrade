
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateHeadReset;

public interface TemplateHeadResetDAO extends DAO {

    /**
     * Retrieves all of the templateHeadResets
     */
    public List getTemplateHeadResets(TemplateHeadReset templateHeadReset);

    /**
     * Gets templateHeadReset's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateHeadReset's id
     * @return templateHeadReset populated templateHeadReset object
     */
    public TemplateHeadReset getTemplateHeadReset(final Long id);

    /**
     * Saves a templateHeadReset's information
     * @param templateHeadReset the object to be saved
     */	
    public void saveTemplateHeadReset(TemplateHeadReset templateHeadReset);

	/**
     * Removes a templateHeadReset from the database by id
     * @param id the templateHeadReset's id
     */
    public void removeTemplateHeadReset(final Long id);
}

