
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateTag;

import com.popultrade.dao.TemplateTagDAO;

import org.springframework.orm.ObjectRetrievalFailureException;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class TemplateTagDAOHibernate extends BaseDAOHibernate implements TemplateTagDAO {
	
	
	
	
	 public List getTemplateTags(final TemplateTag templateTag,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateTag order by datum_TemplateTaga");

	      Example ex = Example.create(templateTag).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateTag.class).add(ex);
	        if (templateTag.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateTag.getId()));
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
	
	
	
	
	
	
	
	
	
	
	public int getStTemplateTag(final TemplateTag tf) {
		
		try {
			 Example ex = Example.create(tf).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(TemplateTag.class).add(ex) ; 
			
		     if (tf.getId_veza()==null) {
		    	 criteria.add(Restrictions.isNull("id_veza"));
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
	
	
	
	
	
	
	

    public List getTemplateTags(final TemplateTag tf,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from TemplateTag order by datum_TemplateTaga");

      Example ex = Example.create(tf).ignoreCase().excludeZeroes();     
        
        Criteria cri =  currentSession().createCriteria(TemplateTag.class).add(ex).addOrder(Order.asc("zaporedje"));

        if (tf.getId_veza()==null) {
        	cri.add(Restrictions.isNull("id_veza"));
        }
        
        return cri.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
    
    
    
    
    
    
    /**
     * @see com.popultrade.dao.TemplateTagDAO#getTemplateTags(com.popultrade.model.TemplateTag)
     */
    
    
    public TemplateTag getTemplateTagByVezaId(String veza_id) {
        List li= getHibernateTemplate().find("from TemplateTag where id_veza="+veza_id);
        
        if (li.size()>0) {
        	return (TemplateTag)li.get(0);
        }
        
        return null;
        
        
    }
    /**
     * @see com.popultrade.dao.TemplateTagDAO#getTemplateTags(com.popultrade.model.TemplateTag)
     */
    public List getTemplateTags(final TemplateTag templateTag) {
        return getHibernateTemplate().find("from TemplateTag");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateTag == null) {
            return getHibernateTemplate().find("from TemplateTag");
        } else {
            // filter on properties set in the templateTag
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateTag).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateTag.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateTagDAO#getTemplateTag(Long id)
     */
    public TemplateTag getTemplateTag(final Long id) {
        TemplateTag templateTag = (TemplateTag) getHibernateTemplate().get(TemplateTag.class, id);
        if (templateTag == null) {
            log.warn("uh oh, templateTag with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateTag.class, id);
        }

        return templateTag;
    }

    /**
     * @see com.popultrade.dao.TemplateTagDAO#saveTemplateTag(TemplateTag templateTag)
     */    
    public void saveTemplateTag(final TemplateTag templateTag) {
        getHibernateTemplate().saveOrUpdate(templateTag);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateTagDAO#removeTemplateTag(Long id)
     */
    public void removeTemplateTag(final Long id) {
        getHibernateTemplate().delete(getTemplateTag(id));
        getHibernateTemplate().flush();
    }
}
