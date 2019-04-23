package com.adstream.automate.babylon.JsonObjects.adcost;

import java.util.List;

/**
 * Created by Raja.Gone on 26/06/2017.
 */
public class Approvals {
    private String[] validBusinessRoles;

    private String id;

    private List<ApprovalMembers> approvalMembers;

    private List<Requisitioners> requisitioners;

    private String created;

    private String createdById;

    private String status;

    private String type;

    private String backup;

    private String modified;

    private boolean isExternal;

    public String[] getValidBusinessRoles ()
    {
        return validBusinessRoles;
    }

    public void setValidBusinessRoles (String[] validBusinessRoles)
    {
        this.validBusinessRoles = validBusinessRoles;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public List<Requisitioners> getRequisitioners ()
    {
        return requisitioners;
    }

    public void setRequisitioners (List<Requisitioners> requisitioners)
    {
        this.requisitioners = requisitioners;
    }

    public List<ApprovalMembers> getApprovalMembers ()
    {
        return approvalMembers;
    }

    public void setApprovalMembers (List<ApprovalMembers> approvalMembers)
    {
        this.approvalMembers = approvalMembers;
    }

    public String getCreated ()
    {
        return created;
    }

    public void setCreated (String created)
    {
        this.created = created;
    }

    public String getCreatedById ()
    {
        return createdById;
    }

    public void setCreatedById (String createdById)
    {
        this.createdById = createdById;
    }

    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }

    public String getType ()
    {
        return type;
    }

    public void setType (String type)
    {
        this.type = type;
    }

    public String getBackup ()
    {
        return backup;
    }

    public void setBackup (String backup)
    {
        this.backup = backup;
    }

    public String getModified ()
    {
        return modified;
    }

    public void setModified (String modified)
    {
        this.modified = modified;
    }

    public boolean getIsExternal ()
    {
        return isExternal;
    }

    public void setIsExternal (boolean isExternal)
    {
        this.isExternal = isExternal;
    }
}
