    public String[] getUserRoles() {
        com.popultrade.model.Role role;
        String[] userRoles = new String[roles.size()];
        int i = 0;
        for (java.util.Iterator iter = roles.iterator(); iter.hasNext();) {
            role = (com.popultrade.model.Role) iter.next();
            userRoles[i] = role.getName();
            i++;
        }
        return userRoles;
    }

    /**
     * Note that this is not used - it's just needed by Struts.  If you look
     * in UserAction - you'll see that request.getParameterValues("userRoles")
     * is used instead.
     * 
     * @param roles
     */
    public void setUserRoles(String[] roles) {}
    