
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.TemplateMenu;
import com.popultrade.dao.TemplateMenuDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateMenuDAOHibernate extends BaseDAOHibernate implements TemplateMenuDAO {

	
	 public List getTemplateMenus(final TemplateMenu templateMenu,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateMenu order by datum_TemplateMenua");

	      Example ex = Example.create(templateMenu).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateMenu.class).add(ex);
	        if (templateMenu.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateMenu.getId()));
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
	
	
	
	public int getStTemplateMenu(final TemplateMenu templateHead) {
		
		try {
			 Example ex = Example.create(templateHead).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(TemplateMenu.class).add(ex).add(Restrictions.isNull("templatemenu_id")) ; 
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getTemplateMenus(final TemplateMenu templateHead,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from TemplateMenu order by datum_TemplateMenua");

      Example ex = Example.create(templateHead).ignoreCase().excludeZeroes();     
        
        return currentSession().createCriteria(TemplateMenu.class).add(ex).add(Restrictions.isNull("templatemenu_id")).addOrder(Order.asc("zaporedje")).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
	
	
	
	
	
	
    /**
     * @see com.popultrade.dao.TemplateMenuDAO#getTemplateMenus(com.popultrade.model.TemplateMenu)
     */
    public List getTemplateMenus(final TemplateMenu templateMenu) {
        return getHibernateTemplate().find("from TemplateMenu");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateMenu == null) {
            return getHibernateTemplate().find("from TemplateMenu");
        } else {
            // filter on properties set in the templateMenu
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateMenu).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateMenu.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateMenuDAO#getTemplateMenu(Long id)
     */
    public TemplateMenu getTemplateMenu(final Long id) {
        TemplateMenu templateMenu = (TemplateMenu) getHibernateTemplate().get(TemplateMenu.class, id);
        if (templateMenu == null) {
            log.warn("uh oh, templateMenu with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateMenu.class, id);
        }

        return templateMenu;
    }

    /**
     * @see com.popultrade.dao.TemplateMenuDAO#saveTemplateMenu(TemplateMenu templateMenu)
     */    
    public void saveTemplateMenu(final TemplateMenu templateMenu) {
        getHibernateTemplate().saveOrUpdate(templateMenu);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateMenuDAO#removeTemplateMenu(Long id)
     */
    public void removeTemplateMenu(final Long id) {
        getHibernateTemplate().delete(getTemplateMenu(id));
        getHibernateTemplate().flush();
    }
}
