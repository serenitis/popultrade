
package com.popultrade.dao.hibernate;

import java.util.List;

import com.popultrade.model.Jeziki;
import com.popultrade.dao.JezikiDAO;

import org.springframework.orm.ObjectRetrievalFailureException;

public class JezikiDAOHibernate extends BaseDAOHibernate implements JezikiDAO {

    /**
     * @see com.popultrade.dao.JezikiDAO#getJezikis(com.popultrade.model.Jeziki)
     */
    public List getJezikis(final Jeziki jeziki) {
    	
        return getHibernateTemplate().find("from Jeziki where status='1' order by OPIS_JEZ");

        /* Remove the line above and uncomment this code block if you want 
           to use Hibernate's Query by Example API.
        if (jeziki == null) {
            return getHibernateTemplate().find("from Jeziki");
        } else {
            // filter on properties set in the jeziki
            HibernateCallback callback = new HibernateCallback() {
                public Object doInHibernate(Session session) throws HibernateException {
                    Example ex = Example.create(jeziki).ignoreCase().enableLike(MatchMode.ANYWHERE);
                    return session.createCriteria(Jeziki.class).add(ex).list();
                }
            };
            return (List) getHibernateTemplate().execute(callback);
        }*/
    } 

    /**
     * @see com.popultrade.dao.JezikiDAO#getJeziki(String SIFRA_JEZ)
     */
    public Jeziki getJeziki(final String SIFRA_JEZ) {
        Jeziki jeziki = (Jeziki) getHibernateTemplate().get(Jeziki.class, SIFRA_JEZ);
        if (jeziki == null) {
            log.warn("uh oh, jeziki with SIFRA_JEZ '" + SIFRA_JEZ + "' not found...");
            throw new ObjectRetrievalFailureException(Jeziki.class, SIFRA_JEZ);
        }

        return jeziki;
    }

    /**
     * @see com.popultrade.dao.JezikiDAO#saveJeziki(Jeziki jeziki)
     */    
    public void saveJeziki(final Jeziki jeziki) {
        getHibernateTemplate().saveOrUpdate(jeziki);
        getHibernateTemplate().flush();
    }

    /**
     * @see com.popultrade.dao.JezikiDAO#removeJeziki(String SIFRA_JEZ)
     */
    public void removeJeziki(final String SIFRA_JEZ) {
        getHibernateTemplate().delete(getJeziki(SIFRA_JEZ));
        getHibernateTemplate().flush();
    }
}
