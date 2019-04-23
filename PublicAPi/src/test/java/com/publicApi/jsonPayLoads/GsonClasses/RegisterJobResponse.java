package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 18/01/2017.
 */
public class RegisterJobResponse {
    private String Status;

    private String WorkflowID;

    private String ExternalID;

    private String FileUri;

    private String FileID;

    private String StorageID;

    private String xmlns;

    public String getStatus ()
    {
        return Status;
    }

    public void setStatus (String Status)
    {
        this.Status = Status;
    }

    public String getWorkflowID ()
    {
        return WorkflowID;
    }

    public void setWorkflowID (String WorkflowID)
    {
        this.WorkflowID = WorkflowID;
    }

    public String getExternalID ()
    {
        return ExternalID;
    }

    public void setExternalID (String ExternalID)
    {
        this.ExternalID = ExternalID;
    }

    public String getFileUri ()
    {
        return FileUri;
    }

    public void setFileUri (String FileUri)
    {
        this.FileUri = FileUri;
    }

    public String getFileID ()
    {
        return FileID;
    }

    public void setFileID (String FileID)
    {
        this.FileID = FileID;
    }

    public String getStorageID ()
    {
        return StorageID;
    }

    public void setStorageID (String StorageID)
    {
        this.StorageID = StorageID;
    }

    public String getXmlns ()
    {
        return xmlns;
    }

    public void setXmlns (String xmlns)
    {
        this.xmlns = xmlns;
    }
}
