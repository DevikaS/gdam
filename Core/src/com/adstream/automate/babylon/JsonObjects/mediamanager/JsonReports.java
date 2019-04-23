package com.adstream.automate.babylon.JsonObjects.mediamanager;

/**
 * Created by Saritha.Dhanala on 19/02/2018.
 */
public class JsonReports
{
    private String id;

    private StreamInfo streamInfo;

    private String pdfReport;

    private JobInfo jobInfo;

    private ESVideo eSVideo;

    private ContainerInfo containerInfo;

    private ESAudio eSAudio;

    private Messages messages;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public StreamInfo getStreamInfo ()
    {
        return streamInfo;
    }

    public void setStreamInfo (StreamInfo streamInfo)
    {
        this.streamInfo = streamInfo;
    }

    public String getPdfReport ()
    {
        return pdfReport;
    }

    public void setPdfReport (String pdfReport)
    {
        this.pdfReport = pdfReport;
    }

    public JobInfo getJobInfo ()
    {
        return jobInfo;
    }

    public void setJobInfo (JobInfo jobInfo)
    {
        this.jobInfo = jobInfo;
    }

    public ESVideo getESVideo ()
    {
        return eSVideo;
    }

    public void setESVideo (ESVideo eSVideo)
    {
        this.eSVideo = eSVideo;
    }

    public ContainerInfo getContainerInfo ()
    {
        return containerInfo;
    }

    public void setContainerInfo (ContainerInfo containerInfo)
    {
        this.containerInfo = containerInfo;
    }

    public ESAudio getESAudio ()
    {
        return eSAudio;
    }

    public void setESAudio (ESAudio eSAudio)
    {
        this.eSAudio = eSAudio;
    }

    public Messages getMessages ()
    {
        return messages;
    }

    public void setMessages (Messages messages)
    {
        this.messages = messages;
    }

}