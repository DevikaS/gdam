package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 08/07/2016.
 */
public class DestinationsCount {

    private String total;

    private String cancelled;

    private String atDestination;

    public String getTotal ()
    {
        return total;
    }

    public void setTotal (String total)
    {
        this.total = total;
    }

    public String getCancelled ()
    {
        return cancelled;
    }

    public void setCancelled (String cancelled)
    {
        this.cancelled = cancelled;
    }

    public String getAtDestination ()
    {
        return atDestination;
    }

    public void setAtDestination (String atDestination)
    {
        this.atDestination = atDestination;
    }
}
