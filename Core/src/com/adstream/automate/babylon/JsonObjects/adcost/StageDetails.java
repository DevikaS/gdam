package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 08/06/2017.
 */
public class StageDetails {
    private Data data;

    public Data getData ()
    {
        if (data == null) data = new Data();
        return data;
    }

    public void setData (Data data)
    {
        this.data = data;
    }

}
