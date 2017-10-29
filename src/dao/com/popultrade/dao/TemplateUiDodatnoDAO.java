
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateUiDodatno;

public interface TemplateUiDodatnoDAO extends DAO {
	
	
	 public List getTemplateUiDodatnos(final TemplateUiDodatno templateUiDodatno,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);
			
	public TemplateUiDodatno getTemplateUiDodatnos(String idui);
    /**
     * Retrieves all of the templateUiDodatnos
     */
    public List getTemplateUiDodatnos(TemplateUiDodatno templateUiDodatno);
    public void updateClob(String id,String polje,String vrednost);
    /**
     * Gets templateUiDodatno's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateUiDodatno's id
     * @return templateUiDodatno populated templateUiDodatno object
     */
    public TemplateUiDodatno getTemplateUiDodatno(final Long id);

    /**
     * Saves a templateUiDodatno's information
     * @param templateUiDodatno the object to be saved
     */	
    public void saveTemplateUiDodatno(TemplateUiDodatno templateUiDodatno);

	/**
     * Removes a templateUiDodatno from the database by id
     * @param id the templateUiDodatno's id
     */
    public void removeTemplateUiDodatno(final Long id);
}

