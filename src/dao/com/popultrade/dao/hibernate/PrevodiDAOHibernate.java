
package com.popultrade.dao.hibernate;

import java.util.List;


import com.popultrade.model.Prevodi;
import com.popultrade.dao.PrevodiDAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.ObjectRetrievalFailureException;

public class PrevodiDAOHibernate extends BaseDAOHibernate implements PrevodiDAO {
	 
	 
	
	
	
    public Prevodi getPrevodiCopy(final Prevodi prevodi) {
        //return getHibernateTemplate().find("from Prevodi order by datum_Prevodia");

      Example ex = Example.create(prevodi).ignoreCase().excludeZeroes().excludeProperty("id").excludeProperty("prevod");     
        
        Criteria cri =  currentSession().createCriteria(Prevodi.class).add(ex).add(Restrictions.eq("prevod_id", prevodi.getPrevod_id()));
        
        if (cri.list().size()>0) {
        return (Prevodi)cri.list().get(0);
        }
        else {
        	return null;
        }
        
    }
	
    
    
    public String getPrevodEn(String sif_jez,String vrsta,String prevodid) {
        List lo= getHibernateTemplate().find("from Prevodi  where sifra_jez='"+sif_jez+"' and vrsta='"+vrsta+"' and prevod_id="+prevodid);
        if (lo.size()>0) {
        	Prevodi re = (Prevodi)lo.get(0);
        	return re.getPrevod();
        }
        return "";
    
    
    }
    
    public String getPrevodEnId(String prevodid) {
        List lo= getHibernateTemplate().find("from Prevodi  where  prevod_id="+prevodid);
        if (lo.size()>0) {
        	Prevodi re = (Prevodi)lo.get(0);
        	return re.getId()+"";
        }
        return "";
    
    
    }
    
    
    
    public List getPrevodis() {
        return getHibernateTemplate().find("from Prevodi ");
    }
    
    
    public List getPrevodisByJezik(String sif_jez) {
        return getHibernateTemplate().find("from Prevodi where sifra_jez='"+sif_jez+"'");
    }
    
    
    public List getPrevodisByVrsta(String sif_jez,String vrsta) {
        return getHibernateTemplate().find("from Prevodi where sifra_jez='"+sif_jez+"' and vrsta='"+vrsta+"'");
    }
	
    public List getPrevodisDodatno(final Prevodi prevodi) {
        return getHibernateTemplate().find("from Prevodi where sifra_jez='"+prevodi.getSifra_jez()+"' and vrsta='D'");
    }
	
    public List getPrevodisHint(final Prevodi prevodi) {
        return getHibernateTemplate().find("from Prevodi where sifra_jez='"+prevodi.getSifra_jez()+"' and vrsta='H'");
    }
    /**
     * @see com.popultrade.dao.PrevodiDAO#getPrevodis(com.popultrade.model.Prevodi)
     */
    public List getPrevodis(final Prevodi prevodi) {
        return getHibernateTemplate().find("from Prevodi where sifra_jez='"+prevodi.getSifra_jez()+"' and vrsta='P'");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (prevodi == null) {
            return getHibernateTemplate().find("from Prevodi");
        } else {
            // filter on properties set in the prevodi
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(prevodi).ignoreCase().enableLike(MatchMode.ANYWHERE);
                    return session.createCriteria(Prevodi.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    }

    /**
     * @see com.popultrade.dao.PrevodiDAO#getPrevodi(Long id)
     */
    public Prevodi getPrevodi(final Long id) {
        Prevodi prevodi = (Prevodi) getHibernateTemplate().get(Prevodi.class, id);
        if (prevodi == null) {
            log.warn("uh oh, prevodi with id '" + id + "' not found...");
            throw new ObjectRetrievalFailureException(Prevodi.class, id);
        }

        return prevodi;
    }

    /**
     * @see com.popultrade.dao.PrevodiDAO#savePrevodi(Prevodi prevodi)
     */    
    public void savePrevodi(final Prevodi prevodi) {
        getHibernateTemplate().saveOrUpdate(prevodi);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.PrevodiDAO#removePrevodi(Long id)
     */
    public void removePrevodi(final Long id) {
        getHibernateTemplate().delete(getPrevodi(id));
getHibernateTemplate().flush();

    }
}
