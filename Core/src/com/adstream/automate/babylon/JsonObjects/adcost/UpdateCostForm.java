package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 28/06/2017.
 */
public class UpdateCostForm {
    private CostFormDetails costFormDetails;

    private String formDefinitionId;

    public CostFormDetails getCostFormDetails ()
    {
        if(costFormDetails==null) costFormDetails= new CostFormDetails();
        return costFormDetails;
    }

    public void setCostFormDetails (CostFormDetails costFormDetails)
    {
        this.costFormDetails = costFormDetails;
    }

    public String getFormDefinitionId ()
    {
        return formDefinitionId;
    }

    public void setFormDefinitionId (String formDefinitionId)
    {
        this.formDefinitionId = formDefinitionId;
    }
}
