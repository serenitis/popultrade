package com.popultrade.dao.ibatis;

import java.util.List;

import com.popultrade.dao.LookupDAO;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

/**
 * iBatis implementation of LookupDAO.
 *
 * <p>
 * <a href="LookupDAOiBatis.java.html"><i>View Source</i></a>
 * </p>
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
public class LookupDAOiBatis extends SqlMapClientDaoSupport implements LookupDAO {

    /**
     * @see com.popultrade.dao.LookupDAO#getRoles()
     */
    public List getRoles() {
        if (logger.isDebugEnabled()) {
            logger.debug("retrieving all role names...");
        }

        return getSqlMapClientTemplate().queryForList("getRoles", null);
    }
}
