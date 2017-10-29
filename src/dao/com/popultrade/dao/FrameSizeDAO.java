
package com.popultrade.dao;

import java.util.List;

import com.popultrade.model.FrameSize;

public interface FrameSizeDAO extends DAO {

	
	public boolean removeFrameSizeByUser(String  username);
	 public List getFrameByUsername(String username);
	public FrameSize getFrameSize(String username,String jsp_page);
    /**
     * Retrieves all of the frameSizes
     */
    public List getFrameSizes(FrameSize frameSize);

    /**
     * Gets frameSize's information based on primary key. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if 
     * nothing is found.
     * 
     * @param id the frameSize's id
     * @return frameSize populated frameSize object
     */
    public FrameSize getFrameSize(final Long id);

    /**
     * Saves a frameSize's information
     * @param frameSize the object to be saved
     */	
    public void saveFrameSize(FrameSize frameSize);

	/**
     * Removes a frameSize from the database by id
     * @param id the frameSize's id
     */
    public void removeFrameSize(final Long id);
}

