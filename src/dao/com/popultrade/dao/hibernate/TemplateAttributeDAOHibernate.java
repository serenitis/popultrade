
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateAttribute;
import com.popultrade.dao.TemplateAttributeDAO;
import org.springframework.orm.ObjectRetrievalFailureException;

import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.spi.SessionFactoryImplementor;

import org.springframework.orm.hibernate4.HibernateCallback;

public class TemplateAttributeDAOHibernate extends BaseDAOHibernate implements TemplateAttributeDAO {

  public List getTemplateAttributes(final TemplateAttribute templateAttribute,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateAttribute order by datum_TemplateAttributea");

      Example ex = Example.create(templateAttribute).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateAttribute.class).add(ex);
        if (templateAttribute.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateAttribute.getId()));
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

	public int getStTemplateAttribute(final TemplateAttribute templateAttribute,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateAttribute).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateAttribute.class).add(ex) ; 

			  if (templateAttribute.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateAttribute.getId()));
		        }
			criteria.setProjection(Projections.rowCount()); 
			   if (!dodatni_sql_pogoji.equals("")) {
				   criteria.add(Restrictions.sqlRestriction(dodatni_sql_pogoji));
		        }
			return ((Long)criteria.list().get(0)).intValue(); 
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}

	public Connection pridobiConnectionZaProceduro() {
		  
		    java.sql.Connection connection = null;
		 
		    return connection;
	}
    public List getTemplateAttributes(final TemplateAttribute templateAttribute,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateAttribute");

          if (templateAttribute == null) {
              return getHibernateTemplate().find("from TemplateAttribute");
          } else {
              // filter on properties set in the templateAttribute
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateAttribute.getSFT_SIFRA());
                  	Example ex = Example.create(templateAttribute).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateAttribute.class).add(ex);
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
                     return cri.list();
                  }
              };
              return (List) getHibernateTemplate().execute(callback);
          }
      }
    public List getTemplateAttributes2(final TemplateAttribute templateAttribute,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateAttribute");

          if (templateAttribute == null) {
              return getHibernateTemplate().find("from TemplateAttribute");
          } else {
              // filter on properties set in the templateAttribute
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateAttribute.getSFT_SIFRA());
                  	Example ex = Example.create(templateAttribute).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateAttribute.class).add(ex);
                   if (templateAttribute.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateAttribute.getId()));
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
                      if (!dodaten_hql.equals("")) {
                      	cri.add(Restrictions.sqlRestriction(dodaten_hql));
                      }
                     return cri.list();
                  }
              };
              return (List) getHibernateTemplate().execute(callback);
          }
      }

    /**
     * @see com.popultrade.dao.TemplateAttributeDAO#getTemplateAttributes(com.popultrade.model.TemplateAttribute)
     */
    public List getTemplateAttributes(final TemplateAttribute templateAttribute) {
       if (templateAttribute == null) {
            return getHibernateTemplate().find("from TemplateAttribute");
        } else {
            // filter on properties set in the templateAttribute
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateAttribute).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateAttribute.class).add(ex);
if (templateAttribute.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateAttribute.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateAttributeDAO#getTemplateAttribute(Long id)
     */
    public TemplateAttribute getTemplateAttribute(final Long id) {
        TemplateAttribute templateAttribute = (TemplateAttribute) getHibernateTemplate().get(TemplateAttribute.class, id);
        if (templateAttribute == null) {
            log.warn("uh oh, templateAttribute with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateAttribute.class, id);
        }

        return templateAttribute;
    }

    /**
     * @see com.popultrade.dao.TemplateAttributeDAO#saveTemplateAttribute(TemplateAttribute templateAttribute)
     */    
    public void saveTemplateAttribute(final TemplateAttribute templateAttribute) {
        getHibernateTemplate().saveOrUpdate(templateAttribute);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateAttributeDAO#removeTemplateAttribute(Long id)
     */
    public void removeTemplateAttribute(final Long id) {
        getHibernateTemplate().delete(getTemplateAttribute(id));
        getHibernateTemplate().flush();
    }
}
