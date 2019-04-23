package com.publicApi.jsonPayLoads.GsonClasses.traffic;

/**
 * Created by Raja.Gone on 20/01/2017.
 */
public class Order {
    private String submitted;

    private String service_level;

    private String reference;

    public String getSubmitted ()
    {
        return submitted;
    }

    public void setSubmitted (String submitted)
    {
        this.submitted = submitted;
    }

    public String getService_level ()
    {
        return service_level;
    }

    public void setService_level (String service_level)
    {
        this.service_level = service_level;
    }

    public String getReference ()
    {
        return reference;
    }

    public void setReference (String reference)
    {
        this.reference = reference;
    }
}
