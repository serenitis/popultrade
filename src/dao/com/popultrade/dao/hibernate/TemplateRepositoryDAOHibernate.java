
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.TemplateRepository;
import com.popultrade.dao.TemplateRepositoryDAO;
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

public class TemplateRepositoryDAOHibernate extends BaseDAOHibernate implements TemplateRepositoryDAO {

  public List getTemplateRepositorys(final TemplateRepository templateRepository,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
        //return getHibernateTemplate().find("from TemplateRepository order by datum_TemplateRepositorya");

      Example ex = Example.create(templateRepository).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
        Criteria cri = currentSession().createCriteria(TemplateRepository.class).add(ex);
        if (templateRepository.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateRepository.getId()));
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

	public int getStTemplateRepository(final TemplateRepository templateRepository,String dodatni_sql_pogoji) {
		try {
			Example ex = Example.create(templateRepository).excludeZeroes();
			Criteria criteria = currentSession().createCriteria(TemplateRepository.class).add(ex) ; 

			  if (templateRepository.getId()!=null) {
				  criteria.add(Restrictions.eq("id",templateRepository.getId()));
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



    public List getTemplateRepositorys(final TemplateRepository templateRepository,final String orderby,final String orderby_smer) {
        //  return getHibernateTemplate().find("from TemplateRepository");

          if (templateRepository == null) {
              return getHibernateTemplate().find("from TemplateRepository");
          } else {
              // filter on properties set in the templateRepository
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateRepository.getSFT_SIFRA());
                  	Example ex = Example.create(templateRepository).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateRepository.class).add(ex);
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
    public List getTemplateRepositorys2(final TemplateRepository templateRepository,final String orderby,final String orderby_smer,final String dodaten_hql) {
        //  return getHibernateTemplate().find("from TemplateRepository");

          if (templateRepository == null) {
              return getHibernateTemplate().find("from TemplateRepository");
          } else {
              // filter on properties set in the templateRepository
              HibernateCallback callback = new HibernateCallback() {
                  public Object doInHibernate(Session session) throws HibernateException {
                 // System.out.println("Sifrant opis:::::::::::::::: "+templateRepository.getSFT_SIFRA());
                  	Example ex = Example.create(templateRepository).ignoreCase().enableLike(MatchMode.START);
                      Criteria cri= session.createCriteria(TemplateRepository.class).add(ex);
                   if (templateRepository.getId()!=null) {
        	cri.add(Restrictions.eq("id",templateRepository.getId()));
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
     * @see com.popultrade.dao.TemplateRepositoryDAO#getTemplateRepositorys(com.popultrade.model.TemplateRepository)
     */
    public List getTemplateRepositorys(final TemplateRepository templateRepository) {
       if (templateRepository == null) {
            return getHibernateTemplate().find("from TemplateRepository");
        } else {
            // filter on properties set in the templateRepository
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(templateRepository).ignoreCase().enableLike(MatchMode.START);
                    Criteria cri = session.createCriteria(TemplateRepository.class).add(ex);
if (templateRepository.getId()!=null) {
                    cri.add(Restrictions.eq("id",templateRepository.getId()));	
                    }
                return cri.list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }
    }

    /**
     * @see com.popultrade.dao.TemplateRepositoryDAO#getTemplateRepository(Long id)
     */
    public TemplateRepository getTemplateRepository(final Long id) {
        TemplateRepository templateRepository = (TemplateRepository) getHibernateTemplate().get(TemplateRepository.class, id);
        if (templateRepository == null) {
            log.warn("uh oh, templateRepository with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(TemplateRepository.class, id);
        }

        return templateRepository;
    }

    /**
     * @see com.popultrade.dao.TemplateRepositoryDAO#saveTemplateRepository(TemplateRepository templateRepository)
     */    
    public void saveTemplateRepository(final TemplateRepository templateRepository) {
        getHibernateTemplate().saveOrUpdate(templateRepository);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.TemplateRepositoryDAO#removeTemplateRepository(Long id)
     */
    public void removeTemplateRepository(final Long id) {
        getHibernateTemplate().delete(getTemplateRepository(id));
        getHibernateTemplate().flush();
    }
}
