package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.annotations.SerializedName;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by mac on 9/24/14.
 */
public class TranscodingAgency {

    @SerializedName("_id")
    private String id;

    @SerializedName("_rev")
    private String revision;

    private String createdAt;

    private boolean valid;

    private RulesAgency rules;

    @SerializedName("source_specification")
    private List<String> sourceSpecification;

    @SerializedName("target_specification")
    private String targetSpecification;

    @SerializedName("capabilities")
    private Map<String, String> capabilities;

    public void setRules(RulesAgency rules) {
        this.rules = rules;
    }

    public RulesAgency getRules() {
        return rules;
    }

    private String comment;

    private String system;

    private String transcoding;

    private String modifiedAt;

    private String svnRev;

    private String createdBy;

    private String modifiedBy;


    public static class RulesAgency {

        @SerializedName("agency_id")
        ArrayList<String> agencyId;

        @SerializedName("exclude_agency_id")
        ArrayList<String> excludeAgencyId;

        public ArrayList<String> getAgencyId() {
            return agencyId;
        }

        public void setAgencyId(String agencyId) {
            this.agencyId.add(agencyId);
        }

        public ArrayList<String> getExcludeAgencyId() { return excludeAgencyId; }

        public void setExcludeAgencyId(String excludeAgencyId) {
            this.excludeAgencyId.add(excludeAgencyId);
        }
    }

}
