package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 06/06/2017.
 */
public class AMQRequestQueue {
    private String id;

    private String timestamp;

    private Action action;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getTimestamp ()
    {
        return timestamp;
    }

    public void setTimestamp (String timestamp)
    {
        this.timestamp = timestamp;
    }

    public Action getAction ()
    {
        if(action==null) action=new Action();
        return action;
    }

    public void setAction (Action action)
    {
        this.action = action;
    }
}
