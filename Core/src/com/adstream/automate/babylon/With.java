package com.adstream.automate.babylon;

/**
 * User: ruslan.semerenko
 * Date: 17.07.12 12:52
 */
public class With {
    private boolean permissions = false;
    private boolean roles = false;
    private boolean lastActivity = false;

    public With() {}

    public With(boolean permissions, boolean roles, boolean lastActivity) {
        this.permissions = permissions;
        this.roles = roles;
        this.lastActivity = lastActivity;
    }

    public boolean isPermissions() {
        return permissions;
    }

    public void setPermissions(boolean permissions) {
        this.permissions = permissions;
    }

    public boolean isRoles() {
        return roles;
    }

    public void setRoles(boolean roles) {
        this.roles = roles;
    }

    public boolean isLastActivity() {
        return lastActivity;
    }

    public void setLastActivity(boolean lastActivity) {
        this.lastActivity = lastActivity;
    }

    public String toGetParams() {
        if (permissions || roles || lastActivity) {
            String with = "&with=";
            if (permissions) with += "permissions,";
            if (roles) with += "roles,";
            if (lastActivity) with += "lastActivity,";
            return with.substring(0, with.length() - 1);
        }
        return "";
    }
}
