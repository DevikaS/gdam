package com.adstream.automate.babylon.JsonObjects.approval;

import com.adstream.automate.babylon.JsonObjects.BaseObject;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 25.09.13
 * Time: 12:07
 */
public class ApprovalTemplate extends BaseObject {
    private String subjectId;
    private String entityId;
    private String shortId;
    private Boolean deleted;
    private String description;
    private String parentId;
    private Boolean closed;
    private String status;
    private String projectId;
    private String projectName;
    private String projectAdvertiser;
    private String folderId;
    private String entityType;
    private String entityName;
    private String currentStageId;
    private Boolean entityIsHiddenForExternal;
    private List<ApprovalStage> stages;
    private List<String> permissions;
    private Object Metadata;

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public String getEntityId() {
        return entityId;
    }

    public void setEntityId(String entityId) {
        this.entityId = entityId;
    }

    public String getShortId() {
        return shortId;
    }

    public void setShortId(String shortId) {
        this.shortId = shortId;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public Boolean getClosed() {
        return closed;
    }

    public void setClosed(Boolean closed) {
        this.closed = closed;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getProjectAdvertiser() {
        return projectAdvertiser;
    }

    public void setProjectAdvertiser(String projectAdvertiser) {
        this.projectAdvertiser = projectAdvertiser;
    }

    public String getFolderId() {
        return folderId;
    }

    public void setFolderId(String folderId) {
        this.folderId = folderId;
    }

    public String getEntityType() {
        return entityType;
    }

    public void setEntityType(String entityType) {
        this.entityType = entityType;
    }

    public String getEntityName() {
        return entityName;
    }

    public void setEntityName(String entityName) {
        this.entityName = entityName;
    }

    public String getCurrentStageId() {
        return currentStageId;
    }

    public void setCurrentStageId(String currentStageId) {
        this.currentStageId = currentStageId;
    }

    public Boolean getEntityIsHiddenForExternal() {
        return entityIsHiddenForExternal;
    }

    public void setEntityIsHiddenForExternal(Boolean entityIsHiddenForExternal) {
        this.entityIsHiddenForExternal = entityIsHiddenForExternal;
    }

    public List<ApprovalStage> getStages() {
        return stages;
    }

    public void setStages(List<ApprovalStage> stages) {
        this.stages = stages;
    }

    public List<String> getPermissions() {
        return permissions;
    }

    public void setPermissions(List<String> permissions) {
        this.permissions = permissions;
    }

    public Object getMetadata() {
        return Metadata;
    }

    public void setMetadata(Object metadata) {
        Metadata = metadata;
    }
}
