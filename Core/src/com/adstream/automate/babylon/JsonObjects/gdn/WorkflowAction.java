package com.adstream.automate.babylon.JsonObjects.gdn;

import java.util.*;


/**
 * Created by Ramababu.Bendalam on 09/05/2016.
 */
public class WorkflowAction extends JsonBase {

    String _id;
    String _documentType;
    Boolean _deleted;
    int _revision;
    Boolean internal;
    String[] status;
    String retryAttempt;
    Map<String, Date> started = new HashMap<String, Date>();
    Map<String, Date> completed = new HashMap<String, Date>();
    Map<String, Date> _created =  new HashMap<String, Date>();
    Map<String, Date> _modified =  new HashMap<String, Date>();
    String workflowType;
    String clientWorkflowId;
    String sender;
    String system;
    int priority;
    String xml;
   // List<ActionCapability> capabilities;
    String[] capabilities;
    String[] action_ids;
    GDNMetadata[] metadata;
    String storage;

    public String getStorage() {
        return storage;
    }

    public void setStorage(String storage) {
        this.storage = storage;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String get_documentType() {
        return _documentType;
    }

    public void set_documentType(String _documentType) {
        this._documentType = _documentType;
    }

    public Boolean get_deleted() {
        return _deleted;
    }

    public void set_deleted(Boolean _deleted) {
        this._deleted = _deleted;
    }

    public int get_revision() {
        return _revision;
    }

    public void set_revision(int _revision) {
        this._revision = _revision;
    }

    public Boolean getInternal() {
        return internal;
    }

    public void setInternal(Boolean internal) {
        this.internal = internal;
    }

    public String[] getStatus() {
        return status;
    }

    public void setStatus(String[] status) {
        this.status = status;
    }

    public String getRetryAttempt() {
        return retryAttempt;
    }

    public void setRetryAttempt(String retryAttempt) {
        this.retryAttempt = retryAttempt;
    }

    public Map<String, Date> getStarted() {
        return started;
    }

    public void setStarted(Map<String, Date> started) {
        this.started = started;
    }

    public Map<String, Date> getCompleted() {
        return completed;
    }

    public void setCompleted(Map<String, Date> completed) {
        this.completed = completed;
    }

    public Map<String, Date> get_created() {
        return _created;
    }

    public void set_created(Map<String, Date> _created) {
        this._created = _created;
    }

    public Map<String, Date> get_modified() {
        return _modified;
    }

    public void set_modified(Map<String, Date> _modified) {
        this._modified = _modified;
    }

    public String getWorkflowType() {
        return workflowType;
    }

    public void setWorkflowType(String workflowType) {
        this.workflowType = workflowType;
    }

    public String getClientWorkflowId() {
        return clientWorkflowId;
    }

    public void setClientWorkflowId(String clientWorkflowId) {
        this.clientWorkflowId = clientWorkflowId;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSystem() {
        return system;
    }

    public void setSystem(String system) {
        this.system = system;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String[] getCapabilities() {
        return capabilities;
    }

    public void setCapabilities(String[] capabilities) {
        this.capabilities = capabilities;
    }

    public String getXml() {
        return xml;
    }

    public void setXml(String xml) {
        this.xml = xml;
    }

    public String[] getAction_ids() {
        return action_ids;
    }

    public void setAction_ids(String[] action_ids) {
        this.action_ids = action_ids;
    }

    public GDNMetadata[] getMetadata() {
        return metadata;
    }

    public void setMetadata(GDNMetadata[] metadata) {
        this.metadata = metadata;
    }
}
