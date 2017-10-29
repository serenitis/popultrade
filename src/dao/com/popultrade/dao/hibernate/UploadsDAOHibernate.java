
package com.popultrade.dao.hibernate;

import java.util.List;

//import com.sportagent.model.Kat2_opisi;
import com.popultrade.model.Uploads;
import com.popultrade.model.Users;
import com.popultrade.dao.UploadsDAO;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;


public class UploadsDAOHibernate extends BaseDAOHibernate implements UploadsDAO {
	   public Uploads getUpload(String sifra) {
	        List li= getHibernateTemplate().find("from Uploads where sifra='"+sifra+"'");
	           
	        if (li.size()>0) {
	       	 return (Uploads)li.get(0);
	        }
	        return null;
	        
	        
	       }
	   
	   public Object[] getUploadZaBrisat(String sifra,String ena,String dva) {
	        List li= getHibernateTemplate().find("select slika"+ena+",slika"+dva+" from Uploads where sifra='"+sifra+"'");
	           
	        if (li.size()>0) {
	       	 return (Object[])li.get(0);
	        }
	        return null;
	        
	        
	       }
	   
	   
		public void setUploadZaUpdate(String sifra,String ena,String dva) {
			
			try {
				
				String que = "update Uploads set slika"+ena+"=null,slika"+dva+"=null where sifra='"+sifra+"'";
				
				currentSession().createQuery(que).executeUpdate();
				
				
			}
			catch (Exception ex) {
				System.out.println(ex.toString());
			}


			
		}
	   
	   
	   
	   
	   
	   public List getUploadList(String sifra) {
	      return getHibernateTemplate().find("from Uploads where sifra='"+sifra+"'");
	      
	        
	        
	       }
    /**
     * @see com.sportagent.dao.UploadsDAO#getUploadss(com.sportagent.model.Uploads)
     */
    public List getUploadss(final Uploads uploads) {
        if (uploads == null) {
            return getHibernateTemplate().find("from Uploads");
        } else {
            // filter on properties set in the uploads
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(uploads).ignoreCase().enableLike(MatchMode.START);
                    
                    
                    Criteria cri = session.createCriteria(Uploads.class).add(ex);
//if (uploads.getLADJA()!=null) {
              //      cri.add(Restrictions.eq("id",uploads.getLADJA()));	
                 //   }
                    
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.sportagent.dao.UploadsDAO#getUploads(Long id)
     */
    public Uploads getUploads(final Long id) {
        Uploads uploads = (Uploads) getHibernateTemplate().get(Uploads.class, id);
        if (uploads == null) {
            log.warn("uh oh, uploads with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Uploads.class, id);
        }

        return uploads;
    }

    /**
     * @see com.sportagent.dao.UploadsDAO#saveUploads(Uploads uploads)
     */    
    public void saveUploads(final Uploads uploads) {
        getHibernateTemplate().saveOrUpdate(uploads);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.sportagent.dao.UploadsDAO#removeUploads(Long id)
     */
    public void removeUploads(final Long id) {
        getHibernateTemplate().delete(getUploads(id));
getHibernateTemplate().flush();

    }
}
