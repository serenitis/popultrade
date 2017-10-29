
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateList;
import com.popultrade.dao.TemplateListDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateListDAOHibernate extends BaseDAOHibernate implements TemplateListDAO {

	 public List getTemplateLists(final TemplateList templateList,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplateList order by datum_TemplateLista");

	      Example ex = Example.create(templateList).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplateList.class).add(ex);
	        if (templateList.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templateList.getId()));
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
	
	
    /**
     * @see com.popultrade.dao.TemplateListDAO#getTemplateLists(com.popultrade.model.TemplateList)
     */
    public List getTemplateLists(final TemplateList templateList) {
        return getHibernateTemplate().find("from TemplateList where Templatehead_id="+templateList.getTemplatehead_id()+" order by zaporedje");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateList == null) {
            return getHibernateTemplate().find("from TemplateList");
        } else {
            // filter on properties set in the templateList
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateList).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateList.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateListDAO#getTemplateList(Long id)
     */
    public TemplateList getTemplateList(final Long id) {
        TemplateList templateList = (TemplateList) getHibernateTemplate().get(TemplateList.class, id);
        if (templateList == null) {
            log.warn("uh oh, templateList with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateList.class, id);
        }

        return templateList;
    }

    /**
     * @see com.popultrade.dao.TemplateListDAO#saveTemplateList(TemplateList templateList)
     */    
    public void saveTemplateList(final TemplateList templateList) {
        getHibernateTemplate().saveOrUpdate(templateList);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateListDAO#removeTemplateList(Long id)
     */
    public void removeTemplateList(final Long id) {
        getHibernateTemplate().delete(getTemplateList(id));
        getHibernateTemplate().flush();
    }
}
