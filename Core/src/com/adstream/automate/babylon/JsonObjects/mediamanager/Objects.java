package com.adstream.automate.babylon.JsonObjects.mediamanager;

/**
 * Created by Saritha.Dhanala on 19/02/2018.
 */
public class Objects
{
    private String[] reportKeys;

    private JsonReports[] jsonReports;

    private Source source;

    private String status;

    private String[] images;

    public String[] getReportKeys ()
    {
        return reportKeys;
    }

    public void setReportKeys (String[] reportKeys)
    {
        this.reportKeys = reportKeys;
    }

    public JsonReports[] getJsonReports ()
    {
        return jsonReports;
    }

    public void setJsonReports (JsonReports[] jsonReports)
    {
        this.jsonReports = jsonReports;
    }

    public Source getSource ()
    {
        return source;
    }

    public void setSource (Source source)
    {
        this.source = source;
    }

    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }

    public String[] getImages ()
    {
        return images;
    }

    public void setImages (String[] images)
    {
        this.images = images;
    }

}

