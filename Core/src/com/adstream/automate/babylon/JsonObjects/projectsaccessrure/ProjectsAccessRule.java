package com.adstream.automate.babylon.JsonObjects.projectsaccessrure;

import com.adstream.automate.babylon.JsonObjects.BaseObject;

import java.util.List;

/**
 * User: lynda-k
 * Date: 12.08.14
 * Time: 12:35
 */

public class ProjectsAccessRule extends BaseObject {
    private String agencyId;
    private String userId;
    private String roleId;
    private Long expiration;
    private List<ProjectsAccessRuleTerm> terms;

    public String getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
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

    public Long getExpiration() {
        return expiration;
    }

    public void setExpiration(Long expiration) {
        this.expiration = expiration;
    }

    public List<ProjectsAccessRuleTerm> getTerms() {
        return terms;
    }

    public void setTerms(List<ProjectsAccessRuleTerm> terms) {
        this.terms = terms;
    }
}
