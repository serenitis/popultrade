
package com.popultrade.dao;

import java.util.List;


import com.popultrade.model.TemplateGumbiParametri;

public interface TemplateGumbiParametriDAO extends DAO {
	 public List getTemplateGumbiParametris(final TemplateGumbiParametri templateGumbiParametri,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) ;
		/// dobim id ce ze obstaja
	    public Long getTemplateGumbiParametriIdByIme(String thid);	
    /**
     * Retrieves all of the templateGumbiParametris
     */
    public List getTemplateGumbiParametris(TemplateGumbiParametri templateGumbiParametri);

    /**
     * Gets templateGumbiParametri's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateGumbiParametri's id
     * @return templateGumbiParametri populated templateGumbiParametri object
     */
    public TemplateGumbiParametri getTemplateGumbiParametri(final Long id);

    /**
     * Saves a templateGumbiParametri's information
     * @param templateGumbiParametri the object to be saved
     */	
    public void saveTemplateGumbiParametri(TemplateGumbiParametri templateGumbiParametri);

	/**
     * Removes a templateGumbiParametri from the database by id
     * @param id the templateGumbiParametri's id
     */
    public void removeTemplateGumbiParametri(final Long id);
}

