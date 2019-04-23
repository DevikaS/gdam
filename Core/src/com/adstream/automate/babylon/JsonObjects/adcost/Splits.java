package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Arti.Sharma on 17/01/2018.
 */
public class Splits {
    private StageSplits stageSplits;

    private String costTotalType;

    public StageSplits getstageSplits ()
    {
        if (stageSplits == null) stageSplits = new StageSplits();
        return stageSplits;
    }

    public void setStageSplits (StageSplits stageSplits)
    {
        if (stageSplits == null) stageSplits = new StageSplits();
        this.stageSplits = stageSplits;
    }

    public String getCostTotalType()
    {
        return costTotalType;
    }

    public void setCostTotalType(String costTotalType)
    {
        this.costTotalType = costTotalType;
    }
}
