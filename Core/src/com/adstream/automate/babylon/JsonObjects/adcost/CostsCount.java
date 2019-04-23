package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 31/05/2017.
 */
public class CostsCount {
    private String count;

    private Costs[] costs;

    public String getCount ()
    {
        return count;
    }

    public void setCount (String count)
    {
        this.count = count;
    }

    public Costs[] getCosts ()
    {
        return costs;
    }

    public void setCosts (Costs[] costs)
    {
        this.costs = costs;
    }
}
