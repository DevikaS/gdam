package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 13.02.13
 * Time: 10:05
 */
public class AgencyTeamMember {
    private String userId;
    private String roleId;

    public AgencyTeamMember() {}

    public AgencyTeamMember(String userId, String roleId) {
        this.userId = userId;
        this.roleId = roleId;
    }

    public AgencyTeamMember(CustomMetadata cm) {
        this(cm.getString("userId"), cm.getString("roleId"));
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
}
