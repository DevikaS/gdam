package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 08/07/2016.
 */
public class Items {

    private String[] statusId;

    private String[] id;

    private String status;

    private String[] viewStatus;

    private String name;

    private String destinationStatusId;

    private String countryCode;

    private ServiceLevel serviceLevel;

    public String[] getStatusId ()
    {
        return statusId;
    }

    public void setStatusId (String[] statusId)
    {
        this.statusId = statusId;
    }

    public String[] getId ()
    {
        return id;
    }

    public void setId (String[] id)
    {
        this.id = id;
    }

    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }

    public String[] getViewStatus ()
    {
        return viewStatus;
    }

    public void setViewStatus (String[] viewStatus)
    {
        this.viewStatus = viewStatus;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getDestinationStatusId ()
    {
        return destinationStatusId;
    }

    public void setDestinationStatusId (String destinationStatusId)
    {
        this.destinationStatusId = destinationStatusId;
    }

    public String getCountryCode ()
    {
        return countryCode;
    }

    public void setCountryCode (String countryCode)
    {
        this.countryCode = countryCode;
    }

    public ServiceLevel getServiceLevel ()
    {
        return serviceLevel;
    }

    public void setServiceLevel (ServiceLevel serviceLevel)
    {
        this.serviceLevel = serviceLevel;
    }

}
