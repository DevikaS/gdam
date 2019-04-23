package com.adstream.automate.babylon.JsonObjects.adcost;

import org.joda.time.DateTime;

import java.util.List;

/**
 * Created by Raja.Gone on 28/06/2017.
 */
public class Contract {
    private DateTime startDate;

    private DateTime endDate;

    private String exclusivity;

    private String period;

    private List<ExclusivityCategoryValues> exclusivityCategoryValues;

    private Integer contractTotal;

    public DateTime getStartDate ()
    {
        return startDate;
    }

    public void setStartDate (DateTime startDate)
    {
        this.startDate = startDate;
    }

    public DateTime getEndDate ()
    {
        return endDate;
    }

    public void setEndDate (DateTime endDate)
    {
        this.endDate = endDate;
    }

    public String getExclusivity ()
    {
        return exclusivity;
    }

    public void setExclusivity (String exclusivity)
    {
        this.exclusivity = exclusivity;
    }

    public String getPeriod ()
    {
        return period;
    }

    public void setPeriod (String period)
    {
        this.period = period;
    }

    public List<ExclusivityCategoryValues> getExclusivityCategoryValues ()
    {
        return exclusivityCategoryValues;
    }

    public void setExclusivityCategoryValues (List<ExclusivityCategoryValues> exclusivityCategoryValues)
    {
        this.exclusivityCategoryValues = exclusivityCategoryValues;
    }

    public Integer getContractTotal ()
    {
        return contractTotal;
    }

    public void setContractTotal (Integer contractTotal)
    {
        this.contractTotal = contractTotal;
    }
}
