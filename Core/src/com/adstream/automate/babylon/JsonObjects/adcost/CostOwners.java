package com.adstream.automate.babylon.JsonObjects.adcost;

import org.joda.time.DateTime;

/**
 * Created by Arti.Sharma on 21/06/2018.
 */
public class CostOwners {
    private String costId;

    private String fullName;

    private String userId;

    private String endDate;

    public String getCostId ()
    {
        return costId;
    }

    public void setCostId (String costId)
    {
        this.costId = costId;
    }

    public String getFullName ()
    {
        return fullName;
    }

    public void setFullName (String fullName)
    {
        this.fullName = fullName;
    }

    public String getUserId ()
    {
        return userId;
    }

    public void setUserId (String userId)
    {
        this.userId = userId;
    }

    public String getEndDate ()
    {
        return endDate;
    }

    public void setEndDate (String endDate)
        {
            this.endDate = endDate;
    }
}
