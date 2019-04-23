package com.adstream.automate.babylon.JsonObjects.approval;

import org.joda.time.DateTime;

import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 19.06.13 20:09
 */
public class ApprovalStage {
    private String stageId;
    private Integer approvalRank;
    private String approvalType;
    private String name;
    private String description;
    private String status;
    private DateTime notificationSent;
    private Boolean locked;
    private StageReminder deadline;
    private StageReminder reminder;
    private List<StageMember> members;
    private transient List<String> membersIds;
    private List<Object> owners;
    private String yadnFileId;
    private String entityName;
    private String projectName;
    private List<String> projectAdvertiser;
    private String entityType;
    private String shortId;
    private String projectId;
    private String folderId;
    private Boolean startImmediately;
    private List<String> permissions;
    private String approvalId = "";
    private Object metadata;
    private Object approveReject = new Object();
    private Object stageStatus = new Object();
    private Object moderate = new Object();
    private Object sendReminder = new Object();

    public String getStageId() {
        return stageId;
    }

    public void setStageId(String stageId) {
        this.stageId = stageId;
    }

    public Integer getApprovalRank() {
        return approvalRank;
    }

    public void setApprovalRank(Integer approvalRank) {
        this.approvalRank = approvalRank;
    }

    public String getApprovalType() {
        return approvalType;
    }

    public void setApprovalType(String approvalType) {
        this.approvalType = approvalType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public DateTime getNotificationSent() {
        return notificationSent;
    }

    public void setNotificationSent(DateTime notificationSent) {
        this.notificationSent = notificationSent;
    }

    public Boolean isLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }

    public StageReminder getDeadline() {
        return deadline;
    }

    public void setDeadline(StageReminder deadline) {
        this.deadline = deadline;
    }

    public StageReminder getReminder() {
        return reminder;
    }

    public void setReminder(StageReminder reminder) {
        this.reminder = reminder;
    }

    public List<StageMember> getMembers() {
        return members;
    }

    public void setMembers(List<StageMember> members) {
        this.members = members;
    }

    public List<String> getMembersIds() {
        return membersIds;
    }

    public void setMembersIds(List<String> membersIds) {
        this.membersIds = membersIds;
    }

    public List<Object> getOwners() {
        return owners;
    }

    public void setOwners(List<Object> owners) {
        this.owners = owners;
    }

    public String getYadnFileId() {
        return yadnFileId;
    }

    public void setYadnFileId(String yadnFileId) {
        this.yadnFileId = yadnFileId;
    }

    public String getEntityName() {
        return entityName;
    }

    public void setEntityName(String entityName) {
        this.entityName = entityName;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public List<String> getProjectAdvertiser() {
        return projectAdvertiser;
    }

    public void setProjectAdvertiser(List<String> projectAdvertiser) {
        this.projectAdvertiser = projectAdvertiser;
    }

    public String getEntityType() {
        return entityType;
    }

    public void setEntityType(String entityType) {
        this.entityType = entityType;
    }

    public String getShortId() {
        return shortId;
    }

    public void setShortId(String shortId) {
        this.shortId = shortId;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getFolderId() {
        return folderId;
    }

    public void setFolderId(String folderId) {
        this.folderId = folderId;
    }

    public Boolean getStartImmediately() {
        return startImmediately;
    }

    public void setStartImmediately(Boolean startImmediately) {
        this.startImmediately = startImmediately;
    }

    public List<String> getPermissions() {
        return permissions;
    }

    public void setPermissions(List<String> permissions) {
        this.permissions = permissions;
    }

    public String getApprovalId() {
        return approvalId;
    }

    public void setApprovalId(String approvalId) {
        this.approvalId = approvalId;
    }

    public Object getMetadata() {
        return metadata;
    }

    public void setMetadata(Object metadata) {
        this.metadata = metadata;
    }

    public Object getApproveReject() {
        return approveReject;
    }

    public void setApproveReject(Object approveReject) {
        this.approveReject = approveReject;
    }

    public Object getStageStatus() {
        return stageStatus;
    }

    public void setStageStatus(Object stageStatus) {
        this.stageStatus = stageStatus;
    }

    public Object getModerate() {
        return moderate;
    }

    public void setModerate(Object moderate) {
        this.moderate = moderate;
    }

    public Object getSendReminder() {
        return sendReminder;
    }

    public void setSendReminder(Object sendReminder) {
        this.sendReminder = sendReminder;
    }
}
