package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 06/06/2017.
 */
public class Action {
    private Payload payload;

    private String eventTimeStamp;

    private String type;

    public Payload getPayload ()
    {
        if(payload==null) payload=new Payload();
        return payload;
    }

    public void setPayload (Payload payload)
    {
        this.payload = payload;
    }

    public String getEventTimeStamp ()
    {
        return eventTimeStamp;
    }

    public void setEventTimeStamp (String eventTimeStamp)
    {
        this.eventTimeStamp = eventTimeStamp;
    }

    public String getType ()
    {
        return type;
    }

    public void setType (String type)
    {
        this.type = type;
    }
}
