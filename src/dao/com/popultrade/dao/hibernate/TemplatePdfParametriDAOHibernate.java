
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.TemplatePdfParametri;

import com.popultrade.dao.TemplatePdfParametriDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class TemplatePdfParametriDAOHibernate extends BaseDAOHibernate implements TemplatePdfParametriDAO {

	
	
	
	 public List getTemplatePdfParametris(final TemplatePdfParametri templatePdfParametri,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from TemplatePdfParametri order by datum_TemplatePdfParametria");

	      Example ex = Example.create(templatePdfParametri).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(TemplatePdfParametri.class).add(ex);
	        if (templatePdfParametri.getId()!=null) {
	        	cri.add(Restrictions.eq("id",templatePdfParametri.getId()));
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
     * @see com.popultrade.dao.TemplatePdfParametriDAO#getTemplatePdfParametris(com.popultrade.model.TemplatePdfParametri)
     */
    public List getTemplatePdfParametris(final TemplatePdfParametri templatePdfParametri) {
        return getHibernateTemplate().find("from TemplatePdfParametri");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (templatePdfParametri == null) {
            return getHibernateTemplate().find("from TemplatePdfParametri");
        } else {
            // filter on properties set in the templatePdfParametri
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templatePdfParametri).ignoreCase().enableLike(MatchMode.START);
                    return session.createCriteria(TemplatePdfParametri.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.TemplatePdfParametriDAO#getTemplatePdfParametri(Long id)
     */
    public TemplatePdfParametri getTemplatePdfParametri(final Long id) {
        TemplatePdfParametri templatePdfParametri = (TemplatePdfParametri) getHibernateTemplate().get(TemplatePdfParametri.class, id);
        if (templatePdfParametri == null) {
            log.warn("uh oh, templatePdfParametri with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplatePdfParametri.class, id);
        }

        return templatePdfParametri;
    }
    
    
    public TemplatePdfParametri getTemplatePdfParametriByVezaId(final Long id) {
        List mi =  getHibernateTemplate().find("from TemplatePdfParametri where veza_id="+id+" ");
try {
        if (mi.size()>0) {
        	return (com.popultrade.model.TemplatePdfParametri)mi.get(0);
        }
}
catch (Exception ex) {
	System.out.println("Napaka pri pridobivanju TemplatePdfParametri: "+ex.toString());
}
return null;
    }
    

    
    public TemplatePdfParametri getTemplatePdfParametriByVezaIdType(final Long id,String type) {
        List mi =  getHibernateTemplate().find("from TemplatePdfParametri where veza_id="+id+" and type='"+type+"'");
try {
        if (mi.size()>0) {
        	return (com.popultrade.model.TemplatePdfParametri)mi.get(0);
        }
}
catch (Exception ex) {
	System.out.println("Napaka pri pridobivanju TemplatePdfParametri: "+ex.toString());
}
return null;
    }
    

    /**
     * @see com.popultrade.dao.TemplatePdfParametriDAO#saveTemplatePdfParametri(TemplatePdfParametri templatePdfParametri)
     */    
    public void saveTemplatePdfParametri(final TemplatePdfParametri templatePdfParametri) {
        getHibernateTemplate().saveOrUpdate(templatePdfParametri);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplatePdfParametriDAO#removeTemplatePdfParametri(Long id)
     */
    public void removeTemplatePdfParametri(final Long id) {
        getHibernateTemplate().delete(getTemplatePdfParametri(id));
        getHibernateTemplate().flush();
    }
}
