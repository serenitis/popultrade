package com.popultrade.webapp.tapestry;

import org.apache.tapestry.IComponent;
import org.apache.tapestry.IRequestCycle;
import org.apache.tapestry.Tapestry;
import org.apache.tapestry.engine.ILink;
import com.popultrade.webapp.action.BaseEngine;

public class ResetService extends org.apache.tapestry.engine.ResetService
{
    /**
     * @see org.apache.tapestry.engine.IEngineService#getLink(org.apache.tapestry.IRequestCycle, org.apache.tapestry.IComponent, java.lang.Object[])
     */
    public ILink getLink(IRequestCycle requestCycle, IComponent component, Object[] parameters)
    {
        String suffix = requestCycle.getEngine().getSpecification().getProperty(BaseEngine.SERVICE_URL_SUFFIX);
        
        return new Link(requestCycle, Tapestry.RESET_SERVICE + suffix, null, null);
    }
}
