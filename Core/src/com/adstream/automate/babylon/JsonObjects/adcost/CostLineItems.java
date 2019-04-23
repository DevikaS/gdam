package com.adstream.automate.babylon.JsonObjects.adcost;

import java.util.List;

/**
 * Created by Raja.Gone on 22/06/2017.
 */
public class CostLineItems {

    private List<CostLineItemData> costLineItemData;

    private CustomData customData;

    private String costId;

    private String costStageId;

    private String revisionId;

    public List<CostLineItemData> getCostLineItemData ()
    {
        return costLineItemData;
    }

    public void setCostLineItemData (List<CostLineItemData>costLineItemData)
    {
        this.costLineItemData = costLineItemData;
    }

    public CustomData getCustomData ()
    {
        if(customData==null) customData = new CustomData();
        return customData;
    }

    public void setCustomData (CustomData customData)
    {
        this.customData = customData;
    }

    public String getCostId ()
    {
        return costId;
    }

    public void setCostId (String costId)
    {
        this.costId = costId;
    }

    public String getCostStageId ()
    {
        return costStageId;
    }

    public void setCostStageId (String costStageId)
    {
        this.costStageId = costStageId;
    }

    public String getRevisionId ()
    {
        return revisionId;
    }

    public void setRevisionId (String revisionId)
    {
        this.revisionId = revisionId;
    }
}
