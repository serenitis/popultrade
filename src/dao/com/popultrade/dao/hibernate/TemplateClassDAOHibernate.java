
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateClass;



import com.popultrade.dao.TemplateClassDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateClassDAOHibernate extends BaseDAOHibernate implements TemplateClassDAO {

	 public List getTemplateClasss(final TemplateClass templateClass,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateClass order by datum_TemplateClassa");

	      Example ex = Example.create(templateClass).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateClass.class).add(ex);
	        if (templateClass.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateClass.getId()));
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
	
    public TemplateClass getTemplateClassDodatnos(String idui) {
        List li = getHibernateTemplate().find("from TemplateClass where templatehead_id="+idui);
        
        if (li.size()>0) {
        	return (TemplateClass)li.get(0);
        }
        else {
        	return new TemplateClass();
        }
        
        
    }
	
	
	
	public int getStTemplateClass(final TemplateClass templateClass) {
		
		try {
			 Example ex = Example.create(templateClass).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(TemplateClass.class).add(ex) ; 
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getTemplateClasss(final TemplateClass templateClass,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from TemplateClass order by datum_TemplateClassa");

      Example ex = Example.create(templateClass).ignoreCase().excludeZeroes();     
        
        return currentSession().createCriteria(TemplateClass.class).add(ex).addOrder(Order.asc("zaporedje")).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
	
	
	
	
	
	
	
	
    /**
     * @see com.popultrade.dao.TemplateClassDAO#getTemplateClasss(com.popultrade.model.TemplateClass)
     */
    public List getTemplateClasss(final TemplateClass templateClass) {
        return getHibernateTemplate().find("from TemplateClass");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateClass == null) {
            return getHibernateTemplate().find("from TemplateClass");
        } else {
            // filter on properties set in the templateClass
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateClass).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateClass.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateClassDAO#getTemplateClass(Long id)
     */
    public TemplateClass getTemplateClass(final Long id) {
        TemplateClass templateClass = (TemplateClass) getHibernateTemplate().get(TemplateClass.class, id);
        if (templateClass == null) {
            log.warn("uh oh, templateClass with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateClass.class, id);
        }

        return templateClass;
    }

    /**
     * @see com.popultrade.dao.TemplateClassDAO#saveTemplateClass(TemplateClass templateClass)
     */    
    public void saveTemplateClass(final TemplateClass templateClass) {
        getHibernateTemplate().saveOrUpdate(templateClass);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateClassDAO#removeTemplateClass(Long id)
     */
    public void removeTemplateClass(final Long id) {
        getHibernateTemplate().delete(getTemplateClass(id));
        getHibernateTemplate().flush();
    }
}
