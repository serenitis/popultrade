package com.popultrade.dao;
import java.util.List;

import com.popultrade.model.Uploads;

public interface UploadsDAO extends DAO {
	public Object[] getUploadZaBrisat(String sifra,String ena,String dva);
	public void setUploadZaUpdate(String sifra,String ena,String dva);
	public List getUploadList(String sifra);
	public Uploads getUpload(String sifra);
    /**
     * Retrieves all of the uploadss
     */
    public List getUploadss(Uploads uploads);

    /**
     * Gets uploads's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the uploads's id
     * @return uploads populated uploads object
     */
    public Uploads getUploads(final Long id);

    /**
     * Saves a uploads's information
     * @param uploads the object to be saved
     */	
    public void saveUploads(Uploads uploads);

	/**
     * Removes a uploads from the database by id
     * @param id the uploads's id
     */
    public void removeUploads(final Long id);
}

