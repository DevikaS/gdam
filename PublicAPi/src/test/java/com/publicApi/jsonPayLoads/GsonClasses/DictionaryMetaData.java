package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 08/07/2016.
 */
public class DictionaryMetaData {

    private String[] brand;

    private String[] advertiser;

    public String[] getBrand ()
    {
        return brand;
    }

    public void setBrand (String[] brand)
    {
        this.brand = brand;
    }

    public String[] getAdvertiser ()
    {
        return advertiser;
    }

    public void setAdvertiser (String[] advertiser)
    {
        this.advertiser = advertiser;
    }
}
