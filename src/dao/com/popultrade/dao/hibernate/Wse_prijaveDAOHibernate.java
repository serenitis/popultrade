
package com.popultrade.dao.hibernate;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.popultrade.model.Wse_prijave;
import com.popultrade.model.Wse_prijave;
import com.popultrade.dao.Wse_prijaveDAO;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.jdbc.connections.spi.ConnectionProvider;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.hibernate4.HibernateCallback;

public class Wse_prijaveDAOHibernate extends BaseDAOHibernate implements Wse_prijaveDAO {

	

	  public List getWse_prijaves(final Wse_prijave wse_prijave,final int pageNumber,final int pageSize,String dodatni_sql_pogoji,String orderby,String orderby_smer) {
	        //return getHibernateTemplate().find("from Wse_prijave order by datum_Wse_prijavea");

	      Example ex = Example.create(wse_prijave).ignoreCase().excludeZeroes().enableLike(MatchMode.START);     
	        Criteria cri = currentSession().createCriteria(Wse_prijave.class).add(ex);
	        if (wse_prijave.getId()!=null) {
	        	cri.add(Restrictions.eq("id",wse_prijave.getId()));
	        }
	        
	        
	      	if (wse_prijave.getDatum_odjave1()!=null) {
	      		cri.add(Restrictions.ge("datum_odjave",wse_prijave.getDatum_odjave1()));
				}
				if (wse_prijave.getDatum_odjave2()!=null) {
					cri.add(Restrictions.le("datum_odjave",wse_prijave.getDatum_odjave2()));
				}
				
				if (wse_prijave.getDatum_prijave1()!=null) {
					cri.add(Restrictions.ge("datum_prijave",wse_prijave.getDatum_prijave1()));
					}
					if (wse_prijave.getDatum_prijave2()!=null) {
						cri.add(Restrictions.le("datum_prijave",wse_prijave.getDatum_prijave2()));
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

		public int getStWse_prijave(final Wse_prijave wse_prijave,String dodatni_sql_pogoji) {
			try {
				Example ex = Example.create(wse_prijave).excludeZeroes();
				Criteria criteria = currentSession().createCriteria(Wse_prijave.class).add(ex) ; 

				  if (wse_prijave.getId()!=null) {
					  criteria.add(Restrictions.eq("id",wse_prijave.getId()));
			        }
				  
		        	if (wse_prijave.getDatum_odjave1()!=null) {
		        		criteria.add(Restrictions.ge("datum_odjave",wse_prijave.getDatum_odjave1()));
	    				}
	    				if (wse_prijave.getDatum_odjave2()!=null) {
	    					criteria.add(Restrictions.le("datum_odjave",wse_prijave.getDatum_odjave2()));
	    				}
	    				
	    				if (wse_prijave.getDatum_prijave1()!=null) {
	    					criteria.add(Restrictions.ge("datum_prijave",wse_prijave.getDatum_prijave1()));
	    					}
	    					if (wse_prijave.getDatum_prijave2()!=null) {
	    						criteria.add(Restrictions.le("datum_prijave",wse_prijave.getDatum_prijave2()));
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
			Session session = this.currentSession();
			SessionFactoryImplementor sessionFactoryImplementor = null;
			 ConnectionProvider connectionProvider = null;
			java.sql.Connection connection = null;
			try {
			sessionFactoryImplementor = (SessionFactoryImplementor) session.getSessionFactory();
			connectionProvider = (ConnectionProvider) sessionFactoryImplementor.getConnectionProvider().getConnection();
			connection = connectionProvider.getConnection();
			} catch (SQLException e) {
			e.printStackTrace();
			}
			return connection;
			}
		
		
		
	    public List getWse_prijaves(final Wse_prijave wse_prijave,final String orderby,final String orderby_smer) {
	        //  return getHibernateTemplate().find("from Wse_prijave");

	          if (wse_prijave == null) {
	              return getHibernateTemplate().find("from Wse_prijave");
	          } else {
	              // filter on properties set in the Wse_prijave
	              HibernateCallback callback = new HibernateCallback() {
	                  public Object doInHibernate(Session session) throws HibernateException {
	                 // System.out.println("Sifrant opis:::::::::::::::: "+Wse_prijave.getSFT_SIFRA());
	                  	Example ex = Example.create(wse_prijave).ignoreCase().enableLike(MatchMode.START);
	                      Criteria cri= session.createCriteria(Wse_prijave.class).add(ex);
	                      
	                     	if (wse_prijave.getDatum_odjave1()!=null) {
	    	               		cri.add(Restrictions.ge("datum_odjave",wse_prijave.getDatum_odjave1()));
	    	    				}
	    	    				if (wse_prijave.getDatum_odjave2()!=null) {
	    	    					cri.add(Restrictions.le("datum_odjave",wse_prijave.getDatum_odjave2()));
	    	    				}
	    	    				
	    	    				if (wse_prijave.getDatum_prijave1()!=null) {
	    	    					cri.add(Restrictions.ge("datum_prijave",wse_prijave.getDatum_prijave1()));
	    	    					}
	    	    					if (wse_prijave.getDatum_prijave2()!=null) {
	    	    						cri.add(Restrictions.le("datum_prijave",wse_prijave.getDatum_prijave2()));
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
	                     return cri.list();
	                  }
	              };
	              return (List) getHibernateTemplate().execute(callback);
	          }
	      }
	    public List getWse_prijaves2(final Wse_prijave wse_prijave,final String orderby,final String orderby_smer,final String dodaten_hql) {
	        //  return getHibernateTemplate().find("from Wse_prijave");

	          if (wse_prijave == null) {
	              return getHibernateTemplate().find("from Wse_prijave");
	          } else {
	              // filter on properties set in the Wse_prijave
	              HibernateCallback callback = new HibernateCallback() {
	                  public Object doInHibernate(Session session) throws HibernateException {
	                 // System.out.println("Sifrant opis:::::::::::::::: "+Wse_prijave.getSFT_SIFRA());
	                  	Example ex = Example.create(wse_prijave).ignoreCase().enableLike(MatchMode.START);
	                      Criteria cri= session.createCriteria(Wse_prijave.class).add(ex);
	                   if (wse_prijave.getId()!=null) {
	        	cri.add(Restrictions.eq("id",wse_prijave.getId()));
	        }
	                   
	               	if (wse_prijave.getDatum_odjave1()!=null) {
	               		cri.add(Restrictions.ge("datum_odjave",wse_prijave.getDatum_odjave1()));
	    				}
	    				if (wse_prijave.getDatum_odjave2()!=null) {
	    					cri.add(Restrictions.le("datum_odjave",wse_prijave.getDatum_odjave2()));
	    				}
	    				
	    				if (wse_prijave.getDatum_prijave1()!=null) {
	    					cri.add(Restrictions.ge("datum_prijave",wse_prijave.getDatum_prijave1()));
	    					}
	    					if (wse_prijave.getDatum_prijave2()!=null) {
	    						cri.add(Restrictions.le("datum_prijave",wse_prijave.getDatum_prijave2()));
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

	
	
	
	
	
	public int getStWse_prijave(final Wse_prijave wse_prijave) {
		
		try {
			 Example ex = Example.create(wse_prijave).ignoreCase().excludeZeroes(); 
			Criteria criteria = currentSession().createCriteria(Wse_prijave.class).add(ex) ; 
			
			if (wse_prijave.getDatum_odjave1()!=null) {
				criteria.add(Restrictions.ge("datum_odjave",wse_prijave.getDatum_odjave1()));
				}
				if (wse_prijave.getDatum_odjave2()!=null) {
				criteria.add(Restrictions.le("datum_odjave",wse_prijave.getDatum_odjave2()));
				}
				
				if (wse_prijave.getDatum_prijave1()!=null) {
					criteria.add(Restrictions.ge("datum_prijave",wse_prijave.getDatum_prijave1()));
					}
					if (wse_prijave.getDatum_prijave2()!=null) {
					criteria.add(Restrictions.le("datum_prijave",wse_prijave.getDatum_prijave2()));
					}
			criteria.setProjection(Projections.rowCount()); 
			return ((Long)criteria.list().get(0)).intValue(); 
			
		}
		catch (Exception ex) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(this.getClass());
			log.error(ex.toString());
		}
		return 0;
	}
	
	
	
	
	
	
	

    public List getWse_prijaves(final Wse_prijave wse_prijave,final int pageNumber,final int pageSize) {
        //return getHibernateTemplate().find("from Wse_prijave order by datum_Wse_prijavea");

      Example ex = Example.create(wse_prijave).ignoreCase().excludeZeroes();     
        
        Criteria criteria =  currentSession().createCriteria(Wse_prijave.class).add(ex).addOrder(Order.desc("id"));
        
        
		if (wse_prijave.getDatum_odjave1()!=null) {
			criteria.add(Restrictions.ge("datum_odjave",wse_prijave.getDatum_odjave1()));
			}
			if (wse_prijave.getDatum_odjave2()!=null) {
			criteria.add(Restrictions.le("datum_odjave",wse_prijave.getDatum_odjave2()));
			}
			
			if (wse_prijave.getDatum_prijave1()!=null) {
				criteria.add(Restrictions.ge("datum_prijave",wse_prijave.getDatum_prijave1()));
				}
				if (wse_prijave.getDatum_prijave2()!=null) {
				criteria.add(Restrictions.le("datum_prijave",wse_prijave.getDatum_prijave2()));
				}
        
        
        return criteria.setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list();

        
    }
	
	
	
    /**
     * @see com.popultrade.dao.Wse_prijaveDAO#getWse_prijaves(com.popultrade.model.Wse_prijave)
     */
    public List getWse_prijaves(final Wse_prijave wse_prijave) {
        return getHibernateTemplate().find("from Wse_prijave");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (wse_prijave == null) {
            return getHibernateTemplate().find("from Wse_prijave");
        } else {
            // filter on properties set in the wse_prijave
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(wse_prijave).ignoreCase().enableLike(MatchMode.ANYWHERE);
                    return session.createCriteria(Wse_prijave.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.Wse_prijaveDAO#getWse_prijave(Long id)
     */
    public Wse_prijave getWse_prijave(final Long id) {
        Wse_prijave wse_prijave = (Wse_prijave) getHibernateTemplate().get(Wse_prijave.class, id);
        if (wse_prijave == null) {
            log.warn("uh oh, wse_prijave with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Wse_prijave.class, id);
        }

        return wse_prijave;
    }

    /**
     * @see com.popultrade.dao.Wse_prijaveDAO#saveWse_prijave(Wse_prijave wse_prijave)
     */    
    public void saveWse_prijave(final Wse_prijave wse_prijave) {
        getHibernateTemplate().saveOrUpdate(wse_prijave);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.Wse_prijaveDAO#removeWse_prijave(Long id)
     */
    public void removeWse_prijave(final Long id) {
        getHibernateTemplate().delete(getWse_prijave(id));
getHibernateTemplate().flush();

    }
}
