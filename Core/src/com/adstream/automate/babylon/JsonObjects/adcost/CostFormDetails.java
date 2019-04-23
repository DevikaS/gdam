package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 28/06/2017.
 */
public class CostFormDetails {
    private Data data;

    public Data getData ()
    {
        if(data ==null) data = new Data();
        return data;
    }

    public void setData (Data data)
    {
        this.data = data;
    }
}
