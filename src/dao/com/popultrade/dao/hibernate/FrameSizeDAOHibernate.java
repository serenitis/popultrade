
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.FrameSize;
import com.popultrade.dao.FrameSizeDAO;

import org.springframework.orm.ObjectRetrievalFailureException;

public class FrameSizeDAOHibernate extends BaseDAOHibernate implements FrameSizeDAO {

	
	
	
	
	public boolean removeFrameSizeByUser(String  username) {
		
		
		try {
			
			String que = "delete from FrameSize  where username='"+username+"' ";
			
			currentSession().createQuery(que).executeUpdate();

			return true;
			
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		
		return true;

	
}
	
	
	
	
	
	
    /**
     * @see com.popultrade.dao.FrameSizeDAO#getFrameSizes(com.popultrade.model.FrameSize)
     */
    public List getFrameSizes(final FrameSize frameSize) {
        return getHibernateTemplate().find("from FrameSize");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (frameSize == null) {
            return getHibernateTemplate().find("from FrameSize");
        } else {
            // filter on properties set in the frameSize
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(frameSize).ignoreCase().enableLike(MatchMode.ANYWHERE);
                    return session.createCriteria(FrameSize.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }
    
    public List getFrameByUsername(String username) {
    	
    	
   	 return  getHibernateTemplate().find("from FrameSize where username='"+username+"' ");

   	
   }
    
    
    
    
    public FrameSize getFrameSize(String username,String jsp_page) {
    	
    	
    	 List li =  getHibernateTemplate().find("from FrameSize where username='"+username+"' and jsp_page_name='"+jsp_page+"'");
	        
    	 if (li.size()==1) {
    		 return (FrameSize)li.get(0);
    	 }
    	 else {
    		 return null;
    	 }
    	 
    	
    }

    /**
     * @see com.popultrade.dao.FrameSizeDAO#getFrameSize(Long id)
     */
    public FrameSize getFrameSize(final Long id) {
        FrameSize frameSize = (FrameSize) getHibernateTemplate().get(FrameSize.class, id);
        if (frameSize == null) {
            log.warn("uh oh, frameSize with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(FrameSize.class, id);
        }

        return frameSize;
    }

    /**
     * @see com.popultrade.dao.FrameSizeDAO#saveFrameSize(FrameSize frameSize)
     */    
    public void saveFrameSize(final FrameSize frameSize) {
        getHibernateTemplate().saveOrUpdate(frameSize);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.FrameSizeDAO#removeFrameSize(Long id)
     */
    public void removeFrameSize(final Long id) {
        getHibernateTemplate().delete(getFrameSize(id));
getHibernateTemplate().flush();

    }
}
