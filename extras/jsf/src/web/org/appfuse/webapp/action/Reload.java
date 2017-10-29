package com.popultrade.webapp.action;

import java.io.IOException;
import java.io.Serializable;

import com.popultrade.webapp.listener.StartupListener;

/**
 * JSF Page class to handle reloading options in servlet context.
 *
 * @author Matt Raible
 */
public class Reload extends BasePage implements Serializable {

    public String execute() throws IOException {

        if (log.isDebugEnabled()) {
            log.debug("Entering 'execute' method");
        }

        StartupListener.setupContext(getServletContext());
        addMessage("reload.succeeded"); 

        return "mainMenu";
    }

}
