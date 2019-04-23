package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Arti.Sharma on 24/05/2018.
 */
public class CostUser {
    private String count;

    private CostUsers[] users;

    public String getCount ()
    {
        return count;
    }

    public void setCount (String count)
    {
        this.count = count;
    }

    public CostUsers[] getUsers ()
    {
        return users;
    }

    public void setUsers (CostUsers[] users)
    {
        this.users = users;
    }


}
