package com.popultrade.webapp.tapestry;

import org.apache.tapestry.IComponent;
import org.apache.tapestry.IRequestCycle;
import org.apache.tapestry.Tapestry;
import org.apache.tapestry.engine.ILink;
import com.popultrade.webapp.action.BaseEngine;

public class HomeService extends org.apache.tapestry.engine.HomeService
{
    public ILink getLink(IRequestCycle requestCycle, IComponent component, Object[] parameters)
    {
        String suffix = requestCycle.getEngine().getSpecification().getProperty(BaseEngine.SERVICE_URL_SUFFIX);
        
        return new Link(requestCycle, Tapestry.HOME_SERVICE + suffix, null, null);
    }
}
