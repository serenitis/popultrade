
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateXml;
import com.popultrade.dao.TemplateXmlDAO;
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

public class TemplateXmlDAOHibernate extends BaseDAOHibernate implements TemplateXmlDAO {

	
	
	
	
	
	public boolean updateZaporedja(Long temxml_id,String zaporedje) {
		
		
		try {
			
		
//			String que = "delete from Esd11  where zapst="+zapst+" and e10_ide10="+e10_ide10;
			
//			getSession().createQuery(que).executeUpdate();
			Session session = this.currentSession();
		String	que = "update TemplateXml  set zaporedje=zaporedje+3 where zaporedje>"+zaporedje+" and id_nad="+temxml_id;
			
		session.createQuery(que).executeUpdate();
		
			return true;
			
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		
		return true;
		
		
	
	
	
}
	
	
	
	
	
	
	
	
  public List getTemplateXmls(final TemplateXml templateXml,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateXml order by datum_TemplateXmla");

      Example ex = Example.create(templateXml).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateXml.class).add(ex);
        if (templateXml.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateXml.getId()));
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

	public int getStTemplateXml(final TemplateXml templateXml,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateXml).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateXml.class).add(ex) ; 

			  if (templateXml.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateXml.getId()));
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
    public List getTemplateXmls(final TemplateXml templateXml,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateXml");

          if (templateXml == null) {
              return getHibernateTemplate().find("from TemplateXml");
          } else {
              // filter on properties set in the templateXml
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateXml.getSFT_SIFRA());
                  	Example ex = Example.create(templateXml).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateXml.class).add(ex);
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
    public List getTemplateXmls2(final TemplateXml templateXml,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateXml");

          if (templateXml == null) {
              return getHibernateTemplate().find("from TemplateXml");
          } else {
              // filter on properties set in the templateXml
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateXml.getSFT_SIFRA());
                  	Example ex = Example.create(templateXml).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateXml.class).add(ex);
                   if (templateXml.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateXml.getId()));
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
     * @see com.popultrade.dao.TemplateXmlDAO#getTemplateXmls(com.popultrade.model.TemplateXml)
     */
    public List getTemplateXmls(final TemplateXml templateXml) {
       if (templateXml == null) {
            return getHibernateTemplate().find("from TemplateXml");
        } else {
            // filter on properties set in the templateXml
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateXml).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateXml.class).add(ex);
if (templateXml.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateXml.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateXmlDAO#getTemplateXml(Long id)
     */
    public TemplateXml getTemplateXml(final Long id) {
        TemplateXml templateXml = (TemplateXml) getHibernateTemplate().get(TemplateXml.class, id);
        if (templateXml == null) {
            log.warn("uh oh, templateXml with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateXml.class, id);
        }

        return templateXml;
    }

    /**
     * @see com.popultrade.dao.TemplateXmlDAO#saveTemplateXml(TemplateXml templateXml)
     */    
    public void saveTemplateXml(final TemplateXml templateXml) {
        getHibernateTemplate().saveOrUpdate(templateXml);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateXmlDAO#removeTemplateXml(Long id)
     */
    public void removeTemplateXml(final Long id) {
        getHibernateTemplate().delete(getTemplateXml(id));
        getHibernateTemplate().flush();
    }
}
