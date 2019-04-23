package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 13.02.13
 * Time: 10:06

 */
public class AgencyProjectTeam extends UserGroup {

    public AgencyTeamMember[] getMembers() {
        return getCmCommon().getArrayForClass("members", AgencyTeamMember.class);
    }

    public void setMembers(AgencyTeamMember[] members) {
        getCmCommon().put("members", members);
    }
}