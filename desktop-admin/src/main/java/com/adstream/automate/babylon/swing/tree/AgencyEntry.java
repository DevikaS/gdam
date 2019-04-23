package com.adstream.automate.babylon.swing.tree;

/**
 * User: ruslan.semerenko
 * Date: 25.11.12 12:12
 */
public class AgencyEntry {
    private String agencyId;
    private String agencyName;

    public AgencyEntry(String agencyId, String agencyName) {
        this.agencyId = agencyId;
        this.agencyName = agencyName;
    }

    public String getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
    }

    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String toString() {
        return agencyName;
    }
}
