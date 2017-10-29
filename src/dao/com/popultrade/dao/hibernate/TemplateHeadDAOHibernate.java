
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.TemplateHead;

import com.popultrade.dao.TemplateHeadDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplateHeadDAOHibernate extends BaseDAOHibernate implements TemplateHeadDAO {

    
  public List getTemplateHeads(final TemplateHead TemplateHead,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateHead order by datum_TemplateHeada");

      Example ex = Example.create(TemplateHead).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateHead.class).add(ex);
        if (TemplateHead.getId()!=null) {
        	cri.add(Restrictions.eq("id",TemplateHead.getId()));
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
	
	
	public int getStTemplateHead(final TemplateHead templateHead) {
		
		try {
			 Example ex = Example.create(templateHead).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(TemplateHead.class).add(ex).add(Restrictions.isNull("veza_gumb")) ; 
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getTemplateHeads(final TemplateHead templateHead,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from TemplateHead order by datum_TemplateHeada");

      Example ex = Example.create(templateHead).ignoreCase().excludeZeroes();     
        
        return currentSession().createCriteria(TemplateHead.class).add(ex).add(Restrictions.isNull("veza_gumb")).addOrder(Order.asc("zaporedje")).setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
	
    public List getTemplateHeads2(final TemplateHead templateHead) {
        //return getHibernateTemplate().find("from TemplateHead order by datum_TemplateHeada");

      Example ex = Example.create(templateHead).ignoreCase().excludeZeroes();     
        
        return currentSession().createCriteria(TemplateHead.class).add(ex).addOrder(Order.asc("zaporedje")).list();

        
    }
	
	
	
    public List getTemplateHeadImaGumb(String thid) {
        return getHibernateTemplate().find("from TemplateHead where veza_gumb='"+thid+"'");
        
    }
	
    public TemplateHead getTemplateHeadNadGumb(String thid) {
        List li = getHibernateTemplate().find("from TemplateHead where veza_gumb='"+thid+"'");
        
        try {
        	if (li.size()==1) {
        	return (TemplateHead)li.get(0);
        	}
        	
        }
        catch (Exception j) {
        	
        }
        return null;
    }
	
	
	
	
    /**
     * @see com.popultrade.dao.TemplateHeadDAO#getTemplateHeads(com.popultrade.model.TemplateHead)
     */
    public List getTemplateHeads(final TemplateHead templateHead) {
        return getHibernateTemplate().find("from TemplateHead");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templateHead == null) {
            return getHibernateTemplate().find("from TemplateHead");
        } else {
            // filter on properties set in the templateHead
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateHead).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplateHead.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplateHeadDAO#getTemplateHead(Long id)
     */
    public TemplateHead getTemplateHead(final Long id) {
        TemplateHead templateHead = (TemplateHead) getHibernateTemplate().get(TemplateHead.class, id);
        if (templateHead == null) {
            log.warn("uh oh, templateHead with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateHead.class, id);
        }

        return templateHead;
    }

    /**
     * @see com.popultrade.dao.TemplateHeadDAO#saveTemplateHead(TemplateHead templateHead)
     */    
    public void saveTemplateHead(final TemplateHead templateHead) {
        getHibernateTemplate().saveOrUpdate(templateHead);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateHeadDAO#removeTemplateHead(Long id)
     */
    public void removeTemplateHead(final Long id) {
        getHibernateTemplate().delete(getTemplateHead(id));
        getHibernateTemplate().flush();
    }
}
