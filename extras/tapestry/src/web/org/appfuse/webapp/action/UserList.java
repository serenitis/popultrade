package com.popultrade.webapp.action;

import java.util.List;

import org.apache.tapestry.IRequestCycle;
import com.popultrade.model.User;
import com.popultrade.service.UserManager;

public abstract class UserList extends BasePage {

    public abstract UserManager getUserManager();
    public abstract void setUserManager(UserManager manager);

    public List getUsers() {
        return getUserManager().getUsers(null);
    }
    
    public void edit(IRequestCycle cycle) {
        UserForm nextPage = (UserForm) cycle.getPage("userForm");
        Object[] parameters = cycle.getServiceParameters();
        String username = (String) parameters[0];

        if (log.isDebugEnabled()) {
            log.debug("fetching user with username: " + username);
        }

        User user = getUserManager().getUser(username);
        user.setConfirmPassword(user.getPassword());
        nextPage.setUser(user);
        nextPage.setFrom("list");
        cycle.activate(nextPage);
    }
}
