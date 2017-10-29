
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateGumbiParametri;
import com.popultrade.dao.TemplateGumbiParametriDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateGumbiParametriDAOHibernate extends BaseDAOHibernate implements TemplateGumbiParametriDAO {

	 public List getTemplateGumbiParametris(final TemplateGumbiParametri templateGumbiParametri,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateGumbiParametri order by datum_TemplateGumbiParametria");

	      Example ex = Example.create(templateGumbiParametri).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateGumbiParametri.class).add(ex);
	        if (templateGumbiParametri.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateGumbiParametri.getId()));
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
	
	/// dobim id ce ze obstaja
	    public Long getTemplateGumbiParametriIdByIme(String thid) {
	        List je= getHibernateTemplate().find("from TemplateGumbiParametri where dugacno_ime_parametra='"+thid+"'");
	        
	        if (je.size()>0) {
	        	
	        	 TemplateGumbiParametri templateGumbiParametri = (TemplateGumbiParametri)je.get(0);
	        	 
	        	Long imo = templateGumbiParametri.getId();
	        	je.clear();
	        	getHibernateTemplate().clear();
	        	return imo;
	        	
	        	
	        }
	        return null;
	        
	    }
	 
	 
	 
	 
	 
	 
    /**
     * @see com.popultrade.dao.TemplateGumbiParametriDAO#getTemplateGumbiParametris(com.popultrade.model.TemplateGumbiParametri)
     */
    public List getTemplateGumbiParametris(final TemplateGumbiParametri templateGumbiParametri) {
  
        if (templateGumbiParametri == null) {
            return getHibernateTemplate().find("from TemplateGumbiParametri");
        } else {
            // filter on properties set in the templateGumbiParametri
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateGumbiParametri).ignoreCase().enableLike(MatchMode.EXACT);
                    return session.createCriteria(TemplateGumbiParametri.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateGumbiParametriDAO#getTemplateGumbiParametri(Long id)
     */
    public TemplateGumbiParametri getTemplateGumbiParametri(final Long id) {
        TemplateGumbiParametri templateGumbiParametri = (TemplateGumbiParametri) getHibernateTemplate().get(TemplateGumbiParametri.class, id);
        if (templateGumbiParametri == null) {
            log.warn("uh oh, templateGumbiParametri with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateGumbiParametri.class, id);
        }

        return templateGumbiParametri;
    }

    /**
     * @see com.popultrade.dao.TemplateGumbiParametriDAO#saveTemplateGumbiParametri(TemplateGumbiParametri templateGumbiParametri)
     */    
    public void saveTemplateGumbiParametri(final TemplateGumbiParametri templateGumbiParametri) {
        getHibernateTemplate().saveOrUpdate(templateGumbiParametri);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateGumbiParametriDAO#removeTemplateGumbiParametri(Long id)
     */
    public void removeTemplateGumbiParametri(final Long id) {
        getHibernateTemplate().delete(getTemplateGumbiParametri(id));
        getHibernateTemplate().flush();
    }
}
