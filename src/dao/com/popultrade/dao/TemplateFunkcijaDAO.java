
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.TemplateFunkcija;

public interface TemplateFunkcijaDAO extends DAO {
	public int getStTemplateFunkcija(final TemplateFunkcija esd50);
	  public List getTemplateFunkcijas(final TemplateFunkcija esd50,final int pageNumber,final int pageSize);
		 public List getTemplateFunkcijas(final TemplateFunkcija templateFunkcija,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer);

    /**
     * Retrieves all of the templateFunkcijas
     */
    public List getTemplateFunkcijas(TemplateFunkcija templateFunkcija);

    /**
     * Gets templateFunkcija's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the templateFunkcija's id
     * @return templateFunkcija populated templateFunkcija object
     */
    public TemplateFunkcija getTemplateFunkcija(final Long id);

    /**
     * Saves a templateFunkcija's information
     * @param templateFunkcija the object to be saved
     */	
    public void saveTemplateFunkcija(TemplateFunkcija templateFunkcija);

	/**
     * Removes a templateFunkcija from the database by id
     * @param id the templateFunkcija's id
     */
    public void removeTemplateFunkcija(final Long id);
}

