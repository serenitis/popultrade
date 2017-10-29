
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateFunkcijaStart;
import com.popultrade.dao.TemplateFunkcijaStartDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateFunkcijaStartDAOHibernate extends BaseDAOHibernate implements TemplateFunkcijaStartDAO {
	

	 public List getTemplateFunkcijaStarts(final TemplateFunkcijaStart templateFunkcijaStart,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateFunkcijaStart order by datum_TemplateFunkcijaStarta");

	      Example ex = Example.create(templateFunkcijaStart).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateFunkcijaStart.class).add(ex);
	        if (templateFunkcijaStart.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateFunkcijaStart.getId()));
	        }

	        if (!orderby.equals("")) {

	        	if (orderby.indexOf(",")!=-1) {
	        	String[] yum = orderby.split(",");
	        	for (int i=0;i<yum.length;i++) {
	        		if (yum[i].indexOf(" ")!=-1) {
	        			if (yum[i].indexOf("asc")!=-1) {
	        				cri.addOrder(Order.asc(yum[i].substring(0,yum[i].indexOf(" "))));	
	        			}
	        			else {
	        				cri.addOrder(Order.desc(yum[i].substring(0,yum[i].indexOf(" "))));	
	        			}
	        		}
	        		else {
	        			cri.addOrder(Order.desc(yum[i].trim()));	
	        		}
	        	}

	        	}
	        	else {
	        	if (orderby_smer.equals("asc")) {
	        cri.addOrder(Order.asc(orderby));
	        	}
	        	else {
	        		cri.addOrder(Order.desc(orderby));	
	        	}
	        	}

	        }
	        if (!dodatni_sql_pogoji.equals("")) {
	        	cri.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
	        }

	        return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

	    }
	
	
	public int getStTemplateFunkcijaStart(final TemplateFunkcijaStart tf) {
		
		try {
			 Example ex = Example.create(tf).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(TemplateFunkcijaStart.class).add(ex) ; 
			
		     if (tf.getVeza_id()==null) {
		    	 criteria.add(Restrictions.isNull("veza_id"));
		        }
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getTemplateFunkcijaStarts(final TemplateFunkcijaStart tf,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from TemplateFunkcijaStart order by datum_TemplateFunkcijaStarta");

      Example ex = Example.create(tf).ignoreCase().excludeZeroes();     
        
        Criteria cri =  currentSession().createCriteria(TemplateFunkcijaStart.class).add(ex).addOrder(Order.asc("zaporedje"));

        if (tf.getVeza_id()==null) {
        	cri.add(Restrictions.isNull("veza_id"));
        }
        
        return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
    
    
    
    
    
    
    /**
     * @see com.popultrade.dao.TemplateFunkcijaStartDAO#getTemplateFunkcijaStarts(com.popultrade.model.TemplateFunkcijaStart)
     */
    
    
    public List getTemplateFunkcijaStartByVezaId(String veza_id) {
        return getHibernateTemplate().find("from TemplateFunkcijaStart where veza_id="+veza_id+" order by zaporedje");
    }
    
    
    
    
    
    public List getTemplateFunkcijaStarts(final TemplateFunkcijaStart templateFunkcijaStart) {
        return getHibernateTemplate().find("from TemplateFunkcijaStart");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateFunkcijaStart == null) {
            return getHibernateTemplate().find("from TemplateFunkcijaStart");
        } else {
            // filter on properties set in the templateFunkcijaStart
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateFunkcijaStart).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateFunkcijaStart.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateFunkcijaStartDAO#getTemplateFunkcijaStart(Long id)
     */
    public TemplateFunkcijaStart getTemplateFunkcijaStart(final Long id) {
        TemplateFunkcijaStart templateFunkcijaStart = (TemplateFunkcijaStart) getHibernateTemplate().get(TemplateFunkcijaStart.class, id);
        if (templateFunkcijaStart == null) {
            log.warn("uh oh, templateFunkcijaStart with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateFunkcijaStart.class, id);
        }

        return templateFunkcijaStart;
    }

    /**
     * @see com.popultrade.dao.TemplateFunkcijaStartDAO#saveTemplateFunkcijaStart(TemplateFunkcijaStart templateFunkcijaStart)
     */    
    public void saveTemplateFunkcijaStart(final TemplateFunkcijaStart templateFunkcijaStart) {
        getHibernateTemplate().saveOrUpdate(templateFunkcijaStart);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateFunkcijaStartDAO#removeTemplateFunkcijaStart(Long id)
     */
    public void removeTemplateFunkcijaStart(final Long id) {
        getHibernateTemplate().delete(getTemplateFunkcijaStart(id));
        getHibernateTemplate().flush();
    }
}
