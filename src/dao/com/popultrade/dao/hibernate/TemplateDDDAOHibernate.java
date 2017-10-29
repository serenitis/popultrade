
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateDD;

import com.popultrade.dao.TemplateDDDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateDDDAOHibernate extends BaseDAOHibernate implements TemplateDDDAO {
	
	
	
	 public List getTemplateDDs(final TemplateDD templateDD,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateDD order by datum_TemplateDDa");

	      Example ex = Example.create(templateDD).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateDD.class).add(ex);
	        if (templateDD.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateDD.getId()));
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
	
	
	
	
	
	
	
	
	
    public TemplateDD getTemplateDDs(String idui) {
        List li = getHibernateTemplate().find("from TemplateDD where templateui_id="+idui+" and (kontrola='' or kontrola is null)");
        
        if (li.size()>0) {
        	return (TemplateDD)li.get(0);
        }
        else {
        	return new TemplateDD();
        }
        
        
    }
    
    
    public TemplateDD getTemplateDDKontrolas(String idui,String kontrola) {
        List li = getHibernateTemplate().find("from TemplateDD where templateui_id="+idui+" and kontrola='"+kontrola+"'");
        
        if (li.size()>0) {
        	return (TemplateDD)li.get(0);
        }
        else {
        	return new TemplateDD();
        }
        
        
    }
    /**
     * @see com.popultrade.dao.TemplateDDDAO#getTemplateDDs(com.popultrade.model.TemplateDD)
     */
    public List getTemplateDDs(final TemplateDD templateDD) {
        return getHibernateTemplate().find("from TemplateDD");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateDD == null) {
            return getHibernateTemplate().find("from TemplateDD");
        } else {
            // filter on properties set in the templateDD
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateDD).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateDD.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateDDDAO#getTemplateDD(Long id)
     */
    public TemplateDD getTemplateDD(final Long id) {
        TemplateDD templateDD = (TemplateDD) getHibernateTemplate().get(TemplateDD.class, id);
        if (templateDD == null) {
            log.warn("uh oh, templateDD with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateDD.class, id);
        }

        return templateDD;
    }

    /**
     * @see com.popultrade.dao.TemplateDDDAO#saveTemplateDD(TemplateDD templateDD)
     */    
    public void saveTemplateDD(final TemplateDD templateDD) {
        getHibernateTemplate().saveOrUpdate(templateDD);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateDDDAO#removeTemplateDD(Long id)
     */
    public void removeTemplateDD(final Long id) {
        getHibernateTemplate().delete(getTemplateDD(id));
        getHibernateTemplate().flush();
    }
}
