package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 07/06/2017.
 */
public class CostTemplates {
    private String id;

    private String templateId;

    private String costType;

    private String latestVersionId;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getCostType ()
    {
        return costType;
    }

    public void setCostType (String costType)
    {
        this.costType = costType;
    }

    public String getLatestVersionId ()
    {
        return latestVersionId;
    }

    public void setLatestVersionId (String latestVersionId)
    {
        this.latestVersionId = latestVersionId;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId() {
        this.templateId = getId();
    }
        private Versions[] versions;

        public Versions[] getVersions ()
        {
            return versions;
        }

        public void setVersions (Versions[] versions)
        {
            this.versions = versions;
        }

}
