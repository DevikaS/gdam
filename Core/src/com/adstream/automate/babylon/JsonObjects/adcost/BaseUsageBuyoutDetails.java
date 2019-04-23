package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 28/06/2017.
 */
public class BaseUsageBuyoutDetails {
    private UpdateCostForm updateCostForm;

    private String costId;

    public UpdateCostForm getUpdateCostForm ()
    {
        if(updateCostForm == null) updateCostForm = new UpdateCostForm();
        return updateCostForm;
    }

    public void setUpdateCostForm (UpdateCostForm updateCostForm)
    {
        this.updateCostForm = updateCostForm;
    }

    public String getCostId ()
    {
        return costId;
    }

    public void setCostId (String costId)
    {
        this.costId = costId;
    }
}
