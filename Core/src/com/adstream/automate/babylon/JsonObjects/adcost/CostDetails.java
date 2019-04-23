package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 08/06/2017.
 */
public class CostDetails {
    private String templateId;

    private StageDetails stageDetails;

    public String getTemplateId ()
    {
        return templateId;
    }

    public void setTemplateId (String templateId)
    {
        this.templateId = templateId;
    }

    public StageDetails getStageDetails ()
    {
        if (stageDetails == null) stageDetails = new StageDetails();
        return stageDetails;
    }

    public void setStageDetails (StageDetails stageDetails)
    {
        this.stageDetails = stageDetails;
    }
}
