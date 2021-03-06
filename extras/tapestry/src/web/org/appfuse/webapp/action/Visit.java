package com.popultrade.webapp.action;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import com.popultrade.model.User;

public class Visit implements Serializable {
    private User currentUser;
    private boolean cookieLogin;
    
    /**
     * @return Returns the cookieLogin.
     */
    public boolean isCookieLogin() {
        return cookieLogin;
    }
    /**
     * @param cookieLogin The cookieLogin to set.
     */
    public void setCookieLogin(boolean cookieLogin) {
        this.cookieLogin = cookieLogin;
    }

    /**
     * @return Returns the currentUser.
     */
    public User getCurrentUser() {
        return currentUser;
    }
    /**
     * @param currentUser The currentUser to set.
     */
    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this,
                ToStringStyle.MULTI_LINE_STYLE);
    }
}
